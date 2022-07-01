# Metric Ranking:

#### The goal of this sheet is to build a list of potential metrics/data points for ZK circuits in Ethereum with written pros and cons of including in data capture.

#### It's important to note that all data that can be collected without major trade off will be collected.  

---

### Metric: Type of Snark/Stark
#### Example: Groth 16, Plonk, Stark 
#### Benefits:
* Data into the type of circuit construction will give lots of information into the security and performance characteristics
* Many additional data points can be inferred by this data point: i.e. Quantum computing vulnerability
#### Challenges:
* Not sure how to capture through chain data, though manually it is relatively easy
* Certain constructions can be difficult to distinguish from each other
* While research is making large strides in different types of proofs, there aren't a lot of different types in production
#### How to capture:

---
### Metric: Hash Structures Used
#### Example: Pedersen, MiMC
#### Benefits:
* Will be meaningful for security of the hashing used as hashes are broken
* Gas performance and speed will likely be impacted by this
* The layers and structures in merkle trees will also be informative
#### Challenges:
* Not sure how to capture through chain data, though manually it is relatively easy to determine thru code.  May be able to do it thru libraries called in bytecode
#### How to capture:
---
### Metric: Library/Compiler Used
#### Example: ZoKrates, Circom
#### Benefits:
* Help builders understand what tools other projects are using
* If security exploits are shown from a particular compiler, users can become aware of their exposure  
#### Challenges:
* Not sure how to capture through chain data, though manually it is relatively easy to determine thru code.  May be able to do it thru libraries called in bytecode
#### How to capture:
---
### Metric: Elliptic Curve Used
#### Example: bn-128
#### Benefits:
* It's an important cryptographic primitive that underlies everything
#### Challenges:
* After EIP 196 this is pretty standardized, and may not have as much use
#### How to capture:
---
### Metric: Roll Up (L2)
#### Example: Starknet, zkSync
#### Benefits:
* As scalability continues to come into focus, many users' primary concern for zk proofs is rollups
* With large marketing budgets, objectivity could be important to users
#### Challenges:
* Some of the code is private (Starkware)
#### How to capture:
---
### Metric: Rollup TPS and Transation Gas Costs
#### Example: 10 tps, 5mm gwei
#### Benefits:
* Very in demand stats for rollups
* Likely will be interesting to compare performance metrics vs. different zk constructions
#### Challenges:
* May need to be done over time, which would present a unique presentation challenge
#### How to capture:
---
### Metric: Protocol/Company Associated With 
#### Example: Tornado.cash, AZTEC
#### Benefits:
* Gives name recognition to the system
* Likely will be interesting to compare performance metrics vs. different zk constructions
#### Challenges:
* It is hard to determine the owner of contracts, especially with forked code
#### How to capture:
---
### Metric: Number of Constraints in Proof
#### Example: 
#### Benefits:
* Gives an idea of the efficiency of the proof
#### Challenges:
* Proofs may not be public
* 
#### How to capture:
---
### Metric: Gas Cost Per Transaction
#### Example: 5mm gwei
#### Benefits: 
* One of the primary performance data points for users
* Should be relatively easy to track
#### Challenges:
* Differentiating the method calls to ensure gas tracking is done for the proper functions 
#### How to capture:
---
### Metric: Narrative for primary purpose of the zk circuits
#### Example: Tornado.Cash is a mixer which allows users to deposit into a contract and withdraw from a different contract without connecting the two accounts. 
#### Benefits: 
* Can help users understand what the purpose of the circuit is
#### Challenges:
* This is objectively subjective 
* Many contracts do not have great documentation
#### How to capture:
---
### Metric: Number of Trusted Setup Participants
#### Example: 1114 Participants
#### Benefits: 
* One of the primary security data points
* Should have real differences between circuits
#### Challenges:
* Not sure how to collect the data on chain
* There are more data points than just number of participants, i.e. browser based, and timing that should probably be included
#### How to capture:
---
### Metric: L2 Contracts Data
#### Benefits: 
* Many projects are deployed to L2s vs L1s which should accelerate over time
* Should have real differences between circuits
#### Challenges:
* Need to get access to chain data on L2s
* Need to likely run a node for all L2s to accurately capture data
#### How to capture:
