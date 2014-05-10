require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'bundler/setup'

desc "run spec"

#do `rake spec`
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ["-c", "-fs"]
end

task default: :spec

