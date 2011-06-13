require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Bitbank::Transaction" do
  before(:each) do
    @client = Bitbank.new(File.join(File.dirname(__FILE__), '..', 'config.yml'))
    @transaction = Bitbank::Transaction.new(@client, 'txid1',
                                            :account => 'adent', :address => 'addr1',
                                            :category => 'receive', :amount => 0.02,
                                            :confirmations => 1001, :time => 1306082334)
  end

  it 'should have a transaction id' do
    @transaction.txid.should == 'txid1'
  end

  it 'should have an account' do
    account = @transaction.account
    account.is_a?(Bitbank::Account).should be_true
    account.name.should == 'adent'
  end

  it 'should have an address' do
    @transaction.address.should == 'addr1'
  end

  it 'should have a category' do
    @transaction.category.should == 'receive'
  end

  it 'should have an amount' do
    @transaction.amount.should == 0.02
  end

  it 'should have confirmations' do
    @transaction.confirmations.should == 1001
  end

  it 'should have a time' do
    @transaction.time.strftime("%m-%d-%y").should == "05-22-11"
  end
end
