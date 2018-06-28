possible_album <- possibly(genius_album, otherwise = as_tibble())
possible_lyrics <- possibly(genius_lyrics, otherwise = as_tibble())

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
