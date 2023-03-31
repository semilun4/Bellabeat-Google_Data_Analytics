
# ------------------------------------------------------------------------------

# Archivo   :  00_Inicio_Proyecto_Google.R
# Autora    :  Semiramis Garcia de la Cruz
# Fecha     :  26-03-2023
# Descripcion : Inicio del proyecto final de la certificación de Google

#-------------------------------------------------------------------------------

# UBICACION  

PATH <- "C:/Users/Semiramis/Documents/Capacitación/Google/Proyecto final/"

if(substr(PATH, nchar(PATH), nchar(PATH)) != "/") PATH <- paste0(PATH,"/")
#setwd(PATH)

# DIRECTORIOS 

DATADIR    <- paste0(PATH, 'data/')
DOCDIR     <- paste0(PATH, 'doc/')
SYNTAXDIR  <- paste0(PATH,"syntax/") 

SCRIPTSDIR  <- paste0(SYNTAXDIR,"scripts/") 
