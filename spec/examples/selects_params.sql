-- name: select_users_older_than
SELECT * FROM users
WHERE age > ?

-- name: select_users_younger_than
-- params:
-- - age: Int32
SELECT * FROM users
WHERE age < ?

-- name: select_users_aged_between
-- params:
-- - lb: Int32
-- - ub: Int32
SELECT * FROM users
WHERE age > ? AND age < ?
