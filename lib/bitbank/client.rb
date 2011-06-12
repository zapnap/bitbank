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

    def difficulty
      request('getdifficulty')
    end

    def info
      request('getinfo')
    end

    private

    def request(method, *args)
      body = { 'id' => 'jsonrpc', 'method' => method }
      body['params'] = args unless args.empty?

      response_json = RestClient.post(@endpoint, body.to_json)
      response = JSON.parse(response_json)
      response['result']
    end
  end
end
