module Qlang
  module Api
    module FuncApi
      def execute(func_name, args, contents)
        case $type
        when :R
          "#{func_name} <- function(#{ args.join(' ,') }) #{contents}"
        when :Ruby
          "#{func_name}(#{ args.join(' ,') }) <= #{contents}"
        end

      end
      module_function :execute
    end
  end
end
