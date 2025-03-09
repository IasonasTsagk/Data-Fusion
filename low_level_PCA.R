library(dplyr)
library(ggfortify)
library(ggplot2)
library(multiblock)


# Import and process dataset ----------------------------------------------


setwd("C:/Users/Filippo/Documents/DSDM/Data Fusion/DF Project/")
df = read.csv("Data Fusion Assignment 2025 Data.csv")
df$class <- as.factor(df$class)

# Consider only spectrum variables and split y from X

X_spectrum <- df %>%
  select(starts_with("spectrum_"))

y_spectrum <- df$class


# PCA applied to whole spectrum dataset -----------------------------------

output <- prcomp(X_spectrum, center = TRUE, scale. = FALSE) # Not standardize

sum(output$sdev^2) # Total variance

scores = output$x # Principal component scores

loadings = output$rotation # Loadings
loadings[,1]

PC1_scores <- scores[, 1] # Extract PC1 scores

# Compute correlations with original variables

cor_PC1 <- cor(X_spectrum, scores[, 1])  # Correlation with PC1
cor_PC2 <- cor(X_spectrum, scores[, 2])  # Correlation with PC2

cor_PC1
cor_PC2


# Selection of number of PC -----------------------------------------------

# Method 1:

summary(output) # More than 97% of the total variance is explained by PC1

# Method 2:

eigenvalues = output$sdev^2 # Eigenvalues
print(eigenvalues[eigenvalues > mean(eigenvalues)]) # 3 values larger than the mean

# Method 3:

screeplot(output, type = "lines", main = "Scree Plot") 


# Plotting ----------------------------------------------------------------

class_color_names <- c('black', 'blue', 'dark gray', 'green', 'magenta', 'orange', 'purple', 'red', 'white', 'yellow')
class_colors <- c('black', 'blue', '#696969', 'green', 'magenta', 'orange', 'purple', 'red', 'white', 'yellow')  # Darker gray

autoplot(output, data = df, fill = 'color', shape = 'class', color = 'color') +  # Fill inside with color and border with color
  scale_fill_manual(values = class_colors, labels = class_color_names) +  # Fill colors for shapes 21-25
  scale_color_manual(values = class_colors, labels = class_color_names) +  # Border colors based on the 'color' column
  scale_shape_manual(values = c(21, 22, 23, 24, 25, 3, 7, 8)) +  # Shapes 21-25 (filled), shapes 3-5 (borders)
  theme_minimal() +
  theme(
    panel.background = element_rect(fill = "lightgray"),  # Set light gray background
    plot.background = element_rect(fill = "white")  # Optional: Set the background of the entire plot to white
  ) +
  guides(
    fill = 'none',  # Hide the fill legend
    color = 'none',  # Hide the color legend
    shape = guide_legend(title = "Class")  # Keep only the shape legend
  )


# Shape by transparency
autoplot(output, data = df, colour = 'color' , shape = 'transparency') + scale_color_manual(values = class_colors)


# PCA by plastic class ----------------------------------------------------

# Split df by plastic class

spectrum_columns <- grep("^spectrum_", names(df), value = TRUE)

df_split <- df %>%
  select(class, color, all_of(spectrum_columns)) %>%
  group_by(class) %>%
  group_split() %>%
  lapply(function(x) select(x, -class))  

# df_split is a list of dataframes

df_class_1 <- df_split[[1]]  
df_class_2 <- df_split[[2]] 
df_class_3 <- df_split[[3]] 
df_class_4 <- df_split[[4]] 
df_class_5 <- df_split[[5]] 
df_class_6 <- df_split[[6]] 
df_class_7 <- df_split[[7]] 
df_class_8 <- df_split[[8]] 

# Loop through each class (df_class_1 to df_class_8)
for (i in 1:1) {
  # Access the data for the current class
  df_class <- get(paste0("df_class_", i))
  
  # Perform PCA (center the data, don't scale)
  output <- prcomp(df_class, center = TRUE, scale. = FALSE)
  
  # Total variance explained
  total_variance <- sum(output$sdev^2)
  cat("Total variance for Class", i, ":", total_variance, "\n")
  
  # Summary of PCA
  cat("Summary for Class", i, ":\n")
  print(summary(output))
  
  # Scree plot
  #screeplot(output, type = "lines", main = paste("Scree Plot for Class", i))
  
  # Principal component scores
  #scores <- output$x
  #cat("PC1 scores for Class", i, ":\n")
  #print(scores[, 1])  # Print PC1 scores
  
  # Loadings for PC1
  #loadings <- output$rotation
  #cat("Loadings for PC1 for Class", i, ":\n")
  #print(loadings[, 1])  # Print loadings for PC1
  
  # Compute correlations between original variables and PC1 scores
  #cor_matrix <- cor(df_class, scores[, 1])
  #cat("Correlations with PC1 for Class", i, ":\n")
  #print(cor_matrix)
  
  autoplot(output) #data=df_class,colour = 'color' )
}


# DISCO-SCA model ---------------------------------------------------------

X1 = X_spectrum[,1:40]
X2 = X_spectrum[,41:80]
X3 = X_spectrum[, 81:120]
X4 = X_spectrum[, 121:160]
X5 = X_spectrum[, 161:200]
X6 = X_spectrum[, 201:240]
X7 = X_spectrum[, 241:280]
X8 = X_spectrum[, 281:331]



X_list = list(X1, X2,X3,X4,X5,X6,X7,X8)


disco_model = disco(X_list, ncomp = 2)
print(scores_disco)
plot(scores(disco_model))

scores_matrix <- as.matrix(scores_df$x)  # Convert to matrix if necessary
scores_df_fixed <- as.data.frame(scores_matrix)  # Convert to data frame


scores_disco = scores(disco_model)
scores_df <- as.data.frame(scores_disco)
write.csv(scores_df_fixed, "disco_scores.csv", row.names = FALSE)

