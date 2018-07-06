require "socket"

require "./folldo/commands/*"
require "./folldo/queue"

module Folldo
  class Folldo

    def initialize
      @queue = Queue.new
    end

    def handle_client(client)
      begin
        message = client.gets

        return if message.nil?

        args = message.split(/\s/)
        command = args.shift.downcase

        if command == "put"
          delay = (args[0]? || 0).to_i
          priority = (args[1]? || 1024).to_i
          data = client.gets

          response = Commands::Put.new(@queue).run(data, delay, priority)
        end

        if command == "reserve"
          response = Commands::Reserve.new(@queue).run
        end

        client.puts response if response

      rescue ex
        puts ex.message
      ensure
        client.close
      end
    end

    def start
      server = TCPServer.new("0.0.0.0", 15200)
      while client = server.accept?
        spawn handle_client(client)
      end
    end

  end
end

Folldo::Folldo.new.start
