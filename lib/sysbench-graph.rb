#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'sinatra'

require 'sysbench/io'
require 'dataset'

disable :logging

get "/" do
    
    profiles = DataSet.create.data
    
    tests = profiles.values.first.map{ |v| v.test }.sort.uniq
    test = params[:test]
    test = "random read" if test.nil? or test.strip.empty? or not tests.include? test.strip
    test.strip!
    
    series = []
    profiles.each do |k,v|
        series << create_series(k, v, test, :threads, :request_rate)
    end        
  
    body = []
    body << <<-EOF
<html>
  <head>
    <!--[if IE]><script language="javascript" type="text/javascript" src="/js/excanvas.js"></script><![endif]--> 
    <script type='text/javascript' src='/js/jquery.min.js'></script>
    <script type='text/javascript' src='/js/jquery.flot.js'></script>
    <script type='text/javascript' src='/js/jquery.flot.axislabels.js'></script>
    <script type='text/javascript'>
    $(function () {
            
        $(document).ready(function() {
            var options = {
                xaxis: {
                    axisLabel: '# of Threads',
                    ticks: [1, 4, 8, 16]
                },
                yaxis: {
                    axisLabel: 'Requests/sec'
                }
            };
            $.plot( $("#chart_div"), #{series.to_json}, options );
        });
    });

    </script>
  </head>

  <body>
    <div id='chart_div' style="width:900px; height:600px; float:left;"></div>
    <div id="menu" style="float:right;">
EOF

        tests.each do |t|
            if test == t then
                body << "#{t}<br/>"
            else
                body << '<a href="?test=' + t + '">' + t + '</a><br/>'
            end
        end

        body << <<-EOF
    </div>
  </body>
</html>
EOF

    body.join
    
end

def create_series(key, data, test, x, y)
    series = { "label" => key,
               "points" => { "show" => true },
               "lines" => { "show" => true },
               "data"  => data.find_all{ |d| d.send(:test) == test }.map{ |d| [ d.send(x), d.send(y) ] }.sort{ |a,b| a[0].to_i <=> b[0].to_i }
              }
end

profiles = {}
ARGV.each do |a|
    if not File.exists? a then
        puts "'#{a}' does not exist"
        next
    end
    tests = []
    Dir.entries(a).each do |e|
        f = "#{a}/#{e}"
        next if not FileTest.file? f
        tests << SysBench::IO.new(f)
    end
    profiles[a] = tests
end

DataSet.create.data = profiles

puts ''
puts 'Going to start server at http://localhost:4756/'
puts ''
