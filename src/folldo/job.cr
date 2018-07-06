require "uuid"

module Folldo
  struct Job
    property data : String
    property delay : Int32
    property id : String
    property priority : Int32
    property state : Symbol
    property queued_at : Int64

    def initialize(@data, @delay, @priority)
      @id = UUID.random.to_s
      @state = @delay > 0 ? :delayed : :ready
      @queued_at = Time.now.epoch
    end
  end
end