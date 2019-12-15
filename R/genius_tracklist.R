if(getRversion() >= "2.15.1")  utils::globalVariables(c("track_n"))


#' Create a tracklist of an album
#'
#' Creates a `tibble` containing all track titles for a given artist and album. This function is used internally in `genius_album()`.
#'
#' @param artist The quoted name of the artist. Spelling matters, capitalization does not.
#' @param album The quoted name of the album Spelling matters, capitalization does not.
#'
#' @examples
#'
#' genius_tracklist(artist = "Andrew Bird", album = "Noble Beast")
#'
#' @export
#' @import dplyr
#' @importFrom rvest html_session html_nodes html_text html_attr
#' @importFrom stringr str_replace_all str_trim

genius_tracklist <- function(artist = NULL, album = NULL) {
  url <- gen_album_url(artist, album)
  session <- html_session(url)

  # Get the album name
  album_name <- html_nodes(session, ".header_with_cover_art-primary_info-title") %>%
    html_text()

  # Get track numbers
  # Where there are no track numbers, it isn't a song
  track_numbers <- html_nodes(session, ".chart_row-number_container-number") %>%
    html_text() %>%
    str_replace_all("\n", "") %>%
    str_trim()

  # Get all titles
  # Where there is a title and a track number, it isn't an actual song
  track_titles <- html_nodes(session, ".chart_row-content-title") %>%
    html_text() %>%
    str_replace_all("\n","") %>%
    str_replace_all("Lyrics", "") %>%
    str_trim()

  # Get all song urls
  track_url <- html_nodes(session, ".u-display_block") %>%
    html_attr('href') %>%
    str_replace_all("\n", "") %>%
    str_trim()

  # Create df for easy filtering
  # Filter to find only the actual tracks, the ones without a track number were credits / booklet etc
  df <- tibble(
    album_name = album_name,
    track_title = track_titles,
    track_n = as.integer(track_numbers),
    track_url = track_url
  ) %>%
    filter(track_n > 0)

  return(df)
}
