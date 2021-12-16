### 
### Creating an Analysis pipeline for a foundry.
### 

### 1.Main.R accesses a working directory, creates folders for data and outcomes.
### Stores folder paths to variables for output files such as tables and figures


#location of work directory
wk.dir <- getwd()

#creating a vector with folder names needed for the project
folder.names <- c("a.data.raw","b.data.clean", "c.output","d.figures")

#creates directories (if the folder name exists, the function won't change it)
for(i in 1:length(folder.names)){ 
  if(file.exists(folder.names[i]) == FALSE){
    dir.create(folder.names[i])
  } 
}


#path names to variables (to use when saving plots)
p.data.raw <- paste(wk.dir, "/", folder.names[1], "/", sep = "")
p.data.clean <- paste(wk.dir, "/", folder.names[2], "/", sep = "")
p.output <- paste(wk.dir, "/", folder.names[3], "/", sep = "")
p.fig <- paste(wk.dir, "/", folder.names[4], "/", sep = "")


