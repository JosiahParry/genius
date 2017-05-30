genius_url <- function(url) {
  gsub(pattern = "<.*?>", 
       replacement = "\n",
       html_node(
         read_html(url),
         ".lyrics")) %>%
    str_replace_all("\\[.*?\\]|[[:punct:]]", "") %>% 
  read_csv(col_names = "line") %>% 
  na.omit()
}