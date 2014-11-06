require 'hilbert/api/matrix_api'
require 'hilbert/api/vector_api'
require 'hilbert/api/list_api'
require 'hilbert/api/func_api'
require 'hilbert/api/integral_api'
require 'hilbert/api/limit_api'
require 'hilbert/api/sigma_api'

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
