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
  cat("<GitHub ",  ">\n", sep = "")
  str(x$content)
  invisible(x)
}
