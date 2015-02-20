require 'stringio'
require 'home_run'

module Skyline

  class Parser

    fattr :ips
    attr_reader :raw_line
    attr_reader :parsable
    attr_reader :filename
    attr_reader :line_number   

    include Enumerable
 
    # Matches timestamps in logfile
    NGINX_LOG_PATTERN = Regexp.compile(/(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}) \- \- \[([^\]]+)\] "([^"]+)" (\d+) (\d+) "([^"]*?)" "([^"]*?)" "([^"]*?)" (\d+\.\d+)/)

    @@log_pattern = NGINX_LOG_PATTERN

    def initialize path, starting_at = Time.now
      raise ArgumentError unless File.exists?( path )
 
      @log            = File.open( path )
      @ending_at      = starting_at
      @starting_at    = (@ending_at - 300)
      @ips             = Hash.new(0)

      parse
    end
 
    def parse
 
      filesize      = @log.stat.size
      buffer_size   = 128000
      offset        = buffer_size
 
      # Seek to the end of the file
      @log.seek(0, File::SEEK_END)
 
      timestamp     = @starting_at.strftime("%FT%T")
 
      while @log.tell > 0
        @log.seek(-offset, File::SEEK_END)
 
        buffer = @log.read( buffer_size )

        buffer.split("\n").each do |line|
          @parsable = if @@log_pattern.match(@raw_line = line)
            @remote_addr, @time_local, @request, @status, @body_bytes_sent, @http_referer, @http_user_agent, @something, @response_time = $~.captures
            @ips["#{@remote_addr}|#{@request}"] += 1
            true
          else
            false
          end
        end
 
        offset += buffer_size
 
        return if offset > filesize
      end

    end
 
    def each &block
      @ips.each do |ip|
        yield ip
      end
    end
 
  end
end