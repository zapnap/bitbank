module Bitbank
  class Account
    attr_reader :name, :balance

    def initialize(client, name, balance=nil)
      @client = client
      @name = name
      @balance = balance
    end
  end
end
