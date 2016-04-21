module AdBird
  module Lookups
    DEFAULT_UPSTREAMS = [ [ :udp, '8.8.8.8', 53 ], [ :tcp, '8.8.8.8', 53 ] ].freeze

    class Upstream
      def initialize
      end

      def process(transaction)
        transaction.passthrough!(upstream)
      end

      private

        def upstream
          @upstream ||= RubyDNS::Resolver.new(DEFAULT_UPSTREAMS)
        end
    end
  end
end
