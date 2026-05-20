#!/bin/bash

# -1 = Login menu
# 0  = HR main menu
# 1  = Add employee menu
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
    # create database directories
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
    # login
    if [ $MENUP == -1 ]; then
        echo -e "$LINEBREAK\nHR Database System\n$LINEBREAK\nPlease enter your username and password to log in.\n$LINEBREAK"
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
    # hr main menu
    elif [ $MENUP == 0 ]; then
        echo -e "$LINEBREAK\nHR Main Menu\n$LINEBREAK"
        echo -e "1) Add Employee\n2) Modify Employee\n3) Search Employee\n4) View Action Log\n5) Manage HR Accounts\n6) Generate Report\n7) Logout\n8) Exit"
        echo "$LINEBREAK"
        read -p "Please select an option: " MENUP
        if [ $MENUP == 7 ]; then
            echo "Logging out..."
            echo "$(date '+%Y-%m-%d %H:%M') - LOGGED OUT - $USERNAME" >> HRDatabase/Logs/actions.txt
            USERTYPE="nil"
            MENUP=-1
        elif [ $MENUP == 8 ]; then
            echo "Exiting the program. Goodbye!"
            echo "$(date '+%Y-%m-%d %H:%M') - LOGGED OUT - $USERNAME" >> HRDatabase/Logs/actions.txt
            ACTIVE="false"
        fi
    # add / remove employee menu
    elif [ $MENUP == 1 ]; then
        echo -e "$LINEBREAK\nAdd Employee Menu\n$LINEBREAK\n1) Add Employee\n2) Back to Main Menu\n$LINEBREAK"
        read -p "Please select an option: " MENUP2

        # add employee
        if [ $MENUP2 == 1 ]; then
            echo -e "$LINEBREAK\nAdd Employee\n$LINEBREAK"

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

            # generate employee id
            FIRSTINIT=$(echo "$FIRSTNAME" | tr 'A-Z' 'a-z' | head -c 1)
            LASTNAMELOW=$(echo "$LASTNAME" | tr 'A-Z' 'a-z')
            IDNUM=$(cat HRDatabase/Logs/next_id.txt)
            EMPID="$FIRSTINIT$LASTNAMELOW$IDNUM"

            # generate email from employee id
            EMPEMAIL="$EMPID@umb.edu"

            # get date
            TODAY=$(date +%Y-%m-%d)

            # determine status
            STATUS="\033[0;32mActive\033[0m"

            # write employee record
            echo "==============================" > HRDatabase/Active/$EMPID.txt
            echo -e "\tEMPLOYEE RECORD" >> HRDatabase/Active/$EMPID.txt
            echo "==============================" >> HRDatabase/Active/$EMPID.txt
            echo "" >> HRDatabase/Active/$EMPID.txt
            echo "Employee ID: $EMPID" >> HRDatabase/Active/$EMPID.txt
            echo "Name: $FIRSTNAME $LASTNAME" >> HRDatabase/Active/$EMPID.txt
            echo "Email: $EMPEMAIL" >> HRDatabase/Active/$EMPID.txt
            echo -e "Status: $STATUS" >> HRDatabase/Active/$EMPID.txt
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

            # create employee login (temp password)
            TEMPPASS="Temp$IDNUM"
            echo "$EMPID:$TEMPPASS:EMPLOYEE" >> HRDatabase/Auth/employee_accounts.txt

            # increment id counter - otherwise if two john doe's exist, there's a chance they may have the same employee id
            NEXTID=$((IDNUM + 1))
            echo "$NEXTID" > HRDatabase/Logs/next_id.txt

            echo "$LINEBREAK"
            echo "Employee added successfully."
            echo "Employee ID: $EMPID"
            echo "Temporary Password: $TEMPPASS"
            echo "$LINEBREAK"
            echo "$(date '+%Y-%m-%d %H:%M') - $USERNAME - ADDED EMPLOYEE - $EMPID - $FIRSTNAME $LASTNAME" >> HRDatabase/Logs/actions.txt
        elif [ $MENUP2 == 2 ]; then
            MENUP=0
        fi
        
    # modify employee
    elif [ $MENUP == 2 ]; then
        echo -e "$LINEBREAK\nModify Employee\n$LINEBREAK\n1) Search Active Employees\n2) Search Terminated Employees\n3) Return to HR Menu\n$LINEBREAK"
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
                        echo -e "$LINEBREAK\nModify Employee Record\n$LINEBREAK\n1) Modify Personal Data\n2) Modify Payroll Data\n3) Modify Job Data\n4) Reinstate/Terminate Employee\n5) Return to HR Menu\n$LINEBREAK"
                        read -p "Enter a number: " MODCHOICE

                        if [ "$MODCHOICE" == "1" ]; then
                            echo -e "$LINEBREAK\nModify Personal Data\n$LINEBREAK\n1) Name\n2) Phone\n3) Address\n4) Back"
                            read -p "Select field to modify: " FIELDCHOICE

                            if [ "$FIELDCHOICE" == "1" ]; then
                                read -p "Enter new first name: " NEWFIRST
                                read -p "Enter new last name: " NEWLAST
                                grep -v "Name:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                                mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                                echo "Name: $NEWFIRST $NEWLAST" >> "$TARGETFILE"
                                MODIFIEDNAME=$(grep "Name:" "$TARGETFILE" | tr ':' '\n' | tail -n 1)
                                echo "$(date '+%Y-%m-%d %H:%M') - $USERNAME - MODIFIED EMPLOYEE -$MODIFIEDNAME - Personal Data" >> HRDatabase/Logs/actions.txt
                            elif [ "$FIELDCHOICE" == "2" ]; then
                                read -p "Enter new phone number: " NEWPHONE
                                grep -v "Phone:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                                mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                                echo "Phone: $NEWPHONE" >> "$TARGETFILE"
                                MODIFIEDNAME=$(grep "Name:" "$TARGETFILE" | tr ':' '\n' | tail -n 1)
                                echo "$(date '+%Y-%m-%d %H:%M') - $USERNAME - MODIFIED EMPLOYEE -$MODIFIEDNAME - Personal Data" >> HRDatabase/Logs/actions.txt
                            elif [ "$FIELDCHOICE" == "3" ]; then
                                read -p "Enter new address: " NEWADDRESS
                                grep -v "Address:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                                mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                                echo "Address: $NEWADDRESS" >> "$TARGETFILE"
                                MODIFIEDNAME=$(grep "Name:" "$TARGETFILE" | tr ':' '\n' | tail -n 1)
                                echo "$(date '+%Y-%m-%d %H:%M') - $USERNAME - MODIFIED EMPLOYEE -$MODIFIEDNAME - Personal Data" >> HRDatabase/Logs/actions.txt
                            fi

                        elif [ "$MODCHOICE" == "2" ]; then
                            echo -e "$LINEBREAK\nModify Payroll Data\n$LINEBREAK\n1) Salary\n2) Pay Type\n3) Bonus\n4) Back"
                            read -p "Select field to modify: " FIELDCHOICE

                            if [ "$FIELDCHOICE" == "1" ]; then
                                read -p "Enter new salary: " NEWSALARY
                                grep -v "Salary:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                                mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                                echo "Salary: $NEWSALARY" >> "$TARGETFILE"
                                MODIFIEDNAME=$(grep "Name:" "$TARGETFILE" | tr ':' '\n' | tail -n 1)
                                echo "$(date '+%Y-%m-%d %H:%M') - $USERNAME - MODIFIED EMPLOYEE -$MODIFIEDNAME - Payroll Data" >> HRDatabase/Logs/actions.txt
                            elif [ "$FIELDCHOICE" == "2" ]; then
                                read -p "Enter new pay type (weekly, biweekly, monthly): " NEWPAYTYPE
                                grep -v "Pay Type:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                                mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                                echo "Pay Type: $NEWPAYTYPE" >> "$TARGETFILE"
                                MODIFIEDNAME=$(grep "Name:" "$TARGETFILE" | tr ':' '\n' | tail -n 1)
                                echo "$(date '+%Y-%m-%d %H:%M') - $USERNAME - MODIFIED EMPLOYEE -$MODIFIEDNAME - Payroll Data" >> HRDatabase/Logs/actions.txt
                            elif [ "$FIELDCHOICE" == "3" ]; then
                                read -p "Enter new bonus: " NEWBONUS
                                grep -v "Bonus:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                                mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                                echo "Bonus: $NEWBONUS" >> "$TARGETFILE"
                                MODIFIEDNAME=$(grep "Name:" "$TARGETFILE" | tr ':' '\n' | tail -n 1)
                                echo "$(date '+%Y-%m-%d %H:%M') - $USERNAME - MODIFIED EMPLOYEE -$MODIFIEDNAME - Payroll Data" >> HRDatabase/Logs/actions.txt
                            fi

                        elif [ "$MODCHOICE" == "3" ]; then
                            echo -e "$LINEBREAK\nModify Job Data\n$LINEBREAK\n1) Job Title\n2) Department\n3) Manager\n4) Back"
                            read -p "Select field to modify: " FIELDCHOICE

                            if [ "$FIELDCHOICE" == "1" ]; then
                                read -p "Enter new job title: " NEWTITLE
                                grep -v "Job Title:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                                mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                                echo "Job Title: $NEWTITLE" >> "$TARGETFILE"
                                MODIFIEDNAME=$(grep "Name:" "$TARGETFILE" | tr ':' '\n' | tail -n 1)
                                echo "$(date '+%Y-%m-%d %H:%M') - $USERNAME - MODIFIED EMPLOYEE -$MODIFIEDNAME - Job Data" >> HRDatabase/Logs/actions.txt
                            elif [ "$FIELDCHOICE" == "2" ]; then
                                read -p "Enter new department: " NEWDEPT
                                grep -v "Department:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                                mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                                echo "Department: $NEWDEPT" >> "$TARGETFILE"
                                MODIFIEDNAME=$(grep "Name:" "$TARGETFILE" | tr ':' '\n' | tail -n 1)
                                echo "$(date '+%Y-%m-%d %H:%M') - $USERNAME - MODIFIED EMPLOYEE -$MODIFIEDNAME - Job Data" >> HRDatabase/Logs/actions.txt
                            elif [ "$FIELDCHOICE" == "3" ]; then
                                read -p "Enter new manager: " NEWMANAGER
                                grep -v "Manager:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                                mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                                echo "Manager: $NEWMANAGER" >> "$TARGETFILE"
                                MODIFIEDNAME=$(grep "Name:" "$TARGETFILE" | tr ':' '\n' | tail -n 1)
                                echo "$(date '+%Y-%m-%d %H:%M') - $USERNAME - MODIFIED EMPLOYEE -$MODIFIEDNAME - Job Data" >> HRDatabase/Logs/actions.txt
                            fi

                        elif [ "$MODCHOICE" == "4" ]; then
                            # check if file is in active or terminated
                            if echo "$TARGETFILE" | grep -q "Active"; then
                                read -p "Terminate this employee? (y/n): " CONFIRMED
                                if [ "$CONFIRMED" == "y" ]; then
                                    mv "$TARGETFILE" HRDatabase/Terminated/
                                    MODIFIEDNAME=$(grep "Name:" HRDatabase/Terminated/$(echo "$TARGETFILE" | tr '/' '\n' | tail -n 1) | tr ':' '\n' | tail -n 1)
                                    TARGETFILE="HRDatabase/Terminated/$(echo "$TARGETFILE" | tr '/' '\n' | tail -n 1)"
                                    grep -v "Status:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                                    mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                                    echo -e "Status: \033[0;31mTerminated\033[0m" >> "$TARGETFILE"
                                    echo "Employee terminated."
                                    echo "$(date '+%Y-%m-%d %H:%M') - $USERNAME - TERMINATED EMPLOYEE -$MODIFIEDNAME" >> HRDatabase/Logs/actions.txt
                                fi
                            elif echo "$TARGETFILE" | grep -q "Terminated"; then
                                read -p "Reinstate this employee? (y/n): " CONFIRMED
                                if [ "$CONFIRMED" == "y" ]; then
                                    mv "$TARGETFILE" HRDatabase/Active/
                                    MODIFIEDNAME=$(grep "Name:" HRDatabase/Active/$(echo "$TARGETFILE" | tr '/' '\n' | tail -n 1) | tr ':' '\n' | tail -n 1)
                                    TARGETFILE="HRDatabase/Active/$(echo "$TARGETFILE" | tr '/' '\n' | tail -n 1)"
                                    grep -v "Status:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                                    mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                                    echo -e "Status: \033[0;32mActive\033[0m" >> "$TARGETFILE"
                                    echo "Employee reinstated."
                                    echo "$(date '+%Y-%m-%d %H:%M') - $USERNAME - REINSTATED EMPLOYEE -$MODIFIEDNAME" >> HRDatabase/Logs/actions.txt
                                fi
                            fi

                        elif [ "$MODCHOICE" == "5" ]; then
                            MODIFYING="false"
                            MENUP=0
                        fi

                        # update last modified date
                        if [ "$MODCHOICE" != "5" ] && [ "$FIELDCHOICE" != "4" ]; then
                            grep -v "Last Modified:" "$TARGETFILE" > HRDatabase/Logs/temp_modify.txt
                            mv HRDatabase/Logs/temp_modify.txt "$TARGETFILE"
                            echo "Last Modified: $(date '+%Y-%m-%d')" >> "$TARGETFILE"
                        fi
                    done
                fi
            fi
            rm -f HRDatabase/Logs/search_results.txt
        fi
    # search employee
    elif [ $MENUP == 3 ]; then
        echo -e "$LINEBREAK\nSearch Employee\n$LINEBREAK"
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
    # action log
    elif [ $MENUP == 4 ]; then
        echo -e "$LINEBREAK\nAction Log\n$LINEBREAK"
        cat HRDatabase/Logs/actions.txt
        MENUP=0
    # manage hr accounts
    elif [ $MENUP == 5 ]; then
        echo -e "$LINEBREAK\nManage HR Accounts\n$LINEBREAK\n1) Create HR Account\n2) Remove HR Account\n3) Return to HR Menu\n$LINEBREAK"
        read -p "Please select an option: " MENUP2

        if [ "$MENUP2" == "1" ]; then
            read -p "Enter new HR username: " NEWHRUSER
            read -s -p "Enter password: " NEWHRPASS
            echo ""
            read -s -p "Confirm password: " NEWHRPASS2
            echo ""
            if [ "$NEWHRPASS" == "$NEWHRPASS2" ]; then
                echo "$NEWHRUSER:$NEWHRPASS:HR" >> HRDatabase/Auth/hr_accounts.txt
                echo "HR account '$NEWHRUSER' created successfully."
                echo "$(date '+%Y-%m-%d %H:%M') - $USERNAME - CREATED HR ACCOUNT - $NEWHRUSER" >> HRDatabase/Logs/actions.txt
            else
                echo "Passwords do not match. Account not created."
            fi
        elif [ "$MENUP2" == "2" ]; then
            read -p "Enter HR username to remove: " REMOVEHR
            if [ "$REMOVEHR" == "$USERNAME" ]; then
                echo "You cannot remove your own account."
            elif grep -q "$REMOVEHR:" HRDatabase/Auth/hr_accounts.txt; then
                read -p "Are you sure you want to remove HR account '$REMOVEHR'? (y/n): " CONFIRMED
                if [ "$CONFIRMED" == "y" ]; then
                    grep -v "$REMOVEHR:" HRDatabase/Auth/hr_accounts.txt > HRDatabase/Logs/temp_accounts.txt
                    mv HRDatabase/Logs/temp_accounts.txt HRDatabase/Auth/hr_accounts.txt
                    echo "HR account '$REMOVEHR' removed."
                    echo "$(date '+%Y-%m-%d %H:%M') - $USERNAME - REMOVED HR ACCOUNT - $REMOVEHR" >> HRDatabase/Logs/actions.txt
                else
                    echo "Removal cancelled."
                fi
            else
                echo "HR account '$REMOVEHR' not found."
            fi
        fi
        MENUP=0
    # generate report
    elif [ $MENUP == 6 ]; then
        REPORTFILE="HRDatabase/Logs/report_$(date '+%Y-%m-%d_%H%M').txt"
        TOTALACTIVE=0
        TOTALTERMINATED=0
        TOTALPAYROLL=0
        TOTALBONUS=0

        # count active employees and sum salaries
        grep -ril "Salary:" HRDatabase/Active/ > HRDatabase/Logs/report_temp.txt
        TOTALACTIVE=$(wc -l < HRDatabase/Logs/report_temp.txt)
        LINENUM=1
        while [ $LINENUM -le $TOTALACTIVE ]; do
            FILEPATH=$(head -n $LINENUM HRDatabase/Logs/report_temp.txt | tail -n 1)
            SAL=$(grep "Salary:" "$FILEPATH" | tr -d ' ' | tr ':' '\n' | tail -n 1)
            BON=$(grep "Bonus:" "$FILEPATH" | tr -d ' ' | tr ':' '\n' | tail -n 1)
            TOTALPAYROLL=$(echo "$TOTALPAYROLL + $SAL" | bc)
            TOTALBONUS=$(echo "$TOTALBONUS + $BON" | bc)
            LINENUM=$((LINENUM + 1))
        done

        # count terminated employees
        grep -ril "Salary:" HRDatabase/Terminated/ > HRDatabase/Logs/report_temp2.txt
        TOTALTERMINATED=$(wc -l < HRDatabase/Logs/report_temp2.txt)

        # calculate average salary
        if [ $TOTALACTIVE -gt 0 ]; then
            AVGSALARY=$(echo "scale=2; $TOTALPAYROLL / $TOTALACTIVE" | bc)
        else
            AVGSALARY=0
        fi

        # get unique departments and count
        grep -rh "Department:" HRDatabase/Active/ | tr ':' '\n' | tail -n +2 > HRDatabase/Logs/dept_temp.txt

        # build report
        echo "$LINEBREAK" > "$REPORTFILE"
        echo -e "\tHR PAYROLL REPORT" >> "$REPORTFILE"
        echo -e "\tGenerated: $(date '+%Y-%m-%d %H:%M')" >> "$REPORTFILE"
        echo -e "\tGenerated by: $USERNAME" >> "$REPORTFILE"
        echo "$LINEBREAK" >> "$REPORTFILE"
        echo "" >> "$REPORTFILE"
        echo "Total Active Employees: $TOTALACTIVE" >> "$REPORTFILE"
        echo "Total Terminated Employees: $TOTALTERMINATED" >> "$REPORTFILE"
        echo "" >> "$REPORTFILE"
        echo "$LINEBREAK" >> "$REPORTFILE"
        echo -e "\tPAYROLL SUMMARY" >> "$REPORTFILE"
        echo "$LINEBREAK" >> "$REPORTFILE"
        echo "" >> "$REPORTFILE"
        echo "Total Annual Payroll: $TOTALPAYROLL" >> "$REPORTFILE"
        echo "Total Annual Bonuses: $TOTALBONUS" >> "$REPORTFILE"
        echo "Average Salary: $AVGSALARY" >> "$REPORTFILE"
        echo "" >> "$REPORTFILE"
        echo "$LINEBREAK" >> "$REPORTFILE"
        echo -e "\tDEPARTMENT BREAKDOWN" >> "$REPORTFILE"
        echo "$LINEBREAK" >> "$REPORTFILE"
        echo "" >> "$REPORTFILE"

        # loop through active files and tally departments
        LINENUM=1
        while [ $LINENUM -le $TOTALACTIVE ]; do
            FILEPATH=$(head -n $LINENUM HRDatabase/Logs/report_temp.txt | tail -n 1)
            DEPT=$(grep "Department:" "$FILEPATH" | tr ':' '\n' | tail -n 1)
            echo "$DEPT" >> HRDatabase/Logs/dept_list.txt
            LINENUM=$((LINENUM + 1))
        done

        # get unique departments and count each
        if [ -f HRDatabase/Logs/dept_list.txt ]; then
            PREVDEPT=""
            sort HRDatabase/Logs/dept_list.txt > HRDatabase/Logs/dept_sorted.txt
            DEPTCOUNT=$(wc -l < HRDatabase/Logs/dept_sorted.txt)
            LINENUM=1
            while [ $LINENUM -le $DEPTCOUNT ]; do
                CURDEPT=$(head -n $LINENUM HRDatabase/Logs/dept_sorted.txt | tail -n 1)
                if [ "$CURDEPT" != "$PREVDEPT" ]; then
                    if [ "$PREVDEPT" != "" ]; then
                        echo " $PREVDEPT: $DEPTNUM employees" >> "$REPORTFILE"
                    fi
                    DEPTNUM=1
                    PREVDEPT="$CURDEPT"
                else
                    DEPTNUM=$((DEPTNUM + 1))
                fi
                LINENUM=$((LINENUM + 1))
            done
            # print last department
            if [ "$PREVDEPT" != "" ]; then
                echo " $PREVDEPT: $DEPTNUM employees" >> "$REPORTFILE"
            fi
        fi

        echo "" >> "$REPORTFILE"
        echo "$LINEBREAK" >> "$REPORTFILE"
        echo -e "\tACTIVE EMPLOYEE ROSTER" >> "$REPORTFILE"
        echo "$LINEBREAK" >> "$REPORTFILE"
        echo "" >> "$REPORTFILE"

        LINENUM=1
        while [ $LINENUM -le $TOTALACTIVE ]; do
            FILEPATH=$(head -n $LINENUM HRDatabase/Logs/report_temp.txt | tail -n 1)
            EMPNAME=$(grep "Name:" "$FILEPATH" | tr ':' '\n' | tail -n 1)
            EMPDEPT=$(grep "Department:" "$FILEPATH" | tr ':' '\n' | tail -n 1)
            EMPTITLE=$(grep "Job Title:" "$FILEPATH" | tr ':' '\n' | tail -n 1)
            EMPSAL=$(grep "Salary:" "$FILEPATH" | tr -d ' ' | tr ':' '\n' | tail -n 1)
            echo " $EMPNAME |$EMPDEPT |$EMPTITLE | $EMPSAL" >> "$REPORTFILE"
            LINENUM=$((LINENUM + 1))
        done

        echo "" >> "$REPORTFILE"
        echo "$LINEBREAK" >> "$REPORTFILE"

        # display report
        cat "$REPORTFILE"
        echo ""
        echo "Report saved to: $REPORTFILE"

        # ask about csv export
        read -p "Export employee roster to CSV? (y/n): " EXPORTCSV
        if [ "$EXPORTCSV" == "y" ]; then
            CSVFILE="HRDatabase/Logs/report_$(date '+%Y-%m-%d_%H%M').csv"
            echo "Name,Department,Job Title,Salary,Pay Type,Bonus,Phone,Email" > "$CSVFILE"
            LINENUM=1
            while [ $LINENUM -le $TOTALACTIVE ]; do
                FILEPATH=$(head -n $LINENUM HRDatabase/Logs/report_temp.txt | tail -n 1)
                CNAME=$(grep "Name:" "$FILEPATH" | tr ':' '\n' | tail -n 1)
                CDEPT=$(grep "Department:" "$FILEPATH" | tr ':' '\n' | tail -n 1)
                CTITLE=$(grep "Job Title:" "$FILEPATH" | tr ':' '\n' | tail -n 1)
                CSAL=$(grep "Salary:" "$FILEPATH" | tr -d ' ' | tr ':' '\n' | tail -n 1)
                CPAY=$(grep "Pay Type:" "$FILEPATH" | tr ':' '\n' | tail -n 1)
                CBON=$(grep "Bonus:" "$FILEPATH" | tr -d ' ' | tr ':' '\n' | tail -n 1)
                CPHONE=$(grep "Phone:" "$FILEPATH" | tr ':' '\n' | tail -n 1)
                CEMAIL=$(grep "Email:" "$FILEPATH" | tr ':' '\n' | tail -n 1)
                echo "$CNAME,$CDEPT,$CTITLE,$CSAL,$CPAY,$CBON,$CPHONE,$CEMAIL" >> "$CSVFILE"
                LINENUM=$((LINENUM + 1))
            done
            echo "CSV exported to: $CSVFILE"
        fi

        # cleanup temp files
        rm -f HRDatabase/Logs/report_temp.txt
        rm -f HRDatabase/Logs/report_temp2.txt
        rm -f HRDatabase/Logs/dept_temp.txt
        rm -f HRDatabase/Logs/dept_list.txt
        rm -f HRDatabase/Logs/dept_sorted.txt

        echo "$(date '+%Y-%m-%d %H:%M') - $USERNAME - GENERATED REPORT" >> HRDatabase/Logs/actions.txt
        MENUP=0

    # employee main menu
    elif [ $MENUP == 10 ]; then
        echo -e "$LINEBREAK\nEmployee Main Menu\n$LINEBREAK\n1) View Personal Information\n2) View Payroll Information\n3) Change Password\n4) Logout\n5) Exit\n$LINEBREAK"
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
    # personal information
    elif [ $MENUP == 11 ]; then
        echo -e "$LINEBREAK\nPersonal Information\n$LINEBREAK"
        cat HRDatabase/Active/$USERNAME.txt
        MENUP=10
    # payroll information
    elif [ $MENUP == 12 ]; then
        echo -e "$LINEBREAK\nPayroll Information\n$LINEBREAK"

        # get salary and pay type from employee file
        SALARY=$(grep "Salary:" HRDatabase/Active/$USERNAME.txt | tr -d ' ' | tr ':' '\n' | tail -n 1)
        PAYTYPE=$(grep "Pay Type:" HRDatabase/Active/$USERNAME.txt | tr ':' '\n' | tail -n 1 | tr -d ' ')
        EMPBONUS=$(grep "Bonus:" HRDatabase/Active/$USERNAME.txt | tr -d ' ' | tr ':' '\n' | tail -n 1)

        # calculate gross pay per period
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

        # calculate deductions
        FEDTAX=$(echo "$GROSSPAY * 0.22" | bc -l)
        STATETAX=$(echo "$GROSSPAY * 0.05" | bc -l)
        SOCSEC=$(echo "$GROSSPAY * 0.062" | bc -l)
        MEDICARE=$(echo "$GROSSPAY * 0.0145" | bc -l)
        TOTALDEDUCT=$(echo "$FEDTAX + $STATETAX + $SOCSEC + $MEDICARE" | bc -l)
        NETPAY=$(echo "$GROSSPAY - $TOTALDEDUCT" | bc -l)

        # round to 2 decimal places for display
        GROSSPAY=$(echo "scale=2; $GROSSPAY / 1" | bc)
        FEDTAX=$(echo "scale=2; $FEDTAX / 1" | bc)
        STATETAX=$(echo "scale=2; $STATETAX / 1" | bc)
        SOCSEC=$(echo "scale=2; $SOCSEC / 1" | bc)
        MEDICARE=$(echo "scale=2; $MEDICARE / 1" | bc)
        NETPAY=$(echo "scale=2; $NETPAY / 1" | bc)

        echo "$LINEBREAK"
        echo -e "\tPAYROLL INFORMATION"
        echo -e "$LINEBREAK\n"
        echo "Salary: $SALARY"
        echo "Pay Type: $PAYTYPE ($PERIOD)"
        echo -e "Gross Pay (per period): $GROSSPAY\n"
        echo "Federal Tax (22%): $FEDTAX"
        echo "State Tax (5%): $STATETAX"
        echo "Social Security (6.2%): $SOCSEC"
        echo -e "Medicare (1.45%): $MEDICARE\n"
        echo "Net Pay (per period): $NETPAY"
        echo "Bonus: $EMPBONUS"
        echo "$LINEBREAK"

        MENUP=10
    # change password
    elif [ $MENUP == 13 ]; then
        echo -e "$LINEBREAK\nChange Password\n$LINEBREAK"
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
            echo "$(date '+%Y-%m-%d %H:%M') - $USERNAME - CHANGED PASSWORD" >> HRDatabase/Logs/actions.txt
        else
            echo "Incorrect current password."
        fi
        MENUP=10
    fi
done
