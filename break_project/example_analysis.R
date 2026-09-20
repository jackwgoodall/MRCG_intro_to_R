# =====================================================================
# Under-fives malaria & anaemia survey: cleaning and first look
# -----------------------------------------------------------------
# Author:  Jack Goodall
# Date:    2026-09-20
# Purpose: import u5_malaria.csv, clean the data-entry errors, and
#          produce a first summary and figure.
#
# This is a "clean" example of what a finished analysis script might
# look like. It is not a teaching document; the worked_answers page
# explains the reasoning behind each step.
#
# Run from the project root, with the data in a `data/` folder.
# =====================================================================

library(tidyverse)


# ---------------------------------------------------------------------
# 1. Import
# ---------------------------------------------------------------------

u5_malaria <- read_csv("data/u5_malaria.csv")

# read_csv adds an unnamed row-number column from the original file; drop it
u5_malaria <- u5_malaria |>
  select(-1)

# Keep an untouched copy for the before/after comparison at the end
u5_malaria_raw <- u5_malaria


# ---------------------------------------------------------------------
# 2. Initial checks
# ---------------------------------------------------------------------

dim(u5_malaria)
str(u5_malaria)
summary(u5_malaria)

# Text columns
table(u5_malaria$sex)
table(u5_malaria$site)
table(u5_malaria$bednet)
table(u5_malaria$rdt_result)

# Duplicated IDs
table(duplicated(u5_malaria$child_id))


# ---------------------------------------------------------------------
# 3. Clean
#    Every change is recorded with an initialled, dated comment.
# ---------------------------------------------------------------------

# JG 2026-09-20 - MAL-51 entered three times; keep the first, drop the copies.
u5_malaria <- u5_malaria[!duplicated(u5_malaria$child_id), ]

# JG 2026-09-20 - height_cm imported as character because MAL-68 holds a
# free-text note. Coercing to numeric turns that one cell into NA.
u5_malaria$height_cm <- as.numeric(u5_malaria$height_cm)

# JG 2026-09-20 - age of 380 months (~32 yrs) impossible in an under-5s survey.
u5_malaria$age_months[u5_malaria$age_months == 380] <- NA

# JG 2026-09-20 - temp of 3.71 is a slipped decimal for 37.1; corrected.
u5_malaria$temp[u5_malaria$temp == 3.71] <- 37.1

# JG 2026-09-20 - muac of 999 is a "not measured" code, not a measurement.
u5_malaria$muac[u5_malaria$muac == 999] <- NA

# JG 2026-09-20 - Brikama Hb recorded in g/L, ten times too high; convert to g/dL.
u5_malaria$hb_gdl[u5_malaria$site == "Brikama"] <-
  u5_malaria$hb_gdl[u5_malaria$site == "Brikama"] / 10

# JG 2026-09-20 - sex coded inconsistently (Male/Female vs M/F); standardise.
u5_malaria$sex[u5_malaria$sex == "Male"]   <- "M"
u5_malaria$sex[u5_malaria$sex == "Female"] <- "F"

# JG 2026-09-20 - one visit_date predates the survey by four years; cannot
# infer the true date, so set to NA and flag for the field team.
u5_malaria$visit_date[u5_malaria$visit_date < as.Date("2025-01-01")] <- NA

# Confirm the clean has done what was intended
nrow(u5_malaria)      # expect 250
table(u5_malaria$sex) # expect two categories
summary(u5_malaria)


# ---------------------------------------------------------------------
# 4. Derived variables
# ---------------------------------------------------------------------

# Anaemia: haemoglobin below 11 g/dL
u5_malaria <- u5_malaria |>
  mutate(anaemic = if_else(hb_gdl < 11, "Anaemic", "Not anaemic"))


# ---------------------------------------------------------------------
# 5. Summarise
# ---------------------------------------------------------------------

# Key measurements
u5_malaria |>
  summarise(mean_hb   = mean(hb_gdl),
            min_hb    = min(hb_gdl),
            max_hb    = max(hb_gdl),
            mean_temp = mean(temp),
            mean_muac = mean(muac, na.rm = TRUE))

# Children per site
u5_malaria |>
  count(site)

# Haemoglobin by malaria result
u5_malaria |>
  group_by(rdt_result) |>
  summarise(mean_hb = mean(hb_gdl), n = n())

# Anaemia count
table(u5_malaria$anaemic)

# Before / after: what the cleaning changed
mean(u5_malaria_raw$hb_gdl)   # before
mean(u5_malaria$hb_gdl)       # after


# ---------------------------------------------------------------------
# 6. Plot
# ---------------------------------------------------------------------

ggplot(u5_malaria) +
  geom_boxplot(aes(x = rdt_result, y = hb_gdl, fill = rdt_result),
               outliers = FALSE) +
  geom_jitter(aes(x = rdt_result, y = hb_gdl),
              width = 0.2, height = 0, alpha = 0.4) +
  labs(title = "Haemoglobin by malaria test result",
       subtitle = "Children under five, five sites, rainy season 2025",
       x = "Malaria rapid diagnostic test result",
       y = "Haemoglobin (g/dL)") +
  scale_fill_manual(values = c("Negative" = "#685581",
                               "Positive" = "#6E8155")) +
  theme_minimal() +
  theme(legend.position = "none",
        panel.grid.major.x = element_blank())


# ---------------------------------------------------------------------
# 7. Save the cleaned data
# ---------------------------------------------------------------------

write_csv(u5_malaria, "data/u5_malaria_clean.csv")
