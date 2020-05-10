#!/usr/bin/env bash
echo -e "pulling COVID19 case data from NZ MoH website"
. ./covid_data_scrape.sh
echo -e "...done..."
echo -e "foratting excel data to JSON"
. ./xlsx2json.sh
echo -e "...done..."
echo -e "pulling lab testing data from NZ MoH website"
. ./nz_covid_test_scrape.sh
echo -e "...done..."
echo -e "pulling daily COVID19 summary information from NZ MoH website"
. ./summaryData_scrape.sh
echo -e "...done..."
echo -e "pulling daily COVID19 DHB summary information from NZ MoH website"
. ./DHB_summary_scrape.sh
echo -e "...done..."
echo -e "pulling daily COVID19 DHB summary information from NZ MoH website"
. ./missing_data_process.sh
echo -e "...done..."