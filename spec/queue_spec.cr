require "./spec_helper"

describe Folldo::Queue do
  describe "#enqueue" do
    it "adds the job" do
      queue = Folldo::Queue.new
      job = Folldo::Job.new "Foobar", 0, 10
      queue.enqueue job

      queue.jobs.should eq [job]
    end
  end

  describe "#reserve" do
    it "returns jobs with state :ready" do
      queue = Folldo::Queue.new

      job1 = Folldo::Job.new "Foo", 10, 1
      job2 = Folldo::Job.new "Baz", 0, 10

      queue.enqueue job1
      queue.enqueue job2

      queue.reserve.should eq job2
    end

    it "returns the job with lowest priority" do
      queue = Folldo::Queue.new

      job1 = Folldo::Job.new "Foo", 0, 100
      job2 = Folldo::Job.new "Baz", 0, 10
      job3 = Folldo::Job.new "Foo", 0, 1000

      queue.enqueue job1
      queue.enqueue job2
      queue.enqueue job3

      queue.reserve.should eq job2
    end
  end
end
