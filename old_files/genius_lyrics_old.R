# genius_lyrics <- function(artist = NULL, song = NULL, access_token = NULL, simple = FALSE, ...) {
#   base_url <- "http://genius.com/search"
#   # headers
#   headers <- add_headers(Accept = "application/json",
#                          Host = "api.genius.com",
#                          Authorization = paste("Bearer", access_token))
#   # create a query with given parameters
#   query <- paste(artist, song, ..., sep = "+") %>%
#     stringr::str_replace_all(" ", "+")
#   url <- paste(base_url,"?q=", query, sep = "")
#   response <- GET(url, headers)
#   #parse the response
#   parsed <- jsonlite::fromJSON(content(response, "text"),
#                                simplifyVector = FALSE)
#
#   if (http_error(response)) {
#     stop(
#       # creating stop message
#       sprintf(
#         "Genius API request failed [%s]\n%s\n<%s>",
#         status_code(response),
#         parsed$message, #when it fails there will be a message in the parsed object
#         parsed$documentation_url
#       ),
#       call. = FALSE
#     )
#   }
#   structure(
#     list(
#       content = parsed,
#       response = response
#     ),
#     class = "genius_api"
#   )
#
#   song_url <- NULL
#   for (hit in parsed$response$hits) {
#     #print(str_detect(hit$result$primary_artist, ignore.case(artist)))
#     if (hit$type == "song" && str_detect(hit$result$primary_artist$name,
#                                          coll(artist, ignore_case = TRUE)) == TRUE) {
#       song_url <- hit$result$url
#       song_title <- hit$result$title
#       song_artist <- hit$result$primary_artist$name
#     }
#     break
#   }
#   if (simple == TRUE) {
#    return(genius_url(song_url))
#   } else {
#     return(genius_url(song_url) %>%
#              mutate(line_num = row_number(),
#                     song = song_title,
#                     artist = song_artist))
#     }
# }
#
