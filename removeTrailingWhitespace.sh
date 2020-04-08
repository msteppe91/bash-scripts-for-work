#!/bin/bash
#===============================================================================
#   @file   removeTrailingWhitespaces.sh
#   @brief  This script removes trailing whitespace from a given file
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
    echo "   -f FILE        File in which to remove trailing whitespace"
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

# Want to make sure that -f flag was entered
if [[ -z ${fileToEdit} ]] ; then
    echo -e "${RED}You must provide the file to edit. Exiting...${RESET}"
    echo
    usage
    exit 1
fi

echo -e "${CYAN}Removing whitespace in '${fileToEdit}', while also backing it up...${RESET}"

sed -i.bak -e 's/[[:space:]]\+$//' ${fileToEdit}

echo -e "${GREEN}Successfully removed trailing whitespace from '${fileToEdit}'.${RESET}"

