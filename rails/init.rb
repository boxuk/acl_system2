require "#{ File.dirname(__FILE__) }/../lib/acl_system2"

ActionController::Base.send :include, Caboose
ActionController::Base.send :include, Caboose::AccessControl

