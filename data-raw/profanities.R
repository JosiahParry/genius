# Resource from Carnegie Mellon University
# Taken from Luis Von Ahn's (founder of reCAPTCHA & duoling) resources
# Sourced from https://www.cs.cmu.edu/~biglou/resources/bad-words.txt

profanities <- tibble(word = read_lines("https://www.cs.cmu.edu/~biglou/resources/bad-words.txt")) %>%
  filter(word != "")

save(profanities, file = "data/profanities.RData")
