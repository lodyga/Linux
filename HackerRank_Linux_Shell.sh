./ nazwa

# Bash
#!/bin/bash
# Let's Echo
echo "HELLO"
echo "katalog domowy"
echo "$PWD"
echo "$USER"
echo "Greetings $USER, your current working directory is $PWD"
echo Greetings $USER, your current working directory is $PWD
pwd

echo HELLO pwd
pwd
echo $PWD


# Looping and Skipping
#!/bin/bash
for i in {1..99..2}; do
    echo $i
done

#!/bin/bash
for ((i=1; i<=99; i+=2)); do
    echo $i
done



# A Personalized Echo
#!/bin/bash
read number
echo "Welcome $number"



# Looping with Numbers
#!/bin/bash
for i in {1..50}; do
    echo $i
do

echo {1..50} | sed 's/ /\n/g'

seq 1 50



# The World of Numbers
#!/bin/bash
read a
read b
echo $((a+b))
echo $((a-b))
echo $[a*b]
echo $[a/b]



# Comparing Numbers
#!/bin/bash
read a
read b
if [[ $a > $b ]]; then
    echo X is greater than Y
elif [[ $a == $b ]]; then
    echo X is equal to Y
else
    echo X is less than Y
fi



# Getting started with conditionals
#!/bin/bash
read a
if [[ $a = y ]] || [[ $a = Y ]]; then
    echo YES
elif [[ $a = n ]] || [[ $a = N ]]; then
    echo NO
fi



# More on Conditionals
#!/bin/bash
#!/bin/bash
read a
read b
read c
if [[ $a -eq $b ]] && [[ $b -eq $c ]] && [[ $c -eq $a ]]; then
    echo EQUILATERAL
elif [[ $a = $b ]] || [[ $b = $c ]] || [[ $c = $a ]]; then
    echo ISOSCELES
else 
    echo SCALENE
fi


































# Text Processing
# Cut #1
#!/bin/bash
while read a; do
    echo $a | cut -c3
done

echo '0000 192.168.1.100 192.168.100.1' |cut -d ' ' -f 2 |cut -d '.' -f 4|cut -c 1
1



# Cut #2
#!/bin/bash
while read line; do
    echo $line | cut -c2,7
done

cut -c2,7



# Cut #3
#!/bin/bash
while read line; do
    echo $line | cut -c2-7
done



# Cut #4
cut -c-4



# Cut #5
#!/bin/bash
#IFS = ""
while read line; do
    echo "$line" | cut -f-3
done

"$line" zachowuje taby



# Cut #6
cut -c13-



# Cut #7
cut -d " " -f4



# Cut #9
cut -d " " -f-3



# Cut #10
while read line; do
    echo $line | cut -d " " -f2-
done

cut -f2-


# Head of a Text File #1
head -n 20
cut -d $'\n' -f-20



# Head of a Text File #2
head -c20



# Middle of a Text File
sed -n '12,22p'

head -n 22 | tail -n 11


# Tail of a Text File #1
tail -n 20



# Tail of a Text File #2
tail -c 20



# 'Tr' Command #1
tr "(" "[" | tr ")" "]"
tr "()" "[]"



# 'Tr' Command #2
tr -d [a-z]
tr -d a-z
tr -d [:lower:]



# 'Tr' Command #3
tr -s [:space:]
tr -s " "
tr -s " " " "
tr -s ' ' ' '

# This works because you used echo $line and not echo "$line". Double quotes are required to preserve multiple spacing. 
# In absence of that, it replaces sequences of "one or more" blanks with single spaces. That's exactly what's demanded by the problem. Hence, works !
while read line; do
    echo $line
done



# Sort Command #1
sort



# Sort Command #2
sort -r



# Sort Command #3
sort -n


# Sort Command #4
sort -rn



# Sort Command #5
sort -k2 -rn -t$'\t'



# 'Sort' command #6
sort -k2 -n -t$'\t'
sort -k2n -t$'\t'



# 'Sort' command #7
sort -k2 -rn -t "|"



# 'Uniq' Command #1
uniq


# 'Uniq' Command #2
uniq -c | awk '{ sub(/^[ \t]+/, ""); print }'
uniq -c | cut -c7-
uniq -c | tr -s " " | cut -c2-



# 'Uniq' command #3
uniq -ci | cut -c7-
uniq -ci | sed 's/^[ \t]*//'



# 'Uniq' command #4
uniq -u


# Paste - 1
paste -s -d ";"
paste -s | tr -s $'\t' ';'


# Paste - 2
paste -d ";" - - -



# Paste - 3
paste -s -d $'\t'
paste -s | tr $'\n' $'\t'
paste -sd $'\t'



# Paste - 4
paste -d '\t' - - -
paste - - -
paste -sd $'\t\t\n'













































# Arrays in Bash
# Read in an Array
tr $"\n" $" "
paste -sd $" "
echo $(cat)

arr=($(cat))
echo ${a[@]}

arr=($(cat))
echo ${a[*]}

i=0
while read line; do
    arr[$i]=$line
    ((i++))
done
echo ${arr[@]}



# Slice an Array
arr=($(cat))
echo ${arr[@]:3:5}



