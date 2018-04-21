#' Retrieve song lyrics for an album
#'
#' Obtain the lyrics to an album in a tidy format.
#'
#' @param artist The quoted name of the artist. Spelling matters, capitalization does not.
#' @param album The quoted name of the album Spelling matters, capitalization does not.
#' @param info Return extra information about each song. Default `"simple"` returns `title`, `track_n`, and `text`. Set `info = "artist"` for artist and track title. See args to `genius_lyrics()`.
#'
#' @examples
#'
#' genius_album(artist = "Petal", album = "Comfort EP")
#' genius_album(artist = "Fit For A King", album = "Deathgrip")
#'
#' @export
#' @import dplyr
#' @importFrom purrr map
#' @importFrom stringr str_replace_all
#' @importFrom tidyr unnest

genius_album <- function(artist = NULL, album = NULL, info = "simple") {

  # Obtain tracklist from genius_tracklist
  tracks <-  genius_tracklist(artist, album)

  album <- tracks %>%

    # Iterate over the url to the song title
    mutate(lyrics = map(track_url, genius_url, info)) %>%

    # Unnest the tibble with lyrics
    unnest(lyrics) %>%
    right_join(tracks) %>%
    select(-track_url)



  return(album)
}
