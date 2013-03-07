# Rails 2 Campatability
require "#{ File.dirname(__FILE__) }/../lib/acl_system2"

if defined?(Rails) && Rails::VERSION::MAJOR < 3
  ActionController::Base.send :include, ACLSystem2
  ActionController::Base.send :include, ACLSystem2::AccessControl
end
