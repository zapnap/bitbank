module Bitbank
  class Account
    attr_reader :name, :balance

    def initialize(client, name, balance=nil)
      @client = client
      @name = name
      @balance = balance
    end

    def address
      @client.request('getaccountaddress', name)
    end

    def balance
      @client.balance(name)
    end

    def pay(address, amount)
      txid = @client.request('sendfrom', name, address, amount)
      Transaction.new(@client, txid)
    end

    def transactions
      @client.transactions(name)
    end

    def ==(other)
      name == other.name
    end
  end
end
