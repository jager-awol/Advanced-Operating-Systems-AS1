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
			REPLY=
			;;
		"Submit Job")
			#TID,SID,name,estTime,priority= "temporary variables to hold task attributes before it is saved to task list"
			read -p "Enter Student ID: " SID
			read -p "Enter Task Name: " name
			read -p "Enter Task Priority: " priority
			# est time being randomised between 2-20 is just to simulate different task lengths when submitting tasks
			estTime=$(( RANDOM % 19 + 2 ))
			# assigning  TID by incrementing on TID of previous task list entry.
			IFS=',' read -r TID _ <<< "$(tail -n 1 taskPending.txt)"
			((TID++))
			echo $TID,$SID,$name,$estTime,$priority >> taskPending.txt
			;;
		"Process Jobs")
			#highestPriority= "current highest priority read"
			highestPriority=-1
			#selected= "current task selected by priority comparison"
			selected=""
			while IFS=',' read -r TID SID name estTime priority
			do
				if (( priority > highestPriority )); then
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
