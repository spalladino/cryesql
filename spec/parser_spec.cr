require "./spec_helper"

describe Cryesql::Parser do

  it "should parse a singleline query" do
    str = <<-QUERY
    -- name: foobar
    SELECT * FROM foobar
    QUERY

    queries = Cryesql::Parser.new(MemoryIO.new(str)).parse
    queries.size.should eq(1)
    queries[0].name.should eq("foobar")
    queries[0].body.should eq("SELECT * FROM foobar")
  end

  it "should parse a multiline query" do
    str = <<-QUERY
    -- name: foobar
    SELECT *
    FROM foobar
    WHERE 1=1
    QUERY

    queries = Cryesql::Parser.new(MemoryIO.new(str)).parse
    queries.size.should eq(1)
    queries[0].name.should eq("foobar")
    queries[0].body.should eq("SELECT *\nFROM foobar\nWHERE 1=1")
  end

  it "should parse a query with metadata" do
    str = <<-QUERY
    -- name: foobar
    -- label: testing
    SELECT * FROM foobar
    QUERY

    queries = Cryesql::Parser.new(MemoryIO.new(str)).parse
    queries.size.should eq(1)
    queries[0].name.should eq("foobar")
    queries[0].body.should eq("SELECT * FROM foobar")
  end

  it "should parse multiple queries" do
    str = <<-QUERY
    -- name: foobar
    SELECT * FROM foobar

    -- name: another
    SELECT * FROM another
    QUERY

    queries = Cryesql::Parser.new(MemoryIO.new(str)).parse
    queries.size.should eq(2)
    queries[0].name.should eq("foobar")
    queries[0].body.should eq("SELECT * FROM foobar")

    queries[1].name.should eq("another")
    queries[1].body.should eq("SELECT * FROM another")
  end

  it "should parse multiple complex queries with empty lines" do
    str = <<-QUERY

    -- name: foobar
    -- label: testing

    SELECT *

    FROM foobar

    WHERE 1=1


    -- name: another
    -- label: another

    SELECT *

    FROM another

    QUERY

    queries = Cryesql::Parser.new(MemoryIO.new(str)).parse
    queries.size.should eq(2)
    queries[0].name.should eq("foobar")
    queries[0].body.should eq("SELECT *\nFROM foobar\nWHERE 1=1")

    queries[1].name.should eq("another")
    queries[1].body.should eq("SELECT *\nFROM another")
  end

end
