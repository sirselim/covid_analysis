#!/usr/bin/env bash
# define variables
confirmed="NZCOVID_confirmed_formatted.json"
probable="NZCOVID_probable_formatted.json"
# convert to json
xlsx2csv data/NZ_COVID19_data.xlsx -f %Y/%m/%d -s 1 | tail -n +4 | csvjson | jq > data/"$confirmed"
xlsx2csv data/NZ_COVID19_data.xlsx -f %Y/%m/%d -s 2 | tail -n +4 | csvjson | jq > data/"$probable"
#/END