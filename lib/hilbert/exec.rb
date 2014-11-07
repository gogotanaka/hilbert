module Hilbert
  module Exec
    class Compiler
      def initialize(args)
        @args = args
      end

      def output!
        ch_compile_type(@args.first)
        parse_string = parse(@args[1])
        write!(@args[2], parse_string)

      rescue Exception => e
        raise e if @options[:trace] || e.is_a?(SystemExit)

        print "#{e.class}: " unless e.class == RuntimeError
        puts "#{e.message}"
        puts '  Use --trace for backtrace.'
        exit 1
      ensure
        exit 0
      end

      private

      def ch_compile_type(lang)
        case lang
        when '-rb'
          Hilbert.to_ruby
        when '-r'
          Hilbert.to_r
        when '-py'
          Hilbert.to_python
        else
          print 'Hilbert support only Ruby and R now.'
        end
      end

      def parse(file_path)
        file = open_file(file_path)
        input_string = read_file(file)
        file.close
        input_string.gsub(/(.*)I love mathematics\.(.*)Hilbert\.E\.D(.*)/m) {
          "#{$1}#{Kconv.tosjis(Hilbert.compile($2))}#{$3}"
        }
      end

      def write!(output_path, string)
        open(output_path, 'w') do |f|
          f.puts string
        end
      end

      def open_file(filename, flag = 'r')
        return if filename.nil?
        File.open(filename, flag)
      end

      def read_file(file)
        file.read
      end
    end
  end
end
