# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bitbank}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nick Plante"]
  s.date = %q{2011-06-13}
  s.description = %q{Easy to use Ruby interface to the Bitcoind JSON-RPC API}
  s.email = %q{nap@zerosum.org}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".autotest",
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bitbank.gemspec",
    "config.yml",
    "lib/bitbank.rb",
    "lib/bitbank/account.rb",
    "lib/bitbank/client.rb",
    "lib/bitbank/transaction.rb",
    "spec/account_spec.rb",
    "spec/bitbank_spec.rb",
    "spec/client_spec.rb",
    "spec/fixtures/vcr_cassettes/account/address.yml",
    "spec/fixtures/vcr_cassettes/account/balance.yml",
    "spec/fixtures/vcr_cassettes/account/new_address.yml",
    "spec/fixtures/vcr_cassettes/account/pay.yml",
    "spec/fixtures/vcr_cassettes/account/transactions.yml",
    "spec/fixtures/vcr_cassettes/client/accounts.yml",
    "spec/fixtures/vcr_cassettes/client/balance.yml",
    "spec/fixtures/vcr_cassettes/client/balance_account.yml",
    "spec/fixtures/vcr_cassettes/client/block_count.yml",
    "spec/fixtures/vcr_cassettes/client/difficulty.yml",
    "spec/fixtures/vcr_cassettes/client/get_work.yml",
    "spec/fixtures/vcr_cassettes/client/info.yml",
    "spec/fixtures/vcr_cassettes/client/new_address.yml",
    "spec/fixtures/vcr_cassettes/client/transactions.yml",
    "spec/fixtures/vcr_cassettes/client/transactions_account.yml",
    "spec/fixtures/vcr_cassettes/transaction/details.yml",
    "spec/spec_helper.rb",
    "spec/support/focused.rb",
    "spec/transaction_spec.rb"
  ]
  s.homepage = %q{http://github.com/zapnap/bitbank}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Easy to use Ruby interface to the Bitcoind JSON-RPC API}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rest-client>, ["~> 1.6.3"])
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.0.7"])
      s.add_runtime_dependency(%q<i18n>, ["~> 0.6.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.6.0"])
      s.add_development_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.2"])
      s.add_development_dependency(%q<webmock>, ["~> 1.6.4"])
      s.add_development_dependency(%q<vcr>, ["~> 1.10.0"])
      s.add_development_dependency(%q<mocha>, ["~> 0.9.12"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<fuubar>, [">= 0.0.5"])
      s.add_development_dependency(%q<autotest>, [">= 4.4.6"])
    else
      s.add_dependency(%q<rest-client>, ["~> 1.6.3"])
      s.add_dependency(%q<activesupport>, ["~> 3.0.7"])
      s.add_dependency(%q<i18n>, ["~> 0.6.0"])
      s.add_dependency(%q<rspec>, ["~> 2.6.0"])
      s.add_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.2"])
      s.add_dependency(%q<webmock>, ["~> 1.6.4"])
      s.add_dependency(%q<vcr>, ["~> 1.10.0"])
      s.add_dependency(%q<mocha>, ["~> 0.9.12"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<fuubar>, [">= 0.0.5"])
      s.add_dependency(%q<autotest>, [">= 4.4.6"])
    end
  else
    s.add_dependency(%q<rest-client>, ["~> 1.6.3"])
    s.add_dependency(%q<activesupport>, ["~> 3.0.7"])
    s.add_dependency(%q<i18n>, ["~> 0.6.0"])
    s.add_dependency(%q<rspec>, ["~> 2.6.0"])
    s.add_dependency(%q<yard>, ["~> 0.6.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.2"])
    s.add_dependency(%q<webmock>, ["~> 1.6.4"])
    s.add_dependency(%q<vcr>, ["~> 1.10.0"])
    s.add_dependency(%q<mocha>, ["~> 0.9.12"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<fuubar>, [">= 0.0.5"])
    s.add_dependency(%q<autotest>, [">= 4.4.6"])
  end
end

