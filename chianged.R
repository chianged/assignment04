rm(list=ls())




# readPaper command
# Input: a text file you wish to read
# Output: list of all words in file
readPaper <- function(file){
  text <- scan(file,"")               # Reads txt file to create a string of characters
  lower.text <- tolower(text)         # Makes everything lowercase
  text.list<- list(lower.text)        # Creates a list of the previous string of characters
  return(text.list)                   # Print output list
}

# References:
# tolower command found at "http://stackoverflow.com/questions/13640188/converting-text-to-lowercase"




# wordCount command
# Input: Output from readPaper function, word or vector of words of interest
# Output: Vector of number(s) that indicate how many times the word(s) appear
wordCount <- function(filelist, word){
  vector <- unlist(filelist)   # Convert filelist to vector
  TF <- vector == word         # Creates TRUE/FALSE vector
  total <- sum(TF)             # Sum TRUEs
  return(total)                # Print output vector
}




# wordPlacement command
# Input: Output from readPaper function, word of interest
# Output: Vector of #'s which correspond to the location(s) of the word indexed from the beginning
wordPlacement <- function(filelist, word){
  vector <- unlist(filelist)      # Convert filelist to string
  nword <- which(word==vector)    # Where the word is found
  return(nword)                   # Print output vector
}

# References: 
# which function found with Help by searching ??indice




# wordHist command
# Input: Output from readPaper function, # of top words you want
# Output: 
wordHist <- function(filelist, top=10){
 file.table <- table(filelist)                      # Calculate frequency of each unique word in text
 sort.table <- sort(file.table, decreasing=T)       # Sort from highest to lowest
                                                    # Create barplot
 barplot(sort.table[1:top], width=1, space=0, names.arg=rownames(sort.table[1:top]), main = "Top Words", xlab="Word",ylab="Frequency")
 axis(1, labels=F, lwd.ticks=0)                     # Add x-axis w/o ticks
}

# References:
# table function found with Help by searching ??frequency




# nextWord command
# Input: Output from readPaper function, word of interest
# Output: Vector of words & their frequency
# This command tells you the frequency of words that follow the first incidence of your word of interest
nextWord <- function(filelist, word){
  vector <- unlist(filelist)                 # Converts filelist to vector
  word.pos <- which(word==vector)            # Creates vector of word positions
  position <- word.pos[1]                    # Take the first word location
  leng <- length(vector)                     # Define length of filelist
  follow.words <- vector[position:leng]      # Creates vector from first occurance of word to end of filelist vector
  table <- table(follow.words)               # Calculate frequency of each word after target word
  return(table)                              # Print output vector
}



# previousWord command
# Input: Output from readPaper function, word of interest
# Output: Vector of words & their frequency
# This command tells you the frequency of words that precede the first incidence of your word of interest
previousWord <- function(filelist,word){
  vector <- unlist(filelist)                 # Converts filelist to vector
  word.pos <- which(word==vector)            # Creates vector of word positions
  position <- word.pos[1]                    # Take the first word location
  precede.words <- vector[1:position]        # Creates vector from beginning of filelist vector to first occurance of word
  table <- table(precede.words)              # Calculate frequency of each word preceding target word
  return(table)                              # Print output vector
}




# surpriseMe command
# Input: Output from readPaper function
surpriseMe <- function(filelist){
  print("Are the authors of this article more eloquent* than Shakespeare?")
  print("(*measured by vocabulary size)")
  Shake.prop <- 5170/35000           # Shakespeare unique words / total words
  vector <- unlist(filelist)         # Converts filelist to vector
  table <- table(vector)             # Creates vector of unique words & their frequencies  
  unique <- nrow(table)              # Calculate total # of unique words
  total <- length(vector)            # Calculate total length of filelist
  Shake.adj <- Shake.prop * total    # Subsample Shakespeare to reflect article length
  matrix <- matrix(c(unique, Shake.adj), nrow=2, ncol=1)     # Make matrix to present results
  colnames(matrix) <- "Unique words"                         # Add column names to matrix
  rownames(matrix) <- c("Article","Shakespeare")             # Add row names to matrix
  print(matrix)                                              # Print matrix which shows the # of unique words in article vs. Shakespeare
                                                             # Conclusion if article is more eloquent that Shakes, & vice versa
  conclusion <- ifelse (unique > Shake.adj, "Shakespeare ain't got nothin' on dem scientists", "The intellectuals doeth not compareth with the eloquence of Shakespeare")
  print("Conclusion:")                                       # Format conclusion to be more clear
  return(conclusion)                                         # Print conclusion
}

# References:
# Shakespeare vocabulary data from "http://experiments.undercurrent.com/"
# Shakespeare translation from "http://lingojam.com/EnglishtoShakespearean"
