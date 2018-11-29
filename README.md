Quickstart: geniusR
================
Josiah Parry
2/12/2018

# Overview

This package was created to provide an easy method to access lyrics as
text data using the website [Genius](genius.com).

## Installation

This package must be installed from GitHub.

``` r
devtools::install_github("josiahparry/geniusR")
```

Load the package:

``` r
library(geniusR)
```

    ## Loading required package: dplyr

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
suppressPackageStartupMessages(library(tidyverse)) # For manipulation
```

# Getting Lyrics

## Whole Albums

`genius_album()` allows you to download the lyrics for an entire album
in a `tidy` format. There are two arguments `artists` and `album`.
Supply the quoted name of artist and the album (if it gives you issues
check that you have the album name and artists as specified on
[Genius](https://genius.com)).

This returns a tidy data frame with three columns:

  - `title`: track name
  - `track_n`: track number
  - `text`:
lyrics

<!-- end list -->

``` r
emotions_math <- genius_album(artist = "Margaret Glaspy", album = "Emotions and Math")
```

    ## Joining, by = c("track_title", "track_n", "track_url")

``` r
emotions_math
```

    ## # A tibble: 372 x 4
    ##    track_title       track_n lyric                                   line
    ##    <chr>               <int> <chr>                                  <int>
    ##  1 Emotions And Math       1 Oh when I got you by my side               1
    ##  2 Emotions And Math       1 Everything's alright                       2
    ##  3 Emotions And Math       1 Its just when your gone                    3
    ##  4 Emotions And Math       1 I start to snooze the alarm                4
    ##  5 Emotions And Math       1 Cause I stay up until 4 in the morning     5
    ##  6 Emotions And Math       1 Counting all the days 'til you're back     6
    ##  7 Emotions And Math       1 Shivering in an ice cold bath              7
    ##  8 Emotions And Math       1 Of emotions and math                       8
    ##  9 Emotions And Math       1 Oh it's a shame                            9
    ## 10 Emotions And Math       1 And I'm to blame                          10
    ## # ... with 362 more rows

## Multiple Albums

If you wish to download multiple albums from multiple artists, try and
keep it tidy and avoid binding rows if you can. We can achieve this in a
tidy workflow by creating a tibble with two columns: `artist` and
`album` where each row is an artist and their album. We can then iterate
over those columns with `purrr:map2()`.

In this example I will extract 3 albums from Kendrick Lamar and Sara
Bareilles (two of my favotire musicians). The first step is to create
the tibble with artists and album titles.

``` r
albums <-  tibble(
  artist = c(
    rep("Kendrick Lamar", 3), 
    rep("Sara Bareilles", 3)
    ),
  album = c(
    "Section 80", "Good Kid, M.A.A.D City", "DAMN.",
    "The Blessed Unrest", "Kaleidoscope Heart", "Little Voice"
    )
)

albums
```

    ## # A tibble: 6 x 2
    ##   artist         album                 
    ##   <chr>          <chr>                 
    ## 1 Kendrick Lamar Section 80            
    ## 2 Kendrick Lamar Good Kid, M.A.A.D City
    ## 3 Kendrick Lamar DAMN.                 
    ## 4 Sara Bareilles The Blessed Unrest    
    ## 5 Sara Bareilles Kaleidoscope Heart    
    ## 6 Sara Bareilles Little Voice

No we can iterate over each row using the `map2` function. This allows
us to feed each value from the `artist` and `album` columns to the
`genius_album()` function. Utilizing a `map` call within a
`dplyr::mutate()` function creates a list column where each value is a
`tibble` with the data frame from `genius_album()`. We will later unnest
this.

``` r
## We will have an additional artist column that will have to be dropped
album_lyrics <- albums %>% 
  mutate(tracks = map2(artist, album, genius_album))
