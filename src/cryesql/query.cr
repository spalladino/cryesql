module Cryesql

  class Query

    getter :name, :body, :params

    def initialize(@name : String, @body : String)
    end

    def initialize(@name : String, @body : String, @params : Array(Param))
    end

    record Param, name : String, type : String

  end

end
