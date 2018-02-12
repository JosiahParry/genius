# Resource from Carnegie Mellon University
# Taken from Luis Von Ahn's (founder of reCAPTCHA & duoling) resources

profanities <- tibble(word = read_lines("https://www.cs.cmu.edu/~biglou/resources/bad-words.txt"),
                      lexicon = "LVA") %>%
  filter(word != "")

write_rds(profanities, "data/profanities.rds")
