FROM continuumio/anaconda3:2020.02

RUN easy_install xlsx2csv && \
  pip install csvkit && \
  apt install jq -y

COPY ./covid_data_scrape.sh .
COPY ./xlsx2json.sh .

CMD ./covid_data_scrape.sh; ./xlsx2json.sh
