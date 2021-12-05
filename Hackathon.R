
library(gridExtra)
library(ggplot2)
library(rlang)
library(reshape2)
library(sensitivity)
library(lhs)
library(rgenoud)
library(BayesianTools)
library(grid)
library(ggplot2)
library(reshape2)
library(rvle)
library(date)
library(dplyr)
library(tidyr)



source("C:/Users/alanu/vle/pkgs-2.0/vle.recursive/R/vle.recursive.R")

# init the zheat simulator
f = vle.recursive.init(pkg="AZODYN", file="AzodynWheat.vpz")

# show the content
vle.recursive.showEmbedded(f)

# build an experiment plan of 3 simulations zith different sowing density,
# and different max root depth
simData = data.frame(cDecision.fertiMinNH4_1 = c("date=1992-03-10$dose=150"),
                     cDecision.fertiMinNH4_2 = c("date=1992-03-17$dose=150"),
                     cDecision.fertiMinNH4_3 = c("date=1992-03-30$dose=150"),
                     cDecision.fertiMinNH4_4 = c("date=1992-04-10$dose=150"),
                     cDecision.fertiMinNH4_5 = c("date=1992-04-20$dose=150"),
                     stringsAsFactors=FALSE)

# config the simulator with the simulations
simData = vle.recursive.parseSim(file_sim = simData,  rvle_handle=f)

# get available simulqtion outputs
out_vars = vle.recursive.getAvailOutputs(f)

# configure selected outputs
vle.recursive.configOutputs(f,output_vars = c(RDT=out_vars$RDT, MS = out_vars$MS, MSpot=out_vars$MSpot),integration='all')
# simulate
res = vle.recursive.simulate(rvle_handle=f)
d = data.frame(res$RDT,res$MS,res$MSpot)
colnames(d)=c("RDT","MS","MSpot")

setwd("C:/Users/alanu/Desktop/AZODYN/output")

write.csv2(d,file = "d",row.names = FALSE)


# plot
vle.recursive.plot(res, output_vars = c("LAI","MS",'RR'))






### Model sans stress ##############"

f = vle.recursive.init(pkg="AZODYN", file="AzodynWheat.vpz")







simData = data.frame(cDecision.fertiMinNH4_1 = c("date=1992-03-10$dose=150"),
                     cDecision.fertiMinNH4_2 = c("date=1992-03-17$dose=150"),
                     cDecision.fertiMinNH4_3 = c("date=1992-03-30$dose=150"),
                     cDecision.fertiMinNH4_4 = c("date=1992-04-10$dose=150"),
                     cDecision.fertiMinNH4_5 = c("date=1992-04-20$dose=150"),
                     cPlant.date_E1CM = "1992-03-20",
                     cPlant.date_fin_GEL = "1991-12-31",
                     cPlant.date_FLO = "1992-05-12",
                     cPlant.date_init_H = "1992-01-02 ",
                     cPlant.date_init_miner_res = "1992-02-01",
                     cPlant.date_init_MS = "1992-02-01",
                     cPlant.date_init_N = "1992-02-01",
                     cPlant.date_LEVEE = "1991-11-25" ,
                     cPlant.date_S = "1991-10-01",
                     cPlant.RDTmax_var = 120,
                     cSoil.ep_C0 = 300,
                     cSoil.RUmax = 100,
                     cSoil.RU_init =100,
                     cPlant.PMGmax_var = 42,
                     cPlant.Rmax_var = -8,
                     simulation_engine.duration = 365,
                     cBegin.begin_date = "1991-08-01",
                     cPlant.Tmax_plante = 40,
                     cPlant.Topt_plante = 15,
                     condClimate.meteo_file = "ThivervalGrignon_1991_2000.csv"
                     stringsAsFactors=FALSE)


'PMGmax : gramme, ep_C0 : mm, Rumax = mm, RDTMx = q/ha'

