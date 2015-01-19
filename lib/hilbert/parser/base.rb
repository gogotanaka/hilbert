require 'parslet'

module Hilbert
  module Parser
    class Base < Parslet::Parser
      rule(:space)  { match('\s').repeat(1) }
      rule(:space?) { space.maybe }
      rule(:comma)  { str(',') }
      rule(:lparen) { str('(') }
      rule(:rparen) { str(')') }
      rule(:lbracket) { str('[') }
      rule(:rbracket) { str(']') }

      # things
      rule(:integer) { match('[0-9]').repeat(1) >> space? }
      rule(:proposition) { negation.maybe >> match('[A-Z]').as(:identifier) >> space? }
      rule(:variable) { match['a-z'] >> space? }
      rule(:infinity) { str('oo') }
      rule(:pi) { str('pi') }
      rule(:e) { str('e') }

      # embedded functions
      rule(:sin) { str('sin') }
      rule(:cos) { str('cos') }
      rule(:tan) { str('tan') }
      rule(:log) { str('log') }
      rule(:embedded_function) { (sin | cos | tan | log) }

      # operators
      rule(:conjunction) { str('&') >> space? }
      rule(:disjunction) { str('|') >> space? }
      rule(:material_implication) { str('->') >> space? }
      rule(:negation) { str('~') }
      rule(:logical_connective) { conjunction | disjunction | material_implication }
      rule(:sigma) { str('∑') }

      # expressions
      rule(:compound_proposition) {
        negation.as(:operator) >> proposition.as(:operand) |
          proposition.as(:lhs) >> logical_connective.as(:operator) >> logical_expression.as(:rhs)
      }

      rule(:logical_expression) {
        lparen.maybe >> compound_proposition.as(:proposition) >> rparen.maybe |
          lparen.maybe >> proposition.as(:proposition) >> rparen.maybe
      }

      rule(:summation) { sigma >> lbracket >> variable >> str('=') >> integer.as(:start) >> comma >> integer.as(:end) >> rbracket >> space? >> variable }

      rule(:numeric_expression) { integer | lparen >> integer >> rparen | summation.as(:summation) }

      rule(:expression) { logical_expression | numeric_expression }
      root(:expression)
    end
  end
end
