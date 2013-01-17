# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = 'acl_system2'
  gem.version       = '0.1.0'
  gem.authors       = ['Ezra Zygmuntowicz', 'Fabien Franzen', 'Gareth Rees']
  gem.email         = ['gareth@garethrees.co.uk']
  gem.description   = %q{An access control gem for Rails. A flexible declarative way of protecting your various controller actions using roles.}
  gem.summary       = %q{An access control gem for Rails}
  gem.homepage      = 'https://github.com/boxuk/acl_system2'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'turn'
  gem.add_development_dependency 'rake'
end

