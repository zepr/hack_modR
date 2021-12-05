##########
library(rvle)
library(date)


source("C:/Users/alanu/vle/pkgs-2.0/vle.recursive/R/vle.recursive.R")
f = vle.recursive.init(pkg="AZODYN", file="AzodynWheat.vpz")


setwd("C:/Users/alanu/Documents")
Donnees_initiales  = read.csv(file="Donnees_initiales.csv",header=TRUE,sep=';')
Donnees_meteo = read.csv(file="donnee.csv",sep=";",header=TRUE)



################# Simulation pour le RDT potentiel max ###############


begin_date = Donnees_initiales$annee_simule

ligneinitiale = 1


while (begin_date != as.numeric(Donnees_meteo$AN[ligneinitiale])){ligneinitiale = ligneinitiale + 1 
print(Donnees_meteo$AN[ligneinitiale])}

meteo_substract = Donnees_meteo[ligneinitiale:(366+ligneinitiale),]


simData = data.frame(cDecision.fertiMinNH4_1 = paste("date=",as.character(begin_date),"-02-10$dose=150",sep=""),
                     cDecision.fertiMinNH4_2 = paste("date=",as.character(begin_date),"-02-30$dose=150",sep=""),
                     cDecision.fertiMinNH4_3 = paste("date=",as.character(begin_date),"-03-10$dose=150",sep=""),
                     cDecision.fertiMinNH4_4 = paste("date=",as.character(begin_date),"-03-20$dose=150",sep=""),
                     cDecision.fertiMinNH4_5 = paste("date=",as.character(begin_date),"-03-30$dose=150",sep=""),
                     cDecision.fertiMinNH4_6 = paste("date=",as.character(begin_date),"-04-15$dose=150",sep=""),
                     cPlant.date_E1CM = paste(as.character(begin_date),"-03-20",sep=""),
                     cPlant.date_fin_GEL = paste(as.character((begin_date-1)),"-12-31",sep=""),
                     cPlant.date_FLO = paste(as.character(begin_date),"-05-12",sep=""),
                     cPlant.date_init_H = paste(as.character(begin_date),"-01-02 ",sep=""),
                     cPlant.date_init_miner_res = paste(as.character(begin_date),"-02-01",sep=""),
                     cPlant.date_init_MS = paste(as.character(begin_date),"-02-01",sep=""),
                     cPlant.date_init_N = paste(as.character(begin_date),"-02-01",sep=""),
                     cPlant.date_LEVEE = paste(as.character(begin_date-1),"-11-25" ,sep=""),
                     cPlant.date_S = paste(as.character(begin_date-1),"-10-01",sep=""),
                     cPlant.RDTmax_var = Donnees_initiales$RDTmax_var ,
                     cSoil.ep_C0 = Donnees_initiales$ep_co,
                     cSoil.RUmax = Donnees_initiales$Rumax,
                     cSoil.RU_init =Donnees_initiales$Rumax,
                     cPlant.PMGmax_var = Donnees_initiales$PMGmax,
                     cPlant.Rmax_var = -8,
                     simulation_engine.duration = 365,
                     cBegin.begin_date = paste(as.character(begin_date),"-01-01",sep=""),
                     cPlant.Tmax_plante = Donnees_initiales$Tmaxplant,
                     cPlant.Topt_plante = Donnees_initiales$Toptplant,
                     condClimate.meteo_file = "donnee.csv",
                     stringsAsFactors=FALSE)
 

                    
simData = vle.recursive.parseSim(file_sim = simData,  rvle_handle=f)
out_vars = vle.recursive.getAvailOutputs(f)
vle.recursive.configOutputs(f,output_vars = c(RDT=out_vars$RDT, MSpot=out_vars$MSpot),integration='all')
res = vle.recursive.simulate(rvle_handle=f)
dmax = data.frame(res$RDT,res$MSpot)
colnames(dmax)=c("RDTmax","MSpot")
write.csv2(dmax,file = "MSetRDTau_potentiel.csv",row.names = FALSE)



