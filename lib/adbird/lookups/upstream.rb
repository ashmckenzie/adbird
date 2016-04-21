module AdBird
  module Lookups
    DEFAULT_UPSTREAMS = [ [ :udp, '8.8.8.8', 53 ], [ :tcp, '8.8.8.8', 53 ] ].freeze

    class Upstream
      def initialize(transaction)
        @transaction = transaction
      end

      def process
        transaction.passthrough!(upstream)
      end

      private

        attr_reader :transaction

        def upstream
          @upstream ||= RubyDNS::Resolver.new(DEFAULT_UPSTREAMS)
        end
    end
  end
end
