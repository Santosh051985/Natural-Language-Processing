library(tm)
library(slam)
library(topicmodels)

x<-readLines("modi.txt")
mydata.corpus <- Corpus(VectorSource(x))
mydata.corpus <- tm_map(mydata.corpus, removePunctuation) 
my_stopwords <- c(stopwords('english'),"the", "due", "are", "not", "for", "this", "and",  "that", "there", "new", "near", "beyond", "time", "from", "been", "both", "than",  "has","now", "until", "all", "use", "two", "ave", "blvd", "east", "between", "end", "have", "avenue", "before",    "just", "mac", "being",  "when","levels","remaining","based", "still", "off", "over", "only", "north", "past", "twin", "while","then")
mydata.corpus <- tm_map(mydata.corpus, removeWords, my_stopwords)
mydata.corpus <- tm_map(mydata.corpus, removeNumbers) 

# build a term-document matrix
mydata.dtm3 <- TermDocumentMatrix(mydata.corpus)
mydata.dtm3

dim(mydata.dtm3)

dtm <- as.DocumentTermMatrix(mydata.dtm3)
rowTotals <- apply(dtm , 1, sum)
dtm.new   <- dtm[rowTotals> 0, ]
library(NLP)
lda <- LDA(dtm.new, 10) # find 10 topics
term <- terms(lda, 5) # first 5 terms of every topic
term

####################### Emotion mining ##############################
library("syuzhet")

my_example_text <- readLines("modi.txt")
s_v <- get_sentences(my_example_text)
class(s_v)
str(s_v)
(s_v)


sentiment_vector <- get_sentiment(s_v, method = "bing")
head(sentiment_vector)

afinn_s_v <- get_sentiment(s_v, method = "afinn")
head(afinn_s_v)

nrc_vector <- get_sentiment(s_v, method="nrc")
head(nrc_vector)
sentiment_vector
sum(sentiment_vector)
mean(sentiment_vector)
summary(sentiment_vector)

# plot
plot(sentiment_vector, type = "l", main = "Plot Trajectory",
     xlab = "Narrative Time", ylab = "Emotional Valence")
abline(h = 0, col = "red")

# To extract the sentence with the most negative emotional valence
negative <- s_v[which.min(sentiment_vector)]

# and to extract the most positive sentence
positive <- s_v[which.max(sentiment_vector)]

# more depth
poa_v<-my_example_text
poa_sent <- get_sentiment(poa_v, method="bing")
plot(
  poa_sent, 
  type="h", 
  main="Example Plot Trajectory", 
  xlab = "Narrative Time", 
  ylab= "Emotional Valence"
)

# percentage based figures
percent_vals <- get_percentage_values(poa_sent)

plot(
  percent_vals, 
  type="l", 
  main="Throw the ring in the volcano Using Percentage-Based Means", 
  xlab = "Narrative Time", 
  ylab= "Emotional Valence", 
  col="red"
)

ft_values <- get_transformed_values(
  poa_sent, 
  low_pass_size = 3, 
  x_reverse_len = 100,
  scale_vals = TRUE,
  scale_range = FALSE
)

plot(
  ft_values, 
  type ="h", 
  main ="LOTR using Transformed Values", 
  xlab = "Narrative Time", 
  ylab = "Emotional Valence", 
  col = "red"
)

# categorize each sentence by eight emotions
nrc_data <- get_nrc_sentiment(s_v)

# subset

sad_items <- which(nrc_data$sadness > 0)
head(s_v[sad_items])

# To view the emotions as a barplot
barplot(sort(colSums(prop.table(nrc_data[, 1:8]))), horiz = T, cex.names = 0.7,
        las = 1, main = "Emotions", xlab = "Percentage",
        col = 1:8)
# 3 median=2 mean+mode
