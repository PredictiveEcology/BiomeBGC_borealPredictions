# Get climate data for boreal forest ecodistricts and calculate bioclimatic indices

# Define the path to the climate data
# This is the folder containing all the .mtc43 files that were created when running the simulations
# If running the simulations, the folder should named 'metdata' within the input path of the sim 
metDataPath <- "~/metdata/" # ***TO CHANGE TO THE CORRECT PATH***

# load packages and functions
source("scripts/fcnt4analysis.R")
library(reproducible)
library(sf)
library(data.table)

# ecodistricts in the boreal forest
eco_boreal <- getEcoBoreal()

# Create a data frame with all combinations of ecodistricts, CO2 scenarios, and climate models
ecodistricts <- unique(eco_boreal$ECODISTRIC)
co2scenarios <- c("RCP45", "RCP85")
climModel <- c("RCM4", "GCM4", "Hadley")

run_df <- expand.grid(
  ecodistrict = ecodistricts,
  co2scenario = co2scenarios,
  climModel = climModel
)
run_df <- setorder(run_df, ecodistrict, co2scenario)

# Set up an empty data table to store the results
out <- data.table(
  year = c(),
  model = c(),
  scenario = c(),
  ivpd = c(),
  itmin = c(),
  iphoto = c()
)

# Loop through each combination of ecodistrict, CO2 scenario, and climate model and process the climate data
for (i in 1:nrow(run_df)) {
  imodel <- run_df$climModel[i]
  iscenario <- run_df$co2scenario[i]
  iecodistrict <- run_df$ecodistrict[i]
  
  metDataFile <- file.path(
    metDataPath,
    tolower(
      paste0(iecodistrict, "_", imodel, iscenario, "_", "19812100.mtc43")
    )
  )
  if (file.exists(metDataFile)) {
    metData <- try(metRead(metDataFile) |> as.data.table(), silent = TRUE)
    if (inherits(metData, "data.table")) {
      metData <- metData[year %in% c(1991:2020, 2071:2100)]
      
      # calculate bioclimatic index
      metData$ivpd <- iVPD(metData$vpd)
      metData$itmin <- iTmin(metData$tmin)
      metData$iphoto <- iPhoto(metData$daylen / 3600)
      
      metData <- metData[,
                         .(
                           tmin = mean(tmin),
                           vpd = mean(vpd),
                           prcp = sum(prcp),
                           ivpd = sum(ivpd),
                           itmin = sum(itmin),
                           iphoto = sum(iphoto)
                         ),
                         by = .(year)
      ]
      
      out <- rbind(
        out,
        data.table(
          ecodistrict = iecodistrict,
          year = metData$year,
          model = imodel,
          scenario = iscenario,
          tmin = metData$tmin,
          vpd = metData$vpd,
          prcp = metData$prcp,
          ivpd = metData$ivpd,
          itmin = metData$itmin,
          iphoto = metData$iphoto
        )
      )
    }
  }
}

# create a new folder data/processed if it doesn't exist
if (!dir.exists("data/processed")) {
  dir.create("data/processed", recursive = TRUE)
}
fwrite(out, "data/processed/climate_bioclimatic_indices.csv")
