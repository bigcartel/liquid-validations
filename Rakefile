require "bundler/gem_tasks"

require 'rake/testtask'
task :default => :test

Rake::TestTask.new do |t|
  t.verbose = true
  t.libs << "spec"
  t.libs << "lib"
  t.test_files = FileList['spec/**/*_spec.rb']
end
