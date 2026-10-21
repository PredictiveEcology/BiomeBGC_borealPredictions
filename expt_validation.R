options(repos = c(getOption("repos"), PE = "https://predictiveecology.r-universe.dev/"))
if (!require("pak")) {
  install.packages("pak")
}

pak::pak(
  c(
    "PredictiveEcology/Require@development",
    "PredictiveEcology/SpaDES.project@development"
  ),
  ask = FALSE
)

# Change to the path containing flux tower data
fluxDataPath <- "~/data/AmeriFluxData"

.dailyFluxDataPath <- file.path(fluxDataPath,
                                c("AMF_CA-Gro_FLUXNET_2003-2014_v1.3_r1/AMF_CA-Gro_FLUXNET_FLUXMET_DD_2003-2014_v1.3_r1.csv",
                                  "AMF_CA-HPC_FLUXNET_2018-2018_v1.3_r1/AMF_CA-HPC_FLUXNET_FLUXMET_DD_2018-2018_v1.3_r1.csv",
                                  "AMF_CA-LP1_FLUXNET_2007-2024_v1.3_r1/AMF_CA-LP1_FLUXNET_FLUXMET_DD_2007-2024_v1.3_r1.csv",
                                  "AMF_CA-Man_FLUXNET_1994-2008_v1.3_r1/AMF_CA-Man_FLUXNET_FLUXMET_DD_1994-2008_v1.3_r1.csv",
                                  "AMF_CA-NS1_FLUXNET_FULLSET_2001-2005_3-5/AMF_CA-NS1_FLUXNET_FULLSET_DD_2001-2005_3-5.csv",
                                  "AMF_CA-NS2_FLUXNET_FULLSET_2001-2005_5-7/AMF_CA-NS2_FLUXNET_FULLSET_DD_2001-2005_5-7.csv",
                                  "AMF_CA-NS3_FLUXNET_FULLSET_2001-2005_5-7/AMF_CA-NS3_FLUXNET_FULLSET_DD_2001-2005_5-7.csv",
                                  "AMF_CA-NS4_FLUXNET_FULLSET_2001-2005_3-5/AMF_CA-NS4_FLUXNET_FULLSET_DD_2001-2005_3-5.csv",
                                  "AMF_CA-NS5_FLUXNET_FULLSET_2001-2005_5-7/AMF_CA-NS5_FLUXNET_FULLSET_DD_2001-2005_5-7.csv",
                                  "AMF_CA-Qc2_FLUXNET_2007-2010_v1.3_r1/AMF_CA-Qc2_FLUXNET_FLUXMET_DD_2007-2010_v1.3_r1.csv",
                                  "AMF_CA-Qfo_FLUXNET_2003-2010_v1.3_r1/AMF_CA-Qfo_FLUXNET_FLUXMET_DD_2003-2010_v1.3_r1.csv",
                                  "AMF_CA-SCC_FLUXNET_2013-2024_v1.3_r1/AMF_CA-SCC_FLUXNET_FLUXMET_DD_2013-2024_v1.3_r1.csv",
                                  "AMF_CA-SF1_FLUXNET_2003-2006_v1.3_r1/AMF_CA-SF1_FLUXNET_FLUXMET_DD_2003-2006_v1.3_r1.csv",
                                  "AMF_CA-SF2_FLUXNET_2001-2005_v1.3_r1/AMF_CA-SF2_FLUXNET_FLUXMET_DD_2001-2005_v1.3_r1.csv",
                                  "AMF_CA-SMC_FLUXNET_2018-2018_v1.3_r1/AMF_CA-SMC_FLUXNET_FLUXMET_DD_2018-2018_v1.3_r1.csv",
                                  "AMF_CA-Ojp_FLUXNET_1999-2010_v1.3_r1/AMF_CA-Ojp_FLUXNET_FLUXMET_DD_1999-2010_v1.3_r1.csv",
                                  "AMF_CA-SJ2_FLUXNET_2003-2008_v1.3_r1/AMF_CA-SJ2_FLUXNET_FLUXMET_DD_2003-2008_v1.3_r1.csv",
                                  "AMF_CA-Na1_FLUXNET_2003-2005_v1.3_r1/AMF_CA-Na1_FLUXNET_FLUXMET_DD_2003-2005_v1.3_r1.csv")
                                )

