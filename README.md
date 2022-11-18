Building A Smart Contract 

Contents of the file:
•	Project Details
•	Function Details


Project Details :
This project aims at safe and secure transfer of money using Smart Contracts. This Smart Contract is built on Remix IDE in such a way that transfer of money to the seller only occurs when the buyer confirms that they have received their product. Also the offloading of the product only occurs when the buyer has paid a deposit amount to the Smart Contract deployed on the Blockchain Network.
The Smart Contract will consist of following variables:
•	Amount
This is the price of the commodity.
•	Seller
This is the address of the seller.
•	User
This is the address of the buyer.
•	State
This defines the state of the transaction. It can be Created, Locked, Release, or Inactive.




Function Details:
A total of 1 constructor, 4 Modifiers, and 5 Functions have been defined.
•	Constructor:
The seller deploys a contract with twice the amount of his product. The constructor defines the address of the seller and the amount of the product from the deployed contract which will be further used.
•	Modifiers:
1.	inState
This modifier is to assure that the activities are taking place in their desired order. This reverts an error if a particular function gets called at the wrong state.
2.	OnlyUser
This modifier reverts an error if the seller tries to call a function only meant for the user.
3.	OnlySeller
This modifier reverts an error if the user tries to call a function only meant for the seller.
4.	SameAddress
This modifier reverts an error if the user and the seller address are the same.
•	Functions:
1.	getState
This returns the state the Contract is currently in.
2.	confirmationpurchase
This only works when the User calls this function and twice the amount is sent. This defines the address of the User and changes the state to Locked. 
3.	confirmReceived
Only works when called by the User and the state is Locked. Changes the state to Release and transfers the deposit amount back to the user.
4.	paySeller
Only works when called by the Seller and the state is Release. Changes the state to Inactive and transfer 3 times the amount to seller.
5.	Terminate
In case the seller wants to cancel the order. Only possible when state is Created which gets changed to Inactive and the deposit is transferred back to the Seller.

