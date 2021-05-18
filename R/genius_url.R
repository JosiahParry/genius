if(getRversion() >= "2.15.1")  {

  utils::globalVariables(c("type", "lyric", "line", "meta",
                           "element_artist", "element", "track_title"))
}

#' Use Genius url to retrieve lyrics
#'
#' This function is used inside of the `genius_lyrics()` function. Given a url to a song on Genius, this function returns a tibble where each row is one line. Pair this function with `gen_song_url()` for easier access to song lyrics.
#'
#' @param url The url of song lyrics on Genius
#' @param info Default \code{"title"}, returns the track title. Set to \code{"simple"} for only lyrics, \code{"artist"} for the lyrics and artist, \code{"features"} for song element and the artist of that element,  \code{"all"} to return artist, track, line, lyric, element, and element artist.
#'
#' @examples
#' url <- gen_song_url(artist = "Kendrick Lamar", song = "HUMBLE")
#' genius_url(url)
#'
#' genius_url("https://genius.com/Head-north-in-the-water-lyrics", info = "all")
#'
#' @export
#' @import dplyr
#' @importFrom rvest html_session html_node
#' @importFrom tidyr spread fill separate replace_na
#' @importFrom stringr str_detect str_extract

genius_url <- function(url, info = "title")  {
  # create a new session for scraping lyrics
  session <- html_session(url)

  # Get Artist name
  artist <- html_nodes(session, ".header_with_cover_art-primary_info-primary_artist") %>%
    html_text() %>%
    str_replace_all("\n", "") %>%
    str_trim()

  # Get Song title
  song_title <- html_nodes(session, ".header_with_cover_art-primary_info-title") %>%
    html_text() %>%
    str_replace_all("\n", "") %>%
    str_trim()

  # scrape the lyrics
  lyrics <- # read the text from the lyrics class
    html_node(session, ".lyrics") %>%
    # trim white space
    html_text(trim = TRUE) %>%
    # use named vector for cleaning purposes
    str_replace_all(cleaning()) %>%

    # filter to only rows with content
    .[str_detect(., "[[:alnum:]]")] %>%

    # trim whitespace
    str_trim() %>%

    # Convert to tibble
    tibble(artist = artist,
           track_title = song_title,
           lyric = .) %>%
    mutate(line = row_number()) %>%
    bind_rows(tibble(lyric = c("", "[]"))) %>%
    mutate(type =
             case_when(
               str_detect(lyric, "\\[|\\]") ~ "meta",
               TRUE ~ "lyric")) %>%
    spread(key = type, value = lyric) %>%
    filter(!is.na(line)) %>%
    fill(meta) %>%

    #remove producer info
    #filter(!str_detect(lyric, "[Pp]roducer")) %>%

    #remove brackets
    mutate(meta = str_extract(meta, "[^\\[].*[^\\]]")) %>%

    #make "element" and "artist" columns
    # sections of a song are called an element. Artists are resopnsible for each element
    separate(meta, into = c("element", "element_artist"), sep = ": ", fill = "right") %>%

    #if song has no features
    mutate(element_artist = replace_na(element_artist, artist[1])) %>%

    # filter out NA's from spreading meta
    # this will keep the meta if there are no following lyrics
    # this is helpful to keep track of instrumentals
    group_by(element) %>%

    # if there is only one line (meaning only elemnt info) keep the NA, else drop
    filter(if_else(is.na(lyric) & n() > 1, FALSE, TRUE)) %>%
    ungroup() %>%

    # create new line numbers incase they have been messed up
    mutate(line = row_number())


  switch(info,
         simple = {return(select(lyrics, -artist, -track_title, -element, -element_artist))},
         artist = {return(select(lyrics, -track_title, -element, -element_artist))},
         title = {return(select(lyrics, -artist, -element, -element_artist))},
         features = {return(select(lyrics, -artist, -track_title))},
         all = return(lyrics)
  )

}
