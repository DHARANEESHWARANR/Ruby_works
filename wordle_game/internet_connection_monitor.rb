require 'httparty'
require 'colorize'
require 'socket'
module InternetConnectionMonitor
    def internet_connected?
        begin
      # Open a TCP connection to Google's DNS server (8.8.8.8) on port 53
      Socket.tcp("8.8.8.8", 53, connect_timeout: 5).close
      true
      rescue SocketError, Errno::ECONNREFUSED, Errno::EHOSTUNREACH, Errno::ETIMEDOUT
      false
    end
    end
end