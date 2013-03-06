module ACLSystem2
  module AccessControl
    module ClassMethods
      #  access_control [:create, :edit] => 'admin & !blacklist',
      #                 :update => '(admin | moderator) & !blacklist',
      #                 :list => '(admin | moderator | user) & !blacklist'
      def access_control(actions = {})
        # Add class-wide permission callback to before_filter
        defaults = {}

        if block_given?
          yield defaults
          default_block_given = true
        end

        before_filter do |c|
          c.default_access_context = defaults if default_block_given
          @access = AccessSentry.new(c, actions)

          if @access.allowed?(c.action_name)
             c.send(:permission_granted) if c.respond_to?:permission_granted
          else
            if c.respond_to?(:permission_denied)
              c.send(:permission_denied)
            else
              c.send(:render, :text => "You have insuffient permissions to access #{ c.controller_name }/#{ c.action_name }")
            end
          end
        end

      end
    end
  end
end
