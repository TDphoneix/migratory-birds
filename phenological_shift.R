library('tidyverse')
library('terra')
library('sf')
library('geodata')
library('Rchelsa')
library('mgcv')

setwd('/home/borshon/Documents/hello/R_r')



bd_extent <- c(80, 92, 20, 26)

dates <- data.frame(
  year = seq(2010,2021,1),
  date_sep = c(
    as.Date('2010-9-1'),
    as.Date('2011-9-1'),
    as.Date('2012-9-1'),
    as.Date('2013-9-1'),
    as.Date('2014-9-1'),
    as.Date('2015-9-1'),
    as.Date('2016-9-1'),
    as.Date('2017-9-1'),
    as.Date('2018-9-1'),
    as.Date('2019-9-1'),
    as.Date('2020-9-1'),
    as.Date('2021-9-1')
  ),
  date_oct = c(
    as.Date('2010-10-1'),
    as.Date('2011-10-1'),
    as.Date('2012-10-1'),
    as.Date('2013-10-1'),
    as.Date('2014-10-1'),
    as.Date('2015-10-1'),
    as.Date('2016-10-1'),
    as.Date('2017-10-1'),
    as.Date('2018-10-1'),
    as.Date('2019-10-1'),
    as.Date('2020-10-1'),
    as.Date('2021-10-1')
  ),
  date_nov = c(
    as.Date('2010-11-1'),
    as.Date('2011-11-1'),
    as.Date('2012-11-1'),
    as.Date('2013-11-1'),
    as.Date('2014-11-1'),
    as.Date('2015-11-1'),
    as.Date('2016-11-1'),
    as.Date('2017-11-1'),
    as.Date('2018-11-1'),
    as.Date('2019-11-1'),
    as.Date('2020-11-1'),
    as.Date('2021-11-1')
  ),
  date_dec = c(
    as.Date('2010-12-1'),
    as.Date('2011-12-1'),
    as.Date('2012-12-1'),
    as.Date('2013-12-1'),
    as.Date('2014-12-1'),
    as.Date('2015-12-1'),
    as.Date('2016-12-1'),
    as.Date('2017-12-1'),
    as.Date('2018-12-1'),
    as.Date('2019-12-1'),
    as.Date('2020-12-1'),
    as.Date('2021-12-1')
  )
)


# date_2010 <- dates %>%
#   filter(year == 2010) %>%
#   select(-year) %>%
#   t() %>%
#   c() %>%
#   as.Date()


## sep data
sep_tas <- getChelsa(
  var = 'tas',
  date = dates$date_sep,
  dataset = "chelsa-monthly",
  coords = bd_bird_sf_centroid
) %>%
  select(
    -time
  ) %>%
  rename(
    sep_tas = 1
  ) %>%
  mutate(
    id = 1:12
  )

sep_tasmin <- getChelsa(
  var = 'tasmin',
  date = dates$date_sep,
  dataset = "chelsa-monthly",
  coords = bd_bird_sf_centroid
) %>%
  select(
    -time
  ) %>%
  rename(
    sep_tasmin = 1
  ) %>%
  mutate(
    id = 1:12
  )

sep_tasmax <- getChelsa(
  var = 'tasmax',
  date = dates$date_sep,
  dataset = "chelsa-monthly",
  coords = bd_bird_sf_centroid
) %>%
  select(
    -time
  ) %>%
  rename(
    sep_tasmax = 1
  ) %>%
  mutate(
    id = 1:12
  )

sep_pr <- getChelsa(
  var = 'pr',
  date = dates$date_sep,
  dataset = "chelsa-monthly",
  coords = bd_bird_sf_centroid
) %>%
  select(
    -time
  ) %>%
  rename(
    sep_pr = 1
  ) %>%
  mutate(
    id = 1:12
  )




## oct data
oct_tas <- getChelsa(
  var = 'tas',
  date = dates$date_oct,
  dataset = "chelsa-monthly",
  coords = bd_bird_sf_centroid
) %>%
  select(
    -time
  ) %>%
  rename(
    oct_tas = 1
  ) %>%
  mutate(
    id = 1:12
  )

oct_tasmin <- getChelsa(
  var = 'tasmin',
  date = dates$date_oct,
  dataset = "chelsa-monthly",
  coords = bd_bird_sf_centroid
) %>%
  select(
    -time
  ) %>%
  rename(
    oct_tasmin = 1
  ) %>%
  mutate(
    id = 1:12
  )

oct_tasmax <- getChelsa(
  var = 'tasmax',
  date = dates$date_oct,
  dataset = "chelsa-monthly",
  coords = bd_bird_sf_centroid
) %>%
  select(
    -time
  ) %>%
  rename(
    oct_tasmax = 1
  ) %>%
  mutate(
    id = 1:12
  )

oct_pr <- getChelsa(
  var = 'pr',
  date = dates$date_oct,
  dataset = "chelsa-monthly",
  coords = bd_bird_sf_centroid
) %>%
  select(
    -time
  ) %>%
  rename(
    oct_pr = 1
  ) %>%
  mutate(
    id = 1:12
  )




