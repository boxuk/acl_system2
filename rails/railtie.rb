require "#{ File.dirname(__FILE__) }/../lib/acl_system2"
require 'rails'

module ACLSystem2
  class Engine < Rails::Engine
    initializer 'initialize acl_system2' do |app|
      ActionController::Base.send :include, ACLSystem2::AccessControl
    end
  end
end
