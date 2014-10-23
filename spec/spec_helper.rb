$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'qlang'
include Qlang

require 'qlang/iq'

require 'coveralls'
Coveralls.wear!

require 'pry'
