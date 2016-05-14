require "bundler/gem_tasks"
require "rake/testtask"
require "pry"

task :console do
  exec "bin/console"
end

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end
