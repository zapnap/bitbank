# Bitbank

An easy-to-use Ruby interface for the Bitcoind JSON-RPC API. Work in progress :).

## Getting Started

First, you need to be running bitcoind. Download and install the official client from http://bitcoin.org/

Next, in order for the client to respond to JSON-RPC commands, you need to enable it in the config file. An example of this and a good explanation of the various options can be found at https://en.bitcoin.it/wiki/Running_Bitcoin

Make sure to set the server, rpcuser, and rpcpassword options.

## Connecting

Configure the username and password to match the ones in your bitcoind config. I recommend storing these in a yaml file (see the example config.yml). Once you've done that, you can initialize the client and make requests:

    client = Bitbank.new('/path/to/bitbank/config.yml')

## Accounts and Account Balances

You can have a number of different Bitcoin accounts and addresses.

    account = client.new_account('named-account')

    account = client.account('named-account')
    puts "#{account.name} has bitcoin address #{account.address}"

    client.accounts.each do |account|
      puts "#{account.name}: #{account.balance}"
    end

Or you can get the current balance for all your accounts:

    client.balance
    # => 10.05

## Transactions

Each account also has a list of transactions (both sent and received).

    account.transactions.each do |transaction|
      puts "[#{transaction.category}] #{transaction.address} #{transaction.amount}"
    end

You can move money between your accounts:

    account.move('another-account', 0.5)

And of course you can send payments using the library too:

    account.pay('1DSwyVqyhKKQwrdFw3jpAEqnrXEjTcTKMB', 1.0)

This would send 1 BTC to me. Which would be really awesome, if you'd like to support the continued development of the gem :).

## Contributing to Bitbank

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Nick Plante. See LICENSE.txt for
further details.

