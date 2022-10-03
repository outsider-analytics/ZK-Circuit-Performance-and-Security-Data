
-- 1. Collect all transactions and traces which are used
--    verify zk proofs on Ethereum. 
-- 2. Group them by verifier contract address

-- On traces vs tx:
-- Transactions and Traces can both call functions of deployed smart contracts and 
-- deploy new smart contracts.  The diff is that transactions are the intitiaters and
-- traces are functions called by smart contracts which have already been called by 
-- a transaction (or a trace). So essentially it goes tx first which can then call 
-- traces.

-- On tx methods:
-- These method IDs (in hex) are generated by Keccak256 hashing the function call in 
-- the following format (as an example): 
-- verifyBlocks(uint32,uint32,uint256[],uint256[],uint256[],bytes[])
-- the names of the inputs and space around them are discarded.
-- The first 8 characters + 0x are then used as the method ID in the function call.
-- While it is possible that there are either conflicting method IDs, or the same 
-- method ID being used for multiple purposes these were realtively clean.

WITH traces as (
  SELECT 
    *,
    "Plonk_check" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0xb6d5d214"
  UNION ALL
    SELECT 
    *,
    "PLONK(Hermez or zkSync/swap)" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0xa830bd60"
  UNION ALL
  SELECT 
    *,
    "Plonk/Turbo_Plonk" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0xac318c5d"
  UNION ALL
  SELECT 
    *,
    "PLONK_(zkSync/swap)" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0x7756aa8a"
  UNION ALL
  SELECT 
    *,
    "Groth16 ZoKrates" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0x83e93cd6"
  UNION ALL
  SELECT 
    *,
    "Groth16 ZoKrates" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0x5fe8c13b"
  UNION ALL
  SELECT 
    *,
    "Aztec_Early" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0xb5596a88"
  UNION ALL
  SELECT 
    *,
    "Depositor_zkSync" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0x95b5d617"
  UNION ALL
  SELECT 
    *,
    "Loopring Block Verifier (Groth16)" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0x104e4cda"
  UNION ALL
  SELECT 
    *,
    "ZeroPool (Groth16)" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0xcfb7b716"
  UNION ALL
  SELECT 
    *,
    "zkSync (Plonk or Super Plonk)" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0xdc46ea94"
  UNION ALL
  SELECT 
    *,
    "Groth 16 Circom" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0x598da1d1"
  UNION ALL
    SELECT 
    *,
    "Groth 16 Circom" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0x695ef6f9"
  UNION ALL
    SELECT 
    *,
    "WanChain" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0x182f875c"
  UNION ALL
    SELECT 
    *,
    "Loopring Block Verifier" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0xdc77295b"
  UNION ALL
  SELECT 
    *,
    "TreeUpdateVerifier" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0x6bf062b2"
  UNION ALL
  SELECT 
    *,
    "Hermez" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0x43753b4d"
  UNION ALL
    SELECT 
    *,
    "BatchTreeUpdateVerifier" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0x8d8f8a5c"
  UNION ALL
  SELECT 
    *,
    "MembershipVerifier" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0x11479fea"
  UNION ALL
  SELECT 
    *,
    "Verifier" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0xf5c9d69e"
  UNION ALL
  SELECT 
    *,
    "Plonk Private Airdrop" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0x1e8e1e13"
  UNION ALL
  SELECT 
    *,
    "Groth16" as type
  FROM `bigquery-public-data.crypto_ethereum.traces`
  WHERE LEFT(input,10) = "0x695ef6f9"
  

),

txs as (  
  SELECT 
    *,
    "Groth16(LoopRing)" as type
  FROM `bigquery-public-data.crypto_ethereum.transactions`
  WHERE LEFT(input,10) = "0x4be6b36a"
  UNION ALL
  SELECT 
    *,
    "Mixer 0xfa8c5b87f6f7bddea8fe37d9827182d40d290eb0a94971686c89efa3b2fb4f6a" as type
  FROM `bigquery-public-data.crypto_ethereum.transactions`
  WHERE LEFT(input,10) = "0x22a6fef1"
  -- Starkware is a nest of complexity, but I believe the actual verification of the FRIs is completed with the below method call
  UNION ALL
  SELECT 
    *,
    "StarkWare (STARK FRI)" as type
  FROM `bigquery-public-data.crypto_ethereum.transactions`
  WHERE LEFT(input,10) = "0xe85a6a28"
),

