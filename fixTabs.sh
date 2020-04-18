#!/bin/bash
#===============================================================================
#   @file   fixTabs.sh
#   @brief  This script replaces tab spacing with 4-space tabs
#   @author Michael Steppe
#===============================================================================

# Define variables for the various console colors used by this script
RED="\e[0;31mERROR: "
CYAN="\e[0;36mINFO: "
GREEN="\e[0;32mSUCCESS: "
YELLOW="\e[0;33mWARNING: "
RESET="\e[0m"
BOLD="\e[1m"

# This function prints the usage statement
function usage()
{
    echo "Usage: $(basename ${0}) -s NUM_SPACES -f FILE [--help]"
    echo ""
    echo "   -f FILE        File to replace tab spaces in"
    echo ""
    echo "   -s NUM_SPACES  Number of spaces per tab you wish to replace with a 4-space tab"
    echo ""
    echo "   --help         Print this message"
    echo ""
}

# Parse the command line arguments
while [[ ${#} -gt 0 ]]; do
    case ${1} in
        -f)
            shift
            fileToEdit="${1}"
            if [[ "${fileToEdit}" == "" ]] || [[ "${fileToEdit:0:1}" == "-" ]]; then
                echo -en "${RED}No file given after -f flag or next argument is another flag. "
                echo -e  "-f = '${fileToEdit}'. Exiting...${RESET}"
                echo
                usage
                exit 1
            elif [[ ! -f ${fileToEdit} ]]; then
                echo -en "${RED}'${fileToEdit}' does not exist or not a regular file. "
                echo -e  "Exiting...${RESET}"
                echo
                usage
                exit 1
            fi
            ;;
        -s)
            shift
            numSpaces="${1}"
            if [[ "${numSpaces}" == "" ]] || [[ "${numSpaces:0:1}" == "-" ]]; then
                echo -en "${RED}No postive integer given after -s flag or next argument is another "
                echo -e  "flag. -s = '${numSpaces}'. Exiting...${RESET}"
                echo
                usage
                exit 1
            else
                if [[ ! ${numSpaces} =~ ^[0-9]+$ ]]; then
                    echo -e "${RED}'${numSpaces}' is not a positive integer. Exiting...${RESET}"
                    echo
                    usage
                    exit 1
                fi
            fi
            ;;
        --help)
            usage
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid argument passed to $(basename ${0}): ${1}${RESET}"
            echo
            usage
            exit 1
            ;;
    esac
    shift
done

# Want to make sure that -s flag was entered
if [[ -z ${numSpaces} ]] ; then
    echo -e "${RED}You must provide the number of tab spaces to replace. Exiting...${RESET}"
    echo
    usage
    exit 1
fi

# Want to make sure that -f flag was entered
if [[ -z ${fileToEdit} ]] ; then
    echo -e "${RED}You must provide the file to edit. Exiting...${RESET}"
    echo
    usage
    exit 1
fi

# Arguments parsed successfully
echo -en "${CYAN}Replacing ${numSpaces}-space tab widths with 4-space tab "
echo -e  "widths in '${fileToEdit}'...${RESET}"

spacesFromUser="" # We'll build this up below
spacesToReplace="    " # Defaults to 4 spaces

i=1
while [[ ${i} -le ${numSpaces} ]]; do
    spacesFromUser="${spacesFromUser} "
    i=$((${i}+1))
done

echo -e "${CYAN}Backing up '${fileToEdit}'...${RESET}"
cp ${fileToEdit} ${fileToEdit}.bak

# Replace up to 10 indents (these two for loops MUST match number of iterations)
# This loop grows the search terms to 10x the number of spaces
for f in {1..10}; do
    replaceThese="${replaceThese}${spacesFromUser}"
    withThese="${withThese}${spacesToReplace}"
done
# This loop replaces spaces and decrements the search terms
for f in {1..10}; do
    sed -i -r "s/^${replaceThese}([^ ])/${withThese}\1/" ${fileToEdit}
    replaceThese=$(echo "${replaceThese}" | sed "s/${spacesFromUser}\$//")
    withThese=$(echo "${withThese}" | sed "s/${spacesToReplace}\$//")
done

echo -e "${GREEN}Replaced tab spaces in file.${RESET}"