### nov data
nov_tas <- getChelsa(
  var = 'tas',
  date = dates$date_nov,
  dataset = "chelsa-monthly",
  coords = bd_bird_sf_centroid
) %>%
  select(
    -time
  ) %>%
  rename(
    nov_tas = 1
  ) %>%
  mutate(
    id = 1:12
  )

nov_tasmin <- getChelsa(
  var = 'tasmin',
  date = dates$date_nov,
  dataset = "chelsa-monthly",
  coords = bd_bird_sf_centroid
) %>%
  select(
    -time
  ) %>%
  rename(
    nov_tasmin = 1
  ) %>%
  mutate(
    id = 1:12
  )

nov_tasmax <- getChelsa(
  var = 'tasmax',
  date = dates$date_nov,
  dataset = "chelsa-monthly",
  coords = bd_bird_sf_centroid
) %>%
  select(
    -time
  ) %>%
  rename(
    nov_tasmax = 1
  ) %>%
  mutate(
    id = 1:12
  )

nov_pr <- getChelsa(
  var = 'pr',
  date = dates$date_nov,
  dataset = "chelsa-monthly",
  coords = bd_bird_sf_centroid
) %>%
  select(
    -time
  ) %>%
  rename(
    nov_pr = 1
  ) %>%
  mutate(
    id = 1:12
  )



nov_tasmax_sample <- getChelsa(
  var = 'tasmax',
  date = dates$date_nov,
  dataset = "chelsa-monthly",
  coords = bd_bird_sf_centroid
) %>%
  mutate(
    id = 1:12,
    time = as.Date(time)
  )


### combining into single frame
ch_frame <- list(sep_tas, sep_tasmax, sep_tasmin, sep_pr, oct_tas, oct_tasmax, oct_tasmin,
                 oct_pr, nov_tas, nov_tasmax, nov_tasmin, nov_pr) %>%
  reduce(
    full_join,
    by = 'id'
  ) %>%
  rowwise() %>%
  mutate(
    mean_tas = mean(c_across(c(sep_tas, oct_tas, nov_tas))),
    mean_pr = mean(c_across(c(sep_pr, oct_pr, nov_pr))),
    mean_tasmax = mean(c_across(c(sep_tasmax, oct_tasmax, nov_tasmax))),
    mean_tasmin = mean(c_across(c(sep_tasmin, oct_tasmin, nov_tasmin))),
    minmin = min(c_across(c(sep_tasmin, oct_tasmin, nov_tasmin))),
    maxmax = max(c_across(c(sep_tasmax, oct_tasmax, nov_tasmax)))
    ) %>%
  ungroup()


write_rds(ch_frame, './ch_frame.rds')

chf <- read_rds('./ch_frame.rds')

#### methods
# bounding box or convex polygon of observations
# centroid taken and monthly climate data taken at centroid
# 
#
#
#
#
#
#

bd_birds_raw <- read_tsv('bd_birds.csv')

birds <- c(
  "Ficedula albicilla", # NO
  "Motacilla alba", # YES
  "Lanius cristatus", # YES
  "Phylloscopus fuscatus", # YES
  "Acrocephalus stentoreus", # YES
  "Acrocephalus dumetorum", # NO
  "Tringa ochropus" # NO
)



# Grassland/semi-grassland /open area/bush/cropland - Brown shrike, blyths reed warbler 
# 
# Wetland- white wagtail, black headed ibis*, northern pintail*, eurasian curlew*  
#   
# Raptor - long legged buzzard* 
#   
# Forest- red throated flycatcher, Dusky warbler,  Olive-backed pipit

birds_grass <- c(
  'Lanius cristatus', # Brown Shrike ( not enough data to be significant, 0.07)
  'Acrocephalus dumetorum' # Blyth reed wrabler (not enough data, showing positive)
)

birds_wet <- c(
  'Motacilla alba', # white wagtail (significant, 0.01)
  'Threskiornis melanocephalus', # black headed ibis (not enough data to be significant, 0.8)
  'Anas acuta', # northern pintail # not enough data to be significant 0.86
  'Numenius arquata' # eurasian curlew # not enough data to be significant 0.93
)

birds_forest <- c(
  'Buteo rufinus', # long legged buzzard (significant but coming late)
  'Ficedula albicilla', # red throated flycatcher ( not significant)
  'Phylloscopus fuscatus', # dusky wrabler (near significant 0.268)
  'Anthus hodgsoni' # olive backed pipit (increasing 0.234)
)

bd_bird <- bd_birds_raw %>%
  select(
    species = "species",
    family,
    long = "decimalLongitude",
    lat = "decimalLatitude",
    edate = "eventDate",
    day,
    month,
    year
  ) %>%
  filter(
    species == birds_forest[3]
  ) %>%
  filter(
    grepl("^\\d{4}-\\d{2}-\\d{2}$", edate)
  ) %>%
  mutate(
    edate = ymd(edate)
  ) %>%
  mutate(
    j_day = yday(edate)
  ) %>%
  mutate(
    season_year = if_else(month(edate) >= 8, year(edate), year(edate) - 1),
    p = 1
  )


