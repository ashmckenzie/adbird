module AdBird
  module Lookups
    class BlackHole
      def initialize(transaction)
        @transaction = transaction
      end

      def process
        transaction.respond!('127.0.0.1')
      end

      private

        attr_reader :transaction
    end
  end
end
