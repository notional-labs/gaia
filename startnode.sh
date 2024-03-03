#!/bin/sh
set -eux
# create users
rm -rf $HOME/.gaia
BINARY=gaiad
$BINARY config chain-id gaia-02
$BINARY config keyring-backend test
$BINARY config output json
yes | $BINARY keys add validator
yes | $BINARY keys add creator
yes | $BINARY keys add investor
VALIDATOR=$($BINARY keys show validator -a)
CREATOR=$($BINARY keys show creator -a)
INVESTOR=$($BINARY keys show investor -a)
DENOM=uatom
# setup chain
$BINARY init gaia --chain-id gaia-02
gsed -i "s/\"stake\"/\"$DENOM\"/g" ~/.gaia/config/genesis.json
# modify config for development
config="$HOME/.gaia/config/config.toml"
gsed -i "s/cors_allowed_origins = \[\]/cors_allowed_origins = [\"*\"]/g" $config
gsed -i "s/\"stake\"/\"$DENOM\"/g" ~/.gaia/config/genesis.json
# modify genesis params for localnet ease of use
# x/gov params change
# reduce voting period to 2 minutes
contents="$(jq '.app_state.gov.params.voting_period = "120s"' $HOME/.gaia/config/genesis.json)" && echo "${contents}" >  $HOME/.gaia/config/genesis.json
# reduce minimum deposit amount to 10stake
contents="$(jq '.app_state.gov.params.min_deposit[0].amount = "10"' $HOME/.gaia/config/genesis.json)" && echo "${contents}" >  $HOME/.gaia/config/genesis.json
# reduce deposit period to 20seconds
contents="$(jq '.app_state.gov.params.max_deposit_period = "20s"' $HOME/.gaia/config/genesis.json)" && echo "${contents}" >  $HOME/.gaia/config/genesis.json
$BINARY genesis add-genesis-account $VALIDATOR 10000000000000000uatom
$BINARY genesis add-genesis-account $CREATOR 10000000000000000uatom
$BINARY genesis add-genesis-account $INVESTOR 10000000000000000uatom
$BINARY genesis gentx validator 10000000000uatom --chain-id gaia-02 --keyring-backend test
$BINARY genesis collect-gentxs
$BINARY genesis validate-genesis
$BINARY start --minimum-gas-prices 0.00uatom