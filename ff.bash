#!/bin/bash

# Quick file finder.
#
# Search for whole term:- "*myterm*"
# $ fn search
# 0 search.py
# 1 dir/place/search-items.html
# 2 dir/my_search.lst
#
# Search fuzzy:- "*m*y*t*e*r*m*"
# $ fz manp
# 0 place/mananger/point.py
# 1 camannox.py
# 2 taman.py


# Find files, ignore git/python dirs
function find-ignore()
{
    find . -iname "${@}" -not \( -path "*/.git/*" -prune \) \
        -not \( -path "*/.venv/*" -prune \) -printf '%P\n'
}

# Print counter with files
function find-counter()
{
    COUNTER=1
    for FILE in $(find-ignore ${1}); do
        echo ${COUNTER} ${FILE}
        FILE_CACHE[${COUNTER}]="${FILE}"
        ((COUNTER++))
    done

}

# Find name "*filename*"
function fn()
{
    if [ -z $1 ]; then return ; fi
    FILE_CACHE=( )
    FIND_TERM="*${@}*"
    # Going to terminal fd
    if [ -t 1 ]; then
        # Try and highlight match
        find-counter "${FIND_TERM}" | grep "\(${@}\)\|^"
    else
        find-ignore ${FIND_TERM} 
    fi

}

# Fuzzy find name "*f*i*l*e*n*a*m*e*"
function fz()
{
    if [ -z $1 ]; then return ; fi
    FILE_CACHE=( )
    FIND_TERM=$(sed -e 's/./*\0/g' -e 's/$/*/' <<< "$@")
    if [ -t 1 ]; then
        find-counter "${FIND_TERM}"
    else
        find-ignore ${FIND_TERM}
    fi
}

# Open file stored in FILE_CACHE
function fx()
{
    N=${1:-0}
    OBJ=${FILE_CACHE[${N}]}
    if [ -d ${OBJ} ]; then
        cd ${OBJ}
    else
        ${EDITOR:-vi} ${OBJ}
    fi
}
