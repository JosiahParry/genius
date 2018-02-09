#' Use Genius url to retrieve lyrics
#'
#' This function is used inside of the `genius_lyrics()` function. Given a url to a song on Genius, this function returns a tibble where each row is one line. Pair this function with `gen_song_url()` for easier access to song lyrics.
#' @param url The url of song lyrics on Genius
#'
#' @examples
#' url <- gen_song_url(artist = "Kendrick Lamar", song = "HUMBLE")
#' genius_url(url)
#'
#' genius_url("https://genius.com/Head-north-in-the-water-lyrics")
#'
#' @export
#' @import dplyr
#' @importFrom rvest html_session html_node
#' @importFrom stringr str_detect
#' @importFrom readr read_lines

genius_url <- function(url) {

  # Start a new session
  session <- html_session(url)

  # Clean the song lyrics
  lyrics <- gsub(pattern = "<.*?>",
                 replacement = "\n",
                 html_node(session, ".lyrics")) %>%
    read_lines() %>%
    na.omit()

  # Artist
  artist <- html_nodes(session, ".header_with_cover_art-primary_info-primary_artist") %>%
    html_text() %>%
    str_replace_all("\n", "") %>%
    str_trim()

  # Song title
  song_title <- html_nodes(session, ".header_with_cover_art-primary_info-title") %>%
    html_text() %>%
    str_replace_all("\n", "") %>%
    str_trim()

  # Convert to tibble
  lyrics <- tibble(artist = artist,
                   title = song_title,
                   text = lyrics)

  # Isolate only lines that contain content
  index <- which(str_detect(lyrics$text, "[[:alnum:]]") == TRUE)
  lyrics <- lyrics[index,]

  # Remove lines with things such as [Intro: person & so and so]
  return(lyrics[str_detect(lyrics$text, "\\[|\\]") == FALSE, ])

}
