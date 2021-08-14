# data collection: mean, median and std age, and mean median and std of migration rates, mean median and std of the phenotype, per site per species at all generations.

mymean(a) = isempty(a) ? 0.0 : mean(a)
mymedian(a) = isempty(a) ? 0.0 : median(a)
mystd(a) = isempty(a) ? 0.0 : std(a)

function count_per_site(model::ABM)
  spacesize = size(model.space)
  output = Array{Int, 2}(undef, model.nspecies, prod(spacesize))
  for site in 1:prod(spacesize)
    for sp in 1:model.nspecies
      output[sp, site] = count(x-> model[x].species == sp, model.space.s[site])
    end
  end
  return output
end

function age_per_site(model::ABM)
  functions = [mymean, mystd, mymedian]
  spacesize = size(model.space)
  output = Array{Float64, 3}(undef, model.nspecies, prod(spacesize), 3)
  for funcind in 1:3
    func = functions[funcind]
    for site in 1:prod(spacesize)
      for sp in 1:model.nspecies
        output[sp, site, funcind] = func([model[x].age for x in filter(x-> model[x].species == sp, model.space.s[site])])
      end
    end
  end
  return output
end

function migration_rates_per_site(model::ABM)
  functions = [mymean, mystd, mymedian]
  spacesize = size(model.space)
  output = Array{Float64, 3}(undef, model.nspecies, prod(spacesize), 3)
  for funcind in 1:3
    func = functions[funcind]
    for site in 1:prod(spacesize)
      for sp in 1:model.nspecies
        output[sp, site, funcind] = func([EvoDynamics.get_migration_trait(model[x], model) for x in filter(x-> model[x].species == sp, model.space.s[site])])
      end
    end
  end
  return output
end


function abiotic_value_per_site(model::ABM)
  functions = [mymean, mystd, mymedian]
  spacesize = size(model.space)
  output = Array{Float64, 3}(undef, model.nspecies, prod(spacesize), 3)
  for funcind in 1:3
    func = functions[funcind]
    for site in 1:prod(spacesize)
      for sp in 1:model.nspecies
        output[sp, site, funcind] = func([sum(EvoDynamics.get_abiotic_phenotype(model[x], model)) for x in filter(x-> model[x].species == sp, model.space.s[site])])
      end
    end
  end
  return output
end
