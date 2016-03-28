require "./spec_helper"
require "./examples/*"

record User, name : String, age : Int32

private def read_users(rs, *types)
  users = Array(User).new
  rs.each do
    users << User.new(rs.read(String), rs.read(Int32))
  end
  users
end

record Project, name : String

private def read_projects(rs, *types)
  users = Array(Project).new
  rs.each do
    users << Project.new(rs.read(String))
  end
  users
end

describe Cryesql::Parser do

  it "should define select users query" do
    Database.with_db do
      rs = Selects.new.select_users

      rs.should be_a(SQLite3::ResultSet)
      rs.column_count.should eq(2)
      rs.column_name(0).should eq("name")
      rs.column_name(1).should eq("age")

      read_users(rs).should eq([User.new("John", 20), User.new("Jane", 30)])
    end
  end

  it "should define select projects query" do
    Database.with_db do
      rs = Selects.new.select_projects

      rs.should be_a(SQLite3::ResultSet)
      rs.column_count.should eq(1)
      rs.column_name(0).should eq("name")

      read_projects(rs).should eq([Project.new("Cryesql")])
    end
  end

end
