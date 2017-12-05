# matching_geos matches cities from DCM and Adwords based on names, impression
# counts
# Author Wil Poole
# Version 0.1

# Libraries
library(tools)
library(stringdist)

# data files
data.directory <- 'data'

# Check correct files
file.check <- function(
  # Look in the data
  directory.to.check
) {
  # List files in the directory, and then see what is happening
  file.list  <- list.files(directory.to.check)
  if ("adwords_city_impressions.csv" %in% file.list) {
    data.state <- 1
  } else {
    "Missing adwords data file"
  }
  return(data.state)
}

dcm.report.file.process <- function(
  data.directory,dcm.report.file
) {
  # Read original DCM data
  dcm.city <- read.csv(
    file.path(data.directory,dcm.report.file)
    , header = F, as.is = T
  )
  # Count lines
  n.lines <- dim(dcm.city)[1]
  # Read the data and look for "Report Fields"
  counter <- 1
  for (i in 1:n.lines){
    if ("Report Fields" %in% dcm.city[i,1]){counter <- counter +2; break}
    counter <- counter + 1
  }
  # Read csv again so that the data is in the correct form
  dcm.city <- read.csv(
    file.path(data.directory,dcm.report.file)
    , skip = counter, header = T, as.is = T
  )
}

# Need to first join the cities together

# Load the datasets
# Adwords data
adwords.city <- read.csv(
  file.path(data.directory,"adwords_city_impressions.csv")
)

# DCM data - change this to inclide the main list
dcm.city <- dcm.report.file.process(
  data.directory,"dcm_city_impressions.csv"
)

# Match on name
adwords.city.sorted <- sort(unique(adwords.city$City[adwords.city$Country.Territory == "United Kingdom"]))
dcm.city.sorted <- sort(unique(dcm.city$City))

dl <- stringdistmatrix(adwords.city.sorted,dcm.city.sorted, method = 'dl')
jw <- stringdistmatrix(adwords.city.sorted,dcm.city.sorted, method = 'jw')

dcm.matched.to.adwords.dl <- data.frame(
  dcm.city.sorted,
  apply(dl,2,min),
  apply(dl,2,which.min),
  apply(dl,2,function(x) length(x[x == min(x)]) ),
  adwords.city.sorted[apply(dl,2,which.min)]
)

dcm.matched.to.adwords.dl[apply(dl,2,function(x) length(x[x == min(x)]) )!=1,]


unique(apply(dl,2,function(x) length(x[x == min(x)]) ))


adwords.matched.to.dcm.dl <- data.frame(adwords.city.sorted,dcm.city.sorted[apply(dl,1,which.min)])

dcm.matched.to.adwords.jw <- data.frame(dcm.city.sorted,adwords.city.sorted[apply(jw,2,which.min)])
adwords.matched.to.dcm.jw <- data.frame(adwords.city.sorted,dcm.city.sorted[apply(jw,1,which.min)])

m <- data.frame(dcm.matched.to.adwords.dl,dcm.matched.to.adwords.jw)

write.csv(m, "m.csv")

# City list
list.city <- read.csv(
  file.path(data.directory,"cities.csv")
)

# Postalcode data
postal.code.small <- read.csv(file.path(data.directory,"postalcode_small.csv"))

# Postalcode data
postal.code.large <- read.csv(file.path(data.directory,"postalcode_large.csv"))




# Stage 1 do this on names
# Find 5 best matching city names

# Stage 2 do this by impression count
# Of the five, identify those that are closest together


# Process files





# Output is one row per city, with matching:
# city_ids, names, county, and postcodes
