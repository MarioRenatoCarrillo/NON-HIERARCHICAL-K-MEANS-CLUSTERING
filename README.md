# NON-HIERARCHICAL-K-MEANS-CLUSTERING

I used cluster analysis to group objects based on some rule defining by the similarity 
or dissimilarity among objects. Several articles recommend using clustering in data that the group 
labels are not known a priori. Thus our goal is to discover the “natural groupings” 
present in the data.

But What does it Mean for Objects to be “Similar”?

Then our main problem is that we want some rule that measures the “closeness” or “similarity” between x and y.
Where x = (x1,...,xp)′ and y = (y1,...,yp)′ denote two arbitrary vectors.

WE can use either person correlation rule or euclidean distance between x and y


#################    GOAL ############

Develop an algorithm that measures the “closeness” or “similarity” between per capita income, illiteracy, life expectancy in years, and percent high-school graduates for the data sets  
related to the 50 states of the United States of America.

To solve this issue I used the non-hierarchical clustering method by partitions a set of N objects into
K distinct groups based on some distance (or dissimilarity).

The algorithm I used is the following 

1)  Partition the N objects into K distinct clusters C1, . . . , CK

2)  Assign object Xi to cluster Ck that has closest mean
 
2.1)  Update cluster centroids if Xi is reassigned to the new cluster

Repeat 2 until all objects remain in the same cluster

