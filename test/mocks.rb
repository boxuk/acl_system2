require 'ostruct'

Dir[File.dirname(__FILE__) + '/mocks/*.rb'].each do |file|
  require file
end
