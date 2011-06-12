require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Bitbank::Client" do
  before(:each) do
    @client = Bitbank.new(File.join(File.dirname(__FILE__), '..', 'config.yml'))
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
