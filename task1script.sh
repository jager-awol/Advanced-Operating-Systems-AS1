#! /usr/bin/bash

echo "System monitor started at $(date '+%H:%M:%S %d-%m-%Y')"  >> system_monitor_log.txt

echo "This menu is used for selecting  operations."

PS3="Select an Option (Ex. 1, 2, 3): "

options=("Resource Monitoring and Management" "Disk Inspection and Log Archiving" "View Log" "Exit") 

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
						echo ""
						echo "Processes viewed at $(date '+%H:%M:%S %d-%m-%Y')" >> system_monitor_log.txt
						;;
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
									kill $tPID
									echo "PID $tPID terminated at $(date '+%H:%M:%S %d-%m-%Y')" >> system_monitor_log.txt
									;;
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
				du -h -s "$dDirectory"
				echo "Directory $dDirectory inspected at $(date '+%H:%M:%S %d-%m-%Y')" >> system_monitor_log.txt
				# confirm="User input for archive log and exit decisions"
				printf "Do you want to archive large log files?%s?\nY/N: "
				read confirm
				case $confirm in
					"Y")
						mkdir -p ArchiveLogs
						find "$dDirectory" -type f -name "*.log" -size +50M -print0 | while IFS= read -r -d '' file
						do
							#filename="file name to save compressed file as."
							filename=$(basename "$file")
							gzip -c  "$file" > "ArchiveLogs/$filename.gz" && rm "$file"
							echo "$filename compressed to ArchiveLogs at $(date '+%H:%M:%S %d-%m-%Y')" >> system_monitor_log.txt
						done
						if [ "$(du -sm ArchiveLogs | cut -f1)" -gt 1024 ]; then
							echo "Warning - ArchiveLogs directory is over  1GB"
						fi
						;;
					"N")
						;;
					*)
					echo -e "\n Invalid Choice \n"
				esac
				echo ""
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
		"View Log")
			cat system_monitor_log.txt
			echo ""
			REPLY=
			;;
		"Exit")
			echo "Exiting...."
			echo -e "System Monitor terminated at $(date '+%H:%M:%S %d-%m-%Y')\n" >> system_monitor_log.txt
			break;;
		*)
		echo "Invalid Choice, please select again.";;
	esac
done
