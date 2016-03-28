macro def_queries(path, database)
  \{{ run("{{__DIR__.id}}/run/generate", {{path}}, "{{database.id}}") }}
end
