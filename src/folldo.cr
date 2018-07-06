require "socket"
require "uuid"

require "./folldo/commands/*"
require "./folldo/queue"

module Folldo
  class Folldo
    property queue : Queue, id : String

    def initialize
      @queue = Queue.new
      @id = UUID.random.to_s
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

        if command == "delete"
          response = Commands::Delete.new(@queue).run(args[0]?)
        end

        client.puts response if response
      rescue ex
        puts ex.message
      ensure
        client.close
      end
    end

    def start
      ENV["BIND_ADDRESS"] ||= "0.0.0.0"
      ENV["PORT"] ||= "15200"


      spawn do
        socket = UDPSocket.new(Socket::Family::INET)
        socket.broadcast = true

        socket.connect("172.17.255.255", 15300)

        while true
          begin
            socket.puts("Hello I am #{@id}")
            p "sent ping"
            sleep 1.seconds
          rescue ex
            p ex.message
          end
        end

        socket.close
      end

      spawn do
        client = UDPSocket.new
        client.bind "172.17.255.255", 15300
        while true
          p "waiting"
          p client.gets

        end
        client.close
      end


      server = TCPServer.new(ENV["BIND_ADDRESS"], ENV["PORT"].to_i)

      while client = server.accept?
        spawn handle_client(client)
      end
    end

  end
end

Folldo::Folldo.new.start
