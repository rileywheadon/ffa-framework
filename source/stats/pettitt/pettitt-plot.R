library(ggplot2)
library(patchwork)

# Source the plot theme (path is relative to /source)
source("stats/plot-theme.R")

# Plot the results of the Mann-Whitney-Pettitt test for abrupt changes in the mean
plot <- function(df, results) {

	# Load the results of the test into the environment
	list2env(results, envir = environment())

	# Add u_t to df and create change point df (if change point is significant)
	df$u_t = u_t
	change_df <- df[change_index, ]

	# Get the segment endpoints depending on whether there is a change point
	n <- length(u_t)
	ends <- if (change_index == 0) { 
		c(1, n) 
	} else { 
		c(1, change_index, n) 
	}

	n_ends <- length(ends)
	get_segment_mean <- function(i) mean(df$max[ends[i]:ends[i + 1]])

	# Compute the segment means for the plot
	segment_df <- data.frame(
		x = df$year[ends[-n_ends]],            
		xend = df$year[ends[-1]],
		y = sapply(1:(n_ends - 1), get_segment_mean)
	)

	# Generate the labels with proper formatting
	ut_label <- expression(U[t] ~ Statistic)
	flow_label <- expression(AMS ~ m^3/s)

	# First subplot: Mann-Whitney-Pettitt Test
	p1 <- ggplot(df, aes(x = year, y = u_t)) +
		geom_line(aes(color = "black"), linewidth = 1.2) +
		geom_hline(
			aes(yintercept = k_alpha, color = "red"),
			linewidth = 1.2,
			linetype = "dashed",
		) +
		geom_point(data = change_df, aes(color = "blue"), size = 4) +
		labs(
			title = "Mann-Whitney-Pettitt Test",
			x = "Year",
			y = ut_label,
			color = "Legend") +
		scale_color_manual(
			values = c("black" = "black", "red" = "red", "blue" = "blue"),
			breaks = c("black", "red", "blue"),
			labels = c(ut_label, "Change Point Threshold", "Potential Change Point")
		)
		

		
	# Also plot the original flow data and segment means
	p2 <- ggplot(df, aes(x = year, y = max)) +
		geom_point(aes(color = "black")) +
		geom_segment(
			data = segment_df, 
			aes(x = x, xend = xend, y = y, color = "green4"),
			linewidth = 1.2 
		) + 
		geom_point(data = change_df, aes(color = "blue"), size = 4) +
		labs(x = "Year", y = flow_label, color = "Legend") +
		scale_color_manual(
			values = c("black" = "black", "green4" = "green4", "blue" = "blue"),
			breaks = c("black", "green4", "blue"),
			labels = c(flow_label, "Segment Mean(s)", "Potential Change Point")
		)	

	# Stack plots on top of each other and return
	add_theme(p1) / add_theme(p2)

}
