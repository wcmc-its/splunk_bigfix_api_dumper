#!/usr/bin/bash

# read in authentication token from splunk
read AUTH_TOKEN 
export AUTH_TOKEN 

# debug arguments
#echo $(env)
#echo TOKEN: $AUTH_TOKEN 

# override splunk's pythonpath
unset PYTHONPATH


# script mode variables
APP_LOCATION="$SPLUNK_HOME/etc/apps/bigfix_api_dumper"
SCRIPT_ARGS="$APP_LOCATION"
SCRIPT_LOCATION="$APP_LOCATION/bin/bigfix_api_dumper.py"
SCRIPT_CMD="$SCRIPT_LOCATION $SCRIPT_ARGS"
VENV_PATH="$APP_LOCATION/bin/venv"
# debug SCRIPT_CMD
#echo $SCRIPT_CMD

# create the venv
if [[ ! -d $VENV_PATH ]];
then
    echo "attempting to configure virtualenv in $VENV_PATH"
    /usr/local/bin/virtualenv $VENV_PATH
    source $VENV_PATH/bin/activate
    # install prereqs
    pip3 install requests lxml
    deactivate
fi

# call python 3 to execute the bigfix api dumper script
source $VENV_PATH/bin/activate
python3 -O $SCRIPT_CMD
