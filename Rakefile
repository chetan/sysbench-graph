
begin
  require 'rubygems'
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "sysbench-graph"
    gemspec.summary = "Tool for parsing output of SysBench IO tests"
    gemspec.description = "Tool for parsing output of SysBench IO tests"
    gemspec.email = "chetan@betteradvertising.com"
    gemspec.homepage = "http://github.com/chetan/sysbench-graph"
    gemspec.authors = ["Chetan Sarva"]
    gemspec.add_dependency('sinatra', '>= 1.1.0')
    gemspec.add_dependency('json', '>= 1.4.2')
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

# require "rake/testtask"
# desc "Run unit tests"
# Rake::TestTask.new("test") { |t|
#     #t.libs << "test"
#     t.ruby_opts << "-rubygems"
#     t.pattern = "test/**/*_test.rb"
#     t.verbose = false
#     t.warning = false
# }
