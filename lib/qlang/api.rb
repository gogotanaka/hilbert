require 'qlang/api/matrix_api'
require 'qlang/api/vector_api'
require 'qlang/api/list_api'
require 'qlang/api/func_api'
require 'qlang/api/integral_api'

module Qlang
  module Api
    # TODO:
    class ::String
      def rm(str_or_rgx)
        gsub!(str_or_rgx, '')
      end

      def rms(*str_or_rgxs)
        str_or_rgxs.each do |str_or_rgx|
          rm(str_or_rgx)
        end
        self
      end
    end

    class ::Matrix
      def to_q
        q_rows = rows.map { |row| row.join(' ') }.join('; ')
        "(#{q_rows})"
      end
    end

    class ::Vector
      def to_q
        "(#{elements.join(' ')})"
      end
    end
  end
end
