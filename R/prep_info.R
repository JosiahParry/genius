#' Prepares input strings for `gen_song_url()`
#'
#' Applies a number of regular expressions to prepare the input to match Genius url format
#'
#' @param input Either artist, song, or album, function input.
#'
#'
#' @examples
#' prep_info(artist)
#'
#' @export
#' @importFrom stringr str_replace_all str_trim
#' @import dplyr


prep_info <- function(input) {
  str_replace_all(input,
                c("\\s*\\(Ft.[^\\)]+\\)" = "",
                  "&" = "and",
                  #"-" = " ",
                  #"\\+" = " ",
                  "\\$" = " ",
                  #"/" = " ",
                  #":" = " ",
                  "'" = "",
                  #"," = "",
                  "é" = "e",
                  "ö" = "o",
                  "[[:punct:]]" = "",
                  "[[:blank:]]+" = " ")) %>%
                  str_trim() #%>%
                  # str_replace_all("[[:punct:]]", "")
}
