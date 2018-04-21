#' Retrieve song lyrics from Genius.com
#'
#' Retrieve the lyrics of a song with supplied artist and song name.
#' @param artist The quoted name of the artist. Spelling matters, capitalization does not.
#' @param song The quoted name of the song. Spelling matters, capitalization does not.
#'@param info Default `"title"`, returns the track title. Set to `"simple"` for only lyrics, `"artist"` for the lyrics and artist, or `"all"` to return the lyrics, artist, and title.
#'
#'
#' @examples
#' genius_lyrics(artist = "Margaret Glaspy", song = "Memory Street")
#' genius_lyrics(artist = "Kendrick Lamar", song = "Money Trees")
#' genius_lyrics("JMSN", "Drinkin'")
#'
#' @export
#' @import dplyr

genius_lyrics <- function(artist = NULL, song = NULL, info = "title") {
  song_url <- gen_song_url(artist, song)
  lyrics <- genius_url(song_url, info)
  return(lyrics)
}
