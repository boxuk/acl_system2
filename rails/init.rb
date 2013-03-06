require "#{ File.dirname(__FILE__) }/../lib/acl_system2"

ActionController::Base.send :include, ACLSystem2
ActionController::Base.send :include, ACLSystem2::AccessControl

