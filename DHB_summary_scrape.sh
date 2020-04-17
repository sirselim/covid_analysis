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
grep -i -e 'DHB,Active,Recovered' -A 20 | \
sed 's/<th scope="col">//Ig' | \
sed 's/^,//Ig' | sed '1d' | \
sed 's/<\/strong[^>]*>//Ig' | sed 's/<strong[^>]*>//Ig' | \
sed 's/&nbsp;//Ig' | \
sed 1i"DHB,Active,Recovered,Deceased,Total,Change in last 24 hours" | \
csvjson | jq > data/DHB_summaryStats.json
#/END
