module Qlang
  module Api
    module FuncApi
      def execute(func_name, args, contents)
        case $type
        when :r
          "#{func_name} <- function(#{ args.join(' ,') }) #{contents}"
        when :ruby
          "#{func_name}(#{ args.join(' ,') }) <= #{contents}"
        else
          fail "Function is not implemented for #{LANGS_HASH[$type.to_s]}"
        end

      end
      module_function :execute
    end
  end
end
