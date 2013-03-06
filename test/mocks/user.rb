class User

  attr_accessor :name

  def name
    @name ||= 'anon'
  end

  def roles
    [OpenStruct.new(:title => 'admin'), OpenStruct.new(:title => 'user')]
  end

end
