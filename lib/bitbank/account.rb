module Bitbank
  class Account
    attr_reader :name

    def initialize(client, name, balance=nil, check=false)
      @client = client
      @name = name
      @balance = balance # currently unused

      # validate the address if a check is requested
      # (bitcoind creates it if it didn't previous exist)
      address if check
    end

    # Returns the current bitcoin address for receiving payments to this
    # account.
    def address
      @client.request('getaccountaddress', name)
    end

    # Returns the balance in this account.
    def balance
      @client.balance(name)
    end

    # Move funds from one account in your wallet to another.
    # First parameter can either by an account name or an actual account
    # object.
    def move(name_or_account, amount)
      to_name = if name_or_account.is_a?(Bitbank::Account)
        name_or_account.name
      else
        name_or_account
      end

      @client.request('move', name, to_name, amount)
    end

    alias :transfer :move

    # Returns a new bitcoin address for receiving payments to this account.
    def new_address
      @client.new_address(name)
    end

    # Send funds from this account to the recipient identified by +address+.
    # Note that +amount+ is a real and is rounded to 8 decimal places.
    # Returns the transaction if successful.
    def pay(address, amount)
      if @client.validate_address(address, true)
        txid = @client.request('sendfrom', name, address, amount)
        Transaction.new(@client, txid)
      else
        false
      end
    end

    # Returns a list of the most recent transactions for this account.
    def transactions(count = 10)
      @client.transactions(name, count)
    end

    def ==(other)
      name == other.name
    end
  end
end
