# ZK-Circuit-Performance-and-Security-Data
Goal: To collect data on the performance and security characteristics of ZK circuits being verified on the Ethereum Blockchain and expose this data to users in a usable way.

## Background
For all of the benefits of smart contract based blockchains, they fundamentally suffer from two major limitations: Scalability and Privacy.  The TPS of Ethereum is currently 6 TPS https://ethtps.info/, and an astute data scientist can utilize the public chain data to see all transactions within the network. As Ethereum works to cross the chasm to mainstream adoption, zero knowledge proofs have emerged as a potential solution for both issues. For scalability, zk proofs are able to shrink the size of the data on chain by batching transactions and only posting a proof of what state change occured (rollups) or the merkle root of the new state (validiums).  Since the proof of the transaction's validity is generated off chain and verified as correct via a smart contract, the size of the data is dramatically reduced.  On the privacy level, inputs to the zk proof can be kept secret while still guaranteeing that they are valid.  With the complexity of these proofs, it is important to understand what trade offs are being made for the different types, hense this project.  Please see https://ethereum.org/en/developers/docs/scaling/zk-rollups/ and https://ethereum.org/en/developers/docs/scaling/validium/ for really good explainations for scaling using zk proofs.
## **Methodology**
### What data to collect?
What data to collect for zk proving systems is a nuanced question.  While proofs themselves are providing the functionality, the important characteristics of the proof come from the circuit used to generate it.  For instance, there have been over 400 calls to verify proofs for zkSync v1 (0x1f9bb4f4d3163919c2cd0dca256b9dc8614caf97), but these proofs come from the same off chain circuit.  
The issue with gathering data on circuits directly is that they are not posted on-chain, and they are often not public.  Since this project is aimed at the use of zk tech on Ethereum, these verification contracts are a good unique value with which to describe the circuits behind them.
To take categorization to the next level, circuits will be identified with the project behind them whenever possible, as oftentimes the deployed contracts will be upgraded to a new verifier (which is usually a hard change between which verifier is used.
### How we collected the data
**Tools Used:**  While there are several excellent free sources for on-chain data such as dune analytics, they were not powerful enough to use as a starting point.  Therefore, Google Big Query's public crypto_ethereum db was used as the main source of data.  This database includes 3 tables that were used to sql query through on chain ethereum data: Transactions, Traces, and Contracts.  
**Searching with FF Constants:** The first way we searched through the data was to check the bytecode of deployed contracts for the finite field constant "21888242871839275222246405745257275088548364400416034343698204186575808495617" from the BN128 alternate curve native to Ethereum. In bytecode, constants are converted to Hex, which allows simple SQL queries to find inclusion. This drummed up about 600 contracts which included the contract; a very good start.  From there, we checked etherscan to see if the contracts were public and what they were. This was a good jumping off point, but it included a bunch of contracts that were either flow through, or not involved in actually using zk proofs.
**Searching with Method IDs:** After observing the flows of traces and transactions, a pattern emerged for the flow of zk proof verifications on chain. This flow is detailed below in "verifiers", but the best way to capture which contracts are actually verifying proofs is through the method ids of the function calls. Method ids are created by taking the first 8 digits of the keccak256 hash of the function being called. (see this great project www.4byte.directory). We then created a table of method ids and corresponding function calls which were used to verify zk proofs.
**Transactions and Traces:** Through observation, it became clear that verification contracts were often not called directly by the transaction, but were instead being captured as traces.  A trace is created for every smart contract function called after the transaction call (which is included in the transaction data). With this in mind we used a simple method id search through traces and transactions to get a table of all proof verifications on chain using those methods.
## The Data
**Grouping the Data:** After the Method Id search, we then grouped the transaction by verification contract and pulled the following data from on chain:
1. Verification Contract
2. First Transaction Date
3. Last Transaction Date
4. Contract Deployed By Address
5. Contract Creation Input
6. Contract Runtime Bytecode
7. Avg Gas Used for Verification
8. Method ID
9. Method Type (Trace or Transaction)
10. Number of Contract Calls

**Off Chain Data:** Unfortunately not all data points can be collected on-chain. Off-chain we go! The first step was to go through each contract on etherscan to see whether it was public and its code. Assuming the code was public, we then used etherscan to look at realted contracts to determine the project it was associated with. Digging into the contracts the documentation, and discord discussions from the different projects yielded a good confidence of knowing the following:
1. Proving System
2. Contract Author (different than owner in forks)
3. Boolean if the Contract is Public
4. Circuit Development Language (i.e. RUST)
5. Circuit Library (i.e. Libsnark)
6. Hash Types Used



## **A Note On Verifiers**
The verification flow on-chain depends greatly on the type of proving system which is employed by the project.  For Groth16 and standard Plonk, the verification is usually a simple function call to a single verifier contract with the proof as an input.  The verifying contract returns 0x000...001 (indicating a valid proof) and the contract can proceed.  For Turbo PLONK and STARK based contracts, the verification flow can get much more complicated and include many contracts.  They often include calls out of the verifying contract for items like vk keys and Pedersen hash points. For these more complicated verification systems, we grouped all of the contracts together as one verification system.
