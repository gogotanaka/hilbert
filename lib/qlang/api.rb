require 'qlang/api/matrix_api'
require 'qlang/api/vector_api'
require 'qlang/api/list_api'
require 'qlang/api/func_api'
require 'qlang/api/integral_api'

module Qlang
  module Api
    class ::Matrix
      def to_q
        rows.map(&:join_by_sp).join('; ').parentheses
      end
    end

    class ::Vector
      def to_q
        elements.join_by_sp.parentheses
      end
    end
  end
end
