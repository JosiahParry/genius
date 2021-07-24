if (getRversion() >= "2.15.1")  {
  utils::globalVariables(c("Var1", "Var2", "value", "word", "x_id", "y_id"))
}

#' Calculate a self-similarity matrix
#'
#' Calculate the self-similarity matrix for song lyrics.
#'
#' @param df The data frame containing song lyrics. Usually from the output of \code{`genius_lyrics()`}.
#' @param lyric_col The unquoted name of the column containing lyrics
#' @param output Determine the type of output. Default is \code{"tidy"}. Set to \code{"matrix"} for the raw matrix.
#' @param remove_stop_words Optional argument to remove stop words from self-similarity matrix.
#' @param language Language of stop words. See \code{tidytext::get_stopwords()}.
#' @param source Stop words source. See \code{tidytext::get_stopwords()}.
#'
#' @examples
#'
#'\donttest{
#' # bad_habits <- genius_lyrics("Alix", "Bad Habits")
#' # self_sim <- calc_self_sim(bad_habits, lyric)
#'}
#'
#' @export
#' @import dplyr
#' @importFrom tidytext unnest_tokens get_stopwords
#' @importFrom reshape2 melt
#' @importFrom tibble as_tibble

calc_self_sim <- function(df, lyric_col, output = "tidy", remove_stop_words = FALSE, language = "en", source = "snowball") {
  lyric_col <- enquo(lyric_col)
  lyric_vec <- if (remove_stop_words) {
    df %>%
      unnest_tokens(word, !!lyric_col) %>%
      anti_join(get_stopwords(language = language, source = source)) %>%
      pull(word)
  } else {
    df %>%
      unnest_tokens(word, !!lyric_col) %>%
      pull(word)
  }


  # calculate matrix dimensions
  mat_size <- length(lyric_vec)

  # create matrix of the words
  lyric_mat <- matrix(lyric_vec, nrow = mat_size, ncol = mat_size)

  # initialize empty self-sim matrix
  self_sim <- matrix(nrow = mat_size, ncol = mat_size)

  # iterate through matrix and evlaute similarity
  for (col in 1:mat_size) {
    for(row in 1:mat_size) {
      self_sim[row, col] <- (self_sim[row, col] <- lyric_mat[row, col] == lyric_mat[col,col])
    }
  }


  switch(output,
         matrix = {return(self_sim)},
         tidy = {
           reshape2::melt(self_sim) %>%
             as_tibble() %>%
             rename(x_id = Var1, y_id = Var2, identical = value) %>%
             mutate(word_x = lyric_vec[x_id],
                    word_y = lyric_vec[y_id]) %>%
             return()
         })

}
