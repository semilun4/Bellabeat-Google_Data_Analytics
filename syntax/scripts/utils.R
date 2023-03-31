

#  """ 
#  Esta función recive como argumentos:
#  base: un Data Frame con la base de la que se quiere generar el resumen numérico
#  columna: columna del Data Frame al cuál se realizará el resumen numérico
#  tabla: nombre del data frame
#  """

resumen_numerico <- function(base, columna, tabla){
  
  
  
  nombre_tabla <- tabla
  columna_name <-  columna
  total_dim <- dim(base[columna])[1]
  ceros <- dim(filter(base,base[columna]==0))[1]
  nas <- sum(is.na(base[columna]))
  minimo <- base[columna] %>% min(na.rm=TRUE)  
  maximo <- base[columna] %>% max(na.rm=TRUE)  
  media <- base[,columna] %>% mean(na.rm=TRUE)  
  q_01 <- quantile(base[columna], c(0.01), na.rm = TRUE)
  q_05 <- quantile(base[columna], c(0.05), na.rm = TRUE)
  q_50 <- quantile(base[columna], c(0.5), na.rm = TRUE)
  q_90 <- quantile(base[columna], c(0.9), na.rm = TRUE)
  q_95 <- quantile(base[columna], c(0.95), na.rm = TRUE)
  q_99 <- quantile(base[columna], c(0.99), na.rm = TRUE)
  df_final <- data.frame(
    tabla = tabla,
    columna = columna_name,
    total = total_dim,
    ceros = ceros,
    pcj_ceros = ceros/total_dim,
    nas = nas,
    pcj_nas = nas/total_dim,
    minimo = minimo,
    maximo = maximo,
    media = media,
    q_01 = q_01,
    q_05 = q_05,
    q_50 = q_50,
    q_90 = q_90,
    q_95 = q_95,
    q_99 = q_99
    
  )
  
  return(df_final)
  
}




generar_report_value <- function(data, OUTPUT_FILE){
  
  rep_val_cols <- c("tabla", "columna", "total", "ceros", 
                    "pcj_ceros", "nas", "pcj_nas", "minimo", 
                    "maximo", "media", 
                    "q_01", "q_05", "q_50", "q_90",
                    "q_95", "q_99"
  )
  
  
  lista = list()
  resumen_df <- as.data.frame(unlist(lapply(data, class)))
  resumen_df <- cbind(VARIABLE = rownames(resumen_df), resumen_df)
  rownames(resumen_df) <- 1:nrow(resumen_df)
  
  names(resumen_df) <- c("VARIABLE","TIPO")
  lista_aux <- list(resumen_df)
  names(lista_aux) <- "TIPO"
  lista <- append(lista, lista_aux)
  
  df_aux <- data.frame(matrix(ncol = 16, nrow = 0))
  colnames(df_aux) <- rep_val_cols
  
  numericas <- select_if(data, is.numeric) %>% names()
  
  
  for(i in numericas){
    df_loop <- resumen_numerico(data, i, OUTPUT_FILE)
    df_aux <- rbind(df_aux,df_loop)
    
  }
  
  
  lista_aux <- list(df_aux)
  names(lista_aux) <- "RV_numerico"
  lista <- append(lista, lista_aux)
  
  
  var_factor <- select_if(data, is.factor) %>% names()
  
  rep_fact_cols <- c("tabla", "columna", "total", "nas", "pcj_nas", "categorias")
  df_fact_aux <- data.frame(matrix(ncol = 6, nrow = 0))
  colnames(df_fact_aux) <- rep_fact_cols
  ############### BBBBBBBUUUUUUUUUUGGGGGGGGGG
  for(i in var_factor){
    df_loop <- resumen_factor(data, i, "data")
    df_fact_aux <- rbind(df_fact_aux,df_loop)
    
  }
  
  lista_aux <- list(df_fact_aux)
  names(lista_aux) <- "RV_categorico"
  lista <- append(lista, lista_aux)
  
  for(i in var_factor){
    df_conteo <- conteo_categorias(data,i)
    lista_aux <- list(df_conteo)
    names(lista_aux) <- i
    lista <- append(lista, lista_aux)
  }
  
  
  
  openxlsx::write.xlsx(lista, paste0(DOCDIR,
                                     "RV_",OUTPUT_FILE,".xlsx"),
                       append = TRUE)
}

corregir_tipos <- function(data, vars_fecha, vars_num, vars_id){
  data <- data %>% 
    mutate_if(is.character, as.factor) %>% #Corección caracter a factor
    mutate_at(vars_fecha, ~ as.Date(.,format="%Y-%m-%d")) %>% #correción fechas
    mutate_at(vars_num, ~ as.double(.)) %>% #Corrección de variables numericas, únicamente aquellas character
    mutate_at(vars_id, ~ as.character(.)) #Corección ID's a caracter
  
  return(data)
}

#corregir_tipos(data, vars_fecha, vars_num, vars_id)


corregir_tipos <- function(data, vars_fecha, vars_num, vars_id){
  data <- data %>% 
    mutate_at(c(), ~ as.integer(.)) %>% #Corrección de variables numericas, únicamente aquellas character
    
    
    return(data)
}
