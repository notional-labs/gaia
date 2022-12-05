#!/bin/bash
# microtick and bitcanna contributed significantly here.
set -uxe

# set environment variables
export GOPATH=~/go
export PATH=$PATH:~/go/bin


# Install Gaia
go mod edit -replace github.com/tendermint/tm-db=github.com/osmosis-labs/tm-db@599916193fe6c8471bb24ba37fead7e5fca2d1f9
go mod tidy
go install -ldflags '-w -s -X github.com/cosmos/cosmos-sdk/types.DBBackend=mdbx' -tags mdbx ./...

# MAKE HOME FOLDER AND GET GENESIS
gaiad init test 
wget -O ~/.gaia/config/genesis.json https://cloudflare-ipfs.com/ipfs/Qmc54DreioPpPDUdJW6bBTYUKepmcPsscfqsfFcFmTaVig

INTERVAL=1000

# GET TRUST HASH AND TRUST HEIGHT

LATEST_HEIGHT=$(curl -s https://rpc-cosmoshub-ia.cosmosia.notional.ventures/block | jq -r .result.block.header.height);
BLOCK_HEIGHT=$(($LATEST_HEIGHT-$INTERVAL)) 
TRUST_HASH=$(curl -s "https://rpc-cosmoshub-ia.cosmosia.notional.ventures/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)


# TELL USER WHAT WE ARE DOING
echo "TRUST HEIGHT: $BLOCK_HEIGHT"
echo "TRUST HASH: $TRUST_HASH"


# export state sync vars
export GAIAD_STATESYNC_ENABLE=true
export GAIAD_P2P_MAX_NUM_OUTBOUND_PEERS=200
export GAIAD_STATESYNC_RPC_SERVERS="https://cosmoshub-rpc.lavenderfive.com:443,https://rpc.cosmoshub-ia.cosmosia.notional.ventures:443,https://cosmos-rpc.polkachu.com:443"
export GAIAD_STATESYNC_TRUST_HEIGHT=$BLOCK_HEIGHT
export GAIAD_STATESYNC_TRUST_HASH=$TRUST_HASH
export GAIAD_P2P_SEEDS="3b67739570f921cc5e0db4b3efe488ce184155a9@seeds.pupmos.network:2000,3b67739570f921cc5e0db4b3efe488ce184155a9@seeds.goldenratiostaking.net:1618,20e1000e88125698264454a884812746c2eb4807@seeds.lavenderfive.com:14956,bf8328b66dceb4987e5cd94430af66045e59899f@public-seed.cosmos.vitwit.com:26656"

gaiad start --x-crisis-skip-assert-invariants --db_backend mdbx
