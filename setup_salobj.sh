#!/bin/bash
echo "# Running develop-env/setup.sh"

export LSST_DDS_DOMAIN="fmtest"
if [ "$LSST_DDS_DOMAIN" == "citest" ]
then
    NEW_UUID=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
    export LSST_DDS_DOMAIN=SOCS-DOCKER-${HOSTNAME}-${NEW_UUID}
fi
echo "LSST_DDS_DOMAIN="$LSST_DDS_DOMAIN


# ***** SET THIS PATH *****
export TSREPOS=${HOME}/salobj-home

# Eliminate duplicates from bash history
export HISTCONTROL="ignoreboth"

# ***** CHOOSE THE CORRECT ts_sal *****
# (Note: set TS_SAL_DIR here for use by setup.env):
# * If using the ts_sal included in the Docker image:
#   export TS_SAL_DIR=${HOME}/repos/ts_sal
# * If using your own ts_sal:
#   export TS_SAL_DIR=${TSREPOS}/ts_sal
export TS_SAL_DIR=${HOME}/repos/ts_sal
echo "# Configure ts_sal in ${TS_SAL_DIR}"
source ${TSREPOS}/docker/develop-env/setup_salobj.env

echo "# Load the LSST Stack"
. /opt/lsst/software/stack/loadLSST.bash

# ***** SETUP YOUR PACKAGES *****
# For packages you want to use from the Docker container, instead of
# your own copy in TSREPOS: use ${HOME}/repos instead of ${TSREPOS}.
# For packages you do not want to setup: delete the appropriate pair of lines.
# Be sure to declare packages *before* you setup packages that depend on them.
echo "# Declare and setup packages; please ignore \"Warning: path...\" messages"
setup sconsUtils
eups declare -r ${TSREPOS}/ts_idl ts_idl git -t current
setup -k ts_idl

eups declare -r ${TSREPOS}/HeaderService HeaderService git -t current
setup -k HeaderService

# ts_sal is special because we declared TS_SAL_DIR above
eups declare -r ${TS_SAL_DIR} ts_sal git -t current
setup -k ts_sal

# eups declare -r ${TSREPOS}/ts_config_ocs ts_config_ocs git -t current
# setup -k ts_config_ocs
# eups declare -r ${TSREPOS}/ts_config_attcs ts_config_attcs git -t current
# setup -k ts_config_attcs
# eups declare -r ${TSREPOS}/ts_xml ts_xml git -t current
# setup -k ts_xml
# eups declare -r ${TSREPOS}/ts_salobj ts_salobj git -t current
# setup -k ts_salobj
# eups declare -r ${TSREPOS}/ts_ATDome ts_ATDome git -t current
# setup -k ts_ATDome
# eups declare -r ${TSREPOS}/ts_ATDomeTrajectory ts_ATDomeTrajectory git -t current
# setup -k ts_ATDomeTrajectory
# eups declare -r ${TSREPOS}/ts_ATMCSSimulator ts_ATMCSSimulator git -t current
# setup -k ts_ATMCSSimulator
# eups declare -r ${TSREPOS}/ts_externalscripts ts_externalscripts git -t current
# setup -k ts_externalscripts
# eups declare -r ${TSREPOS}/ts_standardscripts ts_standardscripts git -t current
# setup -k ts_standardscripts
# eups declare -r ${TSREPOS}/ts_scriptqueue ts_scriptqueue git -t current
# setup -k ts_scriptqueue
# eups declare -r ${TSREPOS}/ts_watcher ts_watcher git -t current
# setup -k ts_watcher

/bin/bash --rcfile ${HOME}/salobj-home/.bashrc
