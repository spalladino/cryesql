# cryesql

[![Build Status](https://travis-ci.org/spalladino/cryesql.svg?branch=master)](https://travis-ci.org/spalladino/cryesql)

Port of Clojure [yesql](https://github.com/krisajenkins/yesql) to Crystal.

**Work in progress**

## Usage

Automatically create methods for queries defined in a `.sql` file with magic comments via the `def_queries` macro.

Given the file `users.sql`:
```sql
-- name: select_users
SELECT * FROM users
```

Invoke `def_queries("users.sql", db)`, where `db` is a reference to a valid [DB](https://github.com/bcardiff/crystal-db/) object, to autogenerate a method named `select_users` that will run the `SELECT * FROM users` query on the `db` object and return the result.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  cryesql:
    github: spalladino/cryesql
```

## Contributors

- [Santiago Palladino](https://github.com/spalladino) Santiago Palladino - creator, maintainer
