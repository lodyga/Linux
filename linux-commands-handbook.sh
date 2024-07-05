man <command> #manual help
man ls
<command> -h; <command> --help
tldr <command>
tldr ls


ls -Al /home/ukasz/  # list directory

pwd # print the current folder path

mkdir -p fruits/apples # multiple nested folders

rm -rf fruits cars # deletes files and folders

mv pear apple fruits # pear and apple moved to the fruits

cp -r fruits cars # cp -r option to recursively copy the whole fruits folder contents to cars folder (creates cars folder)

open <filename>
open <directory name>
open <application name>

touch <filename> # create an empty file

find -name "*.html" find all html recursivelyi
find . -name '*.txt' # Find all txt files under the current tree
find . -type d -name 'foo*' # Find all 'foo*' directories under the current tree
find dup/ fr/ -iname 'Q1*'  # multiple root trees search
-iname # case-insensitive search
find dup/ fr/ -name 'Q1*' -or -name 'q1*'  # or
find . -type f -size +15c -and -iname 'q1*' #  search files that have more than 15 characters (bytes) in them and name
find . -type f -mtime -1 # Search files edited in the last 24 hours
find . -type f -mtime -1 -delete # deletes all the files edited in the last 24 hours
find . -type f -size +1c -and -iname 'q1*' -exec cat {} \; # execute a command on each result


ln test.txt test_c.txt # create hard link; exatly replica with identical inode number
ln -s t2.txt t2_c.txt # create soft link

gzip -c filename > filename.gz
gzip -k filename # the same
gzip -d filename.gz # decompress

tar -cf arch.tar t2.txt test.txt # compress 2 files
tar -xf arch.tar # decompress
tar -tf arch.tar # list the files contained in an archive
tar -czf arch.tar.gz t2.txt test.txt # compressed archive
tar -xf arch.tar.gz # unzip

alias ll='ls -al' # alias to ls -al
cat ~/.bashrc #  aliases shell configuration
$PWD refers to the current folder the shell is into

echo '$PWD' # $PWD Strings enclosed in single quotes are treated literally.
echo "$PWD" # /home/ukasz Variables within the string are expanded to their values.

cat file1 file2 > file3 # concatenate the content of multiple files into a new file
cat file1 file2 >> file3 # append the content of multiple files into a new file
cat -n file1 # line numbers
cat -b file1 # non-blank lines
cat file1 | anothercommand # pipe operator | to feed a file content as input to another command

less <filename> # 

tail -f /var/log/system.log # It opens the file at the end, and watches for file changes.
tail -n5 t2.txt # last 5 lines
tail -n+5 t2.txt # print the whole file content starting from a specific line using

ls -al | wc # the number of lines/words/bytes
wc -l test.txt # count the lines
wc -w test.txt # words
wc -c test.txt # bytes
echo ${#foo} # It counts the number of characters in the value stored in the variable 
wc -m test.txt # count characters in Unicode

grep -r 'foo' --include='*.py' . # This command will search for the string "foo" in all .py files within the current directory and its subdirectories and display the matching lines along with the file paths.
grep -r index-view --include='*.py' --include='*.html' ./item  # search for "index-view" inside ./item forder in .py and .html extensions files
grep -r -e MEDIA_ROOT -e MEDIA_URL   # search MEDIA_ROOT or MEDIA_URL
grep qwer t2.txt | wc -l # count occurrences
grep -n qwer t2.txt # show the line numbers with qwer occurrences
grep -nC1 qwer t2.txt # print 1 line before, and 1 line after the matched line
-i # case insensitive
ls -l | grep -v test # find all lines without test

sort -r t2.txt # sorted in reverse
ls | sort # sorted ls

sort t2.txt | uniq # detect duplicate lines
sort -u t2.txt # same
sort t2.txt | uniq -d # show only duplicates
sort t2.txt | uniq -u # only display nonduplicate lines
sort t2.txt | uniq -c | sort -nr # sort those lines by most frequent

diff -y f1 f2 # compare the 2 files line by line
diff -u f1 f2 # Git like comparison

echo "hello" >> output.txt
echo * # echo the files in the current folder
echo t* # starts with t*
echo ~ # print your home folder path
echo $(ls -al) # print the result to the standard output
echo "$(ls -al)" # preserved whitespace
echo {1..5} # generate a list of strings

chown <owner> <file>
sudo chown ukasz sutxt.txt # transfer the ownership
chown -R <owner> <file> # change the ownership of a directory, and recursively all the files contained
chown <owner>:<group> <file> # change an owner and a group
chgrp <group> <filename> # change only a group

chmod
# The first set represents the permissions of the owner of the file
# The second set represents the permissions of the members of the group the file is associated to
# The third set represents the permissions of the everyone else
chmod a+r filename #everyone can now read
chmod a+rw filename #everyone can now read and write
chmod o-rwx filename #others (not the owner, not in 
1 if has execution permission
2 if has write permission
4 if has read permission
chmod 777 filename

umask #0022

The du command will calculate the size of a directory as a whole:
du -h * # display the size of each file in human-readable notation
du -m * # display the size of each file in MegaBytes
du -h /home/ute/Downloads/
du -ah * # -a option will print the size of each file in the directories

df -h # get disk usage in a human-readable format

basename /home/ukasz/t2.txt # will return the filename
basename /home/ukasz/ # will return the dirname

dirname /home/ukasz/t2.txt # will return the dirname
dirname /home/ukasz/ # will return /home/

ps # the list of user-initiated processes currentlyrunning in the current session
ps ax # list all processes
ps axww # continue the command listing on a new line instead of cutting it
ps axww | grep "Visual Studio Code"

top # list the processes running in real time
top -o %CPU # sort processes by CPU
top -o %MEM # sort processes by memory

kill <PID> # 
killall <name> # kill multiple instances


type
# A command can be one of those 4 types:
# an executable
# a shell built-in program
# a shell function
# an alias
type cat # cat is /usr/bin/cat
type pwd # pwd is a shell builtin

which # where it is located
which ls # /usr/bin/ls
which docker # /mnt/c/Program Files/Docker/Docker/resources/bin/docker


cat todel.txt
    fil1
    fil3
cat todel.txt | xargs rm # removes files listed in todel.txt
cat todel.txt | xargs -p rm # prompt with the action
cat todel.txt | xargs -p -n1 rm # Here we tell xargs to perform one iteration at a time with -n1

whoami # print the user name currently logged in to the terminal session

su <username> # switch to a user account
sudo nano /etc/hosts # edit root file

ping <host> # pings a specific network host, on the local network or on the Internet
ping 10.44.207.168

traceroute 10.44.207.168 # gather all the information while the packet travels

clear -x # clears the screen, but lets you go back to see the previous work by scrolling up

history # display all the history
!<command number> to repeat a command stored in the history

uname -mp -srv -n # Operating System codename;hardware name; the processor architecture name; -n nodename
uname -a # all info

env # a list of the environment variables set
printenv PATH # == printenv | grep PATH













