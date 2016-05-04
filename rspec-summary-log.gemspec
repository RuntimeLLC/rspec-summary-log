$:.push File.expand_path('../lib', __FILE__)
require_relative 'lib/rspec/summary_log/version'

Gem::Specification.new do |s|
  s.name        = 'rspec-summary-log'
  s.version     = RSpec::SummaryLog::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Aleksandr Fomin', 'Kamila Sharipova', 'Nikolay Sverchkov']
  s.email       = ['ll.wg.bin@gmail.com', 'kam.sharipova@gmail.com', 'ssnikolay@gmail.com']
  s.homepage    = 'https://github.com/RuntimeLLC/rspec-summary-log'
  s.summary     = 'Log summary of failed tests for CI'
  s.description = s.summary

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split($/).map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  s.license = 'MIT'
  s.add_dependency 'rspec', '~> 3'

  s.add_development_dependency 'rake'
end
