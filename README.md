# Advanced-Operating-Systems-AS1
Author - 100092826
Date - March 2026

# Respository Files

README.md

task1script.sh          | System monitor script for Task 1

task2script.sh          | Job scheduling and processing script for Task 2

task3script.sh          | Login and submission upload script for Task 3

taskCompleted.txt       | Optional sample file used by task2script.sh to store completed jobs. If not provided, task2script.sh generates an empty file with the same filename.

taskPending.txt         | Optional sample file used by task2script.sh to store pending jobs. If not provided, task2script.sh generates an empty file with the same filename.

userDetails.txt *       | REQUIRED file used by task3script.sh to store user credentials for login system. Credentials can be edited using any plaintext editor on this file. 
                            Format: username,password

# Dependencies
bash version 5.2.37

## TASKS

Contains 3 tasks from the Advanced Operating Systems module Assignment 1 including: all source code files, clear commit history, and a README file for instructions in executing each script.

ALL Y/N MENU PROMPTS EXPECT UPPER CASE ONLY
Select menu options by inputting the relevant number.

# Task 1

task1script.sh is a system administrative tool written in bash script. It is capable of displaying CPU usage, memory usage, listing top 10 processes by memory consumption, process termination and log compression and archival.

To execute the script, download the task1script.sh file and then type "bash task1script.sh" into the terminal from the same directory. 
For program termination functionality, type "sudo bash task1script.sh" and provide superuser password instead.

# Menu Options

1. Resource Monitoring and Management
       (Displays memory and CPU statistics)
       1. View Processes
             (Displays top 10 processes by memory consumption)
       2. Terminate Process
             (Allows user to terminate a process by entering the relevant PID)
             1. Y
             2. N
                   (Confirmation that user wants to terminate process)
       3. Back
2. Disk Inspection and Log Archiving
      (Prompts user to enter directory to inspect before printing statistics of given directory.)
      1. Y
      2. N
            (Asks user if they want to archive log files larger than 50MB)
      1. Y
      2. N
            (Asks user if they want to inspect another directory)
3. View Log
     (Prints contents of system_monitor_log.txt to the terminal)
4. Exit
     (Quits script)

# Additional Outputs

All administritive actions by the user will be logged in the system_monitor_log.txt file.
All '.log' files compressed by the script will be stored within the ArchiveLogs folder.

# Additional Notes

The script will not allow the termination of processes considered critical to the system.

# Task 2

task2script.sh is a job scheduler written in bash script. It is capable of taking new job submissions, simulating the processing of jobs stored within a pending job list, prioritising jobs with a higher priority value, and storing a list of completed jobs.

To execute the script, download the task2script.sh file and then type "bash task2script.sh" into the terminal from the same directory.

*The user can optionally download the 'taskPending.txt' and 'taskCompleted.txt' files and include them in the same directory as the 'task2script.sh' file in order to providing a pre-existing list of queued and finished jobs to the script.

# Menu Options

1. View Pending
      (Prints all pending tasks to the terminal)
2. Submit Job
      (Prompts user to provide details relevant to task before saving the task to the pending task list.)
3. Process Jobs
      (Processes whichever job from the pending jobs list has the highest priority. If pending jobs have duplicate priority values, processes the first of the duplicate priority jobs.)
      1. Y
      2. N
           (Asks whether user would like to process another job, or return to the menu.)
4. View Completed
      (Prints all completed tasks to the terminal)
5. Exit
      (Quits script)

# Additional Outputs

If the files are not already within the directory upon running the script:
All submitted jobs will be stored within the 'taskPending.txt' file.
All completed jobs will be stored within the 'taskCompleted.txt' file.
All job submissions and completions will be logged within 'scheduler_log.txt'

# Additional Notes

To simulate varying task processing durations, RNG is used to randomly determine the length of user submitted jobs.
The priority system prioritises jobs with HIGHER priority value.

# Task 3

task3script.sh is a submission system written in bash script. The script requires that users log in using valid credentials, before allowing the user to submit either '.pdf' or '.docx' files.
Files must be under 5MB to be accepted. No duplicate file names or contents are allowed to be submitted.

To execute the script, download the task3script.sh AND userDetails.txt files, ensure that they are saved within the same directory, then type "bash task3script.sh" into the terminal.

Upon running the script, the user will immediately be prompted to enter a username and password.
The default credentials are:
USERNAME: john1
PASSWORD: passw0rd

To edit the credentials, use any plaintext editor to adjust the userDetails.txt file using the format: username,password

# Menu Options

1. Upload Submission
     (Prompts the user to provide submission details before validating and uploading submission)
2. Quit
     1. Y
     2. N
        (Quits the script after recieving additional confirmation from user)

# Additional Outputs

Stores all successful submissions within the 'submissions' directory.
Logs all failed login attempts and successful submissions within 'submission_Log.txt'

# Additional Notes

Three consecutive failed login attempts within 60 seconds of one another will cause the script to quit.
