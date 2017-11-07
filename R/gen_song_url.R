# Generates the url for a song given an artist and a song title

gen_song_url <- function(artist = NULL, song = NULL) {
  base_url <- "https://genius.com/"
  query <- paste(artist, song, "lyrics", sep = "-") %>% 
    str_replace_all(" ", "-")
  url <- paste0(base_url, query)
  return(url)
}
