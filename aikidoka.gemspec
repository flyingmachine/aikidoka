# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{aikidoka}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Higginbotham"]
  s.date = %q{2009-05-10}
  s.description = %q{Avoid namespace collisions}
  s.email = %q{daniel@flyingmachinestudios.com}
  s.files = [
    ".gitignore",
     "Rakefile",
     "VERSION",
     "aikidoka.gemspec",
     "lib/aikidoka.rb",
     "spec/aikidoka_spec.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/flyingmachine/aikidoka}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Avoid namespace collisions}
  s.test_files = [
    "spec/aikidoka_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
