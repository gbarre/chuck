# French Chuck Norris facts

## Install

First, you need to create an account on [deepl](https://www.deepl.com) to get an `auth_key`.
Free account is sufficient for testing (the first 500.000 characters per month are free).

Then, `mv` the `.secrets.sample` to `.secrets` and set your `auth_key` in it.

Create you local sqlite database :

```bash
touch local.sqlite3
sqlite3 local.sqlite3 "CREATE TABLE facts(ID TEXT PRIMARY KEY NOT NULL, EN TEXT NOT NULL, FR TEXT NOT NULL);"
```

## Usage

Just launch `script.bash`.
This will populate your local database after each launch, thus avoiding unnecessary queries in the long run.
