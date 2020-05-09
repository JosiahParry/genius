#' Add lyrics to a data frame
#'
#' This function is to be used to build on a data frame with artist and album/track information. To use the function with a data frame of mixed type (albums and tracks), create another column that specifies type. The type values are `"album"`and `"lyrics"`.
#'
#' @param data This is a dataframe with one column for the artist name, and the other column being either the track title or the album title.
#' @param artist This is the column which has artist title information
#' @param title This is the column that has either album titles, track titles, or both.
#' @param type This is a single value character string of either "album" or "track". This tells the function what kind of lyrics to pull. Alternatively, this can be a column with the value of "album" or "track" associated with each row. "lyric" can be used for backward compatibility.
#'
#' @examples
#' \donttest{
#' # Albums only
#'
#' artist_albums <- tibble::tribble(
#'  ~artist, ~album,
#'  "J. Cole", "KOD",
#'  "Sampha", "Process"
#')
#'
#'add_genius(artist_albums, artist, album)
#'
#' # Individual Tracks only
#'
#' artist_songs <- tibble::tribble(
#'  ~artist, ~track,
#'  "J. Cole", "Motiv8",
#'  "Andrew Bird", "Anonanimal"
#' )
#'
#'add_genius(artist_songs, artist, track, type = "track")
#'}
#'
#' # Tracks and Albums
#' mixed_type <- tibble::tribble(
#'   ~artist, ~album, ~type,
#'   "J. Cole", "KOD", "album",
#'   "Andrew Bird", "Proxy War", "track"
#' )
#'
#'add_genius(mixed_type, artist, album, type)
#'
#' @export
#' @importFrom dplyr filter mutate bind_rows inner_join
#' @importFrom tibble as_tibble
#' @importFrom tidyr unnest
#' @importFrom rlang enquo
#' @importFrom purrr map2

add_genius <- function(data, artist, title, type = c("album", "track", "lyrics")) {
  genius_funcs <- list(album = possible_album, lyrics = possible_lyrics)
  artist <- enquo(artist)
  title <- enquo(title)
  type <- enquo(type)

  songs <- filter(data, !!type %in% c("lyrics", "track"))
  albums <- filter(data, !!type == "album")

  song_lyrics <- mutate(songs, lyrics = map2(.x = !!artist, .y = !!title, genius_funcs[["lyrics"]]))
  album_lyrics <- mutate(albums, lyrics = map2(.x = !!artist, .y = !!title, genius_funcs[["album"]]))


  bind_rows(
    album_lyrics %>%
      unnest(lyrics),
    song_lyrics %>%
      unnest(lyrics)
  ) %>%
    inner_join(data) %>%
    as_tibble()


  }