.monthlyFluxDataPath <- file.path(fluxDataPath,
                                  c("AMF_CA-Gro_FLUXNET_2003-2014_v1.3_r1/AMF_CA-Gro_FLUXNET_FLUXMET_MM_2003-2014_v1.3_r1.csv",
                                    "AMF_CA-HPC_FLUXNET_2018-2018_v1.3_r1/AMF_CA-HPC_FLUXNET_FLUXMET_MM_2018-2018_v1.3_r1.csv",
                                    "AMF_CA-LP1_FLUXNET_2007-2024_v1.3_r1/AMF_CA-LP1_FLUXNET_FLUXMET_MM_2007-2024_v1.3_r1.csv",
                                    "AMF_CA-Man_FLUXNET_1994-2008_v1.3_r1/AMF_CA-Man_FLUXNET_FLUXMET_MM_1994-2008_v1.3_r1.csv",
                                    "AMF_CA-NS1_FLUXNET_FULLSET_2001-2005_3-5/AMF_CA-NS1_FLUXNET_FULLSET_MM_2001-2005_3-5.csv",
                                    "AMF_CA-NS2_FLUXNET_FULLSET_2001-2005_5-7/AMF_CA-NS2_FLUXNET_FULLSET_MM_2001-2005_5-7.csv",
                                    "AMF_CA-NS3_FLUXNET_FULLSET_2001-2005_5-7/AMF_CA-NS3_FLUXNET_FULLSET_MM_2001-2005_5-7.csv",
                                    "AMF_CA-NS4_FLUXNET_FULLSET_2001-2005_3-5/AMF_CA-NS4_FLUXNET_FULLSET_MM_2001-2005_3-5.csv",
                                    "AMF_CA-NS5_FLUXNET_FULLSET_2001-2005_5-7/AMF_CA-NS5_FLUXNET_FULLSET_MM_2001-2005_5-7.csv",
                                    "AMF_CA-Qc2_FLUXNET_2007-2010_v1.3_r1/AMF_CA-Qc2_FLUXNET_FLUXMET_MM_2007-2010_v1.3_r1.csv",
                                    "AMF_CA-Qfo_FLUXNET_2003-2010_v1.3_r1/AMF_CA-Qfo_FLUXNET_FLUXMET_MM_2003-2010_v1.3_r1.csv",
                                    "AMF_CA-SCC_FLUXNET_2013-2024_v1.3_r1/AMF_CA-SCC_FLUXNET_FLUXMET_MM_2013-2024_v1.3_r1.csv",
                                    "AMF_CA-SF1_FLUXNET_2003-2006_v1.3_r1/AMF_CA-SF1_FLUXNET_FLUXMET_MM_2003-2006_v1.3_r1.csv",
                                    "AMF_CA-SF2_FLUXNET_2001-2005_v1.3_r1/AMF_CA-SF2_FLUXNET_FLUXMET_MM_2001-2005_v1.3_r1.csv",
                                    "AMF_CA-SMC_FLUXNET_2018-2018_v1.3_r1/AMF_CA-SMC_FLUXNET_FLUXMET_MM_2018-2018_v1.3_r1.csv",
                                    "AMF_CA-Ojp_FLUXNET_1999-2010_v1.3_r1/AMF_CA-Ojp_FLUXNET_FLUXMET_MM_1999-2010_v1.3_r1.csv",
                                    "AMF_CA-SJ2_FLUXNET_2003-2008_v1.3_r1/AMF_CA-SJ2_FLUXNET_FLUXMET_MM_2003-2008_v1.3_r1.csv",
                                    "AMF_CA-Na1_FLUXNET_2003-2005_v1.3_r1/AMF_CA-Na1_FLUXNET_FLUXMET_MM_2003-2005_v1.3_r1.csv")
                                  )

