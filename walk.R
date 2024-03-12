library(dplyr)

list_1 <- penguins %>% 
  group_by(species) %>% 
  group_split(.keep=T)

# each element in list is a df with a difference species 
lapply(list_1, function(x) unique(x$species))

by_factor_lm <- function(df) {
  df <- na.omit(df[, c("bill_length_mm", "body_mass_g", "sex")])
  model <- lm(bill_length_mm ~ body_mass_g + sex, data = df)
  coef(model)
}

(results <- purrr::map(list_1, by_factor_lm_simplified))
df_per_model <- walk(.x = list_1, .f = by_factor_lm_simplified)
all.equal(df_per_model,list_1)


