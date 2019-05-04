Quickstart: genius
================

[![CRAN status](https://www.r-pkg.org/badges/version/genius)](https://cran.r-project.org/package=genius)
[![CRAN RStudio mirror downloads](https://cranlogs.r-pkg.org/badges/grand-total/genius?color=d3a167)](https://r-pkg.org/pkg/genius)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)

This package was created to provide an easy method to access lyrics as text data using [Genius](genius.com).

Access to this code as an API or via Python [here](https://github.com/JosiahParry/genius-api)

Installation
------------

This package is available from CRAN.

``` r
install.packages("genius")
```

Load the package:

``` r
library(genius)
library(tidyverse)
```

Getting Lyrics
==============

Whole Albums
------------

`genius_album()` allows you to download the lyrics for an entire album in a `tidy` format. There are two arguments `artists` and `album`. Supply the quoted name of artist and the album (if it gives you issues check that you have the album name and artists as specified on [Genius](https://genius.com)).

This returns a tidy data frame with three columns:

-   `title`: track name
-   `track_n`: track number
-   `text`: lyrics

``` r
emotions_math <- genius_album(artist = "Margaret Glaspy", album = "Emotions and Math")
```

    ## Joining, by = c("track_title", "track_n", "track_url")

``` r
emotions_math
```

    ## # A tibble: 370 x 4
    ##    track_title       track_n  line lyric                                 
    ##    <chr>               <int> <int> <chr>                                 
    ##  1 Emotions And Math       1     1 Oh when I got you by my side          
    ##  2 Emotions And Math       1     2 Everything's alright                  
    ##  3 Emotions And Math       1     3 Its just when your gone               
    ##  4 Emotions And Math       1     4 I start to snooze the alarm           
    ##  5 Emotions And Math       1     5 Cause I stay up until 4 in the morning
    ##  6 Emotions And Math       1     6 Counting all the days 'til you're back
    ##  7 Emotions And Math       1     7 Shivering in an ice cold bath         
    ##  8 Emotions And Math       1     8 Of emotions and math                  
    ##  9 Emotions And Math       1     9 Oh it's a shame                       
    ## 10 Emotions And Math       1    10 And I'm to blame                      
    ## # … with 360 more rows

Multiple Albums / Songs
-----------------------

If you wish to download multiple albums from multiple artists, try and keep it tidy and avoid binding rows if you can. We can achieve this in a tidy workflow by creating a tibble with two columns: `artist` and `album` where each row is an artist and their album. We can then iterate over those columns with `add_genius()`.

Pipe a dataframe with a column for the album artists and album/track information. The argument `type` is used to indicate if the dataframe contains songs or albums

``` r
# Example with 2 different artists and albums
artist_albums <- tribble(
 ~artist, ~album,
 "J. Cole", "KOD",
 "Sampha", "Process"
)


artist_albums %>%
 add_genius(artist, album)
```

    ## Joining, by = c("track_title", "track_n", "track_url")
    ## Joining, by = c("track_title", "track_n", "track_url")

    ## Joining, by = c("artist", "album")

    ## # A tibble: 1,319 x 6
    ##    artist  album track_title track_n  line lyric                           
    ##    <chr>   <chr> <chr>         <int> <int> <chr>                           
    ##  1 J. Cole KOD   Intro (KOD)       1     1 Can someone please turn off my …
    ##  2 J. Cole KOD   Intro (KOD)       1     2 My thoughts are racing all the …
    ##  3 J. Cole KOD   Intro (KOD)       1     3 There is no reason or no rhyme  
    ##  4 J. Cole KOD   Intro (KOD)       1     4 I'm trapped inside myself       
    ##  5 J. Cole KOD   Intro (KOD)       1     5 A newborn baby has two primary …
    ##  6 J. Cole KOD   Intro (KOD)       1     6 "Laughter, which says, \"I love…
    ##  7 J. Cole KOD   Intro (KOD)       1     7 "Or crying, which says, \"This …
    ##  8 J. Cole KOD   Intro (KOD)       1     8 There are many ways to deal wit…
    ##  9 J. Cole KOD   Intro (KOD)       1     9 Choose wisely                   
    ## 10 J. Cole KOD   Intro (KOD)       1    10 At the bottom of the hourglass  
    ## # … with 1,309 more rows

This can be easily replicated with multiple songs as well.

``` r
# Example with 2 different artists and songs
artist_songs <- tribble(
 ~artist, ~track,
 "J. Cole", "Motiv8",
 "Andrew Bird", "Anonanimal"
)

artist_songs %>%
 add_genius(artist, track, type = "lyrics")
```

    ## Joining, by = c("artist", "track")

    ## # A tibble: 102 x 5
    ##    artist  track  track_title  line lyric                                  
    ##    <chr>   <chr>  <chr>       <int> <chr>                                  
    ##  1 J. Cole Motiv8 Motiv8          1 You really wanna know who Superman is? 
    ##  2 J. Cole Motiv8 Motiv8          2 Watch this, pow!                       
    ##  3 J. Cole Motiv8 Motiv8          3 I like him                             
    ##  4 J. Cole Motiv8 Motiv8          4 I think he's pretty cool               
    ##  5 J. Cole Motiv8 Motiv8          5 He's my idol                           
    ##  6 J. Cole Motiv8 Motiv8          6 I can't have no sympathy for fuck…
    ##  7 J. Cole Motiv8 Motiv8          7 All this shit I've seen done made my b…
    ##  8 J. Cole Motiv8 Motiv8          8 Spill promethazine inside a double cup 
    ##  9 J. Cole Motiv8 Motiv8          9 Double up my cream, now that's a Doubl…
    ## 10 J. Cole Motiv8 Motiv8         10 Please don't hit my phone if it ain't …
    ## # … with 92 more rows

Song Lyrics
-----------

### `genius_lyrics()`

If you want only a single song, you can use `genius_lyrics()`. Supply an artist and a song title as character strings, and voila.

``` r
memory_street <- genius_lyrics(artist = "Margaret Glaspy", song = "Memory Street")

memory_street
```

    ## # A tibble: 27 x 3
    ##    track_title    line lyric                                  
    ##    <chr>         <int> <chr>                                  
    ##  1 Memory Street     1 Ring the alarm                         
    ##  2 Memory Street     2 I'm on memory street                   
    ##  3 Memory Street     3 With him on my arm                     
    ##  4 Memory Street     4 And my feet on the dash of that car    
    ##  5 Memory Street     5 I don't dare                           
    ##  6 Memory Street     6 Walk down memory street                
    ##  7 Memory Street     7 Why remember                           
    ##  8 Memory Street     8 All the times I took forever to forget?
    ##  9 Memory Street     9 Call the guards                        
    ## 10 Memory Street    10 I'm at the gates                       
    ## # … with 17 more rows

This returns a `tibble` with three columns `title`, `text`, and `line`. However, you can specifiy additional arguments to control the amount of information to be returned using the `info` argument.

-   `info = "title"` (default): Return the lyrics, line number, and song title.
-   `info = "simple"`: Return just the lyrics and line number.
-   `info = "artist"`: Return the lyrics, line number, and artist.
-   `info = "features"`: Returns the lyrics, line number, artist, verse, and vocalist if available.
-   `info = "all"`: Return lyrics, line number, song title, artist.

Tracklists
----------

`genius_tracklist()`, given an `artist` and an `album` will return a barebones `tibble` with the track title, track number, and the url to the lyrics.

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

------------------------------------------------------------------------

Nitty Gritty
------------

`genius_lyrics()` generates a url via `gen_song_url()` to Genius which is fed to `genius_url()`, the function that does the heavy lifting of actually fetching lyrics.

I have not figured out all of the patterns that are used for generating the Genius.com urls, so errors are bound to happen. If `genius_lyrics()` returns an error. Try utilizing `genius_tracklist()` and `genius_url()` together to get the song lyrics.

For example, say "(No One Knows Me) Like the Piano" by *Sampha* wasn't working in a standard `genius_lyrics()` call.

``` r
piano <- genius_lyrics("Sampha", "(No One Knows Me) Like the Piano")
```

We could grab the tracklist for the album *Process* which the song is from. We could then isolate the url for *(No One Knows Me) Like the Piano* and feed that into \`genius\_url().

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

    ## # A tibble: 12 x 2
    ##     line lyric                                                             
    ##    <int> <chr>                                                             
    ##  1     1 No one knows me like the piano in my mother's home                
    ##  2     2 You would show me I had something some people call a soul         
    ##  3     3 And you dropped out the sky, oh you arrived when I was three year…
    ##  4     4 No one knows me like the piano in my mother's home                
    ##  5     5 You know I left, I flew the nest                                  
    ##  6     6 And you know I won't be long                                      
    ##  7     7 And in my chest you know me best                                  
    ##  8     8 And you know I'll be back home                                    
    ##  9     9 An angel by her side, all of the times I knew we couldn't cope    
    ## 10    10 They said that it's her time, no tears in sight, I kept the feeli…
    ## 11    11 And you took hold of me and never, never, never let me go'Cause n…
    ## 12    12 In my mother's home

------------------------------------------------------------------------

On the Internals
================

Generative functions
--------------------

This package works almost entirely on pattern detection. The urls from *Genius* are (mostly) easily reproducible (shout out to [Angela Li](https://twitter.com/CivicAngela) for pointing this out).

The two functions that generate urls are `gen_song_url()` and `gen_album_url()`. To see how the functions work, try feeding an artist and song title to `gen_song_url()` and an artist and album title to `gen_album_url()`.

``` r
gen_song_url("Laura Marling", "Soothing")
```

    ## [1] "https://genius.com/Laura-Marling-Soothing-lyrics"

``` r
gen_album_url("Daniel Caesar", "Freudian")
```

    ## [1] "https://genius.com/albums/Daniel-Caesar/Freudian"

`genius_lyrics()` calls `gen_song_url()` and feeds the output to `genius_url()` which preforms the scraping.

Getting lyrics for albums is slightly more involved. It first calls `genius_tracklist()` which first calls `gen_album_url()` then using the handy package `rvest` scrapes the song titles, track numbers, and song lyric urls. Next, the song urls from the output are iterated over and fed to `genius_url()`.

### Notes:

As this is my first *"package"* there will be many issues. Please submit an issue and I will do my best to attend to it.

There are already issues of which I am present (the lack of error handling). If you would like to take those on, please go ahead and make a pull request. Please contact me on [Twitter](twitter.com/josiahparry).
