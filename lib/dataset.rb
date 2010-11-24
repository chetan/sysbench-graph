
class DataSet
    
    attr_accessor :data

    private_class_method :new
    @@dataset = nil
    def self.create
        @@dataset = new if not @@dataset
        return @@dataset
    end
    
    def initialize
    end
    
end
