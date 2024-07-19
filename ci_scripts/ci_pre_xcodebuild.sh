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
printf "GOOGLE_API_KEY = \"%s\"\n" "$GOOGLE_API_KEY" >> ../Development\ Environment/DevelopmentBuildConfig.xcconfig
printf "OPEN_SECRETS_API_KEY = \"%s\"\n" "$OPEN_SECRETS_API_KEY" >> ../Development\ Environment/DevelopmentBuildConfig.xcconfig
printf "CONGRESS_GOV_API_KEY = \"%s\"\n" "$CONGRESS_GOV_API_KEY" >> ../Development\ Environment/DevelopmentBuildConfig.xcconfig
printf "OPEN_STATES_API_KEY = \"%s\"\n" "$OPEN_STATES_API_KEY" >> ../Development\ Environment/DevelopmentBuildConfig.xcconfig
printf "NYT_API_KEY = \"%s\"\n" "$NYT_API_KEY" >> ../Development\ Environment/DevelopmentBuildConfig.xcconfig
printf "AWS_REGION = \"%s\"\n" "$AWS_REGION" >> ../Development\ Environment/DevelopmentBuildConfig.xcconfig
printf "AWS_ACCESS_KEY_ID = \"%s\"\n" "$AWS_ACCESS_KEY_ID" >> ../Development\ Environment/DevelopmentBuildConfig.xcconfig
printf "AWS_SECRET_ACCESS_KEY = \"%s\"\n" "$AWS_SECRET_ACCESS_KEY" >> ../Development\ Environment/DevelopmentBuildConfig.xcconfig


echo "Wrote to xcconfig file."

echo "Stage: PRE-Xcode Build is DONE .... "

exit 0

