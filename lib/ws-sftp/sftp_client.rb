module Ws
  module SFTP
    class Client
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

      def glob(path, pattern)
        start_session do |session|
          session.dir.glob(path, pattern) do |match|
            yield match
          end
        end
      end

      private

      def start_session
        Net::SFTP.start(SFTP.configuration.host, SFTP.configuration.username, options) do |session|
          yield session
        end
      end

      def options
        {
          password: SFTP.configuration.password,
          non_interactive: true,
        }
      end

      def chunk(string, size)
        string.chars.each_slice(size).map(&:join)
      end
    end
  end
end
