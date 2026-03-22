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
	else
		break
	fi
done

if $login; then
	echo "login success, continuing"
else
	echo "login failed, exiting"
	sleep 5
	exit
fi

