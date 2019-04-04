# run_nifi_curl
Simple bash script to invoke NiFi REST APIs via curl and return output in pretty json format

Change nifi url in script, and if you want set username in script. 
Make sure jsonformat.py is also in same node.
run as

`./run_curl.sh nifi-api/process-groups/root/process-groups?recursive=true pg_list`
