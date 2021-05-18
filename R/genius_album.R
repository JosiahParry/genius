if(getRversion() >= "2.15.1")  utils::globalVariables(c("track_url", "lyrics"))

#' Retrieve song lyrics for an album
#'
#' Obtain the lyrics to an album in a tidy format.
#'
#' @param artist The quoted name of the artist. Spelling matters, capitalization does not.
#' @param album The quoted name of the album Spelling matters, capitalization does not.
#' @param info Return track level metadata. See details.
#'
#' @details
#' The `info` argument returns additional columns to the returned tibble:
#' `"simple"` returns only the song lyrics.
#' `"title"` returns the track title and lyrics.
#' `"artist"` returns the lyrics and artist.
#' `"features"` returns the lyrics, song elements, and element artists.
#' `"all"` returns all of the above mentioned, plus appends the album name.
#'
#' @examples
#'
#'\dontrun{
#' genius_album(artist = "Petal", album = "Comfort EP")
#' genius_album(artist = "Fit For A King", album = "Deathgrip", info = "all")
#'}
#'
#' @export
#' @import dplyr
#' @importFrom purrr map
#' @importFrom stringr str_replace_all
#' @importFrom tidyr unnest

genius_album <- function(artist = NULL, album = NULL, info = "simple") {

  tracks <-  genius_tracklist(artist, album)

  album <- tracks %>%
    mutate(lyrics = map(track_url, possible_url, info)) %>%
    select(-track_title) %>%
    unnest(lyrics) %>%
    right_join(tracks) %>%
    select(-track_url)

  if(info != "all"){album <- album %>% select(-.data$album_name)}

  album
}
