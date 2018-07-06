module Folldo
  module Commands
    class Delete < Base
      def run(id)
        if @queue.delete(id)
          deleted
        else
          not_found
        end
      end
    end
  end
end