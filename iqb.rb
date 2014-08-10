require 'qlang'
include Q

loop do
  puts eval Qlang.to_ruby.compile(gets)
end
