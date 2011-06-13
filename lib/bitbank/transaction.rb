module Bitbank
  class Transaction
    attr_reader :txid, :address, :category, :amount, :confirmations

    def initialize(client, txid, data={})
      @client = client
      @txid = txid

      data.symbolize_keys!
      @account = data[:account] if data[:account]
      @address = data[:address] if data[:address]
      @category = data[:category] if data[:category]
      @amount = data[:amount] if data[:amount]
      @confirmations = data[:confirmations] if data[:confirmations]
      @time = data[:time] if data[:time]
    end

    def account
      @account ? Account.new(@client, @account) : nil
    end

    def time
      Time.at(@time)
    end
  end
end
