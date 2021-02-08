using DataFrames
using CSV
using Query
using JDF

"""
Data Filtering DATRAS database.

Returns a DataFrame that is the merge of haul and lengths. Taxa is already incorporated into
the length file.

Ali 29 January 2021

# Inputs

* HHd.csv: haul data
* HLd.csv: lenght-based data
"""
function merge_haul_length(haul_file= "HLd_first10000.csv", length_file="HLd.csv", lengths_file_small = "HLd_first10000.csv")
  classes = ["Myxini", "Petromyzonti", "Elasmobranchii", "Holocephali", "Actinopterygii"]
  surveys = ["BITS", "NS-IBTS", "SP-PORC", "SCOWCGFS", "ROCKALL", "SCOROC", "DWS", "IE-IGFS", "IE-IAMS", "NIGFS", "SP-NORTH", "FR-CGFS", "EVHOE", "SP-ARSA", "PT-IBTS", "SNS"]
  ranks = ["Species", "Subspecies"]
  common_names = ["Survey", "Year", "Quarter", "Country", "Gear", "HaulNo"]
  haul = CSV.read(haul_file, DataFrame);
  lengths_small = CSV.read(lengths_file_small, DataFrame);
  
  lengths_small = lengths_small[union(findall(x-> in(x, ranks), lengths_small.Rank), findall(x-> in(x, classes), lengths_small.Class), findall(x-> in(x, surveys), lengths_small.Survey)), :];
  
  ## Get the common set between Hld and HHd
  merged = @from i in lengths_small begin
    @let it = join([i.Survey, i.Year, i.Quarter, i.Country, i.Gear, i.HaulNo], ",")
      @join j in haul on it equals join([j.Survey, j.Year, j.Quarter, j.Country, j.Gear, j.HaulNo], ",")
      @select {i.Survey, i.Year, i.Quarter, i.Country, i.Gear,
      i.HaulNo, i.Ship, i.GearExp, j.DoorType, i.SpecCodeType,
      i.SpecCode, i.SpecVal, i.Sex, i.TotalNo, i.CatIdentifier, i.NoMeas, i.SubFactor, i.SubWgt,
      i.CatCatchWgt, i.LngtClass, i.LngtCode, i.HLNoAtLngt, i.DateofCalculation, i.Valid_Aphia,
      i.AphiaID, i.Scientificname, i.Status, i.Rank, i.Valid_name, i.Genus, i.Family, i.Order,
      i.Class, i.Phylum,
      j.Month, j.Day, j.Date, j.TimeShot, j.HaulDur, j.ShootLat, j.ShootLong}
      @collect DataFrame                               
  end
  
  return merged
end

# merged_data = merge_haul_length()

# merged data is in DB.csv
db = CSV.read("DB.csv", DataFrame)

# describe(db)
db = db[!, 8:end]

excluded_vars = [:Status, :SweepLngt, :GearExp, :DoorType, :StNo, :HaulNo, :SpecCode,   :SpecCodeType, :SpecVal, :CatIdentifier, :TotalNo, :NoMeas, :SubFactor, :SubWgt, :CatCatchWgt, :LngtCode, :HLNoAtLngt, :DateofCalculation, :Valid_Aphia, :Valid_name, :Rank, :Phylum, :ID, :TimeShot, :HaulVal, :StdSpecRecCode, :BycSpecRecCode, :DataType, :DateTime, :Sex, :AphiaID, :Date]

remained_vars = [i for i in names(db) if !in(Symbol(i), excluded_vars)]

db_final = db[!, remained_vars]
des = describe(db_final)

# remove rows with NA.

# for col in 1:size(db_final, 2)
#   if !isnothing(findfirst(x-> x == "NA", db_final[:, col]))
#     println(col)
#   end
# end
# # 7, 19
# names(db_final)[[7,19]]  # "LngtClass", "Depth"
# count(x-> x=="NA", db_final.Depth) # 13105
# count(x-> x=="NA", db_final.LngtClass) # 18928

j = findall(x-> x=="NA", db_final.Depth);
j2 = findall(x-> x=="NA", db_final.LngtClass);
j3 = union(j, j2);
newrows = setdiff(1:size(db_final, 1), j3)

db_final = db_final[newrows, :]

# remove rows with HaulDur == 0
db_final = db_final[db_final.HaulDur .!= 0, :]

# Convert LngtClass and Depth to integers
db_final[!, :LngtClass2] = parse.(Int, db_final.LngtClass)
newnames = names(db_final)
splice!(newnames, findfirst(x -> x=="LngtClass", newnames))
db_final = db_final[!, newnames]
rename!(db_final, :LngtClass2 => :LngtClass)

db_final[!, :Depth2] = parse.(Int, db_final.Depth)
newnames = names(db_final)
splice!(newnames, findfirst(x -> x=="Depth", newnames))
db_final = db_final[!, newnames]
rename!(db_final, :Depth2 => :Depth)

# remove Infs from CPUE_number_per_hour
keeprows = findall(x-> x != Inf, db_final.CPUE_number_per_hour)
db_final = db_final[keeprows, :]

# Save with JDF for compressed saving and fast loading
JDF.save("DB_cleaned.jdf", db_final)

## TODO: Descretize the data
# 1. bin continuous variables into groups