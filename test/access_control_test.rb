require File.dirname(__FILE__) + '/test_helper'

class AccessControlTest  < Test::Unit::TestCase
  
  def test_first
    context = { :user => User.new }
    @handler = ACLSystem2::RoleHandler.new
    assert @handler.process("(admin | moderator) & !blacklist", context)  
    assert @handler.process("(user | moderator) & !blacklist", context)  
    assert @handler.process("(user | moderator | user) & !blacklist", context)  
    assert @handler.process("(user | moderator | !blacklist)", context)  
    assert @handler.process("user & !blacklist", context)  
    assert @handler.process("!moderator & !blacklist", context)  
    assert @handler.process("admin & user & !blacklist", context)  
    assert_equal @handler.process("moderator | blacklist", context), false 
    assert_equal @handler.process("!admin | blacklist", context), false 
    assert_equal @handler.process("moderator | unknown", context), false 
    assert_equal @handler.process("!anon & !moderator", context), true 
  end
 
  def test_custom_access_handler
    context = { :user => User.new }
    controller = ControllerProxyWithFabHandler.new    
    assert_equal controller.permit?("(admin | moderator) & !blacklist", context), false 
   
    context[:user].name = 'Ezra'
    assert_equal controller.permit?("(admin | moderator) & !blacklist", context), false 
   
    context[:user].name = 'Fabien'
    assert controller.permit?("(admin | moderator) & !blacklist", context)     
  end
  
  def test_permit
    context = { :user => User.new }
    controller = ControllerProxy.new   
    assert controller.permit?("(admin | moderator) & !blacklist", context)  
    assert controller.permit?("(user | moderator) & !blacklist", context)  
    assert controller.permit?("(user | moderator | user) & !blacklist", context)  
    assert controller.permit?("(user | moderator | !blacklist)", context)  
    assert controller.permit?("user & !blacklist", context)  
    assert controller.permit?("!moderator & !blacklist", context)  
    assert controller.permit?("admin & user & !blacklist", context)  
    assert_equal controller.permit?("moderator | blacklist", context), false 
    assert_equal controller.permit?("!admin | blacklist", context), false 
    assert_equal controller.permit?("moderator", context), false 
    assert_equal controller.permit?("!anon & !moderator", context), true     
  end
  
  def test_restrict_to
    controller = ControllerProxy.new
    assert_block do
      controller.restrict_to "admin | moderator" do
        true
      end
    end
  end
  
  def test_before_filter
    context = { :user => User.new }
    controller = ControllerProxy.new 
    
    controller.action_name = 'list'
    assert_block { controller.before_action }
    
    controller.action_name = 'other'
    assert_block { controller.before_action }
    
    controller.action_name = 'private'
    assert_block { !controller.before_action }
  end
 
  def test_set_default_context_with_block
    context = { :user => User.new }
    controller = ControllerProxy.new 
    controller.action_name = 'list'
    controller.before_action
    assert controller.access_context.include?(:user)
    assert controller.access_context.include?(:variable)
    assert controller.access_context.include?(:login_time)
  end
    
end  
