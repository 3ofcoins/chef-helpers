# -*- encoding: utf-8 -*-
require File.expand_path('../lib/chef-helpers/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Maciej Pasternacki"]
  gem.email         = ["maciej@pasternacki.net"]
  gem.description   = "A collection of helper methods to use in Opscode Chef recipes"
  gem.summary       = "Helper methods for Opscode Chef"
  gem.homepage      = "https://github.com/3ofcoins/chef-helpers/"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "chef-helpers"
  gem.require_paths = ["lib"]
  gem.version       = ChefHelpers::VERSION

  gem.add_dependency "chef"
end
