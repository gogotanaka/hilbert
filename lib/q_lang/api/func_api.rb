module QLang
  module Api
    module FuncApi
      def execute(func_name, args, contents)
        "#{func_name} <- function(#{ args.join(' ,') }) #{contents}"
      end
      module_function :execute
    end
  end
end
