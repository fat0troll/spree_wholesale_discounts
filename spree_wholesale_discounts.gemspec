# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_wholesale_discounts'
  s.version     = '1.3.2'
  s.summary     = 'Discounts based on cart value'
  s.description = 'Adding ability to discount price for any product if order total cost more than something'
  s.required_ruby_version = '>= 1.8.7'

  s.author    = 'Valdos Sine'
  s.email     = 'iam@toofat.ru'
  s.homepage  = 'http://delta-zet.com'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.3.2'

  s.add_development_dependency 'capybara', '~> 1.1.2'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'factory_girl', '~> 2.6.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.9'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'sqlite3'
end
