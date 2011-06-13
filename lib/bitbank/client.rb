module Bitbank
  class Client
    def initialize(config={})
      @config = config
      @endpoint = "http://#{config[:username]}:#{config[:password]}" +
                  "@#{config[:host]}:#{config[:port]}"
    end

    def accounts
      account_data = request('listaccounts')
      account_data.map do |account_name, account_value|
        Account.new(self, account_name, account_value)
      end
    end

    def balance(account_name=nil)
      request('getbalance', account_name)
    end

    # Returns the number of blocks in the longest block chain.
    def block_count
      request('getblockcount')
    end

    # Returns the proof-of-work difficulty as a multiple of the minimum difficulty.
    def difficulty
      request('getdifficulty')
    end

    def get_work(data=nil)
      request('getwork', data)
    end

    def info
      request('getinfo')
    end

    def new_address(account_name=nil)
      request('getnewaddress', account_name)
    end

    def transactions(account_name=nil, count=10)
      transaction_data = request('listtransactions', account_name, count)
      transaction_data.map do |txdata|
        Transaction.new(self, txdata['txid'], txdata)
      end
    end

    def request(method, *args)
      body = { 'id' => 'jsonrpc', 'method' => method }
      body['params'] = args unless args.empty? || args.first.nil?

      response_json = RestClient.post(@endpoint, body.to_json)
      response = JSON.parse(response_json)
      response['result']
    end
  end
end
