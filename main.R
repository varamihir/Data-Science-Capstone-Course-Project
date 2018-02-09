setwd("C:/Users/nvarshney/Desktop/R programming/Coursera/Git Hub and Programming assignments/Course10/projectData/final/en_US")
library(tm) # text mining
library(data.table)
library(qdap)
library(wordcloud)
library(R.utils)
library(stringi) #stat files
library(stringr)
library(NLP)
library(ggplot2) # visualization
library(SnowballC) # stemming
library(tidyr)
library(dplyr)
library(RColorBrewer)#Color Palettes
library(scales)
library(rJava)
library(RWeka) # tokenizer- create unigrams, bigrams,trigrams, quadgrams
set.seed(4567)
# Load data into R
blogs <- readLines("en_US.blogs.txt")
news <- readLines("en_US.news.txt")
twitter <- readLines("en_US.twitter.txt")
badWords <- read.csv("bad_words.txt", header = FALSE, stringsAsFactors = FALSE)
badWords <- badWords$V1
set.seed(4567)

# Sample 1 % of the data to simplify computations.
sTwitter <- sample(twitter, length(twitter)*.01, replace = TRUE)
sBlogs <- sample(blogs, length(blogs)*.01, replace = TRUE)
sNews <- sample(news,length(news)*.01, replace = TRUE)
sample2<- c(sTwitter, sBlogs, sNews)
## Saving the Sample Total
writeLines(sample2, "sample2.txt")

# Transform word to lower case
corpus <- VectorSource(sample2)
corpus <- VCorpus(corpus)
toSpace <- content_transformer(function(x, pattern){ gsub(pattern, " ", x)})
corpus <- tm_map(corpus, toSpace, "(f|ht)tp(s?)://(.*)[.][a-z]+")
corpus <- tm_map(corpus, toSpace, "@[^\\s]+")
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, removeWords,badWords)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, PlainTextDocument)   
rm(blogs, news, twitter,sample2)
saveRDS(corpus, file = "./finalCorpus2.RData")
finalCorpusMem <- readRDS("./finalCorpus2.RData")

finalCorpus <-data.frame(text=unlist(sapply(finalCorpusMem,`[`, "content")),stringsAsFactors = FALSE)
head(finalCorpus)

unigram <- NGramTokenizer(finalCorpus, Weka_control(min= 1, max = 1, delimeters = "\\r\\n\\t.,;:\"()?!"))
unigram <- data.frame(table(unigram))
unigram <- unigram[order(unigram$Freq, decreasing = TRUE),]
View(unigram[1:20,])
names(unigram) <- c(unigram = "word1", freq = "freq")
write.csv(unigram[unigram$freq > 1,],"unigram2.csv",row.names=F)
unigram <- read.csv("unigram2.csv",stringsAsFactors = F)
saveRDS(unigram, file = "unigram2.RData")


bigram <- NGramTokenizer(finalCorpus, Weka_control(min = 2, max = 2,delimiters = " \\r\\n\\t.,;:\"()?!"))
bigram <- data.frame(table(bigram))
bigram <- bigram[order(bigram$Freq,decreasing = TRUE),]
names(bigram) <- c(bigram = "words",freq = "freq")
bigram$words <- as.character(bigram$words)
str2 <- strsplit(bigram$words,split=" ")
bigram <- transform(bigram,
                    one = sapply(str2,"[[",1),
                    two = sapply(str2,"[[",2))
bigram <- data.frame(word1 = bigram$one,word2 = bigram$two,freq = bigram$freq,stringsAsFactors=FALSE)
View(bigram[1:20,])
write.csv(bigram[bigram$freq > 1,],"bigram2.csv",row.names=F)
bigram <- read.csv("bigram2.csv",stringsAsFactors = F)
saveRDS(bigram,"bigram2.RData")

trigram <- NGramTokenizer(finalCorpus, Weka_control(min = 3, max = 3,delimiters = " \\r\\n\\t.,;:\"()?!"))
trigram <- data.frame(table(trigram))
trigram <- trigram[order(trigram$Freq,decreasing = TRUE),]
names(trigram) <- c(trigram = "words", freq = "freq")
View(trigram[1:20,])
trigram$words <- as.character(trigram$words)
str3 <- strsplit(trigram$words, split = " ")
head(str3)
trigram <- transform(trigram,
                     one = sapply(str3,"[[",1)  ,
                     two = sapply(str3,"[[",2),
                     three = sapply(str3,"[[",3))

trigram <- data.frame(word1 = trigram$one,word2 = trigram$two,word3 = trigram$three,
                      freq = trigram$freq, stringsAsFactors = FALSE)
View(trigram[1:20,])
write.csv(trigram[trigram$freq>1,], "trigram2.csv", row.names = FALSE)
trigram<- read.csv("trigram2.csv", stringsAsFactors = FALSE)
saveRDS(trigram, "trigram2.RData")

quadgram <- NGramTokenizer(finalCorpus, Weka_control(min = 4, max = 4,delimiters = " \\r\\n\\t.,;:\"()?!"))
quadgram <- data.frame(table(quadgram))
head(quadgram)
quadgram <- quadgram[order(quadgram$Freq,decreasing = TRUE),]
names(quadgram)<- c(quadgram = "words", freq = "freq")
View(quadgram[1:20,])
quadgram$words <- as.character(quadgram$words)
str4 <- strsplit(quadgram$words, split = " ")
head(str4)
quadgram <- transform(quadgram,
                      one = sapply(str4,"[[",1),
                      two = sapply(str4,"[[",2),
                      three = sapply(str4,"[[",3),
                      four = sapply(str4,"[[",4))
quadgram <- data.frame(word1 = quadgram$one, word2 = quadgram$two, word3 = quadgram$three, word4 = quadgram$four,
                       freq = quadgram$freq, stringsAsFactors = FALSE)
View(quadgram[1:20,])
write.csv(quadgram[quadgram$freq > 1,], "quadgram2.csv", row.names = FALSE)
quadgram <- read.csv("quadgram2.csv", stringsAsFactors = FALSE)
saveRDS(quadgram, "quadgram2.RData")

