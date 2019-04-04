#!/bin/bash

rest_url=$1
outputfile=$2

read -p "Username: \n" username
read -s -p "Password: \n" password
nifi_url="https://nifi.domain.com:9091"

auth="username="${username}"&password="${password}
token=$(curl -s -S -X POST -H "Accept: */*" -H "Accept-Language: en-US,en;q=0.5" -H "Connection: keep-alive" -d $auth  ${nifi_url}/nifi-api/access/token -k)
if [ ${#token} -gt 100 ]; then
  echo "\nToken acquired. Proceeding to fetch ${nifi_url}/$1 "
  curl -s -S -k -X GET -H "Accept: */*"\
                 -H "Accept-Language: en-US,en;q=0.5"\
                 -H "Authorization: Bearer $token"\
                 -H "Connection: keep-alive"\
                 -H "Referer: ${nifi_url}/nifi/login" \
                 -H "X-Requested-With: XMLHttpRequest" \
                 ${nifi_url}/$rest_url > $outputfile
  echo "Converting output to json format"
  python ./jsonformat.py $outputfile > ${outputfile}.json
  echo "Results saved into ${outputfile}.json "
else
  echo "Authentication failed.Exiting"
fi
