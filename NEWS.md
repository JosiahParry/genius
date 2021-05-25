## `genius` v2.2.3

As illustrated in [PR #55](https://github.com/JosiahParry/genius/pull/55), all functionality of genius had been broken due to the changes with genius

This patch release

- brings back full functionality of the package;
- utilizes `pivot_wider()` instead of `spread()`;
- removes `readr` as a dependency;
- utilizes `session()` instead of `html_session()` from `{rvest}` since it has been superceded.

## `genius` v2.2.2

May 9th, 2020

* genius was taken off of CRAN due to my failure to address failing examples. Thank you to the CRAN team for providing thorough explanation and forewarning. Thank you [\@Nicolas-Gallo](https://github.com/Nicolas-Gallo) for bringing this to my attention. This release closes [issue #48](https://github.com/JosiahParry/genius/issues/48).
* The removal of genius from CRAN has had downstream consequences. Failure to update has led to the removal of spotifyr from CRAN as well due to the inclusion of genius in its `Imports`. This release will make it possible to publish spotifyr to CRANA again addressing spotifyr [issue #112](https://github.com/charlie86/spotifyr/issues/112).
* `add_genius()`'s `type` argument took two values `"album"` and `"lyrics"`. This is logically inconsistent as we are specifying track titles not the lyrics. This is an attempt to create more continuity between the data that is returned from `genius_lyrics()` and `genius_album()`. I've introduced the argument value `"track"` which is to be preferred over `"lyrics"`. `"lyrics"` will remain a valid option to `type` for reverse compatability. 
* Version bumped to 2.2.2.

## `genius` v2.2.1

Dec 16th, 2019

* Created a Code of Conduct
* Changed license from GPL-2 to MIT


Dec 15th, 2019

* `add_genius()` now unnests lyrics prior to joining. This ought to reduce the number of errors.
* updates to `tidyr::unnest()` broke functions in many situations. Thank you to [\@eoppe1022](https://github.com/eoppe1022) for pointing out `tidyr::unnest_legacy()`. The legacy version will be used internally for now. 
* Thank you to [\@chris-billingham](https://github.com/chris-billingham) for noting issues with the `info = "title"` and `info = "all"` arguments of `genius_album()` and fixing these whilst also adding album_name into the output from `genius_album(..., info = "all")`.
* Belated thank you to [\@eoppe1022](https://github.com/eoppe1022) for help with `prep_info()` in earlier releases. Evan has been added as a contributor.


Nov 27th, 2019

* Thank you to [\@mine-cetinkaya-rundel](https://github.com/mine-cetinkaya-rundel) for noting changes to `tidyr::unnest()` producing unwanted warnings in `add_genius()`. This has been fixed.


## `genius` v2.2.0

May 5th, 2019

* New package version was submitted to CRAN.
* Interactive tutorial is now available in the package. 
  *  Run `learnr::run_tutorial("genius_tutorial", "genius")` to access the tutorial. 

May 4th, 2019

* New functionality was added to `genius`. The function `calc_self_sim()` enables the user to create a self-similarity matrix. The default output is a _tidy_ data-frame that is ready for plotting. Additional arguments can be used to remove stop words. Stop word functionality is accessed via the [`tidytext`](https://github.com/juliasilge/tidytext) package. 
* `add_genius()` has been modified to be able to accept a column for the `type`. This will enable you to mix both single songs with entire albums. The `type_group` column has been renamed to `title` to be more coherent. This is a potentially breaking change to existing code. 
  * Changes to `add_genius()` were checked for `spotifyr` reverse dependencies. Results returned 0 errors. All should be good. 
  
----------

## `genius` v2.1.0

April 28th, 2019

* Issue [27](https://github.com/JosiahParry/genius/issues/27) has been fixed. Thank you to [\@manadamoth](https://github.com/manandamoth) for bringing the issue to attention. `genius_album()` would fail when it encountered a url with missing lyrics. The solution was to create a safe version of the `genius_url()` function that is called from `genius_album()` instead of `genius_url()` directly. This means that the function will continue to work if a single track url doesn't. Those tracks will have any empty tibble (so after unnesting within `genius_album()` it returns a row of `NA`s).
  * I am still trying to figure out how to customize the warning message from `purrr::possibly()`, if anyone knows how to do this, please let me know via issue or twitter ([\@josiahparry](https://twitter.com/josiahparry)).


-------------

## `genius` v2.0.0
April 10th, 2019

The name of this package has been changed from `geniusR` to `genius` due to a name conflict on **CRAN**.

This update makes some drastic changes to the base `genius_url()` function. It closes two long lasting pull requests [#4](https://github.com/JosiahParry/genius/issues/4), and [#12](https://github.com/JosiahParry/genius/issues/12).

Big thanks to [\@natebarr64](https://github.com/natebarr64) for his pull request [#20](https://github.com/JosiahParry/genius/pull/20) that fixed issue #4. This PR also created a new feature. 

@natebarr64 create the argument `info = "features"` which will identify the song element and artist for that element if they are available. You can use this for `genius_url()`, `genius_lyrics()`, and `genius_album()`. 

