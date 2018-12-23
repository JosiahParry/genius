#' Form of genius_album that can handle errors
#' @importFrom purrr possibly
#' @importFrom tibble as_tibble
#' @export
possible_album <- possibly(genius_album, otherwise = as_tibble())

#' Form of genius_lyrics that can handle errors
#' @importFrom purrr possibly
#' @importFrom tibble as_tibble
#' @export
possible_lyrics <- possibly(genius_lyrics, otherwise = as_tibble())


#' Prepares input strings for `gen_song_url()`
#'
#' Applies a number of regular expressions to prepare the input to match Genius url format
#'
#' @param input Either artist, song, or album, function input.
#' @export
prep_info <- function(input) {
  str_replace_all(input,
                  c("\\s*\\(Ft.[^\\)]+\\)" = "",
                    "&" = "and",
                    #"-" = " ",
                    #"\\+" = " ",
                    "\\$" = " ",
                    #"/" = " ",
                    #":" = " ",
                    #"'" = "",
                    #"," = "",
                    "é" = "e",
                    "ö" = "o",
                    "[[:punct:]]" = " ",
                    "[[:blank:]]+" = " ")) %>%
    str_trim() #%>%
  # str_replace_all("[[:punct:]]", "")
}


#' vector used for cleaning lines from urls
# vector for cleaning names
cleaning <- function() {
    clean_vec <- c("([a-z0-9]{2,})([[:upper:]])" = "\\1\n\\2", # turn camel case into new lines
    "(\\]|\\))([[:upper:]])" = "\\1\n\\2", # letters immediately after closing brackets new lines
    # brackets with producer info into new lines
    "(\\[.{2,100}\\])" ="\n\\1\n",
    # rip smart quotes
    "’" = "'",
    # if quotes follow or precede brackets fix lines
    "(\\])(\")" = "\\1\n\\2",
    "(\")(\\[)" = "\\1\n\\2",
    # if a question mark directly touches a word or number make new lines
    "(\\?)([[:alpha:]])" = "\\1\n\\2")

    return(clean_vec)
}

