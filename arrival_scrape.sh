#!/usr/bin/env bash
sed -E "s|([0-9]{1,2})/([0-9]{2})/([0-9]{4})|\3-\2-\1|" data/arrival_data.csv | sed -E "s|([0-9]{1,2})/([0-9]{2})/([0-9]{4})|\3-\2-\1|" | csvjson | jq > data/arrival_data.json