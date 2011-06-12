require 'yaml'
require 'json'
require 'rest_client'

require 'active_support/core_ext'

Dir[File.join(File.dirname(__FILE__), 'bitbank', '*.rb')].each { |f| require f }

module Bitbank
  @@defaults = {
    :host => 'localhost',
    :port => 8332
  }

  def self.new(options={})
    self.config = options
    Client.new(config)
  end

  def self.config
    @config
  end

  def self.config=(filename_or_hash)
    if filename_or_hash.is_a?(String)
      options = YAML.load_file(filename_or_hash)
    else
      options = filename_or_hash
    end

    options.symbolize_keys!
    if options.has_key?(:username) && options.has_key?(:password)
      @config = @@defaults.merge(options)
    else
      raise ArgumentError, 'Please specify a username and password for bitcoind'
    end
  end

  def self.version
    version_path = File.join(File.dirname(__FILE__), '..', 'VERSION')
    if File.file?(version_path)
      File.read(version_path).chomp
    else
      '0.0.0'
    end
  end
end
