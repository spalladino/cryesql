require "yaml"

module Cryesql

  class Parser

    @queries = Array(Query).new

    def initialize(@io)
      @current_header = String::Builder.new
      @current_body = String::Builder.new
      @current_state = :header
    end

    private def close_query
      header_string = @current_header.to_s
      header = YAML.parse(header_string)
      name = header["name"].as_s.strip
      body = @current_body.to_s.strip
      @queries.push(Query.new(name, body))
    end

    def parse
      @io.each_line do |line|
        if match = /^\s*--\s*(.+)/.match(line)
          # We found a header line
          header_line = match[1]
          if @current_state == :header
            # Append it to the current header if we were at a header
            @current_header << header_line
            @current_header << "\n"
          else
            # Or close the current query otherwise to start a new one
            close_query
            @current_header = String::Builder.new
            @current_header << header_line << "\n"
            @current_body = String::Builder.new
            @current_state = :header
          end
        elsif !line.strip.empty?
          # Body it is
          @current_state = :body
          @current_body << line
        end
      end

      # Close the last query when we reach the end
      close_query
      return @queries
    end

  end

end
