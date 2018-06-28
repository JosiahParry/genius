#' Add lyrics to a data frame
#'
#' This function is to be used to build on a data frame with artist and album/track information. Ideal via the spotifyr package.
#'
#' @param data This is a dataframe with one column for the artist name, and the other column being either the track title or the album title.
#' @param artist This is the column which has artist title information
#' @param type_group This is the column that has either album titles or track titles.
#' @param type This is a single value character string of either `"album"` or `"lyrics"`. This tells the function what kind of lyrics to pull. This needs to be in line with `type_group`
#'
#' @examples
#' Example with 2 different artists and albums
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
#'
#' Example with 2 different artists and songs
#' artist_songs <- tribble(
#'  ~artist, ~track,
#'  "J. Cole", "Motiv8",
#'  "Andrew Bird", "Anonanimal"
#' )

#' artist_songs %>%
#'  add_genius(artist, track, type = "lyrics")

#'
#' @export
#' @import dplyr
#'
#'

add_genius <- function(data, artist, type_group, type = "album") {
    genius_funcs <- list(album = possible_album, lyrics = possible_lyrics)
    artist <- enquo(artist)
    type_group <- enquo(type_group)

    data %>%
        distinct(!!artist, !!type_group) %>%
        mutate(lyrics = map2(!!artist, !!type_group,  genius_funcs[[type]])) %>%
    inner_join(data) %>%
      unnest() %>%
      # nest(artist_uri, album_uri, .key = "uris") %>%
      # nest(album_img, album_type, is_collaboration,
      #      album_release_date, album_release_year, .key = "meta") %>%
      as_tibble() %>%
      return()
}

