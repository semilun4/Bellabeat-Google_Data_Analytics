
# ------------------------------------------------------------------------------

# Archivo   :  02_Modelo_Regresion_Google.R
# Fecha     :  28-03-2023
# Descripcion : Prueba de una regresion con la informacion disponible

#-------------------------------------------------------------------------------

# LIBRERIAS
library(tidyverse)
library(readr)
library(dplyr)
library(ggcorrplot) 
library(tidyr)

# INICIO PROYECTO
source("C:/Users/Semiramis/Documents/Capacitación/Google/Proyecto final/syntax/00_Inicio_Proyecto_Google.R")
source(paste0(SCRIPTSDIR, "utils.R"))

# CARGA DE DATOS

load(paste0(DATADIR,"Daily_Data.RData"))

#---------------------------------------------- REVISION PREVIA ----------------

# Primero revisemos las variables
colnames(daily_data_v2) 

# Eliminar variables repetidas
daily_data_v2 <- daily_data_v2[,-c(3,22,28)]

# Tendremos un dataset de 940x25 con registros de 33 personas
dim(daily_data_v2) 
n_distinct(daily_data_v2$Id)
summary(daily_data_v2)

# Nuevo Report Values
generar_report_value(daily_data_v2,"RV_Daily_Data_V2")

# Revisemos la correlación de las variables

# Solo variables numericas
numeric_vars <- names(dplyr::select_if(daily_data_v2,is.numeric))
numeric_vars <- numeric_vars[-1]

daily_data_numeric <- daily_data_v2 %>% 
  select(numeric_vars)

# Matriz de correlacion
cors <- cor(daily_data_numeric, use = "pairwise.complete.obs")
# Grafico
ggcorrplot(cors)




#---------------------------------------------- TRANSFORMAR VARIABLES ----------


"
Crear una variable de calidad del sueño
Definir que hacer con los NA
Ver la relacion de cada variable con Calories
Investigar en que parte del periodo se pierden mas calorias
Ver el tipo de actividad que se realiza por dia de la semana
Modelo propuesto: 

"
# Tomaremos las calorias como nuestra variable a explicar

# Variable de calidad del sueño

daily_data_v2 <- daily_data_v2 %>% 
  mutate(SleepQuality = TotalMinutesAsleep/TotalTimeInBed)

# Reemplazar con la media los NA

valor_meadian <- median(daily_data_v2$SleepQuality, na.rm = TRUE)

daily_data_v2$SleepQuality[is.na(daily_data_v2$SleepQuality)] <- median(daily_data_v2$SleepQuality,
                                                                        na.rm = T)

resumen_numerico(daily_data_v2, "SleepQuality","test")

round(cor(x = daily_data_v2, method = "pearson"), 3) %>% View()

daily_data_v3 <- daily_data_v2 %>%
  mutate(BoolVeryMin = case_when(
    VeryActiveMinutes >= mean(VeryActiveMinutes) ~ 1,
    TRUE ~ 0
  ))
 

daily_data_v3 <- daily_data_v3 %>%
  mutate(BoolVeryDist = case_when(
    VeryActiveDistance >= mean(VeryActiveDistance) ~ 1,
    TRUE ~ 0
  )) 
  

# Revisar correlacion
names(daily_data_numeric)

daily_data_model <- daily_data_v3 %>% 
  select(TotalSteps, TotalDistance, Calories,
         WeightKg, SleepQuality, BoolVeryMin,
         BoolVeryDist)

# Matriz de correlacion
cors <- cor(daily_data_model, use = "pairwise.complete.obs")
cors
# Grafico
ggcorrplot(cors)


# Modelo

model_v1 <- lm(Calories ~ TotalDistance + WeightKg + 
              SleepQuality + BoolVeryMin, 
            data = daily_data_model)

summary(model_v1)

confint(model_v1)
















