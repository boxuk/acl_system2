require "#{ File.dirname(__FILE__) }/user"

class ControllerProxy

  attr_accessor :action_name

  class << self

    attr_reader :before_block

    def before_filter(&block)
      @before_block = block if block_given?
    end

  end

  def before_action
    self.class.before_block.call(self)
  end

  include ACLSystem2::AccessControl

  access_control([:create, :edit] => 'admin & !blacklist',
      :update => '(admin | moderator) & !blacklist',
      :list => '(admin | moderator | user) & !blacklist',
      :private => 'vip') do |context|
         context[:variable] = 'value'
         context[:login_time] = Time.new
      end

  def permission_granted
    true
  end

  def permission_denied
    false
  end
  
  def current_user
    User.new
  end

end
