genius_lyrics <- function(artist = NULL, song = NULL) {
  song_url <- gen_song_url(artist, song)
  lyrics <- genius_url(song_url)
  return(lyrics)
}
