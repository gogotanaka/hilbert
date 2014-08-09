module Qlang
  module Exec
    class Compiler
      def initialize(args)
        @args = args
      end

      def parse!
        parse
      rescue Exception => e
        raise e if @options[:trace] || e.is_a?(SystemExit)

        print "#{e.class}: " unless e.class == RuntimeError
        puts "#{e.message}"
        puts "  Use --trace for backtrace."
        exit 1
      ensure
        exit 0
      end

      private def parse
        raise '#{@args[0]} is unsupported option' unless @args[0] == '-q'
        filename = @args[1]
        file = open_file(filename)
        string = read_file(file)
        print(Kconv.tosjis(Qlang.compile(string)), '\n')
        file.close
      end

      private def open_file(filename, flag = 'r')
        return if filename.nil?
        File.open(filename, flag)
      end

      private def read_file(file)
        file.read
      end
    end
  end
end
