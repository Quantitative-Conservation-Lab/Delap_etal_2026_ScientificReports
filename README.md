## *Influence of new residential construction varying in housing density on bird species, human tolerance guilds, and communities*

#### Jack H DeLap, John M. Marzluff, and Sarah J Converse 

##### Please contact the first author for questions about the code or data: Jack DeLap (jdelap@seattleu.edu)
##### Secondary contact: Sarah Converse (sconver@usgs.gov)

_______________________________________________________________________________________

## Abstract

Human population growth and changing settlement patterns fuel the development of urban fringe lands worldwide, with implications for biodiversity. We conducted a 12-year study of birds in the fast-developing urban fringe lands of the central Puget Sound region, Washington, USA, to examine the effect of development configuration on birds. We hypothesized that lower-intensity conservation developments, compared to higher-intensity planned community developments, would benefit the overall bird community, as well as native forest birds (avoiders of human development) and avian generalist species (adapters to human development), but that higher-intensity planned community developments would benefit synanthropic species (exploiters of human development). We fit single-species and multi-species occupancy models to test these hypotheses. Consistent with our hypotheses, we found that a greater proportion of the overall community, avoiders, and adapters occupied lower-intensity conservation developments compared to higher-intensity planned community developments. However, we did not detect an effect of development type on the exploiter guild, and we found that species in the exploiter guild are variable in their response to the configuration of suburban developments. We also hypothesized that human tolerance guilds would be a useful predictor of individual species responses to development type. This hypothesis was somewhat supported: we found that, for avoiders, 87% of species in the guild had the same response to development type as the overall guild; for adapters, 63% had the same response as the overall guild, and for exploiters, only 44% had the same response as the overall guild. Our results indicate that the configuration of suburban developments can have a meaningful impact on bird communities, particularly on those species that are most sensitive to any level of development.

### Table of Contents 

Folders include scripts, data, results, and figures. See files listed below. 

### [Scripts](./scripts)

occupancy_guilds.R

occupancy_singlespp.R

process_occupancy_results.R
 
### [Data](./data) 

bird.binary.noCorrRes.csv

### [Results](./results)



### [Figures](./figures)

Adaptor_Figure.png

Avoider_Figure.png

Exploiter_Figure.png

Guilds_Figure.png

### Required Packages and Versions Used 

here (v1.0.1)

tidyr (v1.3.0)

lme4 (v1.1.33)

stringr (v1.5.0)

ggplot2 (v3.4.2)

ggpub4 (v0.6.0)

viridis (v0.6.3)


### Details of Article 

DeLap JH, JM Marzluff, and SJ Converse. In Review. A tale of two suburbs: influence of new residential construction varying in housing density on bird species, human tolerance guilds, and communities. 

### How to Use this Repository 

Run analysis code first, which will create several data objects that can be subsequently run to create figures. Run time for all analyses is >24 hours. 
