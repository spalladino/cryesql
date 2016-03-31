require "../spec_helper"
require "../examples/*"

class SelectsParams
  def_queries "#{__DIR__}/../examples/selects_params.sql", Database.db
end

describe Cryesql::Parser do

  context "selects with parameters" do

    it "should invoke select with untyped parameters with correct SQL data type" do
      Database.with_db do
        rs = SelectsParams.new.select_users_older_than(25)

        rs.should be_a(SQLite3::ResultSet)
        read_users(rs).should eq([User.new("Jane", 30)])
      end
    end

    it "should invoke select with untyped parameters with compatible SQL data type" do
      Database.with_db do
        rs = SelectsParams.new.select_users_older_than("25")

        rs.should be_a(SQLite3::ResultSet)
        read_users(rs).should eq([User.new("Jane", 30)])
      end
    end

    it "should invoke select with untyped parameters with wrong number of parameters and fail" do
      Database.with_db do
        expect_raises { SelectsParams.new.select_users_older_than(25, 30) }
      end
    end

    it "should invoke select with typed parameters" do
      Database.with_db do
        rs = SelectsParams.new.select_users_younger_than(25)

        rs.should be_a(SQLite3::ResultSet)
        read_users(rs).should eq([User.new("John", 20)])
      end
    end

    it "should invoke select with multiple typed parameters" do
      Database.with_db do
        rs = SelectsParams.new.select_users_aged_between(15, "25")

        rs.should be_a(SQLite3::ResultSet)
        read_users(rs).should eq([User.new("John", 20)])
      end
    end

  end

end