.annualFluxDataPath <- file.path(fluxDataPath,
                                 c("AMF_CA-Gro_FLUXNET_2003-2014_v1.3_r1/AMF_CA-Gro_FLUXNET_FLUXMET_YY_2003-2014_v1.3_r1.csv",
                                   "AMF_CA-HPC_FLUXNET_2018-2018_v1.3_r1/AMF_CA-HPC_FLUXNET_FLUXMET_YY_2018-2018_v1.3_r1.csv",
                                   "AMF_CA-LP1_FLUXNET_2007-2024_v1.3_r1/AMF_CA-LP1_FLUXNET_FLUXMET_YY_2007-2024_v1.3_r1.csv",
                                   "AMF_CA-Man_FLUXNET_1994-2008_v1.3_r1/AMF_CA-Man_FLUXNET_FLUXMET_YY_1994-2008_v1.3_r1.csv",
                                   "AMF_CA-NS1_FLUXNET_FULLSET_2001-2005_3-5/AMF_CA-NS1_FLUXNET_FULLSET_YY_2001-2005_3-5.csv",
                                   "AMF_CA-NS2_FLUXNET_FULLSET_2001-2005_5-7/AMF_CA-NS2_FLUXNET_FULLSET_YY_2001-2005_5-7.csv",
                                   "AMF_CA-NS3_FLUXNET_FULLSET_2001-2005_5-7/AMF_CA-NS3_FLUXNET_FULLSET_YY_2001-2005_5-7.csv",
                                   "AMF_CA-NS4_FLUXNET_FULLSET_2001-2005_3-5/AMF_CA-NS4_FLUXNET_FULLSET_YY_2001-2005_3-5.csv",
                                   "AMF_CA-NS5_FLUXNET_FULLSET_2001-2005_5-7/AMF_CA-NS5_FLUXNET_FULLSET_YY_2001-2005_5-7.csv",
                                   "AMF_CA-Qc2_FLUXNET_2007-2010_v1.3_r1/AMF_CA-Qc2_FLUXNET_FLUXMET_YY_2007-2010_v1.3_r1.csv",
                                   "AMF_CA-Qfo_FLUXNET_2003-2010_v1.3_r1/AMF_CA-Qfo_FLUXNET_FLUXMET_YY_2003-2010_v1.3_r1.csv",
                                   "AMF_CA-SCC_FLUXNET_2013-2024_v1.3_r1/AMF_CA-SCC_FLUXNET_FLUXMET_YY_2013-2024_v1.3_r1.csv",
                                   "AMF_CA-SF1_FLUXNET_2003-2006_v1.3_r1/AMF_CA-SF1_FLUXNET_FLUXMET_YY_2003-2006_v1.3_r1.csv",
                                   "AMF_CA-SF2_FLUXNET_2001-2005_v1.3_r1/AMF_CA-SF2_FLUXNET_FLUXMET_YY_2001-2005_v1.3_r1.csv",
                                   "AMF_CA-SMC_FLUXNET_2018-2018_v1.3_r1/AMF_CA-SMC_FLUXNET_FLUXMET_YY_2018-2018_v1.3_r1.csv",
                                   "AMF_CA-Ojp_FLUXNET_1999-2010_v1.3_r1/AMF_CA-Ojp_FLUXNET_FLUXMET_YY_1999-2010_v1.3_r1.csv",
                                   "AMF_CA-SJ2_FLUXNET_2003-2008_v1.3_r1/AMF_CA-SJ2_FLUXNET_FLUXMET_YY_2003-2008_v1.3_r1.csv",
                                   "AMF_CA-Na1_FLUXNET_2003-2005_v1.3_r1/AMF_CA-Na1_FLUXNET_FLUXMET_YY_2003-2005_v1.3_r1.csv")
                                 )

.startYear <- c(2003, 2018, 2007, 1994, 2001, 2001, 2001, 2001, 2001, 2007, 2003, 2013, 2003, 2001, 2018, 1999, 2003, 2003)
.endYear <- c(2014, 2018, 2024, 2008, 2005, 2005, 2005, 2005, 2005, 2010, 2010, 2024, 2006, 2005, 2018, 2010, 2008, 2005)
.lat <- c(48.2167, 68.3203, 55.1119, 55.880, 55.8792, 55.9058, 55.9117, 55.9144, 55.8631, 49.7598, 49.6925, 61.3079, 54.4850, 54.2539, 63.1534, 53.9163, 53.9450, 46.4722)
.lon <- c(-82.1556, -133.5188, -122.8414, -98.481, -98.4839, -98.5247, -98.3822, -98.3806, -98.4850, -74.5711, -74.3421, -121.2992, -105.8176, -105.8775, -123.2522, -104.6920, -104.6490, -67.1000)
.towerName <- c("CA-Gro", "CA-HPC", "CA-LP1", "CA-Man", "CA-NS1", "CA-NS2", "CA-NS3", "CA-NS4", "CA-NS5", "CA-Qc2", "CA-Qfo", "CA-SCC", "CA-SF1", "CA-SF2", "CA-SMC", "CA-Ojp", "CA-SJ2", "CA-Na1")
.dominantSpecies <- c("Betu_pap", "Pice_mar", "Pinu_con", "Pice_mar", "Pice_mar", "Pice_mar", "Pice_mar", "Pice_mar", "Pice_mar", "Pice_mar", "Pice_mar", "Pice_mar", "Pinu_ban", "Pinu_ban", "Pice_mar", "Pinu_ban", "Pinu_ban", "Abie_bal")


expt <- data.frame(.dailyFluxDataPath, .monthlyFluxDataPath, .annualFluxDataPath, .startYear, .endYear, .lat, .lon, .towerName, .dominantSpecies)

for (i in seq_len(nrow(expt))) {
  pars <- expt[i, ]
  with(pars, {
    source("global_validation.R")
  })
}
