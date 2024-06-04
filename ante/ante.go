package ante

import (
	ibcante "github.com/cosmos/ibc-go/v7/modules/core/ante"
	ibckeeper "github.com/cosmos/ibc-go/v7/modules/core/keeper"
	feeabskeeper "github.com/osmosis-labs/fee-abstraction/v7/x/feeabs/keeper"

	errorsmod "cosmossdk.io/errors"

	"github.com/cosmos/cosmos-sdk/codec"
	sdk "github.com/cosmos/cosmos-sdk/types"
	"github.com/cosmos/cosmos-sdk/x/auth/ante"
	paramtypes "github.com/cosmos/cosmos-sdk/x/params/types"
	stakingkeeper "github.com/cosmos/cosmos-sdk/x/staking/keeper"

	gaiaerrors "github.com/cosmos/gaia/v18/types/errors"
	gaiafeeante "github.com/cosmos/gaia/v18/x/globalfee/ante"

	feeabsante "github.com/osmosis-labs/fee-abstraction/v7/x/feeabs/ante"
)

// HandlerOptions extend the SDK's AnteHandler options by requiring the IBC
// channel keeper.
type HandlerOptions struct {
	ante.HandlerOptions
	Codec             codec.BinaryCodec
	IBCkeeper         *ibckeeper.Keeper
	GlobalFeeSubspace paramtypes.Subspace
	StakingKeeper     *stakingkeeper.Keeper
	TxFeeChecker      ante.TxFeeChecker
	FeeAbskeeper      feeabskeeper.Keeper
}

func NewAnteHandler(opts HandlerOptions) (sdk.AnteHandler, error) {
	if opts.AccountKeeper == nil {
		return nil, errorsmod.Wrap(gaiaerrors.ErrLogic, "account keeper is required for AnteHandler")
	}
	if opts.BankKeeper == nil {
		return nil, errorsmod.Wrap(gaiaerrors.ErrLogic, "bank keeper is required for AnteHandler")
	}
	if opts.SignModeHandler == nil {
		return nil, errorsmod.Wrap(gaiaerrors.ErrLogic, "sign mode handler is required for AnteHandler")
	}
	if opts.IBCkeeper == nil {
		return nil, errorsmod.Wrap(gaiaerrors.ErrLogic, "IBC keeper is required for AnteHandler")
	}

	if opts.GlobalFeeSubspace.Name() == "" {
		return nil, errorsmod.Wrap(gaiaerrors.ErrNotFound, "globalfee param store is required for AnteHandler")
	}

	if opts.StakingKeeper == nil {
		return nil, errorsmod.Wrap(gaiaerrors.ErrNotFound, "staking param store is required for AnteHandler")
	}

	sigGasConsumer := opts.SigGasConsumer
	if sigGasConsumer == nil {
		sigGasConsumer = ante.DefaultSigVerificationGasConsumer
	}

	anteDecorators := []sdk.AnteDecorator{
		ante.NewSetUpContextDecorator(), // outermost AnteDecorator. SetUpContext must be called first
		ante.NewExtensionOptionsDecorator(opts.ExtensionOptionChecker),
		ante.NewValidateBasicDecorator(),
		ante.NewTxTimeoutHeightDecorator(),
		ante.NewValidateMemoDecorator(opts.AccountKeeper),
		ante.NewConsumeGasForTxSizeDecorator(opts.AccountKeeper),
		NewGovVoteDecorator(opts.Codec, opts.StakingKeeper),
		gaiafeeante.NewFeeDecorator(opts.GlobalFeeSubspace, opts.StakingKeeper),
		feeabsante.NewFeeAbstrationMempoolFeeDecorator(opts.FeeAbskeeper),
		feeabsante.NewFeeAbstractionDeductFeeDecorate(opts.AccountKeeper, opts.BankKeeper, opts.FeeAbskeeper, opts.FeegrantKeeper),
		ante.NewSetPubKeyDecorator(opts.AccountKeeper), // SetPubKeyDecorator must be called before all signature verification decorators
		ante.NewValidateSigCountDecorator(opts.AccountKeeper),
		ante.NewSigGasConsumeDecorator(opts.AccountKeeper, sigGasConsumer),
		ante.NewSigVerificationDecorator(opts.AccountKeeper, opts.SignModeHandler),
		ante.NewIncrementSequenceDecorator(opts.AccountKeeper),
		ibcante.NewRedundantRelayDecorator(opts.IBCkeeper),
	}

	return sdk.ChainAnteDecorators(anteDecorators...), nil
}
