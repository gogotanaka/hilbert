module Qlang
  module Api
    module ListApi
      def execute(arys)
        case $type
        when :r
          combineds_by_equal = arys.map { |ary| "#{ary[0]}=#{ary[1]}" }.join(', ')
          "list(#{combineds_by_equal})"
        else
          fail "List is not implemented for #{LANGS_HASH[$type.to_s]}"
        end

      end
      module_function :execute
    end
  end
end
