require "../parser"

Cryesql::Parser.parse_path(ARGV[0]).each do |query|
  puts <<-CRYSTAL
    def #{query.name}
      "#{query.name}"
    end
  CRYSTAL
end
