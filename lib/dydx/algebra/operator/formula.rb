require 'dydx/operator/common_parts'
require 'dydx/operator/parts/formula'

module Dydx
  module Operator
    module Formula
      include Parts::Base
      include Parts::Formula
      include Parts::General
      include Parts::Interface
    end
  end

  class Formula; include Operator::Formula; end
end