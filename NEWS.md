## `genius` v.2.2.0

May 5th, 2019

* New package version was submitted to CRAN.
* Interactive tutorial is now available in the package. 
  *  Run `learnr::run_tutorial("genius_tutorial", "genius")` to access the tutorial. 

May 4th, 2019

* New functionality was added to `genius`. The function `calc_self_sim()` enables the user to create a self-similarity matrix. The default output is a _tidy_ data-frame that is ready for plotting. Additional arguments can be used to remove stop words. Stop word functionality is accessed via the [`tidytext`](https://github.com/juliasilge/tidytext) package. 
* `add_genius()` has been modified to be able to accept a column for the `type`. This will enable you to mix both single songs with entire albums. The `type_group` column has been renamed to `title` to be more coherent. This is a potentially breaking change to existing code. 
  * Changes to `add_genius()` were checked for `spotifyr` reverse dependencies. Results returned 0 errors. All should be good. 
----------
## `genius` v.2.1.0

April 28th, 2019

* Issue [27](https://github.com/JosiahParry/genius/issues/27) has been fixed. Thank you to [\@manadamoth](https://github.com/manandamoth) for bringing the issue to attention. `genius_album()` would fail when it encountered a url with missing lyrics. The solution was to create a safe version of the `genius_url()` function that is called from `genius_album()` instead of `genius_url()` directly. This means that the function will continue to work if a single track url doesn't. Those tracks will have any empty tibble (so after unnesting within `genius_album()` it returns a row of `NA`s).
  * I am still trying to figure out how to customize the warning message from `purrr::possibly()`, if anyone knows how to do this, please let me know via issue or twitter ([\@josiahparry](http://twitter.com/josiahparry)).


-------------
## `genius` v.2.0.0
April 10th, 2019

The name of this package has been changed from `geniusR` to `genius` due to a name conflict on **CRAN**.

This update makes some drastic changes to the base `genius_url()` function. It closes two long lasting pull requests [#4](https://github.com/JosiahParry/genius/issues/4), and [#12](https://github.com/JosiahParry/genius/issues/12).

Big thanks to [\@natebarr64](https://github.com/natebarr64) for his pull request [#20](https://github.com/JosiahParry/geniusR/pull/20) that fixed issue #4. This PR also created a new feature. 

@natebarr64 create the argument `info = "features"` which will identify the song element and artist for that element if they are available. You can use this for `genius_url()`, `genius_lyrics()`, and `genius_album()`. 

