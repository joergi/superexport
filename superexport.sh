#!/bin/bash
# _____                       _____                      _
#/  ___|                     |  ___|                    | |
#\ `--. _   _ _ __   ___ _ __| |____  ___ __   ___  _ __| |_
# `--. \ | | | '_ \ / _ \ '__|  __\ \/ / '_ \ / _ \| '__| __|
#/\__/ / |_| | |_) |  __/ |  | |___>  <| |_) | (_) | |  | |_
#\____/ \__,_| .__/ \___|_|  \____/_/\_\ .__/ \___/|_|   \__|
#            | |                       | |
#            |_|                       |_|

set -euo pipefail
IFS=$'\n\t'

# feel free to change this
superexportfolder=/home/$(whoami)/.superexport

#######################
# check the variables #
#######################

# superexporter EXPORTED_USERNME username company/project/

if [ $# -lt 4 ]
then
  echo " "
  echo "error - all four parameters needed"
  echo " "
  echo "try: superexport MY_KEY name-in-vault companyname/teamname/folder-with-secret a-prefix"
  echo " "
  echo "MY_KEY - the variable under which you want to make it available"
  echo "name-in-vault - should be something like username or password ..."
  echo "companyname/teamname/folder-with-secret - under which you find the secrets"
  echo "a-prefix - there are maybe many usernames later - so you can give it a specific prefix, so there is no confusion"
  exit 1
fi

if [[ -z $1 ]]; then
    echo "1st parameter can't be empty - it's the name how it should be exported (how it's used in your project), mostly written in BIG LETTERS"
    echo "try: superexport MY_KEY name-in-vault companyname/teamname/folder-with-secret a-prefix"
     echo " "
     echo "MY_KEY - the variable under which you want to make it available"
     echo "name-in-vault - should be something like username or password ..."
     echo "companyname/teamname/folder-with-secret - under which you find the secrets"
     echo "a-prefix - there are maybe many usernames later - so you can give it a specific prefix, so there is no confusion"
    exit 1
fi

if [[ -z $2 ]]; then
    echo "2nd parameter can't be empty - it's name under what it is saved in vault"
    echo " "
    echo "try: superexport MY_KEY name-in-vault companyname/teamname/folder-with-secret a-prefix"
    echo " "
    echo "MY_KEY - the variable under which you want to make it available"
    echo "name-in-vault - should be something like username or password ..."
    echo "companyname/teamname/folder-with-secret - under which you find the secrets"
    echo "a-prefix - there are maybe many usernames later - so you can give it a specific prefix, so there is no confusion"
    exit 1
fi

if [[ -z $3 ]]; then
    echo "3rd parameter can't be empty - it's the navigation in vault to the secret"
    echo " "
    echo "try: superexport MY_KEY name-in-vault companyname/teamname/folder-with-secret a-prefix"
    echo " "
    echo "MY_KEY - the variable under which you want to make it available"
    echo "name-in-vault - should be something like username or password ..."
    echo "companyname/teamname/folder-with-secret - under which you find the secrets"
    echo "a-prefix - there are maybe many usernames later - so you can give it a specific prefix, so there is no confusion"
    exit 1
fi

if [[ -z $4 ]]; then
    echo "4th parameter can't be empty - this is the prefix for the secret name in you secret tools - because username can be only used ones"
    echo " "
    echo "try: superexport MY_KEY name-in-vault companyname/teamname/folder-with-secret a-prefix"
    echo " "
    echo "MY_KEY - the variable under which you want to make it available"
    echo "name-in-vault - should be something like username or password ..."
    echo "companyname/teamname/folder-with-secret - under which you find the secrets"
    echo "a-prefix - there are maybe many usernames later - so you can give it a specific prefix, so there is no confusion"
    exit 1
fi

######################################################
# check if superexportfolder exist, if not create it #
# ####################################################
if [ ! -d $superexportfolder ]; then
 mkdir $superexportfolder
fi

#######################################################
# set the secretname to lowercase and put a prefix on #
#######################################################
## todo check if $4 is set or not
secretname=$(echo $1 | tr '[:upper:]' '[:lower:]')
secretname=$4-$secretname

###########################################################
# get variables out of vault and export it to the secrets #
###########################################################
export="export $1=\$(vault kv get -field=$2 \"$3\")"
export+="\n"
export+="echo \$$1 | secret-tool store --label=\"\$USER $secretname\" \$USER $secretname"
export+="\n"

###########################
# write .exported.sh file #
###########################
if [ ! -f $superexportfolder/.exported.sh ]; then
 echo "#!/bin/bash" > $superexportfolder/.exported.sh
 echo "set -euo pipefail" >> $superexportfolder/.exported.sh
 echo "IFS=\$'\n\t'" >> $superexportfolder/.exported.sh
 newlines="\n"
 echo -e $newlines >> $superexportfolder/.exported.sh

 chmod +x $superexportfolder/.exported.sh
fi

echo -e $export >> $superexportfolder/.exported.sh
bash $superexportfolder/.exported.sh

####################################
# reading passwords out of secrets #
####################################

if [ ! -f $superexportfolder/.secretreader.sh ]; then
 echo "#!/bin/bash" > $superexportfolder/.secretreader.sh
 chmod +x $superexportfolder/.secretreader.sh
fi

secretreader="export $1=\$(secret-tool lookup \$USER $secretname)"
echo -e $secretreader >> $superexportfolder/.secretreader.sh

