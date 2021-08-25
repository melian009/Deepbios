using EvoDynamics
using Pkg
Pkg.activate(".")
using Statistics
using Agents
using DataFrames
using CSV
include("collection_functions.jl")
include("init.jl")

param_file = "initialization.yml"
if !isfile(param_file)
  data = create_dicts()
  EvoDynamics.YAML.write_file(param_file, data)
end

_, results, model = EvoDynamics.runmodel(param_file, adata=nothing, mdata=[count_per_site, age_per_site, migration_rates_per_site, abiotic_value_per_site], when = [1, 99, 100])

# reshape the output
base_names=["age_per_site", "migration_rates_per_site", "abiotic_value_per_site"]
similar_columns = vcat([:step], Symbol.(base_names))

df = add_columns(model, results[:, similar_columns], base_names=base_names, summary_functions=["mean", "std", "median"])
df_count_only = add_columns(model, results[:, [:step, :count_per_site]], base_names=["count_per_site"], summary_functions=["identity"])