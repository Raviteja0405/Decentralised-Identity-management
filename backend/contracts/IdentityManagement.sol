// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract IdentityManager {

    struct Identity {
        address verifiedBy;
        string signature;
        bool verified;
        uint256 timestamp;
    }

    address public owner;
    string public institution;
    mapping(bytes32 => Identity) identities;
    bool public isDestructed = false;

    event IdentityAdded(string fingerprint, string signature, uint256 timestamp);
    event IdentityRemoved(string fingerprint, bool verified);
    event ContractDestructed(address owner);

    modifier isOwner(address sender){
        require(sender == owner, "Sender must be contract owner");
        _;
    }

    modifier isVerified(bytes32 fingerprint){
        require(identities[fingerprint].verified, "Identity must be verified");
        _;
    }

    modifier notDestructed() {
        require(!isDestructed, "Contract has been destructed");
        _;
    }

    constructor(string memory _institution) {
        owner = msg.sender;
        institution = _institution;
    }

    function addIdentity(string memory _fingerprint, string memory _signature, bool _verified)
    public
    isOwner(msg.sender)
    notDestructed
    {
        bytes memory encodedFingerprint = abi.encode(_fingerprint);
        require(_verified, "Identity must be verified before adding to a blockchain");
        identities[keccak256(encodedFingerprint)] = Identity({
                verifiedBy: msg.sender,
                signature: _signature,
                verified: _verified,
                timestamp: block.timestamp
            });
        emit IdentityAdded(_fingerprint, _signature, block.timestamp);
    }

    function removeIdentity(string memory _fingerprint)
    public
    isOwner(msg.sender)
    notDestructed
    {
        bytes memory encodedFingerprint = abi.encode(_fingerprint);
        delete identities[keccak256(encodedFingerprint)];
        emit IdentityRemoved(_fingerprint, identities[keccak256(encodedFingerprint)].verified);
    }

    function getIdentity(string memory _fingerprint)
    isVerified(keccak256(abi.encode(_fingerprint)))
    public
    view
    notDestructed
    returns (address verifiedBy, string memory signature, bool verified, string memory fingerprint, uint256 timestamp) {
        bytes memory encodedFingerprint = abi.encode(_fingerprint);
        Identity memory identity = identities[keccak256(encodedFingerprint)];
        return (identity.verifiedBy, identity.signature, identity.verified, _fingerprint, identity.timestamp);
    }

    function removeContract() public isOwner(msg.sender) notDestructed {
        isDestructed = true;
        payable(owner).transfer(address(this).balance);
        emit ContractDestructed(owner);
    }
}
