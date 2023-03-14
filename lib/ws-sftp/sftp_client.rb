module Ws
  module SFTP
    class Client
      def initialize(host: nil, username: nil, password: nil, options: {})
        @host = host
        @username = username
        @password = password
        @options = options
      end

      def write(path, content, chunk_size: 25_000)
        start_session do |session|
          session.file.open(path, 'w') do |f|
            chunk(content, chunk_size).each do |chunk|
              f.write(chunk)
            end
          end
        end
      end

      def read(path)
        start_session do |session|
          session.file.open(path, 'r') do |f|
            contents = ''
            while (line = f.gets)
              contents << line
            end
            return contents
          end
        end
      end

      def ls(path = '/')
        dir = []
        start_session do |session|
          session.dir.foreach(path) do |name|
            dir.push(name.directory? ? "#{name.name}/" : name.name)
          end
        end
        dir
      end

      def each_file(paths = ['/'])
        start_session do |session|
          paths.each do |path|
            session.file.open(path, 'r') do |file|
              yield path, file.read
            end
          end
        end
      end

      def glob(path, pattern, &block)
        start_session do |session|
          session.dir.glob(path, pattern, &block)
        end
      end

      # Initiates a download from +remote+ to +local+.
      #
      # @param :path Remote filepath
      # @param :local_path Local filepath (may be '/dev/null')
      # @param :options The hash of options to pass to Net::SFTP::Operations::Download
      # @yield  If a block is given, it will be passed to the SFTP session and will be called once the SFTP session is fully open and initialized. When the block terminates, the new SSH session will automatically be closed.
      #
      # @see https://github.com/net-ssh/net-sftp/blob/master/lib/net/sftp/operations/download.rb
      # @see http://net-ssh.github.io/sftp/v2/api/classes/Net/SFTP/Operations/Download.html
      #
      # Note that the underlying Net::SFTP client downloads
      # asynchronously while this method explicitly calls the #wait
      # method and acts as effectively as a synchronous call.
      #
      # See Net::SFTP::Operations::Download for a full discussion of
      # how this method can be used - specifically around the use of
      # a custom handler instance.
      #
      # An example CustomHandler implementation
      #
      #   class CustomHandler
      #     def on_open(download_as_tuple, file)
      #       puts "starting download: #{file.remote} -> #{file.local} (#{file.size} bytes)"
      #     end
      #
      #     def on_get(download_as_tuple, file, offset, data)
      #       puts "writing #{data.length} bytes to #{file.local} starting at #{offset}"
      #     end
      #
      #     def on_close(download_as_tuple, file)
      #       puts "finished with #{file.remote}"
      #     end
      #
      #     def on_mkdir(download_as_tuple, path)
      #       puts "creating directory #{path}"
      #     end
      #
      #     def on_finish(download_as_tuple)
      #       puts "all done!"
      #     end
      #   end
      #
      # To stream process a file, pass in a custom handler object with the :progress key
      #
      #
      def download_with_handler(path, local_path, options = {}, &block)
        start_session do |session|
          download = session.download(path, local_path, options, &block)
          download.wait
        end
      end

      private

      def start_session(&block)
        Net::SFTP.start(@host, @username, options, &block)
      end

      def options
        {
          password: @password,
          non_interactive: true,
        }.merge(@options)
      end

      def chunk(string, size)
        string.each_char.each_slice(size).map(&:join)
      end
    end
  end
end
