require 'coveralls'
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'hilbert'

require 'minitest/autorun'
require 'pp'
require 'pry'

require 'interpreter/base'
Hilbert::Iq.execute('postulate zfc_analysis')
