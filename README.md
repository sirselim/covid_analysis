# Readme - playing with NZ COVID19 data

## resources

This GitHub repo: https://github.com/dixoncheng/covid19map

Data from MoH, (i.e for Mar 30 2020): https://www.health.govt.nz/our-work/diseases-and-conditions/covid-19-novel-coronavirus/covid-19-current-situation/covid-19-current-cases/covid-19-current-cases-details

## setup

**Note:** requires a few dependencies:
>  + jq

1. conda 
   *  `conda create --name excel2csv python=3.7`
   *  `conda activate excel2csv`
2. install [xlsx2csv](https://github.com/dilshod/xlsx2csv) and csvkit (for `csvjson`):
   * `easy_install xlsx2csv`
   * `pip install csvkit`
3. string it all together to get a nicely formatted json:
   * [old]: ~~`xlsx2csv data/covid-cases-only-30_mar_2020.xlsx | csvjson | jq > test.json`~~
   * [Update]: `xlsx2csv data/covid-cases-only-30_mar_2020.xlsx | sed -r 's/([0-9]{1,2})\/([0-9]{2})\/([0-9]{4})/\3\/\2\/\1/g' | csvjson | jq > data/NZCOVID_formatted.json`



## appendix

A space for extra notes.

The data from the Ministry of Health has dates formatted DD/MM/YYYY, this isn't really compatible with most types of data analysis, which expect YYYY/MM/DD.

* Create a csv:
`xlsx2csv data/covid-cases-only-30_mar_2020.xlsx > test.csv`  

* Extract the date reported column, sort and count number of confirmed cases per day:
`tail -n +2 test.csv | tr ',' ' ' | awk '{print $1}' | sort -n -k 1.9 -k 1.5 -k 1 | uniq -c`

Better to do it in place:

* Reverse the date format from DD/MM/YYYY to YYYY/MM/DD:
  * a 'simple' sed command:
`sed -r 's/([0-9]{1,2})\/([0-9]{2})\/([0-9]{4})/\3\/\2\/\1/g'`
  * the full command becomes:
`xlsx2csv data/covid-cases-only-30_mar_2020.xlsx | sed -r 's/([0-9]{1,2})\/([0-9]{2})\/([0-9]{4})/\3\/\2\/\1/g' | csvjson | jq > test.json`