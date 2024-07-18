#!/bin/sh

#  ci_pre_xcodebuild.sh
#  
#
#  Created by Mason Cochran on 7/18/24.
#


echo "Stage: PRE-Xcode Build is activated .... "

# Move to the place where the scripts are located.
# This is important because the position of the subsequently mentioned files depend of this origin.
cd $CI_WORKSPACE/ci_scripts || exit 1

# Write a JSON File containing all the environment variables and secrets.
printf "{\"APP_NAME\":\"%s\",
        \"GOOGLE_API_KEY\":\"%s\",
        \"OPEN_SECRETS_API_KEY\":\"%s\",
        \"CONGRESS_GOV_API_KEY\":\"%s\",
        \"OPEN_STATES_API_KEY\":\"%s\",
        \"NYT_API_KEY\":\"%s\",
        \"AWS_REGION\":\"%s\",
        \"AWS_ACCESS_KEY_ID\":\"%s\",
        \"AWS_SECRET_ACCESS_KEY\":\"%s\"}"
        "$APP_NAME"
        "$GOOGLE_API_KEY"
        "$OPEN_SECRETS_API_KEY"
        "$CONGRESS_GOV_API_KEY"
        "$OPEN_STATES_API_KEY"
        "$NYT_API_KEY"
        "$AWS_REGION"
        "$AWS_ACCESS_KEY_ID"
        "$AWS_SECRET_ACCESS_KEY"  >> LegisLink/Development Environment/DevelopmentBuildConfig.xcconfig

echo "Wrote Secrets.json file."

echo "Stage: PRE-Xcode Build is DONE .... "
