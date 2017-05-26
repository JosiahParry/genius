genius_search <- function(artist = NULL, song = NULL, ...) {
  base_url <- "http://genius.com/search"
  # headers
  headers <- add_headers(Accept = "application/json",
                         Host = "api.genius.com",
                         Authorization = paste("Bearer", client_access_token))
  # create a query with given parameters
  query <- paste(artist, song, ..., sep = "+") %>%
    stringr::str_replace_all(" ", "+")
  url <- paste(base_url,"?q=", query, sep = "")
  response <- GET(url, headers)
  #parse the response
  parsed <- jsonlite::fromJSON(content(response, "text"),
                     simplifyVector = FALSE)
  
  if (http_error(response)) {
    stop(
      # creating stop message
      sprintf(
        "Genius API request failed [%s]\n%s\n<%s>",
        status_code(response),
        parsed$message, #when it fails there will be a message in the parsed object 
        parsed$documentation_url
      ),
      call. = FALSE
    )
  }
  structure(
    list(
      content = parsed,
      response = response
    ), 
    class = "genius_api"
  )
  print(url)
  return(parsed)
}


# creating a class function
print.genius_api <- function(x, ...) {
  cat("<Genius ",  ">\n", sep = "")
  str(x$content)
  invisible(x)
}

test <- genius_search(artist = "Twenty one pilots", song = "car radio")
artist <- "twenty one pilots"
for (hit in test$response$hits) {
  print(str_detect(hit$result$primary_artist, artist))
  if (hit$type == "song" && str_detect(hit$result$primary_artist$name, artist) == TRUE) {
    song_info <- hit$result
  } 
  break
}




song_info <- NULL
for (hit in test$response$hits) {
  if (hit == "The Decemberists" & hit$result$title == "Lake Song") {
    song_info <- hit
  }
  break
}  
  
  hit["result"]["primary_artist"]["name"] == artist_name:
  song_info = hit
break
}

test$response$hits$type

