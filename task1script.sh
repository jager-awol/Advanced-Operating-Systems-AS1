#! /usr/bin/bash

echo "This menu is used for selecting  operations."

PS3="Select an Option (Ex. 1, 2, 3): "

options=("Resource Monitoring and Management" "Disk Inspection and Log Archiving" "Logging System" "Exit")

select opt in "${options[@]}"
do
	case $opt in 
		"Resource Monitoring and Management")
			echo "Resource Monitoring and Management chosen...."
			echo -e "\nDisplaying Memory Status:"
			free -t
			echo -e "\nDisplaying CPU Status:"
			top -bn1 | grep "Cpu(s)"
			echo ""
			select opt2 in "View Processes" "Terminate Process" Back
			do
				case $opt2 in 
					"View Processes")
						top -o %MEM -d 5 -b -n 1|grep "load average" -A 16
						echo "";;
					"Terminate Process")
						# tPID="USER INPUT"
						read -p "Enter PID to terminate: " tPID
						# confirm="USER INPUT"
						printf "Are you sure you want to terminate %s?\nY/N: " "$tPID"
						read confirm
						case $confirm in
							"Y")
								echo -e "\nTerminating....\n"
								cmd=$(ps -o comm= -p "$tPID")
								case $cmd in 
									systemd|init|bash|sshd)
										echo -e "Error - Critical System Process. Cancelling....\n";;
									*)
									kill $tPID;;
								esac;;
							"N")
								echo -e "\nCancelling....\n";;
							*)
							echo -e "\nInvalid Choice\n"
						esac
						REPLY=
						;;
					"Back")
						break;;
					*)
					echo -e "Invalid Choice, please select again.\n";;
				esac
			done
			REPLY=
			;;
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
