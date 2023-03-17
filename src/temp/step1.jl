using CSV, DataFrames, Random, LinearAlgebra, Distances, Distributions

#Calculate probabilities of offspring having a genotype "u"
# given that parents' genotypes are "v" and "w".

#Model parameters: Demography
nsp=10  #No. of species
a1=1
a0=1
tmean=rand(Uniform(-1,1),nsp)
tvar=rand(Uniform(0.1,0.25),nsp)
r=abs.(rand(Uniform(0,0.1),nsp))

#Quantitative genetic model parameters
n=5    #No. of loci
geno= collect(range(-1,stop=1,length=2*n+1))
nt=length(geno)


Random.seed!(1234)
