#!/bin/bash
#creating an empty string of file path in order to check if is used or not
password_file=""
#creating an -f option to specify file path
while getopts ":f:" option; do
case $option in
f) password_file=$OPTARG;;
esac
done
#clearing optins in order to keep in process with the script
shift $((OPTIND - 1))
#if something is inputed to $password_file then $password will read data from the text file
if [[ -n $password_file ]];
then
password=`cat $password_file`
#if something is not inputed to $password_file then $password will be the string that is written in the command line
elif [[ -n $1 ]];
then
password=$1
fi
#evaluating how much chars the password has
password_length=${#password}
#counter for checking in how much sections the password meets the rquirements
count=0
#Creating an array for stroing reasons why the password is incorrect
requirements=(foo bar)
#Checking if password includes minimum of 10 characters
if [ $password_length -ge 10 ];
then
requirements[0]="Correct"
else
    requirements[0]="Incorrect password syntax. The password
    length must includes minimum of 10 characters"
fi
#checkig if the password includes both alphabet and number
if [[ "$password" == *[a-zA-Z]* && "$password" == *[0-9]* ]]
then
requirements[1]="Correct"
   
else
    requirements[1]="Incorrect password syntax. The password
    must includes both alphabet and number"
fi
#checking if password includes both the small and capital case letters.
if [[ "$password" == *[A-Z]* ]] && [[ "$password" == *[a-z]* ]];
then
requirements[2]="Correct"
else
    requirements[2]="Incorrect password syntax. The password
    must includes both the small and capital case letters"
fi
#checking whether the password is according to the requirements or not
#if yes count will equal to 3 at the end
for i in "${requirements[@]}"
do
    if [[ $i == "Correct" ]];
    then
        let count++
    fi
done
#if the counter count is equal to 3 print the password in light green color and return exit 0
if [[ $count -eq 3 ]];
then
    echo -e "\e[92m$password"
# sleep - user has the time to see that the password's syntax is correct
    sleep 3
    exit 0
#if the count is not equal to 3 print the password in reg color and return exit 1
else
    echo -e "\e[91m$password"
    for i in "${requirements[@]}"
    do
        if [[ $i != "Correct" ]];
        then
            echo $i        
        fi
    done
# sleep - user has the time to see that the password's syntax is incorrect and the reasons for that
    sleep 6
    exit 1
fi