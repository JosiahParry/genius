---
title: 'genius: acquiring analysis ready song lyrics'
tags:
  - R
  - music information retrieval
  - tidy text
  - lyrics
authors:
  - name: Josiah Parry
    orcid: 0000-0001-9910-865X
    affiliation: "1, 2" 
affiliations:
 - name: Northeastern University, School of Public Policy and Urban Affairs
   index: 1
 - name: RStudio 2
   index: 2
date: 16 December 2019
bibliography: index.bib
---


# Summary

Music is a rather unique phenomenon. One song can be considered a dataset with myriad bits of information which can be represented by musical notation, audio signals, lyrics, among many other forms of representation. The extraction of information from music is referred to as music information retrieval (MIR). MIR has been largely focused on audio signal processing and has not put the same effort into the analysis of music text data [@Mayer2010]. Concomitantly, the field of music psychology has been studying the psychological implications of lyrics [@wellbeing; @violence; @soundtracks; @relaxing]. However, there seems to be no consistent MIR system in place for the acquisiton and analysis of song lyrics [@napier]. 

`genius` is an R package that provides a consistent interface for acquiring song lyrics in R. The package was developed with tidy data principles in mind [@tidydata; @tidytext]. As such, the toolkit that `genius` provides integrates with the tidy text framework. `genius` functionality returns one-token-per-document-per-row where each token is a line of a song. This adherance to tidy text principles allows users to transition between tidy and alternative text analysis frameworks.

As song lyrics are only one aspect of music, it is often useful to acquire audio features and metadata as well. To this end `genius` has been integrated with the `spotifyr` packge [@spotifyr]. This integration enables researchers to fetch a single artist's discography with audio features and lyrics in a matter of seconds. 

By providing a robust and consistent framework for acquiring song lyrics, `genius` aids researchers by drastically reducing the amount of time and effort spent in collecting, cleaning, and preparing song lyrics for analysis. 


