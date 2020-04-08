#!/usr/bin/env bash
# horrible script to scrape test data
curl "https://www.health.govt.nz/our-work/diseases-and-conditions/covid-19-novel-coronavirus/covid-19-current-situation/covid-19-current-cases#lab" 2>/dev/null | \
grep -i -e '</\?TABLE\|</\?TD\|</\?TR\|</\?TH' | \
sed 's/^[\ \t]*//g' | \
tr -d '\n' | \
sed 's/<\/TR[^>]*>/\n/Ig' | \
sed 's/<\/\?\(TABLE\|TR\)[^>]*>//Ig' | \
sed 's/^<T[DH][^>]*>\|<\/\?T[DH][^>]*>$//Ig' | \
sed 's/<\/T[DH][^>]*><T[DH][^>]*>/,/Ig' | \
grep -i -e 'Emergencies' -B 60 | \
grep -i -e 'date,tests' -A 60 | \
grep -i -e 'Emergencies' -v | \
sed 's/<th scope="col">//Ig' | 
sed 's/^,//Ig' | sed -r 's/\<[0-9]{1,2}-[a-zA-Z]{3}\>/&-2020/' | \
sed 's/Mar/03/g' | sed 's/Apr/04/g' | tr '-' '/' | sed -E "s|([0-9]{1,2})/([0-9]{2})/([0-9]{4})|\3-\2-\1|" | tr '-' '/' | \
csvjson | jq > data/NZ_testing_stats.json
#/END
