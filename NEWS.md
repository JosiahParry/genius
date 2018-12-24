## `geniusR` 0.0.1.0

This update makes some drastic changes to the base `genius_url()` function. It closes two long lasting pull requests [#4](https://github.com/JosiahParry/geniusR/issues/4), and [#12](https://github.com/JosiahParry/geniusR/issues/12).

Big thanks to [\@natebarr64](https://github.com/natebarr64) for his pull request [#20](https://github.com/JosiahParry/geniusR/pull/20) that fixed issue #4. This PR also created a new feature. 

@natebarr64 create the argument `info = "features"` which will identify the song element and artist for that element if they are available. You can use this for `genius_url()`, `genius_lyrics()`, and `genius_album()`. 

