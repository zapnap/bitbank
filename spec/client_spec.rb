require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Bitbank::Client" do
  before(:each) do
    @client = Bitbank.new(File.join(File.dirname(__FILE__), '..', 'config.yml'))
  end

  describe 'info' do
    it 'should return a hash containing bitcoind status information' do
      VCR.use_cassette('client/info') do
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
end
