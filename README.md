# PAT ERC20 Compatible Token

Abstract: The Pangea Software is a Decentralized Opt-In Jurisdiction where Citizens can conduct peer-to-peer arbitration and create their own Nations. Pangea uses the Panthalassa mesh, which is built using Secure Scuttlebutt (SSB) and Interplanetary File System (IPFS) protocols. This enables Pangea to be highly resilient and secure, conferring resistance to emergent threats such as high-performance quantum cryptography. Pangea is blockchain agnostic, but uses the Ethereum blockchain for the time being. In the future, other chains such as Bitcoin, EOS, Tezos, Tangle and Bitlattice can be integrated with Pangea. 

The Pangea Arbitration Token (PAT) is an ERC20 compatible in-app token for the Pangea Jurisdiction. The PAT token is proof-of-reputation for Citizens, issued when Citizens create a contract, successfully complete a contract or resolve a dispute attached to a contract. PAT is an algorithmic reputation token; an arbitration currency based on performance, rather than  purchasing power, popularity, or attention. 

The distribution mechanism for the PAT token is an autonomous agent, Lucy, which will initially launch on Ethereum as a smart contract. This mechanism will be blockchain agnostic and can be ported to any viable smart contract platform. An oracle chosen by Bitnation will help to facilitate this (semi) autonomous distribution mechanism in a decentralized and secure fashion.

PAT is minted on the BITNATION DBVN Contract. The distribution mechanism for the PAT token on Pangea is an autonomous agent, Lucy, which will initially launch on Ethereum as a smart contract. This mechanism will be blockchain agnostic and can be ported to any viable smart contract platform. An oracle chosen by Bitnation will help to facilitate this (semi) autonomous distribution mechanism in a decentralized and secure fashion.

# Building

 -  Please install truffle: `npm install -g truffle`.
 -  Go to `contracts`.
 -  Run `truffle compile`, that's it you built the contracts.

# Deploying

 -  Edit `contracts/truffle.js` to configure truffle.
 -  Run your ethereum node.
 -  Run `truffle migrate`.
