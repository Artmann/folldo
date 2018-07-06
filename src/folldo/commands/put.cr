module Folldo
  module Commands
    class Put < Base

      def run(data, delay : Int, priority : Int)
        raise "No data" if data.nil?

        job = Job.new data, delay, priority

        @queue.enqueue job

        inserted(job.id)
      end
    end
  end
end