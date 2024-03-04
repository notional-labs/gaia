#!/bin/sh

set -eux

rm -rf $HOME/.gaia

BINARY=gaiad
MONIKER=localgaia
CHAIN_ID=gaia-feeabs-1
KEYRING="test"
DENOM=uatom

$BINARY config chain-id $CHAIN_ID
$BINARY config keyring-backend $KEYRING

command -v gaiad >/dev/null 2>&1 || {
    echo >&2 "gaiad command not found. Ensure this is setup / properly installed in your GOPATH."
    exit 1
}
command -v jq >/dev/null 2>&1 || {
    echo >&2 "jq not installed. More info: https://stedolan.github.io/jq/download/"
    exit 1
}

yes | $BINARY keys add validator
yes | $BINARY keys add creator
yes | $BINARY keys add investor
yes | $BINARY keys add relayer

VALIDATOR=$($BINARY keys show validator -a)
CREATOR=$($BINARY keys show creator -a)
INVESTOR=$($BINARY keys show investor -a)
RELAYER=$($BINARY keys show relayer -a)

# setup chain
$BINARY init $MONIKER --chain-id $CHAIN_ID
gsed -i "s/\"stake\"/\"$DENOM\"/g" ~/.gaia/config/genesis.json
# modify config for development
config="$HOME/.gaia/config/config.toml"
gsed -i "s/cors_allowed_origins = \[\]/cors_allowed_origins = [\"*\"]/g" $config
gsed -i "s/\"stake\"/\"$DENOM\"/g" ~/.gaia/config/genesis.json
# modify genesis params for localnet ease of use
# x/gov params change
# reduce voting period to 1 minutes
contents="$(jq '.app_state.gov.params.voting_period = "60s"' $HOME/.gaia/config/genesis.json)" && echo "${contents}" >$HOME/.gaia/config/genesis.json
# reduce minimum deposit amount to 10stake
contents="$(jq '.app_state.gov.params.min_deposit[0].amount = "10"' $HOME/.gaia/config/genesis.json)" && echo "${contents}" >$HOME/.gaia/config/genesis.json
# reduce deposit period to 20seconds
contents="$(jq '.app_state.gov.params.max_deposit_period = "20s"' $HOME/.gaia/config/genesis.json)" && echo "${contents}" >$HOME/.gaia/config/genesis.json

$BINARY genesis add-genesis-account $VALIDATOR "10000000000000000$DENOM"
$BINARY genesis add-genesis-account $CREATOR "10000000000000000$DENOM"
$BINARY genesis add-genesis-account $INVESTOR "10000000000000000$DENOM"
$BINARY genesis add-genesis-account $RELAYER "10000000000000000$DENOM"

$BINARY genesis gentx validator 10000000000uatom --chain-id $CHAIN_ID --keyring-backend $KEYRING
$BINARY genesis collect-gentxs
$BINARY genesis validate-genesis

$BINARY start --minimum-gas-prices 0.00uatom
