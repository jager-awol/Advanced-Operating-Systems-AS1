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
						# tPID="User input for PID to terminate"
						read -p "Enter PID to terminate: " tPID
						# confirm="User input for confirmation of program termination"
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
			echo ""
			REPLY=
			;;
		"Disk Inspection and Log Archiving")
			echo -e "\nCurrent location:"
			pwd
			echo -e "\nNearby directories:"
			ls -d */
			echo ""
			while :
			do	
				# dDirectory="User input for directory to inspect"
				printf "Enter a directory to inspect:%s\n"
				read dDirectory
				du -h -s $dDirectory
				echo ""
				# confirm="User input for exiting to first menu or continuing"
				printf "Do you want to inspect another directory?%s?\nY/N: "
				read confirm
				case $confirm in 
					"Y")
						;;
					"N")
						echo -e "\nReturning to menu....\n"
						break;;
					*)
					echo -e "\nInvalid Choice\n"
					break
				esac
			done
			REPLY=
			;;
		"Logging System")
			echo "Option 3 chosen";;
		"Exit")
			echo "Exiting...."
			break;;
		*)
		echo "Invalid Choice, please select again.";;
	esac
done

		echo "Invalid Choice, please select again.";;
	esac
done
