#!/usr/bin/env bash
# hack to deal with dates that have 0 COVID cases
COVIDCASES=$(grep '2020' ./data/casesTotal.json | sort | uniq -c | awk '{print $1}' | awk '{total += $0; $0 = total}1')
COVIDDATES=$(grep '2020' ./data/casesTotal.json | sort | uniq -c | awk '{print $5}' | sed -e 's/"//g' -e 's/,//g')
MISSINGDATES=$(echo -e "2020-05-02,1490\n2020-05-04,1491\n2020-05-11,1501\n2020-05-12,1501\n2020-05-13,1501\n2020-05-16,1504\n2020-05-17,1504\n2020-05-18,1504\n2020-05-19,1504\n2020-05-20,1504\n2020-05-21,1504\n2020-05-22,1504\n2020-05-23,1504\n2020-05-24,1504\n2020-05-25,1504") # have to manually edit these points at the moment as there were no cases those daya
CODVIDDATA=$(paste <(echo "$COVIDDATES") <(echo "$COVIDCASES") --delimiters ',')
echo -e "$CODVIDDATA\n$MISSINGDATES" | sort | sed 1i"Date of report,Cases" | csvjson | jq > ./data/cumulative_COVID_data.json
# clean up
unset COVIDCASES COVIDDATES MISSINGDATES CODVIDDATA
#?END
