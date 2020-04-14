#!/usr/bin/env bash

# Check if an override directory has been specified for the output files
if [ "$1" != "" ]; then
  outputDir=$1
else
  outputDir='data'
fi

# define variables
moh_url="https://www.health.govt.nz"
url_result=$(wget -nv -O- https://www.health.govt.nz/our-work/diseases-and-conditions/covid-19-novel-coronavirus/covid-19-current-situation/covid-19-current-cases/covid-19-current-cases-details | \
  grep -Po '/system/files/documents/pages/.*\.xlsx')
download_url=$(echo $moh_url$url_result)
output="$outputDir/NZ_COVID19_data.xlsx"
# download excel file
wget -nv "$download_url" -O "$output"
# format data for total plotting
xlsx2csv data/NZ_COVID19_data.xlsx -f %Y/%m/%d -s 1 | tail -n +5 | cut -d',' -f 1 | awk -v OFS=',' '{print $1,$2="confirmed"}' | sed -e '1i\'$'\n''Date of report,status' > data/confirmedOnly.txt
xlsx2csv data/NZ_COVID19_data.xlsx -f %Y/%m/%d -s 2 | tail -n +5 | cut -d',' -f 1 | awk -v OFS=',' '{print $1,$2="probable"}' > data/probableOnly.txt
csvjson <(cat data/confirmedOnly.txt data/probableOnly.txt) | jq > data/casesTotal.json
# clean up
rm data/confirmedOnly.txt data/probableOnly.txt
#/END
