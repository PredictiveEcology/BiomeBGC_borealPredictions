###
###
# This script runs Biome-BGC to validate output against EC tower data
###
###
projectDir <- "~/repos/BiomeBGC_validation/"
repos <- c("predictiveecology.r-universe.dev", getOption("repos"))
setwd(projectDir)

if (!exists("out")){
  out <- SpaDES.project::setupProject(
    paths = list(projectPath = projectDir,
                 inputPath = "inputs",
                 outputPath = file.path("outputs", pars[,".towerName"]),
                 cachePath = "cache"),
    options = options(
      repos = repos,
      Require.cloneFrom = Sys.getenv("R_LIBS_USER"),
      spades.moduleCodeChecks = FALSE,
      spades.recoveryMode = FALSE),
    times = list(start = pars[,".startYear"], end = pars[,".endYear"]),
    modules = c(
      "PredictiveEcology/BiomeBGC_dataPrep@main",
      "PredictiveEcology/BiomeBGC_core@main",
      "PredictiveEcology/BiomeBGC_validationFluxTower@main"
    ),
    
    towerCoordinates = c(lon = pars[,".lon"], lat = pars[,".lat"]),
    towerDailyFlux = read.csv(pars[,".dailyFluxDataPath"]),
    towerMonthlyFlux = read.csv(pars[,".monthlyFluxDataPath"]),
    towerAnnualFlux = read.csv(pars[,".annualFluxDataPath"]),
    dominantSpecies = pars[,".dominantSpecies"],
    params = list(
      .globals = list(.studyAreaName = pars[,".towerName"]),
      BiomeBGC_dataPrep = list(siteNames = "test",
                               co2scenario = "RCP45",
                               climModel = "RCM4",
                               outputVariables = c(621:626)
      ),
      BiomeBGC_core = list(parallel.cores = 1L,
                           bbgcPath = "biomeBGCtmp")
    )
  )
  out$loadOrder <- c("BiomeBGC_validationFluxTower", "BiomeBGC_dataPrep", "BiomeBGC_core")
  
  } else {
    
  out$times <- list(start = pars[,".startYear"], end = pars[,".endYear"])
  out$towerCoordinates <- c(lon = pars[,".lon"], lat = pars[,".lat"])
  out$towerDailyFlux <- read.csv(pars[,".dailyFluxDataPath"])
  out$towerMonthlyFlux <- read.csv(pars[,".monthlyFluxDataPath"])
  out$towerAnnualFlux <- read.csv(pars[,".annualFluxDataPath"])
  out$dominantSpecies <- pars[,".dominantSpecies"]
  out$params$.globals$.studyAreaName <- pars[,".towerName"]
  out$paths$outputPath <- normPath(file.path("outputs", pars[,".towerName"]))
  
}


initOut <- SpaDES.core::simInit2(out)
simOut <- SpaDES.core::spades(initOut)
