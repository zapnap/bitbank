require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Bitbank::Account" do
  before(:each) do
    @client = Bitbank.new(File.join(File.dirname(__FILE__), '..', 'config.yml'))
    @account = Bitbank::Account.new(@client, 'zapnap', 10.05)
  end

  describe 'accessors' do
    it 'should have a name' do
      @account.name.should == 'zapnap'
    end

    it 'should have a balance' do
      @account.balance.should == 10.05
    end
  end
end
