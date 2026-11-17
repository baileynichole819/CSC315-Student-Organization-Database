import database

def main():
    while True:
        print("\n================================")
        print("STUDENT ORGANIZATION MANAGEMENT")
        print("================================")
        print("1. Add New Member")
        print("2. Update Member Information")
        print("3. View All Members")
        print("4. View Event Attendance")
        print("5. View Service Hours")
        print("6. View Payment Summary")
        print("0. Exit")
        print("================================")

        choice = input("Enter your choice: ")

        if choice == "0":
            print("Goodbye!")
            break

	
        elif choice == "1":
            try:
                print("\n--- ADD NEW MEMBER ---")

                first_name = input("First name: ").strip()
                last_name = input("Last name: ").strip()
                email = input("Email: ").strip()
                phone = input("Phone: ").strip()
                join_date = input("Join date (YYYY-MM-DD): ").strip()
                status = input("Status (Active/Inactive/Pending): ").strip()

                from datetime import date

                if not first_name or not last_name or not email:
                    print("Name and email are required.")

                elif status not in ("Active", "Inactive", "Pending"):
                    print("Invalid membership status.")

                else:
                    date.fromisoformat(join_date)

                    member_id = database.add_member(
                        first_name, last_name, email,
                        phone, join_date, status
                    )

                    print("Member added successfully!")
                    print("New Member ID:", member_id)

            except ValueError:
                print("Invalid date. Use YYYY-MM-DD.")

            except Exception as error:
                print("Unable to add member.")
                print("Database error:", error)

        elif choice == "2":
            try:
                print("\n--- UPDATE MEMBER ---")

                member_id = int(input("Enter Member ID: "))
                email = input("New email: ").strip()
                phone = input("New phone: ").strip()
                status = input(
                    "New status (Active/Inactive/Pending): "
                ).strip()

                if not email:
                    print("Email cannot be empty.")

                elif status not in ("Active", "Inactive", "Pending"):
                    print("Invalid membership status.")

                else:
                    rows = database.update_member(
                        member_id, email, phone, status
                    )

                    if rows > 0:
                        print("Member updated successfully!")
                    else:
                        print("No matching member was updated.")

            except ValueError:
                print("Member ID must be a number.")

            except Exception as error:
                print("Unable to update member.")
                print("Database error:", error)


        elif choice == "3":
            try:
                members = database.view_members()

                if not members:
                    print("No members found.")
                else:
                    print("\n--- ORGANIZATION MEMBERS ---")

                    for member in members:
                        print("----------------------------")
                        print("Member ID:", member["member_id"])
                        print("Name:", member["first_name"],
                              member["last_name"])
                        print("Email:", member["email"])
                        print("Status:", member["membership_status"])

            except Exception as error:
                print("Unable to load members.")
                print("Database error:", error)
	
        elif choice == "4":
            try:
                events = database.view_event_attendance()

                if not events:
                    print("No events found.")
                else:
                    print("\n--- EVENT ATTENDANCE ---")

                    for event in events:
                        print("----------------------------")
                        print("Event ID:", event["event_id"])
                        print("Event:", event["event_name"])
                        print("Total Attendees:", event["total_attendees"])

            except Exception as error:
                print("Unable to load event attendance.")
                print("Database error:", error)

	
        
        elif choice == "5":
            try:
                print("\n--- MEMBER SERVICE HOURS ---")

                member_id = int(input("Enter Member ID: "))

                if member_id <= 0:
                    print("Member ID must be greater than zero.")

                else:
                    members = database.view_service_hours(member_id)

                    if not members:
                        print("No member found with that ID.")

                    else:
                        for member in members:
                            print("----------------------------")
                            print("Member ID:", member["member_id"])
                            print("Name:", member["first_name"],
                                  member["last_name"])
                            print("Total Hours:", member["total_hours"])

            except ValueError:
                print("Member ID must be a number.")

            except Exception as error:
                print("Unable to load service hours.")
                print("Database error:", error)

        
        elif choice == "6":
            try:
                payments = database.view_payment_summary()

                if not payments:
                    print("No members found.")
                else:
                    print("\n--- PAYMENT SUMMARY ---")

                    for payment in payments:
                        print("----------------------------")
                        print("Member ID:", payment["member_id"])
                        print("Name:", payment["first_name"],
                              payment["last_name"])
                        print("Number of Payments:",
                              payment["payment_count"])
                        print("Total Recorded Amount: $",
                              f'{payment["total_paid"]:.2f}',
                              sep="")

            except Exception as error:
                print("Unable to load payment summary.")
                print("Database error:", error)


        else:
            print("Invalid choice. Please try again.")


if __name__ == "__main__":
    main()
