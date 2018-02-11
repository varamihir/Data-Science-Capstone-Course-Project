# Data-Science-Capstone-Course-Project

**Introduction**

This presentation is created as a final project of the requirement for the Coursera Data Science Capstone Course.
The main goal of this capstone course is to build a predictive text model with shiny app that will predict the next word as the user types a word or sentence similar to the way most smartphone keboards are implemented today using the technology of swiftkey.

Please see the link below for shiny app and the github repo for all the codes.

 [Shiny App] <https://support.rstudio.com/hc/en-us/articles/200486468>.
 
 [Github]
 
**Getting and Cleaning the data**

* A subset of  the orginal data was sampled from  the three sources(blogs,news and twitter) which is finally megerd into one.
* Next data cleaning as conversion to lowercase, removing numbers and punctutaions, remove profanity words,
remove stripwhitespace, was done by using TM pacakage.
* The corresponding N-Grams(unigram,bigram, trigram and quadgram) were created using RWeka package.
* Next the term-count tables were extracted from the N-Grams and sorted based on their frequencies in desecending order.
* In these data frames each word is represented by 1 column together with the frquency in desecnding order.
Example -  For quadgram dataframe there are 4 columns for 4 words and another column for frequency.Finally the N-gram objects were saved as R-Compressed files(.RDatafile)



**Word Prediction Algorithm**

The prediction model for the next word is based on the Katz Back-off algorithum. Explanation of the next word prediction is as below:
* First compressed data sets containing descending frequncy sorted n-grams are loaded.
* User input words are cleaned in the simliar as before prior to the prediction of the next word.
* Backoff algorithum will be used for the prediction where it will be recursively trying from the higher order of n-grams data frame to lower order of n- grams data frame until a resonable probabilty is found.
Example- If the input is more than 3 words, compare the last 3 words of the user input to the first 3 words of the quadGram data frame. If an appropriate match is not found, then compare the last 2 words of the input to the first 2 words of the triGram dataframe and continue this process until an appropriate match is not found. If not then most common word "the" is returned.

**Shiny Application**

The shiny app loads the four saved n-gram objects and applies Katz's Back- off algorithum to predict the next word after user enters a partial sentence or word. A shiny application was developed based on the next word prediction model described previousely, is as shown below with a sample text.

 ![](shinyApp3.png)




