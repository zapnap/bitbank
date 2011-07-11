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

  describe 'account' do
    it 'should retrieve a named account' do
      Bitbank::Account.any_instance.expects(:address).returns(true) # check
      @client.account('newaccount').should == Bitbank::Account.new(@client, 'newaccount')
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
    context 'overall' do
      use_vcr_cassette 'client/balance'

      it 'should retreive the current balance' do
        @client.balance.should == 12.34
      end
    end

    context 'scoped to a particular account' do
      use_vcr_cassette 'client/balance_account'

      it 'should retrieve the account balance' do
        @client.balance.should == 10.05
      end
    end
  end

  describe 'block_count' do
    use_vcr_cassette 'client/block_count'

    it 'should return the number of blocks in the longest block chain' do
      @client.block_count.should == 130361
    end
  end

  describe 'block_number' do
    use_vcr_cassette 'client/block_number'

    it 'should return the block number of the latest block in the longest chain' do
      @client.block_number.should == 132426
    end
  end

  describe 'connection_count' do
    use_vcr_cassette 'client/connection_count'

    it 'should return the number of connections to other nodes' do
      @client.connection_count.should == 8
    end
  end

  describe 'difficulty' do
    use_vcr_cassette 'client/difficulty'

    it 'should return the current difficulty' do
      @client.difficulty.should == 567358.22457067
    end
  end

  describe 'get_work' do
    context 'when data is not supplied' do
      use_vcr_cassette 'client/get_work'

      it 'should return new formatted hash data to work on' do
        work = @client.get_work
        ['midstate', 'data', 'hash1', 'target'].each do |key|
          work.has_key?(key).should be_true
        end
      end
    end

    context 'with data' do
      context 'and the block solution is successful' do
        use_vcr_cassette 'client/get_work_data_true'

        it 'should return true' do
          data = "00000001aa1d7a0acb6102db122de979b3eef4e2387f61ce0ca68abb00000eba000000006f35688764fa1d99a8f66b02a25399568a3445af4dfa169448282b02b91f70024dfa59f51a13218573b87d00000000800000000000000000000000000000000000000000000000000000000000000000000000000000000080020000"
          @client.get_work(data).should be_true
        end
      end

      context 'and the block solution is not successful' do
        use_vcr_cassette 'client/get_work_data_false'

        it 'should return false' do
          data = "00000001aa1d7a0acb6102db122de979b3eef4e2387f61ce0ca68abb00000eba000000006f35688764fa1d99a8f66b02a25399568a3445af4dfa169448282b02b91f70024dfa59f51a13218573b87d00000000800000000000000000000000000000000000000000000000000000000000000000000000000000000080020000"
          @client.get_work(data).should be_false
        end
      end
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

  describe 'new_account' do
    it 'should create a new account and a new address' do
      Bitbank::Account.any_instance.expects(:address).returns(true) # check
      @client.new_account('newname').should == Bitbank::Account.new(@client, 'newname')
    end
  end

  describe 'new_address' do
    use_vcr_cassette 'client/new_address'

    it 'should create a new address and return it' do
      @client.new_address.should == '1EzxbYD4rFvZBjUEbtnKZ9KJdrqHB7mkZE'
    end
  end

  describe 'transactions' do
    context 'overall' do
      use_vcr_cassette 'client/transactions'

      it 'should retrieve all transactions' do
        transactions = @client.transactions
        transactions.length.should == 4
        transactions.last.txid.should == 'txid4'
      end
    end

    context 'scoped to a particular account' do
      use_vcr_cassette 'client/transactions_account'

      it 'should retrieve transactions for the account' do
        transactions = @client.transactions('adent')
        transactions.length.should == 1
        transactions.last.txid.should == 'txid1'
      end
    end
  end
end
