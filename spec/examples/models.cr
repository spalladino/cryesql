record User, name : String, age : Int32

def read_users(rs, *types)
  users = Array(User).new
  rs.each do
    users << User.new(rs.read(String), rs.read(Int32))
  end
  users
end

record Project, name : String

def read_projects(rs, *types)
  users = Array(Project).new
  rs.each do
    users << Project.new(rs.read(String))
  end
  users
end
