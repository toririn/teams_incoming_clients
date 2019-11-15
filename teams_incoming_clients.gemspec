lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "teams_incoming_clients/version"

Gem::Specification.new do |spec|
  spec.name          = "teams_incoming_clients"
  spec.version       = TeamsIncomingClients::VERSION
  spec.authors       = ["toririn"]
  spec.email         = ["toririn.paftako@gmail.com"]

  spec.summary       = %q{This gem to send chat messages to O365 Teams.}
  spec.description   = %q{This gem to send chat messages to O365 Teams.}
  spec.homepage      = "https://github.com/toririn/teams_incoming_clients"
  spec.license       = "MIT"

  spec.metadata['allowed_push_host'] = 'https://rubygems.org/'

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/toririn/teams_incoming_clients"
  spec.metadata["changelog_uri"] = "https://github.com/toririn/teams_incoming_clients/releases"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "holiday_japan"
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "simplecov"
end
