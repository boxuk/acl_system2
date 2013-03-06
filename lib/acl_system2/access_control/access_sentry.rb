module ACLSystem2
  module AccessControl
    class AccessSentry

      def initialize(subject, actions={})
        @actions = actions.inject({}) do |auth, current|
          [current.first].flatten.each { |action| auth[action] = current.last }
          auth
        end 
        @subject = subject
      end 

      def allowed?(action)
        if @actions.has_key? action.to_sym
          return @subject.access_handler.process(@actions[action.to_sym].dup, @subject.access_context)
        elsif @actions.has_key? :DEFAULT
          return @subject.access_handler.process(@actions[:DEFAULT].dup, @subject.access_context) 
        else
          return true
        end  
      end

    end
  end
end
