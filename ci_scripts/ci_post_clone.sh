#!/bin/sh

#  ci_post_clone.sh
#  LegisLink
#
#  Created by Mason Cochran on 7/18/24.
#  

echo "Stage: POST CLONE is activated .... "

# Move to the place where the scripts are located.
# This is important because the position of the subsequently mentioned files depend of this origin.
#cd $CI_WORKSPACE/ci_scripts || exit 1

# Write a file containing all the environment variables and secrets.

cd ..

ls

echo "ls 1"

cd "Development Environment"

ls

echo "ls 2"


printf "APP_NAME = \"%s\"\n" "$APP_NAME" >> DevelopmentBuildConfig.xcconfig
printf "GOOGLE_API_KEY = \"%s\"\n" "$GOOGLE_API_KEY" >> DevelopmentBuildConfig.xcconfig
printf "OPEN_SECRETS_API_KEY = \"%s\"\n" "$OPEN_SECRETS_API_KEY" >> DevelopmentBuildConfig.xcconfig
printf "CONGRESS_GOV_API_KEY = \"%s\"\n" "$CONGRESS_GOV_API_KEY" >> DevelopmentBuildConfig.xcconfig
printf "OPEN_STATES_API_KEY = \"%s\"\n" "$OPEN_STATES_API_KEY" >> DevelopmentBuildConfig.xcconfig
printf "NYT_API_KEY = \"%s\"\n" "$NYT_API_KEY" >> DevelopmentBuildConfig.xcconfig
printf "AWS_REGION = \"%s\"\n" "$AWS_REGION" >> DevelopmentBuildConfig.xcconfig
printf "AWS_ACCESS_KEY_ID = \"%s\"\n" "$AWS_ACCESS_KEY_ID" >> DevelopmentBuildConfig.xcconfig
printf "AWS_SECRET_ACCESS_KEY = \"%s\"\n" "$AWS_SECRET_ACCESS_KEY" >> DevelopmentBuildConfig.xcconfig


echo "Wrote to xcconfig file."

ls

echo "ls 2"


echo "Stage: PRE-Xcode Build is DONE .... "

if [ -f "../Development Environment/DevelopmentBuildConfig.xcconfig" ]; then
    echo "File created successfully!"
else
    echo "Error: File creation failed."
fi

exit 0

