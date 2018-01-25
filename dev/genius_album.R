# Genius Album function
# To search full albums and get the lyrics in a functional format

# Test album 
url <- html_session("https://genius.com/albums/Kendrick-lamar/Good-kid-m-a-a-d-city")

# Get song number
# if track number is empty, we know it is a lyric book or something
html_nodes(url, ".chart_row-number_container-number") %>% 
  html_text()

# These are the actual song titles
# Only the first few words are relevant, things in brackets or parenthesis 
# are irrelevant for url making
html_nodes(url, ".chart_row-content-title") %>% 
  html_text() %>% 
  str_split("\n")