library(ggplot2)

# Adds sensible axis scales and legend styling to a plot
add_theme <- function(p) {
	p +
	scale_x_continuous(breaks = scales::pretty_breaks(n = 10)) +
	scale_y_continuous(breaks = scales::pretty_breaks(n = 10)) +
	theme_minimal() +
	theme(
		plot.title = element_text(size = 20, hjust = 0.5),
		plot.margin = margin(5, 15, 5, 15),
		axis.title = element_text(size = 16),
		axis.text = element_text(size = 12),
		panel.grid.minor = element_blank(),
		legend.title = element_text(hjust = 0.5),
		legend.background = element_rect(fill = "white", color = "black"),
		legend.box.background = element_rect(color = "black"),
		legend.direction = "vertical"
	)
}
