library(here)
library(tidyr)

#########################################################################
#                                                                       #
#                              DATA SET-UP                              #
#                                                                       #
#########################################################################

#read in the data 
bird.data <- read.csv(here("data","Bird_Data.csv")) 

#clean some things up 
bird.data$Site[which(bird.data$Site == "Issaquah highlands")] <- "Issaquah Highlands"
bird.data$Site.Type[which(bird.data$Site.Type == "reserve")] <- "Reserve"
bird.data$Point.Type[which(bird.data$Point.Type == "Forest ")] <- "Forest"
bird.data$Initials.Site[intersect(which(bird.data$Site == "Cougar Mountain Park"),which(bird.data$Initials.Site == "LF"))] <- "CM"

#create a new clean data frame with no duplicate columns 
bird.clean <- data.frame(bird.data$Year, bird.data$Initials.Site, bird.data$Site.Type, bird.data$Point, bird.data$Point.Type, bird.data$Round, bird.data$Species, bird.data$Total)
colnames(bird.clean) <- c("Year","Site","Site.Type","Point","Point.Type","Round","Species","Total")

################################################################
#explore the duplicated rows in the dataset 
#create a dataset that contains all the duplicates 

# bird.clean.test <- bird.clean
# total.vect <- 0 
# blank.mat <- rep(NA,3000)
# bird.clean.con <- bird.clean.con.noTotal <- rep(NA,nrow(bird.clean.test)) 
# start <- 1 
# for(i in 1:length(bird.clean.con)){
#   bird.clean.con.noTotal[i] <- paste(bird.clean.test[i,1],bird.clean.test[i,2],bird.clean.test[i,3],bird.clean.test[i,4],bird.clean.test[i,5],bird.clean.test[i,6],bird.clean.test[i,7],sep = "-") 
#   bird.clean.con[i] <- paste(bird.clean.test[i,1],bird.clean.test[i,2],bird.clean.test[i,3],bird.clean.test[i,4],bird.clean.test[i,5],bird.clean.test[i,6],bird.clean.test[i,7],bird.clean.test[i,8],sep = "-") 
# }
# for(j in 1:length(bird.clean.con)){
#   vect <- which(bird.clean.con.noTotal == bird.clean.con.noTotal[j])
#   for(h in 1:length(vect)){
#     if(length(vect)>1 && is.element(vect[h],total.vect)==FALSE){
#         blank.mat[(start+h-1)] <- bird.clean.con[vect[h]]
#       total.vect <- c(total.vect,vect[h])
#     }
#   } 
#   start <- min(which(is.na(blank.mat==TRUE)))
# }
# total.vect <- total.vect[-c(1)]
# repeat.data <- matrix(NA,nrow=length(blank.mat),ncol=9)
# for(i in 1:length(blank.mat)){
#     for(g in 1:ncol(repeat.data)){
#       repeat.data[i,g] <- str_split(blank.mat[i], "-")[[1]][g]
#     }
#   repeat.data[i,9] <- total.vect[i]
# }
# 

################################################################

#we think we can just take the sum because things weren't summed before data entry   
fix.dups <- aggregate(Total ~ Year + Site + Site.Type + Point + Point.Type + Round + Species,data = bird.clean,FUN=sum)

#create wide form 
bird.wide <- pivot_wider(data = fix.dups, id_cols = c("Year","Site","Site.Type","Point","Point.Type","Round"), names_from = "Species", values_from = "Total")
#convert to a data frame 
bird.wide <- as.data.frame(bird.wide)

#replace NA with 0 
bird.wide[is.na(bird.wide)] <- 0

################################################################
#look at the overall counts across all species
# bird.all <- c(bird.wide[,7],bird.wide[,8],bird.wide[,9],bird.wide[,10],bird.wide[,11]
#               ,bird.wide[,12],bird.wide[,13],bird.wide[,14],bird.wide[,15],bird.wide[,16]
#               ,bird.wide[,17],bird.wide[,18],bird.wide[,19],bird.wide[,20],bird.wide[,21]
#               ,bird.wide[,22],bird.wide[,23],bird.wide[,24],bird.wide[,25],bird.wide[,26]
#               ,bird.wide[,27],bird.wide[,28],bird.wide[,29],bird.wide[,30],bird.wide[,31]
#               ,bird.wide[,32],bird.wide[,33],bird.wide[,34],bird.wide[,35],bird.wide[,36]
#               ,bird.wide[,37],bird.wide[,38],bird.wide[,39],bird.wide[,40],bird.wide[,41]
#               ,bird.wide[,42],bird.wide[,43],bird.wide[,44],bird.wide[,45],bird.wide[,46]
#               ,bird.wide[,47],bird.wide[,48],bird.wide[,49],bird.wide[,50],bird.wide[,51]
#               ,bird.wide[,52],bird.wide[,53],bird.wide[,54],bird.wide[,55],bird.wide[,56]
#               ,bird.wide[,57],bird.wide[,58],bird.wide[,59],bird.wide[,60],bird.wide[,61]
#               ,bird.wide[,62],bird.wide[,63])
# table(bird.all)
################################################################

#seems reasonable to treat the data as binary (very few counts are >1)
bird.binary <- bird.wide
for(i in 1:nrow(bird.wide)){
  for(j in 7:63){
    if(bird.wide[i,j]> 1){bird.binary[i,j] <- 1} 
  }
}

#now remove everything but CD/PCD sites 
bird.binary.noCorrRes <- bird.binary[-c(which(bird.binary$Site.Type == "Correlational"),which(bird.binary$Site.Type == "Reserve")),]

#create year variable for modeling 
Year.new <- (bird.binary.noCorrRes$Year - mean(bird.binary.noCorrRes$Year))/sd(bird.binary.noCorrRes$Year)
Year.new2 <- Year.new^2

#put it all into a new dataframe 
bird.binary.noCorrRes <- data.frame(bird.binary.noCorrRes[,c(1)],Year.new,Year.new2,bird.binary.noCorrRes[,c(2:6)],bird.binary.noCorrRes[,c(7:63)])
colnames(bird.binary.noCorrRes) <- c("Year",colnames(bird.binary.noCorrRes[c(2:65)]))

#we start with 57 species, but 53 species are in the guild list from dissertation 
#the guild list excludes HAFL, MODO, RECR, TOSO, so remove these species
bird.binary.noCorrRes <- subset(bird.binary.noCorrRes, select = -c(HAFL,MODO,RECR,TOSO))

#write out data for analysis
write.csv(bird.binary.noCorrRes,here("data","bird.binary.noCorrRes.csv"),row.names=FALSE)
