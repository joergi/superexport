#!/bin/bash
# feel free to change this
superexportfolder=/home/$(whoami)/.superexport


#start with
# ./superexporter.sh ARTIFACTORY_USERNAME username springernature/shared/artifactory

# $1 = NAME how it should be exported, mostly written in BIG LETTERS
# $2 = the name it has in vault
# $3 = my/way/in/vault/vault
# $4mkdir $superexportfolder

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
 chmod +x $superexportfolder/.exported.sh
fi

echo -e $export >> $superexportfolder/.exported.sh

####################################
# reading passwords out of secrets #
####################################

if [ ! -f $superexportfolder/.secretreader.sh ]; then
 echo "#!/bin/bash" > $superexportfolder/.secretreader.sh
 chmod +x $superexportfolder/.secretreader.sh
fi

secretreader="export $1=\$(secret-tool lookup \$USER $secretname)"
echo -e $secretreader >> $superexportfolder/.secretreader.sh
