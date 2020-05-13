lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'as_range/version'

Gem::Specification.new do |spec|
  spec.name          = 'as_range'
  spec.version       = AsRange::VERSION
  spec.authors       = ['Aliou Diallo']
  spec.email         = ['code@aliou.me']

  spec.summary       = 'Quickly generate ranges from object methods.'
  spec.description   = <<-DESCRIPTION
    Quickly generate ranges from object methods or from procs.
  DESCRIPTION
  spec.homepage      = 'https://github.com/aliou/as_range'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(bin|test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.5.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'faker', '~> 2.0'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-instafail', '~> 1.0'
end
