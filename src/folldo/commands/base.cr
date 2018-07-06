require "../response"

module Folldo
  module Commands

    abstract class Base
      include Response

      def initialize(@queue : Queue)
      end
    end
  end
end