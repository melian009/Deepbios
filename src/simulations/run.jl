using EvoDynamics
using Pkg
Pkg.activate(".")
using Statistics
using Agents
include("collection_functions.jl")

param_file = "initialization.yml"

_, results = EvoDynamics.runmodel(param_file, adata=nothing, mdata=[count_per_site, age_per_site, migration_rates_per_site, abiotic_value_per_site], when=[1, 99, 100])
