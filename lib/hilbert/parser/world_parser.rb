module Hilbert
  module Parser
    class WorldParser
      @@parsed_ary = []
      @@stage
      class << self
        def execute(lexeds)
          clear!

          lexeds.each do |lexed|
            parsed =  case lexed[:token]
                      when :DISJ   then ' + '
                      when :CONJ   then ' * '
                      when :COND   then ' >= '
                      when :BICO   then ' <=> '
                      when :PROVAR then "$world.atom(:#{lexed[:value]})"
                      when :NEGA   then " ~"
                      else              lexed[:value]
                      end

            push(parsed)
          end
        end

        def push(parsed)
          if parsed
            @@parsed_ary << parsed
          else
            @@stage << lexed
          end
        end

        def parsed_srt
          @@parsed_ary.join
        end

        def clear!
          @@parsed_ary = []
        end
      end
    end
  end
end
