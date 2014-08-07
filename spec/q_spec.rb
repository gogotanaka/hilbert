$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'q'
include Q
require 'pry'
describe Q do
  it 'demo' do

    Lexer.execute('(1 2 3; 4 5 6)')
    Lexer.execute('(1 2 3)')
    Lexer.execute('{name: “Gogotanaka”, age:  21, birth: (1992 8 10) }')
    '(1 2 3; 4 5 6)'
    _ '(1 2 3; 4 5 6)'
    _ '(1 2 3)'
    _ '{name: “Gogotanaka”, age:  21, birth: (1992 8 10) }'



  end
end
