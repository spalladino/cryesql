require "../spec_helper"
require "../examples/*"

class Selects
  def_queries "#{__DIR__}/../examples/selects.sql", Database.db
end

describe Cryesql::Parser do

  context "selects" do

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

end
