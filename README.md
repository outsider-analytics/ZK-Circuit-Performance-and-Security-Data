# ZK-Circuit-Performance-and-Security-Data
### Goal: To collect data on the performance and security characteristics of ZK circuits being verified on the Ethereum Blockchain and expose this data to users in a usable way.

## The Project:
This project is backed by a grant from the Ethereum Foundation Privacy Scaling Exploration.  The full details can be found here https://medium.com/@outsideranalytics/fantastic-zero-knowledge-proofs-ef4bb746f838.

## Files: 
1. ZK_Learning_Resources.md: A curated list of zk learning resources
2. queries: SQL queries performed on google big query crypto_ethereum public database
3. Data_Tables: Results of the queries and manual data entry completed
4. Google Docs version of data tables https://docs.google.com/spreadsheets/d/1Boo9zmsRDc1nDLUQIp8JyInPddF5F2aXM_1zkKGAG1g/edit#gid=1946907765

## Some Research Notes:
- Research Notes
    - Aztec
        - Primitives (including hashes): https://github.com/AztecProtocol/aztec-connect/blob/63e060f3235c57584aaf75375c835d92cdfa1d11/specs/aztec-connect/src/primitives.md
        - Trusted Setup: https://medium.com/aztec-protocol/aztec-crs-the-biggest-mpc-setup-in-history-has-successfully-finished-74c6909cd0c4
    - zkSync
        - Primitives: https://github.com/matter-labs/zksync/blob/master/docs/protocol.md#rescue-hash
        - Trusted Setup: https://docs.zksync.io/userdocs/security/#primitives
    - Element Finance
        - Primitives: https://github.com/element-fi/zkp-merkle-airdrop-contracts
        - Trusted Setup: https://blog.hermez.io/hermez-cryptographic-setup/
    - Starkex
        - Primitives: https://docs.starkware.co/starkex/fact-registry.html
        - On Chain Data: https://docs.starknet.io/docs/Data%20Availabilty/on-chain-data
        - Contracts: https://docs.starkware.co/starkex/deployments-addresses.html
    - Loopring
        - primitives:
            - https://github.com/Loopring/protocols/blob/5644b2386d0ce2310ce4d8fd1f060b1289a08ebd/packages/loopring_v3/circuit/statements.md
            - https://github.com/Loopring/protocols/blob/81a403ba478f0476f4de2ac7cbfeac2297ad01ab/packages/loopring_v3/BACKEND.md
        - Trusted Setup: https://github.com/Loopring/trusted_setup/blob/2b30037a3a98e51f7dc8cccd2fa363a7e2094fe7/README.md
            - https://github.com/Loopring/trusted_setup/tree/master/attestations (participants)
            - https://loopring.org/#/post/loopring-bi-weekly-update-12-01-2019
        - Technical Details: https://medium.loopring.io/zksnark-prover-optimizations-3e9a3e5578c0
    - Hermez
        - https://polygon.technology/solutions/polygon-hermez/
        - Primitives https://docs.hermez.io/Hermez_1.0/about/security/#multi-party-computation-for-the-trusted-setup
        - Trusted Setup
            - Withdraw circuit: https://github.com/hermeznetwork/phase2ceremony_4
    - Perpetual Powers of Tau
        - https://github.com/weijiekoh/perpetualpowersoftau
        - 71 participants for the phase 1 :)
    - Tornado Cash
        - Trusted Setup: https://tornado-cash.medium.com/the-biggest-trusted-setup-ceremony-in-the-world-3c6ab9c8fffa
