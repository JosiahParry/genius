#' Retrieve song lyrics from Genius.com
#'
#' Retrieve the lyrics of a song with supplied artist and song name.
#' @param artist The quoted name of the artist. Spelling matters, capitalization does not.
#' @param song The quoted name of the song. Spelling matters, capitalization does not.
#'
#' @examples
#' genius_lyrics(artist = "Margaret Glaspy", song = "Memory Street")
#' genius_lyrics(artist = "Kendrick Lamar", song = "Money Trees")
#' genius_lyrics("JMSN", "Drinkin'")
#'
#' @export
#' @import dplyr

genius_lyrics <- function(artist = NULL, song = NULL) {
  song <- str_replace_all(song, "\\s*\\(Ft.[^\\)]+\\)", "") %>%
    str_replace_all("&", "and") %>%
    str_trim()
  song_url <- gen_song_url(artist, song)
  lyrics <- genius_url(song_url) %>%
    mutate(line = row_number())
  return(lyrics)
}
