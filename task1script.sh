#! /usr/bin/bash

echo "This menu is used for selecting  operations."

PS3="Select an Option (Ex. 1, 2, 3): "

options=("Resource Monitoring and Management" "Disk Inspection and Log Archiving" "Logging System" "Exit")

select opt in "${options[@]}"
do
	case $opt in 
		"Resource Monitoring and Management")
			echo "Resource Monitoring and Management chosen...."
			echo ""
			echo "Displaying Memory Status:"
			free -t
			echo ""
			echo "Displaying CPU Status:"
			top -bn1 | grep "Cpu(s)";;
		"Disk Inspection and Log Archiving")
			echo "Option 2 chosen";;
		"Logging System")
			echo "Option 3 chosen";;
		"Exit")
			echo "Exiting...."
			break;;
		*)
		echo "Invalid Choice, please select again.";;
	esac
done
