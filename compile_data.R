# Compile ChatGPT responses

library(tidyverse)

variables <- c("aoa", "aoakup", "arousal", "cd", "conc", "dom", "fam", "freq", "gender", "humor", "image", "meanings", "semdiv", "size", "social", "valence")

data_compiled <- data.frame(condition = c(), variable = c(), model = c(), word = c(), value = c())

for(i in c("20", "20b", "Rand", "Sort")){
  for(j in (1:length(variables))){
    for(k in c("35", "4")){
      
      if(i=="Sort"){
        df <- read_csv(paste0("data/batchSort/", variables[j], k, "-20sort.out"), 
                       col_names = FALSE)
      } else {
        df <- read_csv(paste0("data/batch", i, "/", variables[j], k, "-20.out"), 
                       col_names = FALSE)
      }
      
      colnames(df) <- c("word", "value")
      
      df$condition <- i
      df$variable <- variables[j]
      df$model <- k
      
      data_compiled <- rbind(data_compiled, df)
    }
  }
}

write_csv(data_compiled, "data/data_compiled.csv") 