-- Here we group the txns and traces by the verifier contract address.
-- We also get the first & last transaction timestamp, the average gas used
-- the method ID, and the method type
combine_tx_traces as (
  SELECT 
    to_address as verifier_contract,
    MIN(t.block_timestamp) as first_tx,
    MAX(t.block_timestamp) as last_tx,
    ROUND(avg(t.gas_used)) as avg_gas_used,
    MAX(LEFT(t.input,10)) as method_ID,
    MAX(type) as snark_type,
    "Internal (trace)" as method_type,
    COUNT(*) AS num_contract_calls,
    MAX(LENGTH(input)) as tx_input_length
  FROM traces t
  GROUP BY to_address
  UNION ALL
  SELECT 
    to_address as verifier_contract,
    MIN(t.block_timestamp) as first_tx,
    MAX(t.block_timestamp) as last_tx,
    ROUND(avg(t.receipt_gas_used)) as avg_gas_used,
    MAX(LEFT(t.input,10)),
    MAX(type),
    "External (transaction)",
    COUNT(*),
    MAX(LENGTH(input)) as tx_input_length
  FROM txs t
  GROUP BY to_address
  ),

-- Left join the data from es_bytecode table into the verifier address table
-- This data was manually pulled from Etherscan Data
add_es as (
  SELECT 
    *
  FROM combine_tx_traces c
  LEFT JOIN `starlit-sandbox-349500.snark_contracts.es_bytecode` b 
  ON b.contract_address = c.verifier_contract
  ),
-- Left join the contract data for each verifier contract
add_contract_data as (
  SELECT
    verifier_contract,
    first_tx,
    last_tx,
    avg_gas_used,
    method_ID,
    snark_type,
    method_type,
    num_contract_calls,
    contract_name,
    contract_author,
    es_tag,
    identity,
    public_es,
    c.block_timestamp as creation_time,
    NULL as transaction_hash_creation,
    NULL as deployed_by_address,
    num_contract_transactions,
    a.contract_abi as contract_ABI,
    c.bytecode as runtime_bytecode,
    tx_input_length,
  FROM add_es a
  LEFT JOIN `bigquery-public-data.crypto_ethereum.contracts` c
  ON c.address = a.verifier_contract
  ),

-- Left Join the first transactions data for each verifing contract
-- Need to group them in order to only have the first tx data (and sort that by lowest tx position)
add_transaction_data as (
  SELECT
    verifier_contract,
    first_tx,
    last_tx,
    avg_gas_used,
    method_ID,
    snark_type,
    method_type,
    num_contract_calls,
    contract_name,
    contract_author,
    es_tag,
    identity,
    public_es,
    creation_time,
    t.transaction_index,
    FIRST_VALUE(t.hash) OVER (PARTITION BY verifier_contract ORDER BY block_number, transaction_index) as transaction_hash_creation,
    FIRST_VALUE(t.from_address) OVER (PARTITION BY verifier_contract ORDER BY block_number, transaction_index) as deployed_by_address,
    a.num_contract_transactions, 
    a.contract_ABI, 
    runtime_bytecode,
    FIRST_VALUE(t.input) OVER (PARTITION BY verifier_contract ORDER BY block_number, transaction_index) as input_bytecode,
    a.tx_input_length
  FROM add_contract_data a
  LEFT JOIN `bigquery-public-data.crypto_ethereum.transactions` t
  ON t.receipt_contract_address = a.verifier_contract
  )

SELECT
    verifier_contract,
    MIN(first_tx) as first_tx,
    MAX(last_tx) as last_tx,
    MAX(avg_gas_used) as avg_gas_used,
    MAX(method_ID) as method_ID,
    MAX(snark_type) as snark_type,
    MAX(method_type) as method_type,
    MAX(num_contract_calls) as num_contract_calls,
    MAX(contract_name) as contract_name,
    MAX(contract_author) as contract_author,
    MAX(es_tag) as es_tag,
    MAX(identity) as identity,
    MAX(public_es) as public_es,
    MAX(creation_time) as creation_time,
    MAX(transaction_hash_creation) as tx_hash_creation,
    MAX(deployed_by_address) as deployed_by_address,
    MAX(num_contract_transactions) as num_contract_transactions, 
    MAX(contract_ABI) as contract_ABI, 
    MAX(runtime_bytecode) as runtime_bytecode,
    MAX(input_bytecode) as input_bytecode,
    MAX(tx_input_length) as tx_input_length
FROM add_transaction_data
GROUP BY verifier_contract
