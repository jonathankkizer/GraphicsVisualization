# dictionary used in the wordCounts frequency dictionary
from collections import defaultdict


# performs formatting operations for the writeAllWords function
def formatStuff(i):
	word = ""
	for j in i:
		word += j.replace(",", "").replace(".", "").replace('"', "").replace("?", "").replace("!", "").replace("-","").replace(")","").replace("'","").replace("_","").replace("$","").replace(";","").replace("*","").replace("(","").replace("[","").replace("]","").replace(":","")
	filter(lambda x: x.isalpha(), word)
	return word.lower()

# reads all words from filename, returns based on lin
def readAllWords(filename):
	with open(filename) as book:
		return book.read().split()
	book.close()

# opens a text file named "allwords.txt" and writes the contents of readAllWords() to a new line
def writeAllWords(filename):
	allWords = readAllWords(filename)
	textFile = open("allwords.txt", "w")
	for i in allWords:
		i = formatStuff(i) + "\n"
		textFile.write(i)
	textFile.close()

# prints all words that occur exactly once to uniquewords.txt
def uniqueWords(wordCounts):
	j = ""
	for i in wordCounts:
		textFile = open("uniquewords.txt", "w")
		if (wordCounts[i] == 1):
			#print(j)
			j += str(i).strip() + "\n"
		else:
			continue
	textFile.write(j)
	textFile.close()

# calculates the number of words that occur at each frequency level (note: "the" most frequent word, at ~3300 uses)
def wordFrequency(wordCounts):
	textFile = open("wordfrequency.txt","w")
	wordFreqCounter = 1
	maxNumOccurences = max(wordCounts.values())
	#print(maxNumOccurences)
	while wordFreqCounter <= maxNumOccurences:
		outString = ""
		wordFreq = 0
		for occurences in wordCounts:
			if wordCounts[occurences] == wordFreqCounter:
				wordFreq += 1
			else:
				continue
		outString = str(wordFreqCounter) + ": " + str(wordFreq) + "\n"
		textFile.write(outString)
		wordFreqCounter += 1
		
# iterates through allwords.txt and adds a word if not present in wordCounts; if it is, it increments the word's value by 1
def numOccurrences():
	wordCounts = defaultdict(int)
	for w in open("allwords.txt"):
		wordCounts[w] += 1
	return wordCounts

def main():
	
	# select book here by changing this title
	book = "TheInvisibleMan.txt"
	
	# calls functions in appropriate order
	writeAllWords(book)
	wordCounts = numOccurrences()
	uniqueWords(wordCounts)
	wordFrequency(wordCounts)
	print("Completed!")

main()