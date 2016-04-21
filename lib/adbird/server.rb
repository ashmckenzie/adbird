module AdBird
  class Server
    DEFAULT_INTERFACES = [ [ :udp, '0.0.0.0', 5300 ], [ :tcp, '0.0.0.0', 5300] ].freeze

    RESOLV_NAME = Resolv::DNS::Name
    RESOLV_IN = Resolv::DNS::Resource::IN

    HOST_FILES = %w( data/hosts1.txt data/hosts2.txt data/hosts3.txt ).freeze

    def initialize(interfaces: DEFAULT_INTERFACES)
      @interfaces = interfaces
    end

    def start
      RubyDNS.run_server(listen: interfaces) do
        on(:start) do
          @logger.level = Logger::INFO
        end

        black_hole_lookup        = Lookups::BlackHole.new
        upstream_lookup          = Lookups::Upstream.new
        black_hole_domains_regex = Hosts.new(HOST_FILES).black_hole_domains_regex

        match(black_hole_domains_regex, RESOLV_IN::A) do |transaction|
          black_hole_lookup.process(transaction)
        end

        otherwise { |transaction| upstream_lookup.process(transaction) }
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
