module Bitbank
  class Transaction
    attr_reader :txid, :address, :category, :amount, :confirmations

    def initialize(client, txid, data={})
      @client = client
      @txid = txid

      load_details(data)
    end

    def account
      @account ? Account.new(@client, @account) : nil
    end

    def time
      Time.at(@time)
    end

    def confirmed?
      confirmations && confirmations > 6
    end

    def ==(other)
      txid == other.txid
    end

    private

    def load_details(data={})
      data = @client.request('gettransaction', txid) if data.empty?
      data.symbolize_keys!

      details = ((data.delete(:details) || []).first || {}).symbolize_keys
      @account = data[:account] || details[:account]
      @address = data[:address] || details[:address]
      @category = data[:category] || details[:category]
      @amount = data[:amount] || details[:amount]
      @confirmations = data[:confirmations]
      @time = data[:time]
    end
  end
end
