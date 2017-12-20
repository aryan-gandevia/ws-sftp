module Ws
  module SFTP
    class << self
      attr_writer :configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield(configuration)
    end

    def self.reset_configuration!
      @configuration = Configuration.new
    end

    class Configuration
      ATTRIBUTES = [:host, :username, :password]
      attr_accessor *ATTRIBUTES

      def validate!
        raise "Invalid or missing configuration" unless ATTRIBUTES.all? { |attr| send(attr).present? }
      end
    end
  end
end
