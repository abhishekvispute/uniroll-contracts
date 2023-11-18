# Uniroll Contracts
### For Client : [UniRoll UI](https://github.com/karooolis/uniroll-ui) 
<img src="https://github.com/abhishekvispute/uniroll-contracts/assets/46760063/cf55f79f-b781-4051-8373-49516415664c" alt="drawing" width="600"/>

## Buit at ETHGlobal:Istanbul 

**Uniroll is essentially a flexible and automated payroll streaming service based on Cowswap's programmatic orders.**</br>

1. The Treasury/Employer/DAO determines the amount and tops up the treasury with their own or any token.</br> 
2. Receivers choose the token and chain of their choice, and then payments are regularly swapped from the treasury's token to the token of the receiver's choice and streamed regularly using programmatic orders.</br> 
We also planned to bridge them to the chain of the receiver's choice using hooks.</br> 
However, currently, we could implement and execute only the first part end-to-end, due to time constraints. </br>
The second part remains incomplete as of now. </br>
</br>

We think this level of personalization and flexibility is required in our diverse world, since contributors/receivers might have preferences for certain tokens or blockchains due to factors like base location, transaction fees, processing times, or personal preferences. </br>
The codebase currently is buggy; for example, ERC-1271 always returns true, so please don't use this in production. </br>

## Deployments

Mainnet : Gnosis, We test in Production :) </br>
- Payroll(Handler): https://gnosisscan.io/address/0x467751B9224f7828b37e2c242F7c37F1f8b91A0D#readContract </br>
- Treasury(Owner): https://gnosisscan.io/address/0xdc541fc451c34f8a4ff5f3e21f8f7af224b912cf#tokentxns </br>

1. Example of Creation of Programmatic Order </br>
https://gnosisscan.io/tx/0x7c551dccbac3fbde4dd82c8a612f0342cefe66ca3035cb5304fe3356b680df73 </br>
2. Examples of Execution of Programmatic Order  </br>
Cow being swapped into USDC and streamed </br>
https://gnosisscan.io/address/0xdc541fc451c34f8a4ff5f3e21f8f7af224b912cf#tokentxns </br>
Curve being swapped into USDC and streamed </br>
https://gnosisscan.io/tx/0x13582ff822cd62065ee7305b76b5c8f3dd1999f8a298b9f3d19843daaec19d5e </br>

## Uniroll dApp

URL: [https://uniroll-ui.vercel.app/](https://uniroll-ui.vercel.app/)

![photo_2023-11-19 01 37 39](https://github.com/abhishekvispute/uniroll-contracts/assets/3159964/11fc70a6-2101-4006-83ff-fab09c1c87ea)

![photo_2023-11-19 01 37 40 (1)](https://github.com/abhishekvispute/uniroll-contracts/assets/3159964/a3cbd917-71f7-496b-add7-2dfb7beca493)

![photo_2023-11-19 01 37 34](https://github.com/abhishekvispute/uniroll-contracts/assets/3159964/1bcc1529-1a79-4b81-8c1d-4004fba677d2)

![photo_2023-11-19 01 37 42](https://github.com/abhishekvispute/uniroll-contracts/assets/3159964/8eeaadd6-20e2-4f9b-8771-bf33f1d3997f)

