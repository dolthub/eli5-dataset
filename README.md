# ELI5 Dataset

Uploaded to DoltHub: https://www.dolthub.com/repositories/max-hoffman/eli5

Information on dataset: https://facebookresearch.github.io/ELI5/download.html

Used HuggingFace as an initial remote: https://huggingface.co/datasets/eli5

The `./scripts/populate_db.sh` script takes about 5 minutes to run:

```bash
+ dolt init
Successfully initialized dolt data repository.
+ dolt sql -q 'create table eli5_train (q_id text primary key, title text, selftext text, document text, subreddit text, answers json, title_urls json, selftext_urls json, answers_urls json)'
+ dolt table import --pk id --update-table eli5_train /Users/max-hoffman/Documents/sandbox/dolt/eli5-fb-dataset/scripts/../tmp/train.csv
Rows Processed: 502937, Additions: 502937, Modifications: 0, Had No Effect: 0Import completed successfully.
+ dolt sql -q 'create table eli5_test (q_id text primary key, title text, selftext text, document text, subreddit text, answers json, title_urls json, selftext_urls json, answers_urls json)'
+ dolt table import --pk id --update-table eli5_test /Users/max-hoffman/Documents/sandbox/dolt/eli5-fb-dataset/scripts/../tmp/test.csv
Rows Processed: 38738, Additions: 38738, Modifications: 0, Had No Effect: 0Import completed successfully.
+ dolt sql -q 'create table eli5_validation (q_id text primary key, title text, selftext text, document text, subreddit text, answers json, title_urls json, selftext_urls json, answers_urls json)'
+ dolt table import --pk id --update-table eli5_validation /Users/max-hoffman/Documents/sandbox/dolt/eli5-fb-dataset/scripts/../tmp/validation.csv
Rows Processed: 16994, Additions: 16994, Modifications: 0, Had No Effect: 0Import completed successfully.
+ dolt commit -am 'Initialize and import eli5 data'
commit jaaf8f0e6sobhjtdotj73gl3v1ccamjk
Author: Max Hoffman <max@dolthub.com>
Date:   Fri May 21 15:48:37 -0700 2021

	Initialize and import eli5 data
```