# Filter an Array with Patterns
arr=($(cat))
declare -a arr2=(${arr[@]/*[aA]*})
echo ${arr2[*]}

arr=($(cat))
echo ${arr[@]/*[aA]*}



# Count the number of elements in an Array
arr=($(cat))
echo ${#arr[@]}



# Display an element of an array
arr=($(cat))
echo ${arr[3]}



# Concatenate an array with itself
arr=($(cat))
declare -a arr2=(${arr[*]} ${arr[@]} ${arr[*]})
echo ${arr2[@]}



# Remove the First Capital Letter from Each Element
arr=($(cat))
echo ${arr[*]/[A-Z]/.}

readarray arr
echo ${arr[*]/[A-Z]/.}

readarray arr
echo ${arr[*]/[[:upper:]]/.} # replaces first upper with dot

readarray arr
echo ${arr[*]//[[:upper:]]/.} # replaces all uppers with dot


 
# Lonely Integer - Bash!
read
cat | tr " " "\n" | sort | uniq -u

read
arr=($(cat))
arr=${arr[*]}
echo $((${arr// /^}))

read
echo $(( `tr ' ' '^'` ))
















































# Grep Sed Awk
# 'Grep' - A
grep -Eiw "(the|that|then|those)"
grep -Eiw "the|that|then|those"
grep -iw "\(the\|that\|then\|those\)"
grep -iw "the\|that\|then\|those"

-w option matches only whole words.
-i option causes a case-insensitive search.
-E  # The only difference is that in basic regular expressions the meta-characters ?, +, {, |, (, and ) are interpreted as literal characters. 



# 'Grep' - B
grep '\([0-9]\) *\1'
grep '\([0-9]\) \?\1'
grep '\([0-9]\)\s*\1'
grep '\(\d\)\s\?\1'
grep  "\(\\d\)\\s\?\\1"
grep  "\(\\d\)\\s*\\1"



# 'Sed' command #3
sed -e "s/thy/{&}/gI"
sed -e "s/thy/{&}/gi"
sed -e "s/[Tt]hy/{&}/g"
sed -e "s/thy/{&}/g" -e "s/Thy/{&}/g"
sed "s/thy/{&}/g" | sed "s/Thy/{&}/g"



# 'Sed' command #1
sed "s/\bthe\b/this/"
sed "s/\<the\>/this/"
sed 's/ the / this /1'
sed 's/ the / this /'



# 'Sed' command #2
sed "s/\bthy\b/your/ig"
sed "s/\<thy\>/your/ig"



# 'Grep' #1
grep "\<the\>"
grep -w "the"



# 'Grep' #2
grep -i "\<the\>"
grep -iw "the"



# 'Grep' #3
grep -iwv "that"



# 'Awk' - 1
awk '{if ($4 == "") 
    print "Not all scores are available for", $1
    }'

awk '{if (NF < 4) 
    print "Not all scores are available for", $1
    }'

awk 'NF!=4 {print "Not all scores are available for", $1}'

awk '$4=="" {print "Not all scores are available for " $1}'

# some fuctions
awk "{print;}"
awk '{print $2,$5;}' some_text.txt
awk '$1 > 200' some_text.txt
awk "/A/; /B/"



# 'Awk' - 2
awk '{if ($2>=50 && $3>=50 && $4>=50)
    print $1 " : Pass"
    else
    print $1 " : Fail"
    }'



# 'Awk' - 3
awk '{if (($2+$3+$4)/3>=80)
    print $0, ": A"
    else if (($2+$3+$4)/3>=60)
    print $0, ": B"
    else if (($2+$3+$4)/3>=50)
    print $0, ": c"
    else 
    print $0, ": FAIL"
    }'

awk '{avg=(($2+$3+$4)/3)
    if (avg>=80)
    print $0, ": A"
    else if (avg>=60)
    print $0, ": B"
    else if (avg>=50)
    print $0, ": c"
    else
    print $0, ": FAIL"
    }'

awk '{avg=(($2+$3+$4)/3)
    if (avg>=80)
    grade="A"
    else if (avg>=60)
    grade="B"
    else if (avg>=50)
    grade="B"
    else
    grade="FAIL"
    
    print $0, ":", grade
    }'    



# 'Awk' - 4
awk 'ORS=NR%2?";":"\n"'



# 'Sed' command #4
sed -e 's/\b\d\d\d\d\b/****/1' -e 's/\b\d\d\d\d\b/****/1' -e 's/\b\d\d\d\d\b/****/1'
sed -e 's/\d\{4\} /**** /1' -e 's/[0-9]\{4\} /**** /1' -e 's/\d\+/****/1'
sed 's/\d\+ /**** /g'
sed 's/\d\{4\} /**** /g'
sed 's/[0-9]\+ /**** /g'



# 'Sed' command #5
sed 's/\(\d\{4\} \)\(\d\{4\} \)\(\d\{4\} \)\(\d\{4\}\)/\4 \3\2\1/'
sed 's/\(\d\{4\}\) \(\d\{4\}\) \(\d\{4\}\) \(\d\{4\}\)/\4 \3 \2 \1/'



