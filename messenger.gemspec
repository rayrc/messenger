# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{messenger}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brandon Arbini"]
  s.date = %q{2010-02-01}
  s.default_executable = %q{messenger}
  s.description = %q{Messenger: easy message sending}
  s.email = %q{brandon@zencoder.tv}
  s.executables = ["messenger"]
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "README.markdown",
     "VERSION.yml",
     "lib/messenger.rb",
     "lib/messenger/email.rb",
     "lib/messenger/web.rb",
     "test/test_email.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/zencoder/messenger}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Messenger: easy message sending}
  s.test_files = [
    "test/test_email.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end