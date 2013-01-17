require 'turn'

Turn.config do |c|
 c.format  = :dot
end

require File.dirname(__FILE__) + '/../lib/caboose/logic_parser'
require File.dirname(__FILE__) + '/../lib/caboose/role_handler'
require File.dirname(__FILE__) + '/../lib/caboose/access_control'
