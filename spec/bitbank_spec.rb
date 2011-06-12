require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Bitbank" do
  describe 'initialization' do
    it 'should configure the client' do
      client = Bitbank.new(:username => 'prefect', :password => 'hoopy')
      client.is_a?(Bitbank::Client).should be_true
    end
  end

  describe 'configuration' do
    it 'should require a username and password' do
      expect {
        Bitbank.config = { :username => 'marvin' }
      }.to raise_error(ArgumentError, 'Please specify a username and password for bitcoind')
    end

    it 'should parse a yaml file for credentials' do
      Bitbank.config = File.join(File.dirname(__FILE__), '..', 'config.yml')
      Bitbank.config[:username].should == 'testuser'
      Bitbank.config[:password].should == 'testpass'
    end

    it 'should use default values' do
      Bitbank.config = File.join(File.dirname(__FILE__), '..', 'config.yml')
      Bitbank.config[:host].should == 'localhost'
      Bitbank.config[:port].should == 8332
    end
  end

  describe 'version' do
    it 'should read version from file' do
      Bitbank.version.should == File.read(
        File.join(File.dirname(__FILE__), '..', 'VERSION')).chomp
    end
  end
end
