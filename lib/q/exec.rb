module Q
  module Exec
    class Compiler
      def initialize(args)
        filename = args.first
        file = open_file(filename)
        string = read_file(file)
        print(Kconv.tosjis(Q.compile(string)), '\n')
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
