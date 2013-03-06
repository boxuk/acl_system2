require "#{ File.dirname(__FILE__) }/logic_parser"

module ACLSystem2
  class AccessHandler   
    include LogicParser

    def check(key, context)
      false
    end
  
  end
end
