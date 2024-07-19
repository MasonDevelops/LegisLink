#!/bin/sh

#  ci_pre_xcodebuild.sh
#  LegisLink
#
#  Created by Mason Cochran on 7/18/24.
#  

echo "Stage: PRE-Xcode Build is activated .... "

# Move to the place where the scripts are located.
# This is important because the position of the subsequently mentioned files depend of this origin.
#cd $CI_WORKSPACE/ci_scripts || exit 1

# Write a file containing all the environment variables and secrets.
printf "APP_NAME = \"%s\"\n" "$APP_NAME" >> ../Development\ Environment/DevelopmentBuildConfig.xcconfig

echo "Wrote to xcconfig file."

echo "Stage: PRE-Xcode Build is DONE .... "

exit 0

