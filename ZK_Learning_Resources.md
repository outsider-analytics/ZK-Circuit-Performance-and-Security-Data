# ZK Learning Resources
### Curated by Outsider Analytics 

###### tags: `Zero Knowledge`

> Disclaimer: This work is being funded by the Ethereum Foundation PSE team. (see additional details at end) 


## :rocket: Where do I start?

### :pray: Fantastic Resource Compilations (I owe a great debt to):
* Technical compilation that stopped being updated in 2019: https://zkp.science/
    * contributer page: https://github.com/ZKProofs/ZKProofs.github.io/graphs/contributors
* Full cryptography course from Tari Labs University I only scratched the surface of: https://tlu.tarilabs.com/cryptography
* Justin Martin's accessible "where do i start" resource list with good context: https://hackmd.io/24W3m1kERC-8BrI0giBRNQ?view
* Tolks' Substack ZK Landscape: https://page1.substack.com/p/the-zero-knowledge-landscape?s=r
* Matter Labs' "Awesome" list: https://github.com/matter-labs/awesome-zero-knowledge-proofs#readme
* AtHeartEngineer's zkTech reddit with little overlap from other sources: https://www.reddit.com/r/zkTech/
* Domenico's notion page, don't miss the ZK Research Link! https://humorous-kick-fcd.notion.site/ZK-cryptography-e3e36f6130d5470cbae3be7003763476 


### :100: ZK Overviews:   
* https://docs.circom.io/background/background
    * An intro to ZK Snark implementation from Circom (who powers protocols like Tornado Cash)
    * Circom is a language which allows for the construction of ZK circuits for use in Ethereum (the witness compiles to Solidity)
    * While this is a bit technical, it's nice to have a more practical overview than Suduko + Where's Waldo
*  Zero Knowledge podcast Episode 21 (zkpe 21): intro to ZK Proofs
*  zkpe 34: Intro to snarks with howard Wu
*  https://z.cash/technology/zksnarks/
    *  Zcash started the applied ZK boom, and this is their ZK SNARK overview
*  https://www.notboring.co/p/zero-knowledge?s=r
    *  Non-technical explanation with lots of background

### :1234: Math Background:
* This will immensely help your understanding of the papers and implementations, but you can always "black box" the math side and just focus on the practical.
* Lagrange interpolation: "[Secret Sharing and Erasure Coding: A Guide for the Aspiring Dropbox Decentralizer](https://blog.ethereum.org/2014/08/16/secret-sharing-erasure-coding-guide-aspiring-dropbox-decentralizer/)" 
    * Basic math operation I found necessary to remember from high school :)
