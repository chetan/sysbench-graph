
module SysBench
class IO
    
    attr_accessor :version, :threads, :test
    attr_accessor :total_size, :block_size
    attr_accessor :byte_rate, :request_rate
    attr_accessor :min, :max, :avg, :top
    
    def initialize(file)
        if not File.exists? file then
            puts "File '#{file}' does not exist!"
            exit
        end
        parse(File.new(file).read)
    end
    
    def parse(str)
        str.split(/\n/).each do |l|
           
           l.strip!
           if l =~ /^sysbench (.+?):/
               @version = $1
               
           elsif l =~ /^Number of threads: (\d+)$/
               @threads = $1
               
           elsif l =~ /^Doing (.+?) test$/
               @test = $1
               
           elsif l =~ /^(.+?) total file size$/
               @total_size = $1
            
           elsif l =~ /^Block size (.+?)$/
               @block_size = $1
               
           elsif l =~ /Read [\dKMGTb.]+  Written [\dKMGTb.]+  Total transferred [\dKMGTb.]+  \((.+?)\)/
               @byte_rate = $1
               
           elsif l =~ /^(.+?) Requests\/sec executed$/
               @request_rate = $1
               
           elsif l =~ /min:\s+(.+?)$/
               @min = $1
               
           elsif l =~ /max:\s+(.+?)$/
               @max = $1
           elsif l =~ /avg:\s+(.+?)$/
               @avg = $1
               
           elsif l =~ /approx.*?:\s+(.+?)$/
               @top = $1
           end

        end # each    
    end # parse
    
    def to_s(delim = "\t")
        [@test, @threads, @total_size, @block_size, @byte_rate, @request_rate, @min, @max, @avg, @top].join("\t")
    end
    
end # IO
end # SysBench