require "./job"

module Folldo
  class Queue
    getter jobs : Array(Job)

    def initialize
      @jobs = [] of Job
    end

    def enqueue(job : Job)
      @jobs << job
    end

    def reserve
      availableJobs = @jobs
        .select { |j| j.state == :ready }
        .sort { |a, b| a.priority <=> b.priority }

      return nil if availableJobs.size == 0

      @jobs.delete(availableJobs.first)
    end

  end
end