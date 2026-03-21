#! /usr/bin/bash

PS3="Select an Option (Ex. 1, 2, 3...): "

options=("View Pending" "Submit Job" "Process Jobs" "View Completed" "Exit")

select opt in "${options[@]}"
do
        case $opt in
                "View Pending")
                        echo "Task ID, Student ID, Task Name, Estimated Time, Priority"
                        while IFS=',' read -r TID SID name estTime priority
                        do
                                echo "$TID, $SID, $name, $estTime, $priority"
                        done < "taskPending.txt"
                        ;;
                "Submit Job")
                        echo "option 2 selected"
                        ;;
                "Process Jobs")
                        #highestPriority= "current highest priority read"
                        highestPriority=-1
                        #selected= "current task selected by priority comparison"
                        selected=""
                        while IFS=',' read -r TID SID name estTime priority
                        do
                                if (( priority > highest_priority )); then
                                        highestPriority = $priority
                                        selected="$TID,$SID,$name,$estTime,$priority"
                                fi
                        done < "taskPending.txt"
                        ;;
                "View Completed")
                        echo "option 4 selected"
                        ;;
                "Exit")
                        #confirm = USER INPUT for confirmation on exiting
                        printf "Are you sure you want to quit? \n(Y/N): "
                        read confirm
                        case $confirm in
                                "Y")
                                        echo "Exiting..."
                                        break;;
                                "N")
                                        ;;
                                *)
                                echo -e "Invalid Choice, please select again.\n"
                                REPLY=
                                ;;
                        esac
                        ;;
                *)
                echo "Invalid Choice, please select again.";;
        esac
done
