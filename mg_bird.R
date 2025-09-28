library(tidyverse)
library(CoordinateCleaner)
library(terra)
library(sf)
library(geodata)

setwd("/home/borshon/Documents/r_prac/mg_birds") # set dir to where bd_birds_2010_2025.csv is saved


mg_raw <- read_tsv("bd_birds_2010_2025.csv") # https://www.gbif.org/occurrence/download/0015493-250920141307145



## list of commonly occuring migratory birds of BD
# * Taiga flycatcher "Ficedula albicilla" 
# Gray headed lapwing "Vanellus cinereus"
# Asian brown flycatcher "Muscicapa dauurica"
# * White wagtail "Motacilla alba" 
# Yellow wagtail "Motacilla flava"
# * Brown shrike "Lanius cristatus" 
# * Dusky warbler "Phylloscopus fuscatus"
# Common Sandpiper "Actitis hypoleucos"
# * Clamorous reed warbler "Acrocephalus stentoreus"
# * Blyth reed warbler "Acrocephalus dumetorum"
# Common snipe "Gallinago gallinago"
# * Green Sandpiper "Tringa ochropus"
# Little ringed plover "Charadrius dubius"
# * Little stint "Calidris minuta"
# Temminck stint "Calidris temminckii"
##


birds <- c(
  "Ficedula albicilla",
  "Motacilla alba",
  "Lanius cristatus",
  "Phylloscopus fuscatus",
  "Acrocephalus stentoreus",
  "Acrocephalus dumetorum",
  "Tringa ochropus"
)


### run the below code for every bird in the birds vector ###

bird <- birds[1]


mg <- mg_raw %>%
  select(
    species = "species",
    family,
    long = "decimalLongitude",
    lat = "decimalLatitude",
    edate = "eventDate",
    day,
    month,
    year,
    id_date = "dateIdentified"
  ) %>%
  filter(
    species == bird
  ) %>%
filter(
  grepl("^\\d{4}-\\d{2}-\\d{2}$", edate)
) %>%
  mutate(
    edate = ymd(edate)
  ) %>%
  mutate(
    season_year = if_else(month(edate) >= 8, year(edate), year(edate) - 1)
  )

nrow(mg) # to check number of observations


# creating seasonal day and seasonal span during seasonal year
mg_seasonal <- mg %>%
  mutate(
    month_num = month(edate)
  ) %>%
  group_by(season_year) %>%
  summarise(
    first_sighting = {
      tmp <- edate[month_num %in% c(8:12, 1)]
      if (length(tmp) == 0) NA else min(tmp)
    },
    last_sighting = {
      tmp <- edate[month_num %in% 2:7]
      if (length(tmp) == 0) NA else max(tmp)
    },
    .groups = "drop"
  ) %>%
  mutate(
    first_sighting_seasonal = ifelse(!is.na(first_sighting),
      as.integer(difftime(first_sighting,
        as.Date(paste0(season_year, "-08-01")),
        units = "days"
      )) + 1,
      NA
    ),
    last_sighting_seasonal = ifelse(!is.na(last_sighting),
      as.integer(difftime(last_sighting,
        as.Date(paste0(season_year, "-08-01")),
        units = "days"
      )) + 1,
      NA
    )
  ) %>%
  mutate(
    span = last_sighting_seasonal - first_sighting_seasonal
  )



### calculating avg shift in first sighting, last sighting

mg_avg_first_shift <- mg_seasonal %>%
  arrange(season_year) %>%
  mutate(
    shift = first_sighting_seasonal - lag(first_sighting_seasonal)
  ) %>%
  summarise(
    avg_shift = mean(shift, na.rm = T)
  ) %>%
  as.numeric()

mg_avg_last_shift <- mg_seasonal %>%
  arrange(season_year) %>%
  mutate(
    shift = last_sighting_seasonal - lag(last_sighting_seasonal)
  ) %>%
  summarise(
    avg_shift = mean(shift, na.rm = T)
  ) %>%
  as.numeric()

####




### code for creating plot

mg_seasonal_long <- mg_seasonal %>%
  tidyr::pivot_longer(
    cols = c(first_sighting_seasonal, last_sighting_seasonal),
    names_to = "type",
    values_to = "doy"
  )


# plot
ggplot(mg_seasonal_long, aes(x = season_year, y = doy, color = type)) +
  geom_point(size = 3) +
  geom_line() +
  scale_color_manual(
    values = c('first_sighting_seasonal' = "#51f0b8", "last_sighting_seasonal" = "#ffc403")
  ) +
  scale_x_continuous(
    breaks = seq(2009, 2025, 1)
  ) +
  scale_y_continuous(
    limits = c(0, 365),
    breaks = seq(0, 365, 10)
  ) +
  labs(
    title = paste("change in first and last sighting of", bird),
    x = "Seasonal Year (Aug → Jul)",
    y = "Seasonal Day (Aug 1 = 1, July 31 = 365)",
    color = "Sighting on Seasonal Year"
  ) +
  theme_classic()


## misc code



