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

      job = availableJobs[0].reserve

      @jobs = @jobs.map { |j| j.id == job.id ? job : j}

      return job
    end

    def delete(id)
      size = @jobs.size
      @jobs = @jobs.reject { |j| j.id == id }

      return @jobs.size != size
    end

  end
end