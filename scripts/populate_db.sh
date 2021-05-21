#!/bin/bash

set -eoux pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: `populate_db.sh <path>`"
    exit 1
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"
BASE_DIR=$SCRIPT_DIR/..
DB=$BASE_DIR/$1
TMP=$BASE_DIR/tmp

labels=$TMP/labels.csv
features=$TMP/features.csv

rm -rf $TMP && mkdir -p $TMP

cd $BASE_DIR
poetry run python3 download.py $TMP

if [ ! -d $DB ]; then
    mkdir -p $DB
    cd $DB
    dolt init
    dolt sql -q "create table eli5_train (q_id text primary key, title text, selftext text, document text, subreddit text, answers json, title_urls json, selftext_urls json, answers_urls json)"
    dolt table import --pk id --update-table eli5_train $TMP/train.csv

    dolt sql -q "create table eli5_test (q_id text primary key, title text, selftext text, document text, subreddit text, answers json, title_urls json, selftext_urls json, answers_urls json)"
    dolt table import --pk id --update-table eli5_test $TMP/test.csv

    dolt sql -q "create table eli5_validation (q_id text primary key, title text, selftext text, document text, subreddit text, answers json, title_urls json, selftext_urls json, answers_urls json)"
    dolt table import --pk id --update-table eli5_validation $TMP/validation.csv

    dolt commit -am "Initialize and import eli5 data"
fi
