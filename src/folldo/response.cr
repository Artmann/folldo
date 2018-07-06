module Folldo
  module Response
    def inserted(id : String)
      "INSERTED #{id}"
    end

    def reserved(id : String, data : String)
      "RESERVED #{id}\r\n#{data}"
    end
  end
end