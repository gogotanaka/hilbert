module Qlang
  module Api
    module FuncApi
      def execute(func_name, args, contents)
        case $type
        when :r
          "#{func_name} <- function(#{ args.join(' ,') }) #{contents}"
        when :ruby
          "#{func_name}(#{ args.join(' ,') }) <= #{contents}"
        end

      end
      module_function :execute
    end
  end
end
