// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.17;

import "./PendleGaugeControllerBaseUpg.sol";
import "../../interfaces/IPGaugeControllerMainchain.sol";

contract PendleGaugeControllerMainchainUpg is PendleGaugeControllerBaseUpg, IPGaugeControllerMainchain {
    address public immutable votingController;

    modifier onlyVotingController() {
        if (msg.sender != votingController) revert Errors.GCNotVotingController(msg.sender);
        _;
    }

    constructor(
        address _votingController,
        address _pendle,
        address _marketFactory,
        address _marketFactory2,
        address _marketFactory3,
        address _marketFactory4
    ) PendleGaugeControllerBaseUpg(_pendle, _marketFactory, _marketFactory2, _marketFactory3, _marketFactory4) {
        votingController = _votingController;
        _disableInitializers();
    }

    function initialize(address _owner) external initializer {
        __BoringOwnableV2_init(_owner);
    }

    function updateVotingResults(
        uint128 wTime,
        address[] memory markets,
        uint256[] memory pendleSpeeds
    ) external onlyVotingController {
        _receiveVotingResults(wTime, markets, pendleSpeeds);
    }
}
