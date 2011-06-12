require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Bitbank::Account" do
  before(:each) do
    @client = Bitbank.new(File.join(File.dirname(__FILE__), '..', 'config.yml'))
    @account = Bitbank::Account.new(@client, 'prefect', 10.05)
  end

  it 'should have a name' do
    @account.name.should == 'prefect'
  end

  describe 'address' do
    use_vcr_cassette 'account/address'

    it 'should retrieve the address for this account' do
      @account.address.should == '1NqwGDRi9Gs4xm1BmPnGeMwgz1CowP6CeQ'
    end
  end

  describe 'balance' do
    use_vcr_cassette 'account/balance'

    it 'should retrieve the current balance' do
      @account.balance.should == 10.05
    end
  end
end
