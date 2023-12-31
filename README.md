# Uniroll Contracts
### For Client : [UniRoll UI](https://github.com/karooolis/uniroll-ui) 

![fd906b7c-7ef0-4477-aa30-2629fff52668](https://github.com/abhishekvispute/uniroll-contracts/assets/3159964/f7acb9ef-f2c3-47bc-b9c2-ba63f30dc89a)

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

## Uniroll UI

**URL:** [https://uniroll-ui.vercel.app/](https://uniroll-ui.vercel.app/)

![uniroll_1](https://github.com/abhishekvispute/uniroll-contracts/assets/3159964/1a44c173-7e58-49de-abb0-e5845d75900a)
![uniroll_2](https://github.com/abhishekvispute/uniroll-contracts/assets/3159964/8367731e-ab6c-48cf-8fd5-833b2e056759)
![uniroll_3](https://github.com/abhishekvispute/uniroll-contracts/assets/3159964/38050bd0-912b-4551-a10b-9d5abe19a6ae)
![uniroll_4](https://github.com/abhishekvispute/uniroll-contracts/assets/3159964/bebf921d-5189-4e59-8ba7-53c2bcf622d8)

