#!/bin/bash
# The following colors have been defined to help with presentation of logs: green, red, label_color, no_color.  
echo -e "${label_color}Starting build script${no_color}"

echo "This is from the init docker build sh"
./prepareserver.sh

# The IBM Container Service CLI (ice), Git client (git), IDS Inventory CLI (ids-inv) and Python 2.7.3 (python) have been installed.
# Based on the organization and space selected in the Job credentials are in place for both IBM Container Service and IBM Bluemix 
#####################
# Run unit tests    #
#####################
echo -e "${label_color}No unit tests cases have been checked in ${no_color}"

######################################
# Build Container via Dockerfile     #
######################################

# REGISTRY_URL=${CCS_REGISTRY_HOST}/${NAMESPACE}
# FULL_REPOSITORY_NAME=${REGISTRY_URL}/${IMAGE_NAME}:${APPLICATION_VERSION}

if [ -f Dockerfile ]; then 
    echo -e "${label_color}Building ${FULL_REPOSITORY_NAME} ${no_color}"
    BUILD_COMMAND=""
    if [ "${USE_CACHED_LAYERS}" == "true" ]; then 
        BUILD_COMMAND="ice build --pull --tag ${FULL_REPOSITORY_NAME} ${WORKSPACE}"
        ${BUILD_COMMAND}
        RESULT=$?
    else 
        BUILD_COMMAND="ice build --no-cache --tag ${FULL_REPOSITORY_NAME} ${WORKSPACE}"
        ${BUILD_COMMAND}
        RESULT=$?
    fi 

    if [ $RESULT -ne 0 ]; then
        echo -e "${red}Error building image ${no_color}" | tee -a "$ERROR_LOG_FILE"
        echo "Build command: ${BUILD_COMMAND}"
        ice info 
        ice images
        ${EXT_DIR}/print_help.sh
        exit 1
    else
        echo -e "${green}Container build of ${FULL_REPOSITORY_NAME} was successful ${no_color}"
    fi  
else 
    echo -e "${red}Dockerfile not found in project${no_color}"
    exit 1
fi  

######################################################################################
# Copy any artifacts that will be needed for deployment and testing to $WORKSPACE    #
######################################################################################
echo "IMAGE_NAME=${FULL_REPOSITORY_NAME}" >> $ARCHIVE_DIR/build.properties