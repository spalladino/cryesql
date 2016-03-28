require "../parser"

Cryesql::Parser.parse_path(ARGV[0]).each do |query|
  puts <<-CRYSTAL
    def #{query.name}
      body = "#{query.body}"
      #{ARGV[1]}.query(body)
    end
    
  CRYSTAL
end
