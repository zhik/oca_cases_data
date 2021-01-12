#!/bin/bash

#adapted from https://gist.github.com/ufuk/81568e3e71ce98fda59061912453431f

# PG_HOST=
# PG_USER=
# PG_PASS=
# PG_DB=

function query_and_export_to_csv() {
    echo "login to $PG_DB"

    NAME=$1
    QUERY_FILE=$2

    LOCAL_FILE=./${NAME}.csv
    QUERY=`cat $QUERY_FILE`

    PGPASSWORD=$PG_PASS psql -h $PG_HOST -U $PG_USER -d $PG_DB -c "COPY ($QUERY) TO stdout CSV DELIMITER ',' quote '\"' force quote * HEADER"  > $LOCAL_FILE

    echo "query: $QUERY was saved to $LOCAL_FILE"
}

query_and_export_to_csv "oca_cases" "query.sql"