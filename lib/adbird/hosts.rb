module AdBird
  class Hosts
    def initialize(files)
      @files = files
    end

    def black_hole_domains_regex
      @black_hole_domains_regex ||= Regexp.union(black_hole_domains.values)
    end

    def black_hole_domains
      @black_hole_domains ||= begin
        files.each_with_object({}) do |file, all|
          puts "INFO: Reading '%s'.." % [ file ]
          domains = read(file)
          all.merge!(domains)
        end
      end
    end

    private

      attr_reader :files

      def read(file)
        lines = File.read(file).split("\n")
        lines.each_with_object({}) do |line, all|
          domain = domain_from(line)
          next unless domain
          all[domain] = Regexp.new('^%s$' % [ domain ])
        end
      end

      def domain_from(line)
        m = line.match(/^\d{1,}\.\d{1,}\.\d{1,}\.\d{1,}\s+(?<domain>[^\s]+)$/)
        m ? m[:domain] : nil
      end
  end
end
