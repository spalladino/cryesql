module Cryesql

  class Query

    getter :name, :body

    def initialize(@name : String, @body : String)
    end

  end

end