```

    ## Joining, by = c("track_title", "track_n", "track_url")
    ## Joining, by = c("track_title", "track_n", "track_url")
    ## Joining, by = c("track_title", "track_n", "track_url")
    ## Joining, by = c("track_title", "track_n", "track_url")
    ## Joining, by = c("track_title", "track_n", "track_url")
    ## Joining, by = c("track_title", "track_n", "track_url")

``` r
album_lyrics
```

    ## # A tibble: 6 x 3
    ##   artist         album                  tracks              
    ##   <chr>          <chr>                  <list>              
    ## 1 Kendrick Lamar Section 80             <tibble [1,131 × 4]>
    ## 2 Kendrick Lamar Good Kid, M.A.A.D City <tibble [2,285 × 4]>
    ## 3 Kendrick Lamar DAMN.                  <tibble [1,116 × 4]>
    ## 4 Sara Bareilles The Blessed Unrest     <tibble [698 × 4]>  
    ## 5 Sara Bareilles Kaleidoscope Heart     <tibble [565 × 4]>  
    ## 6 Sara Bareilles Little Voice           <tibble [586 × 4]>

Now when you view this you will see that each value within the `tracks`
column is `<tibble>`. This means that that value is infact another
`tibble`. We expand this using `tidyr::unnest()`.

``` r
# Unnest the lyrics to expand 
lyrics <- album_lyrics %>% 
  unnest(tracks) %>%    # Expanding the lyrics 
  arrange(desc(artist)) # Arranging by artist name 

head(lyrics)
```

    ## # A tibble: 6 x 6
    ##   artist     album       track_title track_n lyric                    line
    ##   <chr>      <chr>       <chr>         <int> <chr>                   <int>
    ## 1 Sara Bare… The Blesse… Brave             1 You can be amazing          1
    ## 2 Sara Bare… The Blesse… Brave             1 You can turn a phrase …     2
    ## 3 Sara Bare… The Blesse… Brave             1 You can be the outcast      3
    ## 4 Sara Bare… The Blesse… Brave             1 Or be the backlash of …     4
    ## 5 Sara Bare… The Blesse… Brave             1 Or you can start speak…     5
    ## 6 Sara Bare… The Blesse… Brave             1 Nothing's gonna hurt y…     6

## Song Lyrics

### `genius_lyrics()`

If you want only a single song, you can use `genius_lyrics()`. Supply an
artist and a song title as character strings, and
voila.

``` r
memory_street <- genius_lyrics(artist = "Margaret Glaspy", song = "Memory Street")

memory_street
```

    ## # A tibble: 27 x 3
    ##    track_title   lyric                                    line
    ##    <chr>         <chr>                                   <int>
    ##  1 Memory Street Ring the alarm                              1
    ##  2 Memory Street I'm on memory street                        2
    ##  3 Memory Street With him on my arm                          3
    ##  4 Memory Street And my feet on the dash of that car         4
    ##  5 Memory Street I don't dare                                5
    ##  6 Memory Street Walk down memory street                     6
    ##  7 Memory Street Why remember                                7
    ##  8 Memory Street All the times I took forever to forget?     8
    ##  9 Memory Street Call the guards                             9
    ## 10 Memory Street I'm at the gates                           10
    ## # ... with 17 more rows

This returns a `tibble` with three columns `title`, `text`, and `line`.
However, you can specifiy additional arguments to control the amount of
information to be returned using the `info` argument.

  - `info = "title"` (default): Return the lyrics, line number, and song
    title.
  - `info = "simple"`: Return just the lyrics and line number.
  - `info = "artist"`: Return the lyrics, line number, and artist.
  - `info = "all"`: Return lyrics, line number, song title, artist.

## Tracklists

`genius_tracklist()`, given an `artist` and an `album` will return a
barebones `tibble` with the track title, track number, and the url to
the lyrics.

``` r
genius_tracklist(artist = "Basement", album = "Colourmeinkindness") 
```

    ## # A tibble: 10 x 3
    ##    track_title track_n track_url                                   
    ##    <chr>         <int> <chr>                                       
    ##  1 Whole             1 https://genius.com/Basement-whole-lyrics    
    ##  2 Covet             2 https://genius.com/Basement-covet-lyrics    
    ##  3 Spoiled           3 https://genius.com/Basement-spoiled-lyrics  
    ##  4 Pine              4 https://genius.com/Basement-pine-lyrics     
    ##  5 Bad Apple         5 https://genius.com/Basement-bad-apple-lyrics
    ##  6 Breathe           6 https://genius.com/Basement-breathe-lyrics  
    ##  7 Control           7 https://genius.com/Basement-control-lyrics  
    ##  8 Black             8 https://genius.com/Basement-black-lyrics    
    ##  9 Comfort           9 https://genius.com/Basement-comfort-lyrics  
    ## 10 Wish             10 https://genius.com/Basement-wish-lyrics

## Nitty Gritty

`genius_lyrics()` generates a url to Genius which is fed to
`genius_url()`, the function that does the heavy lifting of actually
fetching lyrics.

I have not figured out all of the patterns that are used for generating
the Genius.com urls, so errors are bound to happen. If `genius_lyrics()`
returns an error. Try utilizing `genius_tracklist()` and `genius_url()`
together to get the song lyrics.

For example, say “(No One Knows Me) Like the Piano” by *Sampha* wasn’t
working in a standard `genius_lyrics()` call.

``` r
piano <- genius_lyrics("Sampha", "(No One Knows Me) Like the Piano")
```

We could grab the tracklist for the album *Process* which the song is
from. We could then isolate the url for *(No One Knows Me) Like the
Piano* and feed that into \`genius\_url().

``` r
# Get the tracklist for 
process <- genius_tracklist("Sampha", "Process")

