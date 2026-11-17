import configparser
from pathlib import Path
import mysql.connector

def get_connection():
    config_path = Path(__file__).resolve().parent.parent / "config.ini"

    config = configparser.ConfigParser()

    if not config.read(config_path):
        raise RuntimeError(
            "Cannot find config.ini in the main project folder."
        )

    return mysql.connector.connect(
        host=config["mysql"]["host"],
        port=int(config["mysql"]["port"]),
        user=config["mysql"]["user"],
        password=config["mysql"]["password"],
        database=config["mysql"]["database"]
    )


def view_members():
    connection = get_connection()
    cursor = connection.cursor(dictionary=True)

    try:
        cursor.execute("""
            SELECT
                member_id,
                first_name,
                last_name,
                email,
                membership_status
            FROM Member
            ORDER BY last_name, first_name
        """)

        return cursor.fetchall()

    finally:
        cursor.close()
        connection.close()


def add_member(first_name, last_name, email, phone, join_date, status):
    connection = get_connection()
    cursor = connection.cursor()

    try:
        query = """
            INSERT INTO Member
            (first_name, last_name, email, phone,
             join_date, membership_status)
            VALUES (%s, %s, %s, %s, %s, %s)
        """

        cursor.execute(query, (
            first_name, last_name, email,
            phone, join_date, status
        ))

        connection.commit()
        return cursor.lastrowid

    except Exception:
        connection.rollback()
        raise

    finally:
        cursor.close()
        connection.close()


def update_member(member_id, email, phone, status):
    connection = get_connection()
    cursor = connection.cursor()

    try:
        query = """
            UPDATE Member
            SET email = %s,
                phone = %s,
                membership_status = %s
            WHERE member_id = %s
        """

        cursor.execute(query, (
            email, phone, status, member_id
        ))

        rows_updated = cursor.rowcount
        connection.commit()

        return rows_updated

    except Exception:
        connection.rollback()
        raise

    finally:
        cursor.close()
        connection.close()



def view_event_attendance():
    connection = get_connection()
    cursor = connection.cursor(dictionary=True)

    try:
        query = """
            SELECT
                event_id,
                event_name,
                total_present AS total_attendees
            FROM EventAttendanceSummary
            ORDER BY event_id
        """

        cursor.execute(query)
        return cursor.fetchall()

    finally:
        cursor.close()
        connection.close()


def view_service_hours(member_id):
    connection = get_connection()
    cursor = connection.cursor(dictionary=True)

    try:
        query = """
            SELECT
                m.member_id,
                m.first_name,
                m.last_name,
                COALESCE(SUM(ms.hours_completed), 0)
                    AS total_hours
            FROM Member m
            LEFT JOIN MemberService ms
                ON m.member_id = ms.member_id
            WHERE m.member_id = %s
            GROUP BY
                m.member_id,
                m.first_name,
                m.last_name
        """

        cursor.execute(query, (member_id,))
        return cursor.fetchall()

    finally:
        cursor.close()
        connection.close()


def view_payment_summary():
    connection = get_connection()
    cursor = connection.cursor(dictionary=True)

    try:
        query = """
            SELECT
                m.member_id,
                m.first_name,
                m.last_name,
                COUNT(p.payment_id) AS payment_count,
                COALESCE(SUM(p.amount), 0) AS total_paid
            FROM Member m
            LEFT JOIN Payment p
                ON m.member_id = p.member_id
            GROUP BY
                m.member_id,
                m.first_name,
                m.last_name
            ORDER BY total_paid DESC, m.last_name
        """

        cursor.execute(query)
        return cursor.fetchall()

    finally:
        cursor.close()
        connection.close()
