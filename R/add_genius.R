#' Add lyrics to a data frame
#'
#' This function is to be used to build on a data frame with artist and album/track information. Ideal via the spotifyr package.
#'
#' @param data This is a dataframe with one column for the artist name, and the other column being either the track title or the album title.
#' @param artist This is the column which has artist title information
#' @param title This is the column that has either album titles, track titles, or both.
#' @param type This is a single value character string of either "album" or "lyrics". This tells the function what kind of lyrics to pull. Alternatively, this can be a column with the value of "album" or "lyrics" associated with each row.
#'
#' @examples
#' \donttest{
#' artist_albums <- tribble(
#'  ~artist, ~album,
#'  "J. Cole", "KOD",
#'  "Sampha", "Process"
#')
#'
#'
#'artist_albums %>%
#'  add_genius(artist, album)
#'

#' artist_songs <- tribble(
#'  ~artist, ~track,
#'  "J. Cole", "Motiv8",
#'  "Andrew Bird", "Anonanimal"
#' )
#'
#' artist_songs %>%
#'  add_genius(artist, track, type = "lyrics")
#'}
#'
#' @export
#' @import dplyr
#' @import purrr
#'
#'

add_genius <- function(data, artist, title, type = "album") {
  genius_funcs <- list(album = possible_album, lyrics = possible_lyrics)
  artist <- enquo(artist)
  title <- enquo(title)
  type <- enquo(type)

  songs <- filter(data, type == "lyrics")
  albums <- filter(data, type == "album")

  song_lyrics <- mutate(songs, lyrics = map2(.x = !!artist, .y = !!title, genius_funcs[["lyrics"]]))
  album_lyrics <- mutate(albums, lyrics = map2(.x = !!artist, .y = !!title, genius_funcs[["album"]]))

  bind_rows(song_lyrics, album_lyrics) %>%
    inner_join(data) %>%
    unnest() %>%
    as_tibble() %>%
    return()

}
