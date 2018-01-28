# Text Analysis with geniusR & tidytext
library(tidyverse)
library(tidytext)
library(geniusR)


'%!in%' <- function(x,y)!('%in%'(x,y))
# Get DAMN
DAMN <- genius_album(artist = "Kendrick Lamar", album = "DAMN.",  nested = FALSE)
head(DAMN)

# Sentiment
DAMN %>%
  unnest_tokens(word, text) %>%
  count(title, word, sort = TRUE) %>%
  ungroup() %>%
  bind_tf_idf(word, title, n) %>%
  arrange(-tf_idf) %>%
  inner_join(get_sentiments("bing"), by = c(word = "word")) %>%
  count(sentiment, word, wt = n) %>%
  filter(nn >= 5,
         word %!in% c("like", "well")) %>%
  mutate(n = ifelse(sentiment == "negative", -nn, nn)) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_bar(stat = "identity") +theme_minimal() + coord_flip() + scale_fill_manual(values = c("#FFCCD1", "#A9B1FF")) + theme(legend.position = "bottom")


## Create tf_idf
# Document is each song
damn_tf_idf <- DAMN %>%
  unnest_tokens(word, text) %>%
  count(title, word, sort = TRUE) %>%
  ungroup() %>%
  bind_tf_idf(word, title, n) %>%
  arrange(-tf_idf)


damn_tf_idf %>%
  group_by(title) %>%
  top_n(3, (tf_idf)) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, tf_idf)) + geom_bar(stat = "identity") +
  facet_wrap(~title, scales = "free", ncol = 2) + coord_flip()
