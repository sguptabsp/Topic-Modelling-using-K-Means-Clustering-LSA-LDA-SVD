# Load Packages

install.packages("tm")
install.packages("SnowballC")
install.packages("wordcloud")
install.packages("RColorBrewer")
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")


# Load Data 

data2 <- c("E:\\IIT\\Lecture\\CS522 ADM\\20_newsgroups\\comp.sys.ibm.pc.hardware",
           "E:\\IIT\\Lecture\\CS522 ADM\\20_newsgroups\\comp.sys.mac.hardware",
           "E:\\IIT\\Lecture\\CS522 ADM\\20_newsgroups\\comp.os.ms-windows.misc")

news <- Corpus(DirSource(data2, recursive=TRUE),readerControl = list(reader=readPlain))

# Data Cleaning & Preprocessing

news <- tm_map(news, removeWords,"Subject")
news <- tm_map(news, removeWords,"Organization")
news <- tm_map(news, removeWords,"writes")
news <- tm_map(news, removeWords,"From")
news <- tm_map(news, removeWords,"lines")
news <- tm_map(news, removeWords," NNTP-Posting-Host")
news <- tm_map(news, removeWords,"article")
news <- tm_map(news, tolower)
news <- tm_map(news, removeWords, stopwords("english"))
news <- tm_map(news, removePunctuation)
news <- tm_map(news, stemDocument)
news <- tm_map(news, removeNumbers)
news <- tm_map(news, stripWhitespace)
news <- tm_map(news , PlainTextDocument)
		   
# Build Document Term Matrix

dtm <- DocumentTermMatrix(news,control=list(wordLengths=c(4,Inf)))
dtm1 <- DocumentTermMatrix(news)

# Create Term Document Matrix

tdm <- TermDocumentMatrix(news, control=list(wordLengths=c(4,Inf)))
tdm 1<- TermDocumentMatrix(news)

# Verify Frequent Term

m <- as.matrix(tdm)
v <- sort(rowSums(m), decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

# Wordcloud

dtms <- removeSparseTerms(dtm, 0.15)
freq <- colSums(as.matrix(dtm))
dark2 <- brewer.pal(6, "Dark2")
wordcloud(names(freq), freq, max.words=100, rot.per=0.2,colors=dark2)

