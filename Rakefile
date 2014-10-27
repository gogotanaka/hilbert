require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/test_*.rb']
end

require "rake/extensiontask"

Rake::ExtensionTask.new("qlang") do |ext|
  ext.lib_dir = "lib/qlang"
end

task :compile_and_test do
  Rake::Task["compile"].invoke
  Rake::Task["test"].invoke
end

task default: :compile_and_test
