macro def_queries(path)
  \{{ run("{{__DIR__.id}}/run/generate", {{path}}) }}
end
