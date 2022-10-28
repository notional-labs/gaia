(window.webpackJsonp=window.webpackJsonp||[]).push([[89],{554:function(t,e,o){"use strict";o.r(e);var r=o(1),i=Object(r.a)({},(function(){var t=this,e=t.$createElement,o=t._self._c||e;return o("ContentSlotsDistributor",{attrs:{"slot-key":t.$parent.slotKey}},[o("h1",{attrs:{id:"on-chain-proposal-process"}},[o("a",{staticClass:"header-anchor",attrs:{href:"#on-chain-proposal-process"}},[t._v("#")]),t._v(" On-Chain Proposal Process")]),t._v(" "),o("h2",{attrs:{id:"the-proposal-process-two-periods"}},[o("a",{staticClass:"header-anchor",attrs:{href:"#the-proposal-process-two-periods"}},[t._v("#")]),t._v(" The Proposal Process: Two Periods")]),t._v(" "),o("h3",{attrs:{id:"_1-deposit-period"}},[o("a",{staticClass:"header-anchor",attrs:{href:"#_1-deposit-period"}},[t._v("#")]),t._v(" 1. Deposit Period")]),t._v(" "),o("p",[t._v("The deposit period lasts either 14 days or until the proposal deposit totals 64 ATOMs, whichever happens first.")]),t._v(" "),o("h4",{attrs:{id:"deposits"}},[o("a",{staticClass:"header-anchor",attrs:{href:"#deposits"}},[t._v("#")]),t._v(" Deposits")]),t._v(" "),o("p",[t._v("Deposit amounts are at risk of being burned. Prior to a governance proposal entering the voting period (ie. for the proposal to be voted upon), there must be at least a minimum number of ATOMs deposited (64). Anyone may contribute to this deposit. Deposits of passed and failed proposals are returned to the contributors.")]),t._v(" "),o("p",[t._v("In the past, different people have considered contributions amounts differently. There is some consensus that this should be a personal choice. There is also some consensus that this can be an opportunity for supporters to signal their support by adding to the deposit amount, so a proposer may choose to leave contribution room (ie. a deposit below 64 ATOMs) so that others may participate. It is important to remember that any contributed ATOMs are at risk of being burned.")]),t._v(" "),o("h4",{attrs:{id:"burned-deposits"}},[o("a",{staticClass:"header-anchor",attrs:{href:"#burned-deposits"}},[t._v("#")]),t._v(" Burned deposits")]),t._v(" "),o("p",[t._v("Deposits are burned only when proposals are vetoed i.e. 33.4% of voting power backing the 'NoWithVeto' option as documented in the "),o("a",{attrs:{href:"https://docs.cosmos.network/main/modules/gov#deposit-refund-and-burn",target:"_blank",rel:"noopener noreferrer"}},[t._v("Cosmos SDK gov module spec"),o("OutboundLink")],1),t._v(".")]),t._v(" "),o("h3",{attrs:{id:"_2-voting-period"}},[o("a",{staticClass:"header-anchor",attrs:{href:"#_2-voting-period"}},[t._v("#")]),t._v(" 2. Voting Period")]),t._v(" "),o("p",[t._v("The voting period is currently a fixed 14-day period. During the voting period, participants may select a vote of either 'Yes', 'No', 'Abstain', or 'NoWithVeto'. Voters may change their vote at any time before the voting period ends.")]),t._v(" "),o("h2",{attrs:{id:"what-do-the-voting-options-mean"}},[o("a",{staticClass:"header-anchor",attrs:{href:"#what-do-the-voting-options-mean"}},[t._v("#")]),t._v(" What do the voting options mean?")]),t._v(" "),o("ol",[o("li",[o("strong",[t._v("Abstain:")]),t._v(" indicates that the voter is impartial to the outcome of the proposal.")]),t._v(" "),o("li",[o("strong",[t._v("Yes:")]),t._v(" indicates approval of the proposal in its current form.")]),t._v(" "),o("li",[o("strong",[t._v("No:")]),t._v(" indicates disapproval of the proposal in its current form.")]),t._v(" "),o("li",[o("strong",[t._v("NoWithVeto:")]),t._v(" indicates stronger opposition to the proposal than simply voting 'No'. If the number of 'NoWithVeto' votes is greater than a third of total votes excluding 'Abstain' votes, the proposal is rejected and the deposits are "),o("a",{attrs:{href:"#burned-deposits"}},[t._v("burned")]),t._v(".")])]),t._v(" "),o("p",[t._v("As accepted by the community in "),o("a",{attrs:{href:"https://ipfs.io/ipfs/QmRtR7qkeaZCpCzHDwHgJeJAZdTrbmHLxFDYXhw7RoF1pp",target:"_blank",rel:"noopener noreferrer"}},[t._v("Proposal 6"),o("OutboundLink")],1),t._v(", voters are expected to vote 'NoWithVeto' if a proposal leads to undesireable outcomes for the community. It states “if a proposal seems to be spam or is deemed to have caused a negative externality to Cosmos community, voters should vote "),o("em",[t._v("NoWithVeto")]),t._v(".”")]),t._v(" "),o("p",[t._v("Voting 'NoWithVeto' provides a mechanism for a minority group representing a "),o("em",[t._v("third")]),t._v(" of the participating voting power to reject a proposal that would otherwise pass. This makes explicit an aspect of the consensus protocol: it works as long as only up to "),o("a",{attrs:{href:"https://docs.tendermint.com/v0.34/introduction/what-is-tendermint.html",target:"_blank",rel:"noopener noreferrer"}},[t._v("a third of nodes fail"),o("OutboundLink")],1),t._v(". In other words, greater than a third of validators are always in a position to cause a proposal to fail outside the formalized governance process and the network's norms, such as by censoring transactions. The purpose of internalizing this aspect of the consensus protocol into the governance process is to discourage validators from relying on collusion and censorship tactics to influence voting outcomes.")]),t._v(" "),o("h2",{attrs:{id:"what-determines-whether-or-not-a-governance-proposal-passes"}},[o("a",{staticClass:"header-anchor",attrs:{href:"#what-determines-whether-or-not-a-governance-proposal-passes"}},[t._v("#")]),t._v(" What determines whether or not a governance proposal passes?")]),t._v(" "),o("p",[t._v("There are four criteria:")]),t._v(" "),o("ol",[o("li",[t._v("A minimum deposit of 64 ATOM is required for the proposal to enter the voting period\n"),o("ul",[o("li",[t._v("anyone may contribute to this deposit")]),t._v(" "),o("li",[t._v("the deposit must be reached within 14 days (this is the deposit period)")])])]),t._v(" "),o("li",[t._v("A minimum of 40% of the network's voting power (quorum) is required to participate to make the proposal valid")]),t._v(" "),o("li",[t._v("A simple majority (greater than 50%) of the participating voting power must back the 'Yes' vote during the 14-day voting period")]),t._v(" "),o("li",[t._v("Less than 33.4% of participating voting power votes 'NoWithVeto'")])]),t._v(" "),o("p",[t._v("Currently, the criteria for submitting and passing/failing all proposal types is the same.")]),t._v(" "),o("h3",{attrs:{id:"how-is-voting-tallied"}},[o("a",{staticClass:"header-anchor",attrs:{href:"#how-is-voting-tallied"}},[t._v("#")]),t._v(" How is voting tallied?")]),t._v(" "),o("p",[t._v("Voting power is determined by stake weight at the end of the 14-day voting period and is proportional to the number of total ATOMs participating in the vote. Only bonded ATOMs count towards the voting power for a governance proposal. Liquid ATOMs will not count toward a vote or quorum.")]),t._v(" "),o("p",[t._v("Inactive validators can cast a vote, but their voting power (including the backing of their delegators) will not count toward the vote if they are not in the active set when the voting period ends. That means that if I delegate to a validator that is either jailed, tombstoned, or ranked lower than 125 in stake-backing at the time that the voting period ends, my stake-weight will not count in the vote.")]),t._v(" "),o("p",[t._v("Though a simple majority 'Yes' vote (ie. 50% of participating voting power) is required for a governance proposal vote to pass, a 'NoWithVeto' vote of 33.4% of participating voting power or greater can override this outcome and cause the proposal to fail. This enables a minority group representing greater than 1/3 of voting power to fail a proposal that would otherwise pass.")]),t._v(" "),o("h3",{attrs:{id:"how-is-quorum-determined"}},[o("a",{staticClass:"header-anchor",attrs:{href:"#how-is-quorum-determined"}},[t._v("#")]),t._v(" How is quorum determined?")]),t._v(" "),o("p",[t._v("Voting power, whether backing a vote of 'Yes', 'Abstain', 'No', or 'NoWithVeto', counts toward quorum. Quorum is required for the outcome of a governance proposal vote to be considered valid and for deposit contributors to recover their deposit amounts. If the proposal vote does not reach quorum (ie. less than 40% of the network's voting power is participating) within 14 days, any deposit amounts will be burned and the proposal outcome will not be considered to be valid.")])])}),[],!1,null,null,null);e.default=i.exports}}]);