#' Create Genius Album url
#'
#' Creates a string containing the url to an album tracklist on Genius.com. The function is used internally to `genius_tracklist()`.
#'
#' @param artist The quoted name of the artist. Spelling matters, capitalization does not.
#' @param album The quoted name of the album Spelling matters, capitalization does not.
#'
#' @examples
#'
#' gen_album_url(artist = "Pinegrove", album = "Cardinal")
#'
#' @export
#' @import dplyr
#' @importFrom stringr str_replace_all

gen_album_url <- function(artist = NULL, album = NULL) {
  artist <- str_replace_all(artist, "[[:punct:]]", "")
  album <- str_replace_all(album, "[[:punct:]]", "")
  base_url <- "https://genius.com/albums/"
  query <- paste(artist,"/", album, sep = "") %>%
    str_replace_all(" ", "-")
  url <- paste0(base_url, query)
  return(url)
}
