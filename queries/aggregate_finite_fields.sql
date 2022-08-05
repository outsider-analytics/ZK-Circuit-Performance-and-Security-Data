-- This code is intended to find all contracts on Ethereum main chain which are using
-- zk Snarks and collect all of their transactions. The bytecode of the contracts deployed 
-- is in a public use table on Google Big Query, (`bigquery-public-data.crypto_ethereum.contracts`), 
-- allowing for reasonably cheap and very efficient SQL searching through it.  Constants in contract
-- data are hexed and put into the bytecode, which allow a simple LIKE query to find them,
-- provided they are unique. Luckily, the finite field natively supported on Ethereum is a massive and 
-- unique number 21888242871839275222246405745257275088548364400416034343698204186575808495617.

WITH contracts AS (
  SELECT
    address,
    block_timestamp,
    block_number,
    bytecode as runtime_bytecode
  FROM `bigquery-public-data.crypto_ethereum.contracts`
  WHERE bytecode LIKE '%30644e72e131a029b85045b68181585d2833e84879b9709143e1f593f0000001%'
  OR bytecode LIKE '%x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47%'  -- The prime q in the base field also used in many contracts
  ),

--This joins data from the contract creation transaction and the contracts grabbed above
creation AS (
  SELECT
    c.address as contract_address,
    c.block_timestamp, 
    receipt_gas_used as contract_creation_cost,  
    t.hash as creation_hash,
    t.from_address as deployed_by,
    LEFT(t.input,10) as deployment_method,
    c.runtime_bytecode,
    input as creation_input_bytecode
  FROM contracts c
  LEFT JOIN `bigquery-public-data.crypto_ethereum.transactions` t
    on t.receipt_contract_address = c.address
  ),

-- This query joins data from all transactions into the contract address.
-- Later I realized that I am missing internal txs (traces) and put that
-- into a different search type (driven by methods)
all_txs AS (  
  SELECT
      c.contract_address,
      c.block_timestamp,
      t.hash as transaction_hash,
      LEFT(t.input,10) as tx_method,
      c.contract_creation_cost,
      c.creation_hash,
      t.hash as transaction_hash,
      c.deployment_method,
      c.deployed_by,
      t.receipt_gas_used as transaction_gas_cost,
      COUNT(from_address) OVER (PARTITION BY contract_address) as num_transactions,
      c.runtime_bytecode,
      c.creation_input_bytecode
  FROM creation c
  LEFT JOIN `bigquery-public-data.crypto_ethereum.transactions` t
      on t.to_address = c.contract_address
    )

-- group the txns by contract_address
SELECT 
  contract_address,
  MIN(block_timestamp) AS creation_time_stamp,
  MAX(creation_hash) AS creation_hash,
  MAX(deployed_by) AS deployed_by,
  MAX(num_transactions) AS num_transactions,
  MAX(runtime_bytecode) AS runtime_bytecode,
  MAX(creation_input_bytecode) AS creation_input_bytecode
FROM all_txs
GROUP BY contract_address 
ORDER BY creation_time_stamp