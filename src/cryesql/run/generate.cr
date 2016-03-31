require "../parser"

Cryesql::Parser.parse_path(ARGV[0]).each do |query|
  params = query.params

  args_def_string = if params
    params.map{|p| "#{p.name} : #{p.type}"}.join(", ")
  else
    "*args"
  end

  args_call_string = if params
    params.map(&.name).join(", ")
  else
    "*args"
  end

  puts "
    def #{query.name}(#{args_def_string})
      body = \"#{query.body}\"
      #{ARGV[1]}.query(body, #{args_call_string})
    end

  "

end
