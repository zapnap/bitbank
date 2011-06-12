module Bitbank
  class Client
    def initialize(config={})
      @config = config
      @endpoint = "http://#{config[:username]}:#{config[:password]}" +
                  "@#{config[:host]}:#{config[:port]}"
    end

    def accounts
      accounts = []
      account_data = request('listaccounts')
      account_data.map do |account_name, account_value|
        Account.new(self, account_name, account_value)
      end
    end

    def balance
      request('getbalance')
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
      if data.nil?
        request('getwork')
      else
        request('getwork', data)
      end
    end

    def info
      request('getinfo')
    end

    def request(method, *args)
      body = { 'id' => 'jsonrpc', 'method' => method }
      body['params'] = args unless args.empty?

      response_json = RestClient.post(@endpoint, body.to_json)
      response = JSON.parse(response_json)
      response['result']
    end
  end
end
