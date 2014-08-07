module Q
  module API
    module ListApi
      def execute(arys)
        combineds_by_equal = arys.map { |ary| "#{ary[0]}=#{ary[1]}" }.join(', ')
        "list(#{combineds_by_equal})"
      end
      module_function :execute
    end
  end
end
