#!/bin/bash

# Authentication with github
gitget () {
  curl -H "Authorization:token e584e9cf8bd3e6c52c3dabea13197e3f94c90095" $@
}

# Save to intermediary file
gitget https://gecgithub01.walmart.com/api/v3/repos/workshop/frontend/releases > .json

# We get the download url from the JSON via Python
json=$(python -c "import json; j = json.load(open('.json', 'r')); print [x for x in j if x['tag_name'] == '$OO_LOCAL{version}'][0]['assets'][0]['url']")

# Delete intermediary file
rm .json

# Download the tar
gitget -H "Accept:application/octet-stream" -L $json > /tmp/release.zip

# Unzip the tar
unzip /tmp/release.zip -d "$OO_LOCAL{release-dir}"