bd_bird_sf <- sf::st_as_sf(
  bd_bird,
  coords = c('long','lat'),
  crs = 4326
)

bd_bird_sf_mcv <- bd_bird_sf %>% st_union() %>% st_convex_hull()
bd_bird_sf_centroid <- bd_bird_sf_mcv %>%
  st_centroid() %>%
  st_coordinates() %>%
  as.data.frame()



arrival_dates <- bd_bird %>%
  filter(
    j_day > 244
  ) %>%
  filter(
    year %in% 2010:2021
  ) %>%
  group_by(year) %>%
  summarise(
    a_day = median(j_day)
  ) %>%
  ungroup() %>%
  mutate(
    id = 1:12
  )

wagtail_arrival <- get_arrival(birds_wet[1])
shrike_arrival <- get_arrival(birds_grass[1])
wrabler_arrival <- get_arrival(birds_forest[3])

wagtail_mdl_data <- full_join(chf, wagtail_arrival, by = 'id')
shrike_mdl_data <- full_join(chf, shrike_arrival, by = 'id')
wrabler_mdl_data <- full_join(chf, wrabler_arrival, by = 'id')

## plot arrival to year of all birds

ggplot() +
  geom_point(
    data = wrabler_arrival,
    mapping = aes(x = year, y = a_day),
    color = '#a35400'
  ) +
  geom_smooth(
    data = wrabler_arrival,
    mapping = aes(x = year, y = a_day),
    color = '#a35400',
    fill = '#db7a12',
    method = 'lm',
    se = T
  ) +
  scale_y_continuous(
    limits = c(244,365),
    breaks = seq(244,365,5)
  ) +
  scale_x_continuous(
    limits = c(2010,2021),
    breaks = seq(2010,2021,1)
  ) +
  labs(
    x = 'arrival date (julian day)',
    y = 'years',
    title = 'Wrabler Arrival Date against Year'
  ) +
  theme_minimal()

# "sep_tas"     "id"          "sep_tasmax"  "sep_tasmin" 
# [5] "sep_pr"      "oct_tas"     "oct_tasmax"  "oct_tasmin" 
# [9] "oct_pr"      "nov_tas"     "nov_tasmax"  "nov_tasmin" 
# [13] "nov_pr"      "mean_tas"    "mean_pr"     "mean_tasmax"
# [17] "mean_tasmin" "minmin"      "maxmax"     


mdl_data <- full_join(chf, arrival_dates, by = 'id')

sc_mdl_data <- full_join(chf, arrival_dates, by = 'id') %>%
  select(-id) %>%
  scale() %>%
  as.data.frame()

ggplot(mdl_data, mapping = aes(x = mean_pr, y = a_day)) +
  geom_point(color = 'blue') +
  geom_smooth(
    method = 'lm',
    color = 'darkblue',
    fill = 'green'
  ) +
  scale_y_continuous(limits = c(244,365), breaks = seq(244,365,5)) +
  labs(
    title = paste("Dusky Wrabler"),
    x = "Average Rainfaill from Sept-Nov (Kg per cubic meter)",
    y = "Arrival Date (Julian Days)"
  ) +
  theme_minimal()


summary(
  lm(a_day ~ year, data = mdl_data)
)

mdl <- mgcv::gam(a_day ~ sep_tas + nov_tas + sep_pr, data = sc_mdl_data)

summary(mdl)

gam.check(mdl)

### misc code

birds_summary <- bd_birds_raw %>%
  select(
    species = "species",
  ) %>%
  filter(
    species %in% c(birds_grass, birds_wet, birds_forest)
  ) %>%
  group_by(species) %>%
  summarise(
    a = n()
  )

get_arrival <- function(name) {
  
  bird_data <- bd_birds_raw %>%
    select(
      species = "species",
      family,
      long = "decimalLongitude",
      lat = "decimalLatitude",
      edate = "eventDate",
      day,
      month,
      year
    ) %>%
    filter(
      species == name
    ) %>%
    filter(
      grepl("^\\d{4}-\\d{2}-\\d{2}$", edate)
    ) %>%
    mutate(
      edate = ymd(edate)
    ) %>%
    mutate(
      j_day = yday(edate)
    ) %>%
    mutate(
      season_year = if_else(month(edate) >= 8, year(edate), year(edate) - 1),
      p = 1
    )
  
  arrival_dates <- bird_data %>%
    filter(
      j_day > 244
    ) %>%
    filter(
      year %in% 2010:2021
    ) %>%
    group_by(year) %>%
    summarise(
      a_day = median(j_day)
    ) %>%
    ungroup() %>%
    mutate(
      id = 1:12
    )
  
  arrival_dates
  
}




