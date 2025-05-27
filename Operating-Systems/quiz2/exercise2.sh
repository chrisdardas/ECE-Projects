Write a bash or fish script that takes two arguments argument1 and argument2 which can come from the command line or declared inside the script.
argument1 is a filename for input .e.g. usernames.txt, which contains a list of usernames, and argument2 is a string, the filename for a file to check.

So the script would be invoked like this ./myscript.sh usernames.txt essay-1.tar.gz if there is a file usernames.txt with a list of users and essay-1.tar.gz the file to be checked under each user's home folder. In the case of the two arguments declared within the script itself it will be invoked as ./myscript.sh

The script reads usernames.txt and returns:
1) up to 10 last login dates of each user
2) up to last 10 login IPs or hostnames of each user
Then for every user of usernames.txt it checks:
3) the existence of the specific file given in argument2 in their home folder and returns
a) the File size if file has been found, b) File does not exist if file is not found and c) Permission denied if the script cannot access users' home folder.
The output should be as below.

Example argument1=usernames.txt which contains the following users:

superman
batman
wonderwoman
Example argument2=essay-1.tar.gz

Expected output for argument1=usernames.txt and argument2= essay-1.tar.gz

superman
##########
Last login date(s):
Mon Sep 20 10:00
Tue Sep 21 11:30
...
Last login IP(s)/hostname(s):
192.168.1.10
host.example.com
...
File requested: "essay-1.tar.gz" returned File not found.

batman
##########
Last login date(s):
Wed Sep 22 09:15
...
Last login IP(s)/hostname(s):
...
File requested: "essay-1.tar.gz" returned Permission denied

wonderwoman
##########

Last login date(s):
Thu Sep 23 14:45
...
Last login IP(s)/hostname(s):
...
File requested: "essay-1.tar.gz" returned File found and of size of 1812 bytes.
Tips:
The command last can help you check for last logins and there is a flag for N last logins.
Look up a way to find hostnames from IPs, useful commands could be nslookup and host.
Tools like cut or awk would be all you need for most text manipulation.
