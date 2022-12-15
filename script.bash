#!/bin/bash

# Import secrets
. ./.secrets

# Get a random fact
json_fact=`curl -s https://api.chucknorris.io/jokes/random`
fact_id=`echo ${json_fact} | jq -r '.id'`

# Look for this fact in local db
local_fact=`sqlite3 local.sqlite3 "SELECT * FROM facts WHERE ID='${fact_id}';"`
if [ ! -z "${local_fact}" ]; then
  text=`echo ${local_fact} | cut -d'|' -f3 | sed -r 's/__/\"/g'`
else
  original_text=`echo ${json_fact} | jq -r '.value'`

  # Translate
  ret=`curl -s https://api-free.deepl.com/v2/translate -d auth_key=${AUTH_KEY} -d "text=${original_text}" -d "target_lang=FR"`
  text=`echo $ret | jq -r '.translations[0].text'`

  # Store translation in local DB
  clean_text=`echo ${text} | sed -r 's/\"/__/g'`
  clean_original_text=`echo ${original_text} | sed -r 's/\"/__/g'`
  sqlite3 local.sqlite3 "INSERT INTO facts VALUES (\"${fact_id}\", \"${clean_original_text}\", \"${clean_text}\");"
fi

# Return fact
echo $text
