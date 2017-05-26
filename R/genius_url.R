require(rvest)

genius_url <- function(url) {
  gsub(pattern = "<.*?>", 
       replacement = "\n",
       html_node(
         read_html(url),
         ".lyrics")) %>%
  read_csv(col_names = "line") %>% 
  na.omit() %>%
  mutate(line_num = row_number())
}