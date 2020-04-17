#!/usr/bin/env bash

# Check if an override directory has been specified for the output files
if [ "$1" != "" ]; then
  outputDir=$1
else
  outputDir='data'
fi

# define variables
confirmed="NZCOVID_confirmed_formatted.json"
probable="NZCOVID_probable_formatted.json"
# convert to json
xlsx2csv "$outputDir/NZ_COVID19_data.xlsx" -f %Y/%m/%d -s 1 | tail -n +4 | sed -E "s|([0-9]{1,2})/([0-9]{2})/([0-9]{4})|\3-\2-\1|" | tr '-' '/' | csvjson | jq '.' > "$outputDir/$confirmed"
xlsx2csv "$outputDir/NZ_COVID19_data.xlsx" -f %Y/%m/%d -s 2 | tail -n +4 | sed -E "s|([0-9]{1,2})/([0-9]{2})/([0-9]{4})|\3-\2-\1|" | tr '-' '/' | csvjson | jq '.' > "$outputDir/$probable"
#/END
