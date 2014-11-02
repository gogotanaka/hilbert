module Qlang
  module Api
    module FuncApi
      def execute(func_name, args, contents)
        case $meta_info.lang
        when :r
          "#{func_name} <- function(#{ args.join(' ,') }) #{contents}"
        when :ruby
          "#{func_name}(#{ args.join(' ,') }) <= #{contents}"
        else
          fail "Function is not implemented for #{$meta_info.lang_str}"
        end
      end
      module_function :execute
    end
  end
end
