# Making a malaria dataset 
set.seed(2022)

## Child ID 
child_id <- paste0("MAL-", seq(1:250))

## Site 
site <- c(rep("Brikama", 20), 
          rep("Essau", 70),
          rep("Farafenni", 40),
          rep("Basse", 60),
          rep("Kuntaur", 60))

## Age in months 
age_months <- round(runif(250, 1, 12*5))

## Sex
sex <- if_else(rbinom(250, 1, 0.5) == 1, "M", "F")

## Bednet
bednet <- if_else(c(rbinom(20, 1, 0.1),
            rbinom(70, 1, 0.7),
            rbinom(40, 1, 0.5),
            rbinom(60, 1, 0.3),
            rbinom(60, 1, 0.9)) == 1, "Yes", "No")

## Malaria
rdt_result <- if_else(if_else(bednet == "Yes", rbinom(250, size = 1, prob = 0.01), 
                                       rbinom(250, size = 1, prob = 0.015*age_months)) == 1, "Positive", "Negative")

## height 
height_cm <- round(rnorm(250, 60, 8) + (age_months * 0.83) + if_else(sex == "M", 0.3, 0), 2)

muac <- round(if_else(rdt_result == "Positive", rnorm(250, 20, 5), 
                                            rnorm(250, 14, 3)), digits = 1)

temp <- round(if_else(rdt_result == "Positive", rnorm(250, 36.7, 2), 
                      rnorm(250, 36.1, 1)), digits = 1)

hb_gdl <- round(if_else(rdt_result == "Positive", rnorm(250, 8, 2), 
                        rnorm(250, 10, 1.5)), digits = 1)


## visit date
visit_date <- as.Date(runif(250, as.Date("2025-04-01"), as.Date("2025-10-01")))

## Collect 

base <- data.frame(child_id = child_id,
                         visit_date = visit_date,
                         site = site,
                         age_months = age_months,
                         sex = sex,
                         height_cm = height_cm, 
                         muac = muac,
                         bednet = bednet,
                         rdt_result = rdt_result,
                         temp = temp,
                         hb_gdl = hb_gdl)

## Errors 
### Repeat one child
u5_malaria <- rbind(base[1:50, ], base[51,], base[51,], base[51,], base[52:250, ])

u5_malaria$sex <- if_else(u5_malaria$site == "Basse" & u5_malaria$sex == "M", "Male", u5_malaria$sex)
u5_malaria$sex <- if_else(u5_malaria$site == "Basse" & u5_malaria$sex == "F", "Female", u5_malaria$sex)

u5_malaria[120, "age_months"] <- 380

u5_malaria[10, "temp"] <- 3.71

u5_malaria[c(20,30,70), "muac"] <- 999

u5_malaria$hb_gdl <- if_else(u5_malaria$site == "Brikama", u5_malaria$hb_gdl * 10, u5_malaria$hb_gdl)

u5_malaria$height_cm[70] <- "this child wasn't at home, we will come back if able later"

u5_malaria$visit_date[10] <- "2021-08-05"

write.csv(u5_malaria, "data/u5_malaria.csv")
