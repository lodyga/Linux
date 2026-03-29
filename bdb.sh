#!/bin/bash
# Bash database

db_set () {
    echo "$1,$2" >> database
}

db_get () {
    grep "^$1," database | sed -e "s/^$1,//" | tail -n 1
}

# db_set name Alice
# db_set name Bob
# db_set city Warsaw

# echo "name: $(db_get name)"   # prints "Bob"
# echo "city: $(db_get city)"   # prints "Warsaw"
