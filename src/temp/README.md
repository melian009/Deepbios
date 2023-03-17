## This code is a working draft combining the diploid version of an exact hypergeometric model
# from Shpak and Kondrashov (1999) and the EvoDynamics.jl package 

## AIM
# Minimalist model: Evolving genetic-trait architecture during exploitation in a predator-prey interaction
        # Maturation age evolving but not responding to exploitation and without predator-prey feedback (no predator-prey reversal): example of NA DAG 
        # Maturation age evolving but not responding to exploitation and with predator-prey feedback (predator-prey reversal): example of NA NDCG 
        # Maturation age evolving responding to exploitation and without predator-prey feedback (no predator-prey reversal): example of A DAG 
        # Maturation age evolving responding to exploitation with predator-prey feedback (predator-prey reversal): example of A NDCG

## PSEUDOCODE
# step1.jl: init: can be a large number of species
# step2.jl: Set up a probability matrix of an offspring having a phenotype x when the parents have the phenotypes v and w resp (generalize)
# step3.jl: define competition kernel : Extend with EvoDynamics.jl to other interaction types
# step4.jl: simulate the dynamics;Initialize phenotypic frequencies;All phenotypes are uniformly distributed
# step5.jl: csv outputs


Comp_EcoEvo.ipynb and CompEco-evoParallel.ipynb are working drafts from Comp_Coevol repo (Umarani, M.)
