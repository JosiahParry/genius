genius_url <- function(url) {
  
  session <- html_session(url)
  lyrics <- gsub(pattern = "<.*?>",
                 replacement = "\n",
                 html_node(session, ".lyrics")) %>% 
    str_replace_all("\\[.*?\\]|[[:punct:]]", "") %>% 
    read_csv(col_names = "line") %>% 
    na.omit()
  index <- which(str_detect(lyrics$line, "[[:alnum:]]") == TRUE)
  return(lyrics[index,])
  
}