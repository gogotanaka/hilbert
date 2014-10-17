module Qlang
  module Api
    module ListApi
      def execute(arys)
        case $meta_info.lang
        when :r
          combineds_by_equal = arys.map { |ary| "#{ary[0]}=#{ary[1]}" }.join(', ')
          "list(#{combineds_by_equal})"
        else
          fail "List is not implemented for #{LANGS_HASH[$meta_info.lang.to_s]}"
        end

      end
      module_function :execute
    end
  end
end
