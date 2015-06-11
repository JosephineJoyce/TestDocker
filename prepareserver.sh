#   Licensed Materials - Property of IBM 
#   5725-I43 (C) Copyright IBM Corp. 2011, 2013. All Rights Reserved.
#   US Government Users Restricted Rights - Use, duplication or
#   disclosure restricted by GSA ADP Schedule Contract with IBM Corp.  
   
#!/usr/bin/bash

usage() 
{
   echo " Prepare the IBM MobileFirst Platform Foundation Server Image "
   echo " ------------------------------------------------------------ "
   echo 
   echo " The script is used to load, customize, tag and push the IBM MobileFirst Platform Foundation  "
   echo " Server image on IBM Bluemix Container Cloud Service"
   echo " Assumes: The accompanying script prepareserverdbs.sh is run before executing this script."
   echo
   echo " Silent Execution (arguments provided as command line arguments) : "
   echo " USAGE: prepareserver.sh <command line arguments> "
   echo " command-line arguments: "
   echo " -l SERVER_IMAGE_LOCATION, "
   echo "     --location SERVER_IMAGE_LOCATION       (Mandatory) Exact location of the server image (the tar.gz file)"
   echo " -t SERVER_IMAGE_TAG, "
   echo "      --tag SERVER_IMAGE_TAG                (Mandatory) The tag to be used for tagging the server image with customizations."
   echo "                                            The tag should be of form: registryUrl/repositoryNamespace/tag"
   echo
   echo " Silent Execution (arguments loaded from file) : "
   echo " USAGE: prepareserver.sh <file from which arguments have to be read. "
   echo "   Refer to args.props on the semantics of the file"
   echo 
   echo " Interactive Execution: "
   echo " USAGE: prepareserver.sh"
   echo
   exit 1
}
echo "I am here in prepare server dbs"