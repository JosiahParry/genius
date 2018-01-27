# Text Analysis with geniusR & tidytext
library(tidyverse)
library(tidytext)
library(geniusR)

# Get DAMN
DAMN <- genius_album(artist = "Kendrick Lamar", album = "DAMN.",  nested = FALSE)
head(DAMN)

# Create term frequency inverse document frequency of a dataset
DAMN %>%
  unnest_tokens(word, text) %>%
  count(title, word, sort = TRUE) %>%
  ungroup() %>%
  bind_tf_idf(word, title, n) %>%
  arrange(-tf_idf)
