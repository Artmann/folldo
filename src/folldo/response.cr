module Folldo
  module Response
    def inserted(id : String)
      "INSERTED #{id}"
    end

    def reserved(id : String, data : String)
      "RESERVED #{id}\r\n#{data}"
    end

    def deleted
      "DELETED"
    end

    def not_found
      "NOT_FOUND"
    end
  end
end