# Filter down to find the individual song
piano_info <- process %>% 
  filter(track_title == "(No One Knows Me) Like the Piano")

# Filter song using string detection
# process %>% 
#  filter(stringr::str_detect(title, coll("Like the piano", ignore_case = TRUE)))

piano_url <- piano_info$track_url
```

Now that we have the url, feed it into `genius_url()`.

``` r
genius_url(piano_url, info = "simple")
```

    ## # A tibble: 13 x 2
    ##    lyric                                                              line
    ##    <chr>                                                             <int>
    ##  1 No one knows me like the piano in my mother's home                    1
    ##  2 You would show me I had something some people call a soul             2
    ##  3 And you dropped out the sky, oh you arrived when I was three yea…     3
    ##  4 No one knows me like the piano in my mother's home                    4
    ##  5 You know I left, I flew the nest                                      5
    ##  6 And you know I won't be long                                          6
    ##  7 And in my chest you know me best                                      7
    ##  8 And you know I'll be back home                                        8
    ##  9 An angel by her side, all of the times I knew we couldn't cope        9
    ## 10 They said that it's her time, no tears in sight, I kept the feel…    10
    ## 11 And you took hold of me and never, never, never let me go            11
    ## 12 'Cause no one knows me like the piano in my mother's home            12
    ## 13 In my mother's home                                                  13

-----

# On the Internals

## Generative functions

This package works almost entirely on pattern detection. The urls from
*Genius* are (mostly) easily reproducible (shout out to [Angela
Li](https://twitter.com/CivicAngela) for pointing this out).

The two functions that generate urls are `gen_song_url()` and
`gen_album_url()`. To see how the functions work, try feeding an artist
and song title to `gen_song_url()` and an artist and album title to
`gen_album_url()`.

``` r
gen_song_url("Laura Marling", "Soothing")
```

    ## [1] "https://genius.com/Laura-Marling-Soothing-lyrics"

``` r
gen_album_url("Daniel Caesar", "Freudian")
```

    ## [1] "https://genius.com/albums/Daniel-Caesar/Freudian"

`genius_lyrics()` calls `gen_song_url()` and feeds the output to
`genius_url()` which preforms the scraping.

Getting lyrics for albums is slightly more involved. It first calls
`genius_tracklist()` which first calls `gen_album_url()` then using the
handy package `rvest` scrapes the song titles, track numbers, and song
lyric urls. Next, the song urls from the output are iterated over and
fed to `genius_url()`.

To make this more clear, take a look inside of `genius_album()`

``` r
genius_album <- function(artist = NULL, album = NULL, info = "simple") {

  # Obtain tracklist from genius_tracklist
  album <- genius_tracklist(artist, album) %>%

    # Iterate over the url to the song title
    mutate(lyrics = map(track_url, genius_url, info)) %>%

    # Unnest the tibble with lyrics
    unnest(lyrics) %>%
    
    # Deselect the track url
    select(-track_url)

  return(album)
}
```

### Notes:

As this is my first *“package”* there will be many issues. Please submit
an issue and I will do my best to attend to it.

There are already issues of which I am present (the lack of error
handling). If you would like to take those on, please go ahead and make
a pull request. Please contact me on [Twitter](twitter.com/josiahparry).
