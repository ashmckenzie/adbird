module AdBird
  module Lookups
    class BlackHole
      def initialize
      end

      def process(transaction)
        transaction.respond!('127.0.0.1')
      end
    end
  end
end
