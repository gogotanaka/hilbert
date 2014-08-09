module Qlang
  module Parser
    module Base
      include ::Qlang::Api
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
    end
  end
end
