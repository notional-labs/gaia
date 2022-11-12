#!/bin/bash
# microtick and bitcanna contributed significantly here.
set -uxe

# set environment variables
export GOPATH=~/go
export PATH=$PATH:~/go/bin




# Install Gaia
# make install

# MAKE HOME FOLDER AND GET GENESIS
#gaiad init test 
#wget -O ~/.gaia/config/genesis.json https://cloudflare-ipfs.com/ipfs/Qmc54DreioPpPDUdJW6bBTYUKepmcPsscfqsfFcFmTaVig

INTERVAL=1000

# GET TRUST HASH AND TRUST HEIGHT

LATEST_HEIGHT=$(curl -s https://cosmos-rpc.polkachu.com/block | jq -r .result.block.header.height);
BLOCK_HEIGHT=12801337 
TRUST_HASH=$(curl -s "https://cosmos-rpc.polkachu.com/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)


# TELL USER WHAT WE ARE DOING
echo "TRUST HEIGHT: $BLOCK_HEIGHT"
echo "TRUST HASH: $TRUST_HASH"


# export state sync vars
export GAIAD_STATESYNC_ENABLE=true
export GAIAD_P2P_MAX_NUM_OUTBOUND_PEERS=200
export GAIAD_STATESYNC_RPC_SERVERS="https://rpc-cosmoshub-ia.cosmosia.notional.ventures:443,https://cosmos-rpc.polkachu.com:443,https://cosmos-rpc.polkachu.com:443"
export GAIAD_STATESYNC_TRUST_HEIGHT=$BLOCK_HEIGHT
export GAIAD_STATESYNC_TRUST_HASH=$TRUST_HASH
export GAIAD_P2P_SEEDS="ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@seeds.polkachu.com:14956"

gaiad start --x-crisis-skip-assert-invariants --halt-height 12811337
gaiad export 2> gaia.json
