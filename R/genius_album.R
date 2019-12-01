if(getRversion() >= "2.15.1")  utils::globalVariables(c("track_url", "lyrics"))

#' Retrieve song lyrics for an album
#'
#' Obtain the lyrics to an album in a tidy format.
#'
#' @param artist The quoted name of the artist. Spelling matters, capitalization does not.
#' @param album The quoted name of the album Spelling matters, capitalization does not.
#' @param info Return extra information about each song. Default `"simple"` returns title`, `track_n`, and `text`. Set `info = "artist"` for artist and track title and `info = "all"` for all possible columns plus adds the album name. See args to `genius_lyrics()`.
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

  if(info != "all"){album <- album %>% select(-album_name)}

  return(album)
}
