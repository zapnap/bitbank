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

  context 'loaded without details' do
    use_vcr_cassette 'transaction/details'

    it 'should force-load extra attributes' do
      @transaction = Bitbank::Transaction.new(@client, 'txid1')
      @transaction.address.should == 'addr1'
      @transaction.amount.should == 1.00
    end
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

  it 'should have a time' do
    @transaction.time.strftime("%m-%d-%y").should == "05-22-11"
  end

  it 'should be a confirmed transaction' do
    @transaction.should be_confirmed
  end

  describe 'confirmations' do
    it 'should have confirmations' do
      @transaction.confirmations.should == 1001
    end

    it 'should have enough to be confirmed' do
      @transaction.should be_confirmed
    end

    it 'should not have enough to be confirmed' do
      Bitbank::Transaction.new(@client, 'txid2', :confirmations => 5).should_not be_confirmed
    end
  end

  describe 'equality' do
    it 'should compare transaction ids' do
      Bitbank::Transaction.any_instance.stubs(:load_details)
      @transaction.should_not == Bitbank::Transaction.new(@client, 'txid2')
      @transaction.should == Bitbank::Transaction.new(@client, 'txid1')
    end
  end
end
