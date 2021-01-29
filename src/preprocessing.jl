using DataFrames
using CSV
using Query

"""
Data Filtering DATRAS database.

Returns a DataFrame that is the merge of haul and lengths. Taxa is already incorporated into
the length file.

Ali 29 January 2021

# Inputs

* HHd.csv: haul data
* HLd.csv: lenght-based data
"""
function merge_haul_length(haul_file= "HLd_first10000.csv", length_file="HLd.csv")
  classes = ["Myxini", "Petromyzonti", "Elasmobranchii", "Holocephali", "Actinopterygii"]
  surveys = ["BITS", "NS-IBTS", "SP-PORC", "SCOWCGFS", "ROCKALL", "SCOROC", "DWS", "IE-IGFS", "IE-IAMS", "NIGFS", "SP-NORTH", "FR-CGFS", "EVHOE", "SP-ARSA", "PT-IBTS", "SNS"]
  ranks = ["Species", "Subspecies"]
  common_names = ["Survey", "Year", "Quarter", "Country", "Gear", "HaulNo"]
  # taxa_file = "HL_taxa.csv"
  haul_file = "HHd.csv"
  lengths_file = "HLd.csv"
  lengths_file_small = "HLd_first10000.csv"
  
  # taxa = CSV.read(taxa_file, DataFrame);
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
  
  