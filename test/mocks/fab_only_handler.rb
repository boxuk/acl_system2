class FabOnlyHandler < ACLSystem2::AccessHandler

  def check(key, context)
    (context[:user].name.downcase == 'fabien' && context[:user].roles.map{ |role| role.title.downcase }.include?(key))
  end
      
end

