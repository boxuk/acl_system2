Dir[File.dirname(__FILE__) + '/access_control/*.rb'].each do |file|
  require file
end

module ACLSystem2

  module AccessControl
    
    def self.included(subject)
      subject.extend(ClassMethods)
      if subject.respond_to? :helper_method
        subject.helper_method(:permit?)
        subject.helper_method(:restrict_to)
      end
    end
    
    # return the active access handler, fallback to RoleHandler
    # implement #retrieve_access_handler to return non-default handler
    def access_handler
      if respond_to?(:retrieve_access_handler)
        @handler ||= retrieve_access_handler
      else
        @handler ||= RoleHandler.new
      end
    end

    # the current access context; will be created if not setup
    # will add current_user and merge any other elements of context
    def access_context(context = {})     
      default_access_context.merge(context)
    end

    def default_access_context
      @default_access_context ||= {}
      @default_access_context[:user] = send(:current_user) if respond_to?(:current_user)
      @default_access_context 
    end

    def default_access_context=(defaults)
      @default_access_context = defaults      
    end

    def permit?(logicstring, context = {})
      access_handler.process(logicstring, access_context(context))
    end
  
    # restrict_to "admin | moderator" do
    #   link_to "foo"
    # end   
    def restrict_to(logicstring, context = {})
      return false if current_user.nil?
      result = ''    
      if permit?(logicstring, context) 
        result = yield if block_given?
      end 
      result
    end    

  end

end
