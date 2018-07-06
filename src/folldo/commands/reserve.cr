module Folldo
  module Commands
    class Reserve < Base
      def run
        job = nil

        until job
          job = @queue.reserve

          sleep 1.seconds
        end

        reserved job.id, job.data
      end
    end
  end
end