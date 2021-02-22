library(bnlearn)

df = read.csv("DB_cleaned_discretized.csv")

## change data type to factor because bnlearn needs that
df[, 1:20] <- lapply(df[,1:20], as.factor)

# dim(df)
# data(learning.test)

# Tutorials: https://www.bnlearn.com/examples/

## Get a score of bn (learn.net) given the data (learning.test). Other types: aic, bde, etc. (see `score` help)
# score(learn.net, learning.test, type = "bic")

## Whitelists and blacklists in structure learning
"""
* Arcs in the whitelist are always included in the network.
* Arcs in the blacklist are never included in the network.
* Any arc whitelisted and blacklisted at the same time is assumed to be whitelisted, and is thus removed from the blacklist. In other words, the whitelist has precedence over the blacklist.
"""

wl = read.csv("node_whitelist.csv")
bl = read.csv("node_blacklist.csv")

## Structure learning with PC algorithm. To use other algorithms, `?inter.iamb

bn = pc.stable(df, whitelist=wl, blacklist=bl)