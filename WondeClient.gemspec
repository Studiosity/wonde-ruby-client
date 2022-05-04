Gem::Specification.new do |s|
  s.name        = 'wondeclient'
  s.version     = '0.1.3'
  s.date        = '2019-11-15'
  s.summary     = 'Wonde Client'
  s.description = 'Wonde Client'
  s.authors     = ['Mike Donlon']
  s.email       = 'miked63017@gmail.com '
  s.files       = %w[lib].flat_map { |dir| Dir["#{dir}/**/*"] }
  s.homepage    = 'https://github.com/wondeltd/ruby-client'
  s.license     = 'MIT'

  s.executables << 'wondeclient'

  s.add_dependency 'addressable', '~> 2.5'
  s.add_dependency 'rest-client', '~> 2.0'
  s.add_development_dependency 'rubocop'
end
