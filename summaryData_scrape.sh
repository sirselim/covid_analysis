#!/usr/bin/env bash
# horrible script to scrape summary data
curl "https://www.health.govt.nz/our-work/diseases-and-conditions/covid-19-novel-coronavirus/covid-19-current-situation/covid-19-current-cases" 2>/dev/null | \
grep -i -e '</\?TABLE\|</\?TD\|</\?TR\|</\?TH' | \
sed 's/^[\ \t]*//g' | \
tr -d '\n' | \
sed 's/<\/TR[^>]*>/\n/Ig' | \
sed 's/<\/\?\(TABLE\|TR\)[^>]*>//Ig' | \
sed 's/^<T[DH][^>]*>\|<\/\?T[DH][^>]*>$//Ig' | \
sed 's/<\/T[DH][^>]*><T[DH][^>]*>/,/Ig' | \
grep -i -e 'total to date' -A 6 | \
sed 's/<th scope="col">//Ig' | \
sed 's/^,//Ig' | sed '1d' | \
sed 's/<\/strong[^>]*>//Ig' | sed 's/<strong[^>]*>//Ig' |
sed 's/<b>//Ig' | sed 's/<\/b>//Ig' | \
sed -E 's/([0-9]{1}),([0-9]{3})/\1\.\2/g' | sed -E 's/\.//g' | \
sed 1i"Type,Total,Last24hrs" > data/dailySummaryStats.csv
# keeping the intermediate csv incase it's required
csvjson data/dailySummaryStats.csv | jq > data/dailySummaryStats.json
#/END
