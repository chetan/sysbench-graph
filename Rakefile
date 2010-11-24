
begin
  require 'rubygems'
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "sysbench-graph"
    gemspec.summary = "A tool for graphing SysBench IO tests"
    gemspec.description = "A tool for parsing the output of SysBench IO tests and then graphing it"
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
