// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract BuyAgreement{
    uint public amount;
    address payable public seller;
    address payable public user;
    enum State{Created,Locked,Release,Inactive}
    State public state;
    constructor() payable {
        seller=payable(msg.sender);
        amount=msg.value/2;
    }
    function getState() public view returns(string memory){
        if(state==State.Created){
            return "Created";
        }
        else if(state==State.Locked){
            return "Locked";
        }
        else if(state==State.Release){
            return "Released";
        }
        else{
            return "Inactive";
        }
       
    }
    /// The function cannot be called at the current state
    error Invalidstate();
    /// Only user can call this function
    error OnlyUser();
    /// Only Seller can call this function
    error OnlySeller();
    /// Seller and User cannot be the same
    error SameAddress();
    modifier inState(State _state){
        if(state!=_state){
            revert Invalidstate();
        }
        _;
    }
    modifier onlyUser(){
        if(msg.sender!=user){
            revert OnlyUser();
        }
        _;
    }
    modifier onlySeller(){
        if(msg.sender!=seller){
            revert OnlySeller();
        }
        _;
    }

    modifier sameAddress(){
        if(msg.sender==seller){
            revert SameAddress();
        }
        _;
    }

    function confirmationpurchase() external sameAddress inState(State.Created) payable {
        require(msg.value==(2*amount),"Please send in twice the purchase amount");
        user=payable(msg.sender);
        state=State.Locked;

    }
    // Saving from reentrancy attack//
    function confirmRecieved() external onlyUser inState(State.Locked) {
        state=State.Release;
        user.transfer(amount);

    }
    // Seller is going to get back his funds plus deposit
    function paySeller() external onlySeller inState(State.Release) {
        state=State.Inactive;
        seller.transfer(3*amount);



    }
    // Function to terminate transaction in case seller changes their mind and buyer haven't deposited their funds// 

    function terminate() external onlySeller inState(State.Created){
        state=State.Inactive;
        seller.transfer(address(this).balance);

    }
    
}