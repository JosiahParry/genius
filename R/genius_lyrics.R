#' Retrieve song lyrics from Genius.com
#'
#' Retrieve the lyrics of a song with supplied artist and song name.
#' @param artist The quoted name of the artist. Spelling matters, capitalization does not.
#' @param song The quoted name of the song. Spelling matters, capitalization does not.
#' @param info Default \code{"title"}, returns the track title. Set to \code{"simple"} for only lyrics, \code{"artist"} for the lyrics and artist, \code{"features"} for song element and the artist of that element,  \code{"all"} to return artist, track, line, lyric, element, and element artist.
#'
#'
#' @examples
#' \donttest{
#' # genius_lyrics(artist = "Margaret Glaspy", song = "Memory Street")
#' # genius_lyrics(artist = "Kendrick Lamar", song = "Money Trees")
#' # genius_lyrics("JMSN", "Drinkin'")
#'}
#' @export
#' @import dplyr

genius_lyrics <- function(artist = NULL, song = NULL, info = "title") {
  song_url <- gen_song_url(artist, song)

  genius_url(song_url, info)

}
