
# ------------------------------------------------------------------------------

# Archivo   :  01_Limpieza_Proyecto_Google.R
#
# Fecha     :  26-03-2023
# Descripcion : Union y limpieza de las bases de datos

#-------------------------------------------------------------------------------


# LIBRERIAS
library(tidyverse)
library(readr)
library(dplyr)


# INICIO PROYECTO
source("C:/Users/Semiramis/Documents/Capacitación/Google/Proyecto final/syntax/00_Inicio_Proyecto_Google.R")


# CARGA DE DATOS

daily_activity <- read.csv(paste0(DATADIR,
                                  "dailyActivity_merged.csv")) 

heart_rate_seconds <- read.csv(paste0(DATADIR,
                                      "heartrate_seconds_merged.csv"))
sleep_day <- read_csv(paste0(DATADIR,
                             "sleepDay_merged.csv"))
weight <- read_csv(paste0(DATADIR,
                          "weightLogInfo_merged.csv"))

hourly_calories <- read.csv(paste0(DATADIR,
                                   "hourlyCalories_merged.csv"))
hourly_intensities <- read.csv(paste0(DATADIR,
                                      "hourlyIntensities_merged.csv"))
hourly_steps <- read.csv(paste0(DATADIR,
                                "hourlySteps_merged.csv"))


                   
#------------------------------------- UN VISTAZO A LOS DATOS-------------------

n_distinct(daily_activity$Id)     #33

n_distinct(heart_rate_seconds$Id) #14
n_distinct(sleep_day$Id)          #24
n_distinct(weight$Id)             #8

n_distinct(hourly_calories$Id)    #33
n_distinct(hourly_intensities$Id) #33
n_distinct(hourly_steps$Id)       #33




#------------------------------------ REPORT VALUES ---------------------------

# Aplicar un merge entre daily_activity, sleep_day & weight

source(paste0(SCRIPTSDIR, "utils.R"))

generar_report_value(daily_activity,"Daily_Activity") # 940,15
generar_report_value(sleep_day,"Sleep_Day")           # 413,5
generar_report_value(weight,"Weight")                 # 67,8



# TRANSFORMAR VARIABLES

# daily_activity

daily_activity <- daily_activity %>% 
  mutate(ActivityDate_C = format(as.POSIXct(ActivityDate, format='%m/%d/%Y'),
                               format='%m/%d/%Y'),
         Date = ActivityDate_C)

daily_activity %>%
  group_by(Id, Date) %>% 
  summarise(n = n()) %>% 
  View()


# sleep_day
sleep_day <- sleep_day %>% 
  mutate(Date = format(as.POSIXct(SleepDay,format='%m/%d/%Y %H:%M:%S'),
                             format='%m/%d/%Y'))

sleep_day <- sleep_day %>% 
  distinct(Id, Date, .keep_all = TRUE)

sleep_day %>% 
  group_by(Id, Date) %>% 
  summarise(n = n()) %>% 
  View()


# weight
weight <- weight %>% 
  mutate(Date_C = format(as.POSIXct(Date,format='%m/%d/%Y %H:%M:%S'),
                             format='%m/%d/%Y'))

weight %>% 
  group_by(Id, Date_C) %>% 
  summarise(n = n()) %>% 
  View()


#------------------------------- UNION ----------------------------------------

daily_data <- merge(daily_activity, sleep_day,
                    by = c("Id","Date"), all.x = TRUE)

# Otra forma de hacerlo
# daily_data <- daily_activity %>% left_join(sleep_day,
#                                    by=c('Id'='Id','Date'='Date'))

daily_data_v2 <- daily_data %>% left_join(weight,
                                   by=c('Id'='Id','Date'='Date_C'))

save(daily_data_v2, file = paste0(DATADIR,"Daily_Data.RData"))






        