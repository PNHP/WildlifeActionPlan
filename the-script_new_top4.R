#---------------------------------------------------------------------------------------------
# Name: SpeciesTop4Habitats.R
# Purpose: This scripts takes the output of the Tabulate Area command from ArcGIS and calculates the top four percentatages of each habitat type
# Author: Christopher Tracey
# Created: 2015-01-14
# Updated: 2015-01-16
#
# Updates:
# * 2015-01-15 - modified to calculate the top four habitat percentages instead fof just the top two.
# * 2015-01-16 - fixed a wrong index
#
# To Do List/Future Ideas:
# * 
#---------------------------------------------------------------------------------------------

# set the working directory to wherever you put all of your data files for r to work on. 
# This should also be the directory where you want r to put your results files.


x <- read.csv("TestBirds2.csv", row.names = 1)

catchment <- NULL
results <- t(apply(x, 1, function(d){
		d.ordered <- d[order(d, decreasing = TRUE)]
		d.top <- d.ordered[1:4]
		d.1.proportion <- d.ordered[1]/(sum(d.ordered, na.rm = TRUE))
		d.2.proportion <- d.ordered[2]/(sum(d.ordered, na.rm = TRUE))
		d.3.proportion <- d.ordered[3]/(sum(d.ordered, na.rm = TRUE))
		d.4.proportion <- d.ordered[4]/(sum(d.ordered, na.rm = TRUE))
		d.sum <- (sum(d.ordered, na.rm = TRUE))
	
		result <- c(rownames(d), names(d.top)[1], names(d.top[2]), names(d.top[3]), names(d.top[4]), d.top, d.1.proportion, d.2.proportion, d.3.proportion, d.4.proportion, d.sum)
	
		catchment <- rbind(catchment, result)
		}
	)
)

colnames(results) <- c("best", "second_best", "third_best", "fourth_best", "best_score", "second_best_score", "third_best_score", "fourth_best_score","best_proportion", "second_best_proportion","third_best_proportion","fourth_best_proportion", "sum_of_all")
write.csv(results, "results4.csv", na = "")

