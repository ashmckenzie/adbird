module AdBird
  class Server
    DEFAULT_INTERFACES = [ [ :udp, '0.0.0.0', 5300 ], [ :tcp, '0.0.0.0', 5300] ].freeze

    RESOLV_NAME = Resolv::DNS::Name
    RESOLV_IN = Resolv::DNS::Resource::IN

    def initialize(interfaces: DEFAULT_INTERFACES)
      @interfaces = interfaces
    end

    def start
      RubyDNS.run_server(listen: interfaces) do
        on(:start) do
          @logger.level = Logger::INFO
        end
        match(/blah\.com/, RESOLV_IN::A) { |transaction| Lookups::BlackHole.new(transaction).process }
        otherwise { |transaction| Lookups::Upstream.new(transaction).process }
      end
    end

    def stop
    end

    def reload
    end

    private

      attr_reader :interfaces

  end
end
