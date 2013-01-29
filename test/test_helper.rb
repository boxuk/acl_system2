require 'turn'

Turn.config do |c|
 c.format  = :dot
end

require "#{ File.dirname(__FILE__) }/../lib/acl_system2"

