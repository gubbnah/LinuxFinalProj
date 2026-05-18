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
    echo "1" > HRDatabase/Logs/next_id.txt
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
            echo "$(date '+%Y-%m-%d %H:%M') - SIGNED IN - $USERNAME" >> HRDatabase/Logs/actions.txt
        elif grep -q "$USERNAME:$PASSWORD:EMPLOYEE" HRDatabase/Auth/employee_accounts.txt; then
            echo "Login successful. Welcome, $USERNAME!"
            USERTYPE="EMPLOYEE"
            MENUP=10
            echo "$(date '+%Y-%m-%d %H:%M') - SIGNED IN - $USERNAME" >> HRDatabase/Logs/actions.txt
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
            echo "$(date '+%Y-%m-%d %H:%M') - LOGGED OUT - $USERNAME" >> HRDatabase/Logs/actions.txt
            USERTYPE="nil"
            MENUP=-1
        elif [ $MENUP == 6 ]; then
            echo "Exiting the program. Goodbye!"
            echo "$(date '+%Y-%m-%d %H:%M') - LOGGED OUT - $USERNAME" >> HRDatabase/Logs/actions.txt
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

            FIRSTNAME="Blank"
            LASTNAME="Blank"
            DEPARTMENT="Blank"
            POSITION="Blank"
            WAGE="Blank"
            PAYFREQ="Blank"
            BONUS="Blank"
            PHONENUMBER="Blank"
            ADDRESS="Blank"
            STEP=1

            while [ $STEP -le 9 ]; do
                echo "$LINEBREAK"
                echo "First Name: $FIRSTNAME"
                echo "Last Name: $LASTNAME"
                echo "Department: $DEPARTMENT"
                echo "Position: $POSITION"
                echo "Wage: $WAGE"
                echo "Pay Frequency: $PAYFREQ"
                echo "Bonus: $BONUS"
                echo "Phone Number: $PHONENUMBER"
                echo "Address: $ADDRESS"
                echo "$LINEBREAK"

                if [ $STEP == 1 ]; then
                    read -p "Enter employee's first name: " INPUT
                    read -p "Are you sure you want to enter '$INPUT' as their first name? (y/n): " CONFIRMED
                    if [ "$CONFIRMED" == "y" ]; then 
                        FIRSTNAME="$INPUT"; 
                        STEP=2; 
                    fi
                elif [ $STEP == 2 ]; then
                    read -p "Enter employee's last name: " INPUT
                    read -p "Are you sure you want to enter '$INPUT' as their last name? (y/n): " CONFIRMED
                    if [ "$CONFIRMED" == "y" ]; then 
                        LASTNAME="$INPUT"; 
                        STEP=3; 
                    fi
                elif [ $STEP == 3 ]; then
                    read -p "Enter employee's department: " INPUT
                    read -p "Are you sure you want to enter '$INPUT' as their department? (y/n): " CONFIRMED
                    if [ "$CONFIRMED" == "y" ]; then 
                        DEPARTMENT="$INPUT"; 
                        STEP=4; 
                    fi
                elif [ $STEP == 4 ]; then
                    read -p "Enter employee's position: " INPUT
                    read -p "Are you sure you want to enter '$INPUT' as their position? (y/n): " CONFIRMED
                    if [ "$CONFIRMED" == "y" ]; then 
                        POSITION="$INPUT"; 
                        STEP=5; 
                    fi
                elif [ $STEP == 5 ]; then
                    read -p "Enter employee's wage: " INPUT
                    read -p "Are you sure you want to enter '$INPUT' as their wage? (y/n): " CONFIRMED
                    if [ "$CONFIRMED" == "y" ]; then 
                        WAGE="$INPUT"; 
                        STEP=6; 
                    fi
                elif [ $STEP == 6 ]; then
                    read -p "Enter employee's payroll frequency (weekly, biweekly, monthly): " INPUT
                    read -p "Are you sure you want to enter '$INPUT' as their pay frequency? (y/n): " CONFIRMED
                    if [ "$CONFIRMED" == "y" ]; then 
                        PAYFREQ="$INPUT"; 
                        STEP=7; 
                    fi
                elif [ $STEP == 7 ]; then
                    read -p "Enter employee's bonus (0 if none): " INPUT
                    read -p "Are you sure you want to enter '$INPUT' as their bonus? (y/n): " CONFIRMED
                    if [ "$CONFIRMED" == "y" ]; then 
                        BONUS="$INPUT"; 
                        STEP=8; 
                    fi
                elif [ $STEP == 8 ]; then
                    read -p "Enter employee's phone number: " INPUT
                    read -p "Are you sure you want to enter '$INPUT' as their phone number? (y/n): " CONFIRMED
                    if [ "$CONFIRMED" == "y" ]; then 
                        PHONENUMBER="$INPUT"; 
                        STEP=9; 
                    fi
                elif [ $STEP == 9 ]; then
                    read -p "Enter employee's address: " INPUT
                    read -p "Are you sure you want to enter '$INPUT' as their address? (y/n): " CONFIRMED
                    if [ "$CONFIRMED" == "y" ]; then 
                        ADDRESS="$INPUT"; 
                        STEP=10; 
                    fi
                fi
            done

            # Generate employee ID
            FIRSTINIT=$(echo "$FIRSTNAME" | tr 'A-Z' 'a-z' | head -c 1)
            LASTNAMELOW=$(echo "$LASTNAME" | tr 'A-Z' 'a-z')
            IDNUM=$(cat HRDatabase/Logs/next_id.txt)
            EMPID="$FIRSTINIT$LASTNAMELOW$IDNUM"

            # Generate email from employee ID
            EMPEMAIL="$EMPID@umb.edu"

            # Get date
            TODAY=$(date +%Y-%m-%d)

            # Determine status
            STATUS="Active"

            # Write employee record
            echo "==============================" > HRDatabase/Active/$EMPID.txt
            echo "        EMPLOYEE RECORD" >> HRDatabase/Active/$EMPID.txt
            echo "==============================" >> HRDatabase/Active/$EMPID.txt
            echo "" >> HRDatabase/Active/$EMPID.txt
            echo "Employee ID: $EMPID" >> HRDatabase/Active/$EMPID.txt
            echo "Name: $FIRSTNAME $LASTNAME" >> HRDatabase/Active/$EMPID.txt
            echo "Email: $EMPEMAIL" >> HRDatabase/Active/$EMPID.txt
            echo "Status: $STATUS" >> HRDatabase/Active/$EMPID.txt
            echo "" >> HRDatabase/Active/$EMPID.txt
            echo "Job Title: $POSITION" >> HRDatabase/Active/$EMPID.txt
            echo "Department: $DEPARTMENT" >> HRDatabase/Active/$EMPID.txt
            echo "Manager: N/A" >> HRDatabase/Active/$EMPID.txt
            echo "" >> HRDatabase/Active/$EMPID.txt
            echo "Salary: $WAGE" >> HRDatabase/Active/$EMPID.txt
            echo "Pay Type: $PAYFREQ" >> HRDatabase/Active/$EMPID.txt
            echo "Bonus: $BONUS" >> HRDatabase/Active/$EMPID.txt
            echo "" >> HRDatabase/Active/$EMPID.txt
            echo "Phone: $PHONENUMBER" >> HRDatabase/Active/$EMPID.txt
            echo "Address: $ADDRESS" >> HRDatabase/Active/$EMPID.txt
            echo "" >> HRDatabase/Active/$EMPID.txt
            echo "Date Created: $TODAY" >> HRDatabase/Active/$EMPID.txt
            echo "Last Modified: $TODAY" >> HRDatabase/Active/$EMPID.txt

            # Create employee login (temp password)
            TEMPPASS="Temp$IDNUM"
            echo "$EMPID:$TEMPPASS:EMPLOYEE" >> HRDatabase/Auth/employee_accounts.txt

            # Increment ID counter
            NEXTID=$((IDNUM + 1))
            echo "$NEXTID" > HRDatabase/Logs/next_id.txt

            echo "$LINEBREAK"
            echo "Employee added successfully."
            echo "Employee ID: $EMPID"
            echo "Temporary Password: $TEMPPASS"
            echo "$LINEBREAK"
            echo "$(date '+%Y-%m-%d %H:%M') - ADDED EMPLOYEE - $EMPID - $FIRSTNAME $LASTNAME" >> HRDatabase/Logs/actions.txt
            
        elif [ $MENUP2 == 2 ]; then
            echo "$LINEBREAK"
            echo "Remove Employee"
            echo "$LINEBREAK"
            read -p "Search by first name, last name, or username: " SEARCHTERM
            grep -ril "$SEARCHTERM" HRDatabase/Active/ > HRDatabase/Logs/search_results.txt
            RESULTCOUNT=$(wc -l < HRDatabase/Logs/search_results.txt)

            if [ $RESULTCOUNT == 0 ]; then
                echo "No employees found matching '$SEARCHTERM'."
            elif [ $RESULTCOUNT == 1 ]; then
                TARGETFILE=$(head -n 1 HRDatabase/Logs/search_results.txt)
                REMOVEDNAME=$(grep "Name:" "$TARGETFILE" | tr ':' '\n' | tail -n 1)
                echo "Found employee:"
                cat "$TARGETFILE"
                echo ""
                read -p "Are you sure you want to remove this employee? (y/n): " CONFIRMED
                if [ "$CONFIRMED" == "y" ]; then
                    mv "$TARGETFILE" HRDatabase/Terminated/
                    echo "Employee removed successfully."
                    echo "$(date '+%Y-%m-%d %H:%M') - REMOVED EMPLOYEE -$REMOVEDNAME" >> HRDatabase/Logs/actions.txt
                else
                    echo "Removal cancelled."
                fi
            else
                echo "Multiple employees found:"
                echo "$LINEBREAK"
                LINENUM=1
                while [ $LINENUM -le $RESULTCOUNT ]; do
                    FILEPATH=$(head -n $LINENUM HRDatabase/Logs/search_results.txt | tail -n 1)
                    EMPNAME=$(grep "Name:" "$FILEPATH")
                    echo "$LINENUM) $EMPNAME"
                    LINENUM=$((LINENUM + 1))
                done
                echo "$LINEBREAK"
                read -p "Select an employee by number: " SELECTION
                TARGETFILE=$(head -n $SELECTION HRDatabase/Logs/search_results.txt | tail -n 1)
                if [ -z "$TARGETFILE" ]; then
                    echo "Invalid selection."
                else
                    echo "Selected employee:"
                    cat "$TARGETFILE"
                    echo ""
                    REMOVEDNAME=$(grep "Name:" "$TARGETFILE" | tr ':' '\n' | tail -n 1)
                    read -p "Are you sure you want to remove this employee? (y/n): " CONFIRMED
                    if [ "$CONFIRMED" == "y" ]; then
                        mv "$TARGETFILE" HRDatabase/Terminated/
                        echo "Employee removed successfully."
                        echo "$(date '+%Y-%m-%d %H:%M') - REMOVED EMPLOYEE -$REMOVEDNAME" >> HRDatabase/Logs/actions.txt
                    else
                        echo "Removal cancelled."
                    fi
                fi
            fi
            rm -f HRDatabase/Logs/search_results.txt
        elif [ $MENUP2 == 3 ]; then
            MENUP=0
        fi
        
    elif [ $MENUP == 2 ]; then
        echo "+--------------------------------------+"
        echo "|          MODIFY EMPLOYEE             |"
        echo "+--------------------------------------+"
        echo "| 1. Search Active Employees           |"
        echo "| 2. Search Terminated Employees       |"
        echo "| 3. Return to HR Menu                 |"
        echo "+--------------------------------------+"
        read -p "Enter a number: " MENUP2

        if [ "$MENUP2" == "3" ]; then
            MENUP=0
        elif [ "$MENUP2" == "1" ] || [ "$MENUP2" == "2" ]; then
            if [ "$MENUP2" == "1" ]; then
                SEARCHDIR="HRDatabase/Active"
            elif [ "$MENUP2" == "2" ]; then
                SEARCHDIR="HRDatabase/Terminated"
            fi

            read -p "Enter employee name or ID: " SEARCHTERM
            grep -ril "$SEARCHTERM" $SEARCHDIR/ > HRDatabase/Logs/search_results.txt
            RESULTCOUNT=$(wc -l < HRDatabase/Logs/search_results.txt)

            if [ $RESULTCOUNT == 0 ]; then
                echo "No employees found matching '$SEARCHTERM'."
            else
                if [ $RESULTCOUNT == 1 ]; then
                    TARGETFILE=$(head -n 1 HRDatabase/Logs/search_results.txt)
                else
                    echo "Multiple employees found:"
                    echo "$LINEBREAK"
                    LINENUM=1
                    while [ $LINENUM -le $RESULTCOUNT ]; do
                        FILEPATH=$(head -n $LINENUM HRDatabase/Logs/search_results.txt | tail -n 1)
                        EMPNAME=$(grep "Name:" "$FILEPATH")
                        echo "$LINENUM) $EMPNAME"
                        LINENUM=$((LINENUM + 1))
                    done
                    echo "$LINEBREAK"
                    read -p "Select an employee by number: " SELECTION
                    TARGETFILE=$(head -n $SELECTION HRDatabase/Logs/search_results.txt | tail -n 1)
                fi

                if [ -z "$TARGETFILE" ]; then
                    echo "Invalid selection."
                else
                    cat "$TARGETFILE"
                    echo ""
                    MODIFYING="true"
                    while [ "$MODIFYING" == "true" ]; do
                        echo "$LINEBREAK"
                        echo "Modify Employee Record"
                        echo "$LINEBREAK"
                        echo -e "1) Modify Personal Data\n2) Modify Payroll Data\n3) Modify Job Data\n4) Reinstate/Terminate Employee\n5) Return to HR Menu"
                        echo "$LINEBREAK"
                        read -p "Enter a number: " MODCHOICE

                        if [ "$MODCHOICE" == "1" ]; then
                            echo "$LINEBREAK"
                            echo "Modify Personal Data"
                            echo "$LINEBREAK"
                            echo "1) Name"
                            echo "2) Phone"
                            echo "3) Address"
                            read -p "Select field to modify: " FIELDCHOICE

                            if [ "$FIELDCHOICE" == "1" ]; then
                                read -p "Enter new first name: " NEWFIRST
                                read -p "Enter new last name: " NEWLAST
                                grep -v "Name:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                                mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                                echo "Name: $NEWFIRST $NEWLAST" >> "$TARGETFILE"
                            elif [ "$FIELDCHOICE" == "2" ]; then
                                read -p "Enter new phone number: " NEWPHONE
                                grep -v "Phone:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                                mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                                echo "Phone: $NEWPHONE" >> "$TARGETFILE"
                            elif [ "$FIELDCHOICE" == "3" ]; then
                                read -p "Enter new address: " NEWADDRESS
                                grep -v "Address:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                                mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                                echo "Address: $NEWADDRESS" >> "$TARGETFILE"
                            fi
                            MODIFIEDNAME=$(grep "Name:" "$TARGETFILE" | tr ':' '\n' | tail -n 1)
                            echo "$(date '+%Y-%m-%d %H:%M') - MODIFIED EMPLOYEE -$MODIFIEDNAME - Personal Data" >> HRDatabase/Logs/actions.txt

                        elif [ "$MODCHOICE" == "2" ]; then
                            echo "$LINEBREAK"
                            echo "Modify Payroll Data"
                            echo "$LINEBREAK"
                            echo "1) Salary"
                            echo "2) Pay Type"
                            echo "3) Bonus"
                            read -p "Select field to modify: " FIELDCHOICE

                            if [ "$FIELDCHOICE" == "1" ]; then
                                read -p "Enter new salary: " NEWSALARY
                                grep -v "Salary:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                                mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                                echo "Salary: $NEWSALARY" >> "$TARGETFILE"
                            elif [ "$FIELDCHOICE" == "2" ]; then
                                read -p "Enter new pay type (weekly, biweekly, monthly): " NEWPAYTYPE
                                grep -v "Pay Type:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                                mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                                echo "Pay Type: $NEWPAYTYPE" >> "$TARGETFILE"
                            elif [ "$FIELDCHOICE" == "3" ]; then
                                read -p "Enter new bonus: " NEWBONUS
                                grep -v "Bonus:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                                mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                                echo "Bonus: $NEWBONUS" >> "$TARGETFILE"
                            fi
                            MODIFIEDNAME=$(grep "Name:" "$TARGETFILE" | tr ':' '\n' | tail -n 1)
                            echo "$(date '+%Y-%m-%d %H:%M') - MODIFIED EMPLOYEE -$MODIFIEDNAME - Payroll Data" >> HRDatabase/Logs/actions.txt

                        elif [ "$MODCHOICE" == "3" ]; then
                            echo "$LINEBREAK"
                            echo "Modify Job Data"
                            echo "$LINEBREAK"
                            echo "1) Job Title"
                            echo "2) Department"
                            echo "3) Manager"
                            read -p "Select field to modify: " FIELDCHOICE

                            if [ "$FIELDCHOICE" == "1" ]; then
                                read -p "Enter new job title: " NEWTITLE
                                grep -v "Job Title:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                                mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                                echo "Job Title: $NEWTITLE" >> "$TARGETFILE"
                            elif [ "$FIELDCHOICE" == "2" ]; then
                                read -p "Enter new department: " NEWDEPT
                                grep -v "Department:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                                mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                                echo "Department: $NEWDEPT" >> "$TARGETFILE"
                            elif [ "$FIELDCHOICE" == "3" ]; then
                                read -p "Enter new manager: " NEWMANAGER
                                grep -v "Manager:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                                mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                                echo "Manager: $NEWMANAGER" >> "$TARGETFILE"
                            fi
                            MODIFIEDNAME=$(grep "Name:" "$TARGETFILE" | tr ':' '\n' | tail -n 1)
                            echo "$(date '+%Y-%m-%d %H:%M') - MODIFIED EMPLOYEE -$MODIFIEDNAME - Job Data" >> HRDatabase/Logs/actions.txt

                        elif [ "$MODCHOICE" == "4" ]; then
                            # Check if file is in Active or Terminated
                            if echo "$TARGETFILE" | grep -q "Active"; then
                                read -p "Terminate this employee? (y/n): " CONFIRMED
                                if [ "$CONFIRMED" == "y" ]; then
                                    mv "$TARGETFILE" HRDatabase/Terminated/
                                    MODIFIEDNAME=$(grep "Name:" HRDatabase/Terminated/$(echo "$TARGETFILE" | tr '/' '\n' | tail -n 1) | tr ':' '\n' | tail -n 1)
                                    TARGETFILE="HRDatabase/Terminated/$(echo "$TARGETFILE" | tr '/' '\n' | tail -n 1)"
                                    echo "Employee terminated."
                                    echo "$(date '+%Y-%m-%d %H:%M') - TERMINATED EMPLOYEE -$MODIFIEDNAME" >> HRDatabase/Logs/actions.txt
                                fi
                            elif echo "$TARGETFILE" | grep -q "Terminated"; then
                                read -p "Reinstate this employee? (y/n): " CONFIRMED
                                if [ "$CONFIRMED" == "y" ]; then
                                    mv "$TARGETFILE" HRDatabase/Active/
                                    MODIFIEDNAME=$(grep "Name:" HRDatabase/Active/$(echo "$TARGETFILE" | tr '/' '\n' | tail -n 1) | tr ':' '\n' | tail -n 1)
                                    TARGETFILE="HRDatabase/Active/$(echo "$TARGETFILE" | tr '/' '\n' | tail -n 1)"
                                    echo "Employee reinstated."
                                    echo "$(date '+%Y-%m-%d %H:%M') - REINSTATED EMPLOYEE -$MODIFIEDNAME" >> HRDatabase/Logs/actions.txt
                                fi
                            fi

                        elif [ "$MODCHOICE" == "5" ]; then
                            MODIFYING="false"
                            MENUP=0
                        fi

                        # Update last modified date
                        if [ "$MODCHOICE" != "5" ]; then
                            grep -v "Last Modified:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                            mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                            echo "Last Modified: $(date '+%Y-%m-%d')" >> "$TARGETFILE"
                        fi
                    done
                fi
            fi
            rm -f HRDatabase/Logs/search_results.txt
        fi
    elif [ $MENUP == 3 ]; then
        echo "$LINEBREAK"
        echo "Search Employee"
        echo "$LINEBREAK"
        read -p "Enter employee name or ID: " SEARCHNAME
        grep -ril "$SEARCHNAME" HRDatabase/Active/ > HRDatabase/Logs/search_results.txt
        grep -ril "$SEARCHNAME" HRDatabase/Terminated/ >> HRDatabase/Logs/search_results.txt
        RESULTCOUNT=$(wc -l < HRDatabase/Logs/search_results.txt)

        if [ $RESULTCOUNT == 0 ]; then
            echo "No employees found matching '$SEARCHNAME'."
        else
            LINENUM=1
            while [ $LINENUM -le $RESULTCOUNT ]; do
                FILEPATH=$(head -n $LINENUM HRDatabase/Logs/search_results.txt | tail -n 1)
                echo "$LINEBREAK"
                cat "$FILEPATH"
                echo ""
                LINENUM=$((LINENUM + 1))
            done
        fi
        rm -f HRDatabase/Logs/search_results.txt
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
        read -p "Please select an option: " MENUP
        MENUP=$((MENUP + 10))
        if [ $MENUP == 14 ]; then
            echo "Logging out..."
            echo "$(date '+%Y-%m-%d %H:%M') - LOGGED OUT - $USERNAME" >> HRDatabase/Logs/actions.txt
            USERTYPE="nil"
            MENUP=-1
        elif [ $MENUP == 15 ]; then
            echo "Exiting the program. Goodbye!"
            echo "$(date '+%Y-%m-%d %H:%M') - LOGGED OUT - $USERNAME" >> HRDatabase/Logs/actions.txt
            ACTIVE="false"
        fi
    elif [ $MENUP == 11 ]; then
        echo "$LINEBREAK"
        echo "Personal Information"
        echo "$LINEBREAK"
        cat HRDatabase/Active/$USERNAME.txt
        MENUP=10
        # code to display employee personal information
    elif [ $MENUP == 12 ]; then
        echo "$LINEBREAK"
        echo "Payroll Information"
        echo "$LINEBREAK"

        # Get salary and pay type from employee file
        SALARY=$(grep "Salary:" HRDatabase/Active/$USERNAME.txt | tr -d ' ' | tr ':' '\n' | tail -n 1)
        PAYTYPE=$(grep "Pay Type:" HRDatabase/Active/$USERNAME.txt | tr ':' '\n' | tail -n 1 | tr -d ' ')
        EMPBONUS=$(grep "Bonus:" HRDatabase/Active/$USERNAME.txt | tr -d ' ' | tr ':' '\n' | tail -n 1)

        # Calculate gross pay per period
        if [ "$PAYTYPE" == "weekly" ]; then
            GROSSPAY=$(echo "$SALARY / 52" | bc -l)
            PERIOD="Weekly"
        elif [ "$PAYTYPE" == "biweekly" ]; then
            GROSSPAY=$(echo "$SALARY / 26" | bc -l)
            PERIOD="Biweekly"
        elif [ "$PAYTYPE" == "monthly" ]; then
            GROSSPAY=$(echo "$SALARY / 12" | bc -l)
            PERIOD="Monthly"
        fi

        # Calculate deductions
        FEDTAX=$(echo "$GROSSPAY * 0.22" | bc -l)
        STATETAX=$(echo "$GROSSPAY * 0.05" | bc -l)
        SOCSEC=$(echo "$GROSSPAY * 0.062" | bc -l)
        MEDICARE=$(echo "$GROSSPAY * 0.0145" | bc -l)
        TOTALDEDUCT=$(echo "$FEDTAX + $STATETAX + $SOCSEC + $MEDICARE" | bc -l)
        NETPAY=$(echo "$GROSSPAY - $TOTALDEDUCT" | bc -l)

        # Round to 2 decimal places for display
        GROSSPAY=$(echo "scale=2; $GROSSPAY / 1" | bc)
        FEDTAX=$(echo "scale=2; $FEDTAX / 1" | bc)
        STATETAX=$(echo "scale=2; $STATETAX / 1" | bc)
        SOCSEC=$(echo "scale=2; $SOCSEC / 1" | bc)
        MEDICARE=$(echo "scale=2; $MEDICARE / 1" | bc)
        NETPAY=$(echo "scale=2; $NETPAY / 1" | bc)

        echo "=============================="
        echo "       PAYROLL INFORMATION"
        echo "=============================="
        echo ""
        echo "Salary: $SALARY"
        echo "Pay Type: $PAYTYPE ($PERIOD)"
        echo "Gross Pay (per period): $GROSSPAY"
        echo ""
        echo "Federal Tax (22%): $FEDTAX"
        echo "State Tax (5%): $STATETAX"
        echo "Social Security (6.2%): $SOCSEC"
        echo "Medicare (1.45%): $MEDICARE"
        echo ""
        echo "Net Pay (per period): $NETPAY"
        echo "Bonus: $EMPBONUS"
        echo "=============================="

        MENUP=10
    elif [ $MENUP == 13 ]; then
        echo "$LINEBREAK"
        echo "Change Password"
        echo "$LINEBREAK"
        read -s -p "Enter current password: " OLDPASS
        echo ""
        if grep -q "$USERNAME:$OLDPASS:EMPLOYEE" HRDatabase/Auth/employee_accounts.txt; then
            PASSMATCH="false"
            while [ "$PASSMATCH" == "false" ]; do
                read -s -p "Enter new password: " NEWPASS
                echo ""
                read -s -p "Confirm new password: " NEWPASS2
                echo ""
                if [ "$NEWPASS" == "$NEWPASS2" ]; then
                    PASSMATCH="true"
                else
                    echo "Passwords do not match. Try again."
                fi
            done
            grep -v "$USERNAME:$OLDPASS:EMPLOYEE" HRDatabase/Auth/employee_accounts.txt > HRDatabase/Logs/temp_accounts.txt
            mv HRDatabase/Logs/temp_accounts.txt HRDatabase/Auth/employee_accounts.txt
            echo "$USERNAME:$NEWPASS:EMPLOYEE" >> HRDatabase/Auth/employee_accounts.txt
            echo "Password changed successfully."
            echo "$(date '+%Y-%m-%d %H:%M') - CHANGED PASSWORD - $USERNAME" >> HRDatabase/Logs/actions.txt
        else
            echo "Incorrect current password."
        fi
        MENUP=10
    fi
done
