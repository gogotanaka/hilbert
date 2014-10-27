require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/test_*.rb']
end

task :default => :test

require "rake/extensiontask"

Rake::ExtensionTask.new("qlang") do |ext|
  ext.lib_dir = "lib/qlang"
end
