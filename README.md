# Deepbios
Evolving computational sustainability in changing exploited ecosystems

### Workflow (open, decentralized, reproducible)
![plot](Workflow.jpeg)

### Link to the data
(Sustainability of the Oceans)
https://drive.switch.ch/index.php/s/XtYYz37O3pqs8s1

(Fishing data)
https://globalfishingwatch.org/data-download/
https://globalfishingwatch.org/data-download/datasets/public-fishing-effort


### GOAL
Implementation of eco-evolutionary diversification-inspired solutions to perform computational sustainability causal infernce and discovery based on rapidly diversifying traits and interactions. The exploitation of emerging interactions, strategies and traits will allow us to create novel discovery solutions for natural ecosystems facing sustainability challenges like overexploitation of the ocean, where harvesting renewable resources are beyond the diminishing returns for many species and ecosystem resources.

### Main question
How does diversification in technology and traits discover novel paths for resource sustainability in species-rich ecosystems?
![plot](Questions.jpeg) 


METHODS
1. Standarize data to account for units, missing data and sampling bias
2. Bayesian probabilitic causal graph (BPCG) accounting for 
sampling heterogeneity and bias. 

For example, technology in the form of gears in fishing can be represented as a node and new technologies improving catchability or other fishing properties can be modeled as diversifying to explore novel paths (See cartoon in Main question) 

3. Write down the full BPCG as conditional probability tables from each node (i.e., drawn given the parent node and the data) from which we can estimate differential strength between each gear and each fish species. Data comes from the data to fill out the BPCG to explore the total sampling heterogeneity and bias. 

4. BPCG for species as nodes along geographical gradients (i.e., countries). Species interactions list connecting parents for each country

5. KINN (Knowledge Informed Neural Network

Run Evodynamics.jl with bottom up migration and mutation (diversification) rates 

WORKING PAPER 
https://www.overleaf.com/project/5f772ed0806c630001fffc3a



### WORK IN PROGRESS
Two and three species cases

First example: three species of gadidos, which must have a strong interaction

Gadus morhua (Atlantic Cod) AphiaID: 126436
Merlangus merlangius (Whiting) AphiaID: 126438
Melanogrammus aeglefinus (Haddock) AphiaID: 126437

Maps


Second example
PacoB, [10.05.21 12:23]
Second example (case study): a species of gadido and a flat fish, which have different catchability according to the different fishing gear used by the different countries

PacoB, [10.05.21 12:23]
Melanogrammus aeglefinus (Haddock) AphiaID: 126437

PacoB, [10.05.21 12:24]
Lepidorhombus whiffiagonis (Megrim) AphiaID: 127146



Third example: two cogeneric species of flatfish

PacoB, [10.05.21 12:27]
Lepidorhombus whiffiagonis (Megrim) AphiaID: 127146

PacoB, [10.05.21 12:28]
Lepidorhombus boscii (Four-Spotted  Megrim) AphiaID: 127145


Fourth example: two cogeneric species of monkfish

PacoB, [10.05.21 12:30]
Lophius piscatorius (Anglerfish / Monk) AphiaID: 126555

PacoB, [10.05.21 12:30]
Lophius budegassa (Black-bellied Anglerfish) AphiaID: 126554

PacoB, [10.05.21 12:31]
[ File : MON_XL_NS.png ]

PacoB, [10.05.21 12:31]
[ File : WAF_XL_NS.png ]



Fifth example: two species with a wide range of distribution, which probably have interaction

PacoB, [10.05.21 12:34]
Merluccius merluccius (European hake)AphiaID: 126484

PacoB, [10.05.21 12:36]
Micromesistius poutassou (Blue whiting) AphiaID: 126439
