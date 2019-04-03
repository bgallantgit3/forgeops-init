#!/usr/bin/env bash

# This script and a supporting web.xml file should be placed in the
# configuration repository at the path defined by the config.importPath
# property in the custom.yaml file.

echo "Customizing the AM web application for CORS web.xml"
echo ""

echo "Available environment variables:"
echo "================================"
echo ""
env
echo ""

# Copy the web.xml file that is in the same directory as this script to the
# webapps/openam/WEB-INF directory
echo "Copy web.xml file to ${CATALINA_HOME}/webapps/ROOT/WEB-INF"
echo "=========================================================="
echo ""
cp /git/config/6.5/frudevops-blair/am/development/web.xml ${CATALINA_HOME}/webapps/ROOT/WEB-INF

echo "Finished customizing the AM web application for CORS web.xml"
echo ""
