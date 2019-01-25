# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ocawari/version'

Gem::Specification.new do |spec|
  spec.name          = "ocawari"
  spec.version       = Ocawari::VERSION
  spec.authors       = ["Kenneth Uy"]
  spec.email         = ["missingno15@gmail.com"]

  spec.summary       = %q{Extract the image urls of the social media posts of your favorite idols}
  spec.description   = %q{If there is one thing that has plagued me over the years, it's that I constantly have more tabs in my browser open that necessary. And these tabs are usually images of Japanese idols I intend to save at some point but never do. This is because the whole process of grabbing the image either through right clicking the image or having to search for it via my browser's inspector then moving it to the desired directory via the GUI interface is an incredibly tedious and time consuming task. But through the power of code and this library, I will be able to just point the links of posts containing the images I want using this library and it will generate for me the links to the images which I can then pipe into some other tool dedicated for downloading like wget. With that being said, Hashimoto Kanna is your master now and she will show you the true nature of the force.}
  spec.homepage      = "https://github.com/NewSchoolKaidan/ocawari"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "openssl", "~> 2.1"
  spec.add_dependency "nokogiri", "~> 1.10", ">= 1.10.1"
  spec.add_dependency "addressable", "~> 2.6"
  spec.add_dependency "methadone", "~> 2.0", ">= 2.0.2"

  spec.add_development_dependency "bundler", "~> 2.0", ">= 2.0.1"
  spec.add_development_dependency "rake", "~> 12.3", ">= 12.3.2"
  spec.add_development_dependency "rb-readline", "~> 0.5.5"
  spec.add_development_dependency "pry", "~> 0.11.3"
  spec.add_development_dependency "pry-rescue", "~> 1.4", ">= 1.4.5"
  spec.add_development_dependency "minitest", "~> 5.11", ">= 5.11.3"
  spec.add_development_dependency "minitest-reporters", "~> 1.2"
  spec.add_development_dependency "vcr", "~> 4.0"
  spec.add_development_dependency "webmock", "~> 3.5", ">= 3.5.1"
end