* http://theory.cs.princeton.edu/complexity/book.pdf
    * Complexity theory is one of the fundamental ideas behind ZK tech and introduces a large amount of the notation.
    * Appendix A.1-3, Chapters 1, 2, 4.1-4.2, 6.1-6.4, 6.8, 7.1-7.4 
    * If like me this math is too complex a starting place, you may want to start on the beginning of abstract algebra. I used "A first Course in Abstract Algebra"  by Fraleigh ([pdf](https://edisciplinas.usp.br/pluginfile.php/5409004/mod_resource/content/2/John%20B.%20Fraleigh%2C%20Victor%20J.%20Katz%20-%20A%20first%20course%20in%20abstract%20algebra-Addison-Wesley%20%282003%29%20%281%29.pdf))
    * A couple of good companion videos:
         * Big O Notation: https://www.youtube.com/watch?v=0oDAlMwTrLo
        * P vs NP : https://www.youtube.com/watch?v=YX40hbAHx3s & https://www.youtube.com/watch?v=moPtwq_cVH8
        
### :key: Cryptographic Background:  
*  https://blog.cloudflare.com/a-relatively-easy-to-understand-primer-on-elliptic-curve-cryptography/
    * ZK tech has its foundation in elliptic curve cryptography
    * This blog post does a good job of explaining the why and how elliptic curve cryptography came out of RSA and what it is.
    * Blockchain is not discussed in this post (don't be surprised!)
* https://vitalik.ca/general/2017/01/14/exploring_ecp.html
    * Read this right after the above blog post to take a step for elliptic curve points in the blockchain direction
* https://www.msri.org/summer_schools/931/schedules
    * This gets dense fast, but if you want to understand from a base level the theory behind IPs, PCPs, IOPs it's really good!
    * I highly recommend not starting this until you have a good understanding of the math prereqs specified in the course. (finite fields, abstract algebra, computational complexity)
    * This course is pretty far from practical implementation!  But you will greatly increase your capacity to understand theory and important papers afterward :)
    * zkpe 200: Alessandro Chiesa gives a great pitch for why they built this class
* Vitalik's "An approximate introduction to how zk-SNARKs are possible"
    * Does a great job linking the Material from MSRI summer school to real use with Fiat-Shamir heuristic. Also see in snarks theory https://vitalik.ca/general/2021/01/26/snarks.html
* Justin Thaler (Georgetown)'s course and book
    * Huge amount of knowledge from a technical perspective
    * https://people.cs.georgetown.edu/jthaler/COSC544.html

### :deciduous_tree: General ZK-SNARKs Theory:  
* https://vitalik.ca/general/2021/01/26/snarks.html
    * Big picture paper I recommend reading at a few different points throughout your learning. It really ties things together well when you get into the weeds a bit too much on a specific topic
* https://medium.com/@VitalikButerin/quadratic-arithmetic-programs-from-zero-to-hero-f6d558cea649
    * Not Vitalik's most understandable blog post (IMHO), but the best I have seen on some of the machinery in ZK-SNARKs
    * This is a rare ZK paper you can actually do the math with while following along
* https://medium.com/@VitalikButerin/zk-snarks-under-the-hood-b33151a013f6
    * Confusing for me (TBH), but gets at the root of trusted setups and toxic waste 

### :construction_worker: SNARK Constructions:  
* Pinocchio: Nearly Practical Verifiable Computation (2013)
  * https://eprint.iacr.org/2013/279.pdf
* Groth16 : "On the Size of Pairing-based Non-interactive Arguments"
  * https://eprint.iacr.org/2016/260.pdf
* Bullet Proofs
  * https://eprint.iacr.org/2017/1066.pdf
  * zkpe 40: Benedikt Bunz
* Sonic
  * https://eprint.iacr.org/2019/099
* Plonk
  * https://eprint.iacr.org/2019/953
  * zkpe 112: "Dive into plonk"
  * ["Understanding Plonk" by Vitalik](https://vitalik.ca/general/2019/09/22/plonk.html)
* Marlin
    * https://eprint.iacr.org/2019/1047.pdf
* Super Sonic
  * https://eprint.iacr.org/2019/1229
  * zkpe 105: Alan Szepienies on Hash Functions and Supersonic SNARKs
* Fractal
  * https://eprint.iacr.org/2019/1076
  * zkpe 114: Exploring the Fractal transparent SNARK construction with Dev Ojha
* Halo
  * https://eprint.iacr.org/2019/1021
  * https://electriccoin.co/blog/halo-recursive-proof-composition-without-a-trusted-setup/
  * zkpe 123: Halo with Sean Bowe and Daira Hopwood from ECC
* Halo 2
  * https://electriccoin.co/blog/explaining-halo-2/
  * 
* ZEXE
    * https://eprint.iacr.org/2018/962.pdf
    * zkpe 85: Zexe: Decentralized Private Computation with Pratyush Mishra



### :stars: STARKs:  
* Zero-Knowledge Scalable Transparent ARguments of Knowledge
* Vitalik
    * https://vitalik.ca/general/2017/11/09/starks_part_1.html
    * https://vitalik.ca/general/2017/11/22/starks_part_2.html
    * https://vitalik.ca/general/2018/07/21/starks_part_3.html
* [Scalable, transparent, and post-quantum secure computational integrity](https://eprint.iacr.org/2018/046) 
    * Eli Ben-Sasson, Iddo Bentov, Yinon Horesh, and Michael Riabzev
* Eli Ben-Sasson presenting STARKS https://www.youtube.com/watch?v=HJ9K_o-RRSY
* zkpe 59: STARKs and StarkWare with Eli & Alessandro
* zkpe 96: Eli Ben-Sassson on the latest from StarkWare

    


### :world_map: Real World Uses
* Zcash
    * zkpe 50: Zooko talks Zcash
* Tornado Cash
    * zkpe 111: Mixers with Tornado.cash
    * https://github.com/tornadocash/docs/tree/en/circuits
        * Nice overview for the background of ZK circuits (GROTH16 from Circom)
    *  https://github.com/tornadocash/docs/blob/en/circuits/core-deposit-circuit.md
    *  zkpe 137: Trusted Setup Bonus: Tornado Cash
*  ZKSync (Matter Labs)
    *  zkpe 72: zkSNARKs for Scale w/ Matter labs
    *  zkpe 116: zkSync and Redshift with Alex Glukowski
    *  zkpe 175: zkEVM & zkPorter with Matter Labs
*  Aztec
    *  zkpe 75: Exploring Aztec with Zac Williamson
    *  zkpe 176: ZK-zk-rollup and zk.money with Zac and Joe
*  Trail of Bits
    *  Interesting Audits and security of real world ZKPs
    *  zkpe 122: Audits & Security with Ben Perez
*  Dark Forest
    *  zkpe 141: ZK & Games: Dark Forest with Brian Gu
    *  zkpe 225: Dark Forest and 0xPARC with Gubsheep
*  Polygon Hermez
    *  zkpe 194: zkEVM with Jordi & David
    *  zkpe 219: Scaling Ethereum with Mihailo Bjelic
*  Polygon Miden
    *  zkpe 210: The Road to STARKs and Miden with Bobbin Threadbare
*  Polygon Zero
    *  zkpe 220: The Road to Plonky2 with Brendan and Daniel
 *  ZoKrates
    * Stefan Demi's [Efficient ECC in zkSNARKs using ZoKrates](https://medium.com/zokrates/efficient-ecc-in-zksnarks-using-zokrates-bd9ae37b8186)
        * Good explanation for why BN128 curve is used



### :shrug: Misc Knowledge  
* Pedersen Commitments
    * https://link.springer.com/content/pdf/10.1007%2F3-540-46766-1_9.pdf#page=3
    * https://crypto.stackexchange.com/questions/64437/what-is-a-pedersen-commitment
    * https://youtu.be/qWRUPzm3qPY (first 7 min)
* Kate (Ka-tay) Commitments https://dankradfeist.de/ethereum/2020/06/16/kate-polynomial-commitments.html
* Merkle tires and Patricia Tries
    * zkpe 57: "Merkilze this"
* WASM: WebAssembly 
    * Need to understand what this is and why it is used for witnesses.  Any help appreciated!
* Recursion
    * Scalable Zero Knowledge via Cycles of Elliptic Curves from 2014 https://eprint.iacr.org/2014/595
    * zkpe 54: Digging into recursive zkSNARKs with Coda
    * zkpe 113: Latest recursive SNARKitecture with Izaak Meckler from 0(1) Labs
* Languages/Libraries
    * zkpe 172: ZK languages with Alex Ozdemir
        * Please listen to this first!
    * zkpe 145: Circom & Hermez with Jordi Baylina
    * zkpe 41: Zokrates with Jacob Eberhardt
    * zkpe 126: Crypto libraries: Zcash's Zebra with Henry Valence
    * zkpe 169: Arkworks SNARK libraries with Pratyush Mishra
* MPC
    * zkpe 60: Cryptography 101: Multi-Party Computations
    * zkpe 90: MPC systems with Nigel Smart
* Randomness
    * True randomness is fascinating from an esoteric viewpoint
    * zkpe 74: Randomness and Random Beacons with Justin Drake
* Trusted Setups
    * zkpe 133: Trusted Setup Ceremonies Explored
    * zkpe 137: Trusted Setup Bonus: Tornado Cash
    * zkpe 76: Sean Bowe on SNARKs, Trusted Setups & Elliptic Curve Cryptography
* Verifiable Delay Functions
    * zkpe 103: Exploring VDFs with Joseph Bonneau
* MiMC
    * https://eprint.iacr.org/2016/492.pdf
* Fully Homomorphic Encryption
    * zkpe 124: Exploring FHE with Flavio Bergamaschi from IBM Research
 * baby jubjub (eliptic curves)
   * Zcash: https://z.cash/technology/jubjub/

### :book: History
* zkpe 90: Nigel Smart explains MPC & general history advances from the Cryptography vs. Cryptocurrancy side
* zkpe 100: Great history lesson with Dan Boneh of cryptography (most useful in the beginning and end)
* The OG ZKP paper from the 80s: [The Knowledge and Complexity of Interactive Proof Systems](https://people.csail.mit.edu/silvio/Selected%20Scientific%20Papers/Proof%20Systems/The_Knowledge_Complexity_Of_Interactive_Proof_Systems.pdf)
    * This was very academic/theoretical until about 2004 as per Nigel Smart in ZKPE 90.
    * If you are working through the math of abstract algebra/ complexity theory, this paper will show why it is important.  It is not overly complicated 
* 2007 major advance from Paul Valiant [Incrementally Verifiable Computation](https://dspace.mit.edu/bitstream/handle/1721.1/38663/163581090-MIT.pdf?sequence=2)

---
### :memo: Can I contribute to/correct this page? YES! It is open editable by signed in users. Just put yourself in the credit table below :slightly_smiling_face: 


| Name (ANON) | Social Handles | Section Edited | Date
| -------- | -------- | -------- | ------ |
|Brian Wilkes| OutsiderAnalytics|The Whole Thing| 6/14/22|
|  |  |  |  |

If you would like to give me non-public feedback: Outsideranalytics@gmail.com

---
### :heart: If you appreciate this list and want to see it maintained!
1. Thank the Ethereum Foundation PSE team who made it possible
2. Give to Ethereum Public Works Projects on https://gitcoin.co/ (especially ZK projects)
---
### Disclaimer: 
This work is being funded by the Ethereum Foundation PSE team, and my crypto holdings are limited to Eth and ERC-20/721 tokens in the Ethereum/Polygon ecosystems. While this is due to my belief in the future viability/tokenomics of Ethereum, please note my inherent biases. I recognize and am truly grateful for the advances in ZK tech not associated with Ethereum, and will always strive towards the goal of impartiality!
