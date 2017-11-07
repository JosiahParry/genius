genius_url <- function(url) {
  session <- html_session(url)
  lyrics <- gsub(pattern = "<.*?>",
                 replacement = "\n",
                 html_node(session, ".lyrics")) %>% 
    read_lines() %>% 
    na.omit()
  # Convert to tibble
  lyrics <- tibble(line = lyrics)
  # Isolate only lines that contain content
  index <- which(str_detect(lyrics$line, "[[:alnum:]]") == TRUE)
  lyrics <- lyrics[index,]
  # Remove lines with things such as [Intro: person & so and so]
  return(lyrics[str_detect(lyrics$line, "\\[|\\]") == FALSE, ])
  
}
