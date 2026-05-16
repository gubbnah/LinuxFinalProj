#!/bin/bash
# -1 = Login menu
# 0  = HR main menu
# 1  = Add / remove employee menu
# 2  = Modify employee menu
# 3  = Search employee menu
# 4  = View action log
# 10 = Employee main menu
# 11 = Employee personal information
# 12 = Employee payroll information
# 99 = Exit

MENUP=-1
ACTIVE="true"
USERTYPE="nil"
LINEBREAK="------------------------------"

if [ ! -d "HRDatabase" ]; then
    # assume the database doesn't exist and create it
    mkdir HRDatabase
    mkdir HRDatabase/Active
    mkdir HRDatabase/Terminated
    mkdir HRDatabase/Logs
    mkdir HRDatabase/Auth
    # create files
    touch HRDatabase/Auth/hr_accounts.txt
    touch HRDatabase/Auth/employee_accounts.txt
    touch HRDatabase/Logs/actions.txt

    echo "admin:password:HR" > HRDatabase/Auth/hr_accounts.txt
fi

while [ $ACTIVE == "true" ]; do
    if [ $MENUP == -1 ]; then
        echo "$LINEBREAK"
        echo "HR Database System"
        echo "$LINEBREAK"
        echo "Please enter your username and password to log in."
        echo "$LINEBREAK"
        read -p "Username: " USERNAME
        read -s -p "Password: " PASSWORD # hide user input
        echo ""
        if grep -q "$USERNAME:$PASSWORD:HR" HRDatabase/Auth/hr_accounts.txt; then
            echo "Login successful. Welcome, $USERNAME!"
            USERTYPE="HR"
            MENUP=0
        elif grep -q "$USERNAME:$PASSWORD:EMPLOYEE" HRDatabase/Auth/employee_accounts.txt; then
            echo "Login successful. Welcome, $USERNAME!"
            USERTYPE="EMPLOYEE"
            MENUP=10
        else
            echo "Invalid username or password. Please try again."
        fi
    elif [ $MENUP == 0 ]; then
        echo "$LINEBREAK"
        echo "HR Main Menu"
        echo "$LINEBREAK"
        echo -e "1) Add / Remove Employee\n2) Modify Employee\n3) Search Employee\n4) View Action Log\n5) Logout\n6) Exit"
        echo "$LINEBREAK"
        read -p "Please select an option: " MENUP
        if [ $MENUP == 5 ]; then
            echo "Logging out..."
            USERTYPE="nil"
            MENUP=-1
        elif [ $MENUP == 6 ]; then
            echo "Exiting the program. Goodbye!"
            ACTIVE="false"
        fi
    elif [ $MENUP == 1 ]; then
        echo "$LINEBREAK"
        echo "Add / Remove Employee Menu"
        echo "$LINEBREAK"
        echo -e "1) Add Employee\n2) Remove Employee\n3) Back to Main Menu"
        echo "$LINEBREAK"
        read -p "Please select an option: " MENUP2

        if [ $MENUP2 == 1 ]; then
            echo "$LINEBREAK"
            echo "Add Employee"
            echo "$LINEBREAK"
            #read "Enter employee's first name: " FIRSTNAME
            #read "Enter employee's last name: " LASTNAME
            #read "Enter employee's department: " DEPARTMENT
            #read "Enter employee's position: " POSITION
            #read "Enter employee's wage: " WAGE
            #read "Enter employee's payroll frequency (weekly, biweekly, monthly): " PAYFREQ
            #read "Enter employee's bonus (if applicaple, otherwise enter 0): " BONUS
            #read "Enter employee's phone number: " PHONENUMBER
            #read "Enter employee's address: " ADDRESS
            
        elif [ $MENUP2 == 2 ]; then
            echo "$LINEBREAK"
            echo "Remove Employee"
            echo "$LINEBREAK"
            # search for userid? name? idk
        elif [ $MENUP2 == 3 ]; then
            MENUP=0
        fi
        
    elif [ $MENUP == 2 ]; then
        # code to modify employee information
        echo "$LINEBREAK"
        echo "Modify Employee"
        echo "$LINEBREAK"
        # search for employee and then prompt for new information
        read -p "Enter employee's name: " MODIFYNAME
        echo "Enter new information for $MODIFYNAME:"
        MENUP=0
    elif [ $MENUP == 3 ]; then
        # code to search employee information
        echo "$LINEBREAK"
        echo "Search Employee"
        echo "$LINEBREAK"
        read -p "Enter employee's name: " SEARCHNAME
        grep -i "$SEARCHNAME" HRDatabase/Active/employees.txt
        MENUP=0
    elif [ $MENUP == 4 ]; then
        echo "$LINEBREAK"
        echo "Action Log"
        echo "$LINEBREAK"
        # code to display action log
        cat HRDatabase/Logs/actions.txt
        MENUP=0

    elif [ $MENUP == 10 ]; then
        echo "$LINEBREAK"
        echo "Employee Main Menu"
        echo "$LINEBREAK"
        echo -e "1) View Personal Information\n2) View Payroll Information\n3) Change Password\n4) Logout\n5) Exit"
        echo "$LINEBREAK"
        read -p "Please select an option: " MENUP2

        if [ $MENUP2 == 3 ]; then
            echo "Logging out..."
            USERTYPE="nil"
            MENUP=-1
        elif [ $MENUP2 == 5 ]; then
            echo "Exiting the program. Goodbye!"
            ACTIVE="false"
        fi
    elif [ $MENUP == 11 ]; then
        echo "$LINEBREAK"
        echo "Personal Information"
        echo "$LINEBREAK"
        # code to display employee personal information
    elif [ $MENUP == 12 ]; then
        echo "$LINEBREAK"
        echo "Payroll Information"
        echo "$LINEBREAK"
        # code to display employee payroll information
    fi
done
