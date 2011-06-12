require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Bitbank::Client" do
  before(:each) do
    @client = Bitbank.new(File.join(File.dirname(__FILE__), '..', 'config.yml'))
  end

  describe 'request' do
    before(:each) do
      @json = '{"result":{"foo":"bar"}}'
    end

    it 'should post to the endpoint' do
      RestClient.expects(:post).with(
        @client.instance_variable_get('@endpoint'), anything).returns(@json)
      @client.request('foo')
    end

    it 'should parse json results' do
      RestClient.stubs(:post).returns(@json)
      @client.request('whatever').should == { 'foo' => 'bar' }
    end
  end

  describe 'accounts' do
    use_vcr_cassette 'client/accounts'

    it 'should retrieve all accounts' do
      accounts = @client.accounts
      accounts.length.should == 3
      accounts.last.name.should == 'misc'
    end
  end

  describe 'balance' do
    use_vcr_cassette 'client/balance'

    it 'should retreive the current balance' do
      @client.balance.should == 12.34
    end
  end

  describe 'difficulty' do
    use_vcr_cassette 'client/difficulty'

    it 'should return the current difficulty' do
      @client.difficulty.should == 567358.22457067
    end
  end

  describe 'info' do
    use_vcr_cassette 'client/info'

    it 'should return a hash containing bitcoind status information' do
      @result = @client.info

      @result['version'].should == 32100
      @result['testnet'].should be_false

      info_keys = ['version', 'balance', 'blocks', 'connections', 'proxy',
        'generate', 'genproclimit', 'difficulty', 'hashespersec', 'testnet', 
        'keypoololdest', 'paytxfee', 'errors']
      info_keys.each do |key|
        @result.keys.include?(key).should be_true
      end
    end
  end
end
