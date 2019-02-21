##########   NON-HIERARCHICAL (K MEANS) CLUSTERING
##########   Mario Renato Carrillo C (carri201@umn.edu)
##########   Updated: 02-21-2019

# I used cluster analysis to attempt to group objects based on some rule defining by the similarity or dissimilarity between objects. 
# The reasons to use clustering in this data analysis are that the group labels are not known a priori. 
# Thus our goal is to discover the “natural groupings” present in the data.

#################    GOAL ############

# Develop an algorithm that measures the “closeness” or “similarity” between per capita income, illiteracy, 
# life expectancy in years, and percent high-school graduates for the data sets 
# related to the 50 states of the United States of America.

# To solve this issue I used the non-hierarchical clustering method by partitions a set of N objects into
# K distinct groups based on some distance (or dissimilarity).


### For this code me required to load 'maps' package
if(!require(maps)){
  install.packages("maps")
  library(maps)
}

### For this code me required to load  'RColorBrewer' package
if(!require(RColorBrewer)){
  install.packages("RColorBrewer")
  library(RColorBrewer)
}

########### I APPLY THE METHOD TO RAW DATA
# the data set use relates to the 50 states of the United States of America
?state.x77
vars <- c("Income","Illiteracy","Life Exp","HS Grad")
head(state.x77[,vars])
apply(state.x77[,vars], 2, mean)
apply(state.x77[,vars], 2, sd)

# First, we started with some initial partition or “seed points” which define cluster centers.

# The algorithm I used is the following: 
# 
# 1)  Partition the N objects into K distinct clusters C1, . . . , CK
# 
# 2.1)  Assign object Xi to cluster Ck that has closest mean
# 
# 2.2)  Update cluster centroids if Xi is reassigned to the new cluster
# 
# – Repeat 2 until all objects remain in the same cluster

# fit k means for k = 2, ..., 10 (raw data)

kmlist <- vector("list", 9)
for(k in 2:10){
  set.seed(1)
  kmlist[[k-1]] <- kmeans(state.x77[,vars], k, nstart=10000)
}

# scree plot 
tot.withinss <- sapply(kmlist, function(x) x$tot.withinss)

plot(2:10, tot.withinss / kmlist[[1]]$totss, type="b", xlab="# Clusters", 
     ylab="SSW / SST", main="Scree Plot: Raw Data")

# plot results 

par(mfrow=c(2,2))
for(k in 4:7){
  map(database = "state")
  title(paste0("K=",k," Clusters: Raw Data"))
  cols <- brewer.pal(k, "Paired")
  for(j in 1:k){
    ix <- names(which(kmlist[[k-1]]$cluster==j))
    if(length(ix) > 1) map(database = "state", regions = ix, col = cols[j], fill=T, add=TRUE)
  }
}

# ################THE CENTERED DATA (Standardized)

# fit k means for k = 2, ..., 10 
Xs <- scale(state.x77[,vars])
kmlist.std <- vector("list", 9)
for(k in 2:10){
  set.seed(1)
  kmlist.std[[k-1]] <- kmeans(Xs, k, nstart=10000)
}

# scree plot 
tot.withinss.std <- sapply(kmlist.std, function(x) x$tot.withinss)

plot(2:10, tot.withinss.std / kmlist.std[[1]]$totss, type="b", 
     xlab="# Clusters", ylab="SSW / SST", main="Scree Plot: Std. Data")

# plot results 

par(mfrow=c(2,2))
for(k in 3:6){
  map(database = "state")
  title(paste0("K=",k," Clusters: Std. Data"))
  cols <- brewer.pal(k, "Paired")
  for(j in 1:k){
    ix <- names(which(kmlist.std[[k-1]]$cluster==j))
    if(length(ix) > 1) map(database = "state", regions = ix, col = cols[j], fill=T, add=TRUE)
  }
}
