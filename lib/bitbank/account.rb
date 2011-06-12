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
      @client.request('getbalance', name)
    end
  end
end
