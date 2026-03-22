#! /usr/bin/bash

echo "Please log in to upload submission."
#attempt = keep track of login attempts to stop at over 3 tries
#login = keep track of whether login is successful so script continues to submission if login succeeds
#userInput = keep track of username for logging purposes
#lastAttempt = keep track of time of last failed login attempt so attempts can rest after 60 seconds
attempt=0
login=false
userInput=""
lastAttempt=0
mkdir -p "submissions"

while (( "$attempt" < 3 ))
do
	read -p  "Enter username: " userInput
	read -s -p "Enter password: " passInput
	echo
	while IFS=',' read -r user pass
	do
		if [[ "$userInput" == "$user" && "$passInput" == "$pass" ]]; then
			login=true
			break
		fi
	done < userDetails.txt
	if [[ "$login" == "false" ]]; then
		now=$(date +%s)
		if ((lastAttempt != 0 && now - lastAttempt >= 60 )); then
			attempt=0
		fi
		((attempt++))
		echo -e "\nIncorrect username or password. Please try again.\n"
		echo "Failed login attempt at $(date '+%H:%M:%S %d-%m-%Y')" >> submission_Log.txt
		lastAttempt=$now
	else
		break
	fi
done

if $login; then
	#script executes if user successfully logs on
	echo "Login successful."
	while :
	do
		PS3="Select an Option (Ex. 1, 2): "
		options=("Upload Submission" "Quit")
		select opt in "${options[@]}"
		do
			case $opt in
				"Upload Submission")
					printf "Please enter filepath for submission file. Only accepts pdf or docx files under 5MB (Ex. work/submission.pdf): "
					read submission
					if [[ ! -f "$submission" ]]; then
						echo "Error: File does not exist"
						continue
					fi
					#fileExt = extracted file extension for submission file
					fileExt="${submission##*.}"
					if  [[ "$fileExt" != "docx" && "$fileExt" != "pdf" ]]; then
						echo "Error: incorrect filetype. Only .pdf or .docx file are accepted."
						continue
					fi
					#fileSize = file size of provided submission file to compare against 5mb
					fileSize =$(stat -c%s "$submission")
					if (( fileSize > 5242880 )); then
						echo "Error: File over 5MB maximum size."
						continue
					fi
					#fileName = file name of submission to check against files already in submission directory
					fileName=$(basename "$submission")
					if [[ -e "submissions/$fileName" ]]; then
						echo "Error: Duplicate file name already in submissions directory."
						continue
					fi
					#fileHash = hash of file contents to compare against contents of other files already in submission directory
					fileHash=$(sha256sum "$submission" | awk '{print $1}')
					if sha256sum "submissions"/* 2>dev/null | awk '{print $1}' | grep -q "^$fileHash$"; then
						echo "Error: Duplicate file contents already in submissions directory."
						continue
					fi
					mv $submission submissions
					echo "$fileName submitted by $userInput at $(date '+%H:%M:%S %d-%m-%Y')" >> submission_Log.txt
					echo "Submission successfully recieved."
					;;
				"Quit")
					printf "Are you sure you want to quit? \n (Y/N): "
					read confirm
					case $confirm in
						"Y")
							echo "Exiting...."
							sleep 5
							exit
							;;
						"N")
							;;
						*)
						echo -e "Invalid Choice, please select again.\n"
						;;
					esac
					REPLY=
					;;
				*)
				echo "Invalid Choice, please select again.";;
			esac
		done
	done
else
	#script executes is user is unsuccessful at logging in within 3 attempts
	echo "Too many failed login attempts - Please wait 60 seconds between attempts."
	echo "Quitting...."
	sleep 5
	exit
fi
	sleep 5
	exit
fi
