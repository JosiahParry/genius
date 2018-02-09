#' Retrieve song lyrics for an album
#'
#' Obtain the lyrics to an album in a tidy format.
#'
#' @param artist The quoted name of the artist. Spelling matters, capitalization does not.
#' @param album The quoted name of the album Spelling matters, capitalization does not.
#'
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

genius_album <- function(artist = NULL, album = NULL) {

  # Obtain tracklist from genius_tracklist
  album <- genius_tracklist(artist, album) %>%

    # Iterate over the url to the song title
    mutate(lyrics = map(track_url, genius_url)) %>%

    # Unnest the tibble with lyrics
    unnest(lyrics) %>%

    # Select the desired columns
    select(artist, title = title1, track_n, text)

}
