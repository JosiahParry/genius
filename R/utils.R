#' Form of genius_album that can handle errors
#' @param ... arguments that would be passed to `genius_album()`
#' @importFrom purrr possibly
#' @importFrom tibble as_tibble
#' @export
possible_album <- quietly(possibly(genius_album, otherwise = as_tibble()))

#' Form of genius_lyrics that can handle errors
#' @param ... arguments that would be passed to `genius_lyrics()`
#' @importFrom purrr possibly
#' @importFrom tibble as_tibble
#' @export
possible_lyrics <- quietyly(possibly(genius_lyrics, otherwise = as_tibble()))


#' Form of genius_url that can handle errors
#' @param ... arguments that would be passed to `genius_url()`
#' @importFrom purrr possibly
#' @importFrom tibble as_tibble
#' @export
possible_url <- possibly(genius_url, otherwise = as_tibble())


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
                    "\u00E9" = "e",
                    "\u00F6" = "o",
                    "\u00F8" = "",
                    "[[:punct:]]" = " ",
                    "[[:blank:]]+" = " ")) %>%
    str_trim()
}


#' Function which produces a vector to be used in string cleaning from scraping there are a lot of hard coded values in here and will need to be adapted for the weird nuances.
cleaning <- function() {
    # putting randomblackdude in here because I can't figure out a regex for him and he's throwing me off
    clean_vec <- c("([^RandomBlackDude][a-z0-9]{2,})([[:upper:]])" = "\\1\n\\2", # turn camel case into new lines
    "(\\]|\\))([[:upper:]])" = "\\1\n\\2", # letters immediately after closing brackets new lines
    # brackets with producer info into new lines
    "(\\[.{2,100}\\])" ="\n\\1\n",
    # rip smart quotes
    "\u2019" = "'",
    # if quotes follow or precede brackets fix lines
    "(\\])(\")" = "\\1\n\\2",
    "(\")(\\[)" = "\\1\n\\2",
    # if a question mark directly touches a word or number make new lines
    "(\\?)([[:alpha:]])" = "\\1\n\\2",
    # roger waters, you're a pain: comfortably numb, issue # 4
    # https://github.com/JosiahParry/genius/issues/4
    "(\\])(\\[)" = "\\1\n\\2")

    return(clean_vec)
}




