require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Bitbank::Account" do
  before(:each) do
    @client = Bitbank.new(File.join(File.dirname(__FILE__), '..', 'config.yml'))
    @account = Bitbank::Account.new(@client, 'adent')
  end

  it 'should have a name' do
    @account.name.should == 'adent'
  end

  describe 'address' do
    use_vcr_cassette 'account/address'

    it 'should retrieve the address for this account' do
      @account.address.should == '1NqwGDRi9Gs4xm1BmPnGeMwgz1CowP6CeQ'
    end

    it 'should be validated on account creation if a check was requested (default)' do
      Bitbank::Account.any_instance.expects(:address)
      Bitbank::Account.new(@client, 'trill', nil, true)
    end
  end

  describe 'balance' do
    use_vcr_cassette 'account/balance'

    it 'should retrieve the current balance' do
      @account.balance.should == 0.02
    end
  end

  describe 'move' do
    use_vcr_cassette 'account/move'

    before(:each) do
      @to_account = Bitbank::Account.new(@client, 'prefect')
    end

    it 'should move funds between accounts using an account name' do
      @account.move('prefect', 0.01).should be_true
      @to_account.balance.should == 0.01
    end

    it 'should move funds between accounts using an account object' do
      @account.move(@to_account, 0.01).should be_true
      @to_account.balance.should == 0.01
    end
  end

  describe 'new_address' do
    use_vcr_cassette 'account/new_address'

    it 'should create a new address associated with this account and return it' do
      @account.new_address.should == '15GsE7o3isyQ7ygzh8Cya58oetrGYygdoi'
    end
  end

  describe 'pay' do
    use_vcr_cassette 'account/pay'

    it 'should return a new transaction' do
      transaction = @account.pay('destinationaddress', 0.01)
      transaction.amount.should == 0.01
      transaction.account.should == @account
    end
  end

  describe 'transactions' do
    use_vcr_cassette 'account/transactions'

    it 'should retrieve transactions for this account' do
      transactions = @account.transactions
      transactions.length.should == 1
      transactions.first.is_a?(Bitbank::Transaction).should be_true
      transactions.first.txid.should == 'txid1'
    end
  end

  describe 'equality' do
    it 'should compare account names' do
      @account.should_not == Bitbank::Account.new(@client, 'prefect')
      @account.should == Bitbank::Account.new(@client, 'adent')
    end
  end
end
