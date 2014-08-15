module Qlang
  module Api
    module ListApi
      def execute(arys)
        case $type
        when :R
          combineds_by_equal = arys.map { |ary| "#{ary[0]}=#{ary[1]}" }.join(', ')
          "list(#{combineds_by_equal})"
        when :Ruby
          fail 'List is not implemented for Ruby'
        end

      end
      module_function :execute
    end
  end
end
