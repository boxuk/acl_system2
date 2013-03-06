require "#{ File.dirname(__FILE__) }/access_handler"

module ACLSystem2

  class RoleHandler < AccessHandler 
    
    def check(key, context)  
      context[:user].roles.map{ |role| role.title.downcase}.include? key.downcase
    end
        
  end

end
