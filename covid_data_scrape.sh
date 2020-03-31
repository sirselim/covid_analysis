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
  grep -Po '/system/files/documents/pages/covid-cases-[0-9]{0,2}_[a-zA-Z]{0,5}_2020.xlsx')
download_url=$(echo $moh_url$url_result)
output="$outputDir/NZ_COVID19_data.xlsx"
# download excel file
wget -nv "$download_url" -O "$output"
#/END