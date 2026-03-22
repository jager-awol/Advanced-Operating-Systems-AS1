#! /usr/bin/bash

echo "Please log in to upload submission."
#attempt = keep track of login attempts to stop at over 3 tries
#login = keep track of whether login is successful so script continues to submission if login succeeds
attempt=0
login=false

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
		((attempt++))
		echo -e "\nIncorrect username or password. Please try again.\n"
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
					echo "Submission uploaded"
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
	echo "login failed, exiting"
	sleep 5
	exit
fi
