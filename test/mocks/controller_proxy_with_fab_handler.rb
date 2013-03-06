require "#{ File.dirname(__FILE__) }/controller_proxy"
require "#{ File.dirname(__FILE__) }/fab_only_handler"

class ControllerProxyWithFabHandler < ControllerProxy
  
  def retrieve_access_handler
    FabOnlyHandler.new
  end
  
end
