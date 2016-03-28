require "db"
require "sqlite3"

module Database

  PATH = "./test.sqlite3"

  def self.db
    @@db.not_nil!
  end

  def self.with_db
    File.delete(PATH) if File.exists?(PATH)
    @@db = DB.open "sqlite3://#{PATH}"

    db.exec "CREATE TABLE users (name STRING, age INTEGER)"
    db.exec "INSERT INTO users VALUES (?, ?)", ["John", 20]
    db.exec "INSERT INTO users VALUES (?, ?)", ["Jane", 30]

    db.exec "CREATE TABLE projects (name STRING)"
    db.exec "INSERT INTO projects VALUES (?)", ["Cryesql"]

    yield

    db.close
    @@db = nil
  end

end
