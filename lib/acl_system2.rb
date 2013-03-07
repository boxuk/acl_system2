Dir[File.dirname(__FILE__) + '/acl_system2/*.rb'].each do |file|
  require file
end

if defined?(Rails) && Rails::VERSION::MAJOR > 2
  require "#{ File.dirname(__FILE__) }/../rails/railtie"
end
