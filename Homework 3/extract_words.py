# reads all words from filename, returns based on lin
def readAllWords(filename):
	with open(filename) as book:
		return book.read().split()

# opens a text file named "allWords.txt" and writes the contents of readAllWords() to a new line
def writeAllWords(filename):
	allWords = readAllWords(filename)
	textFile = open("allWords.txt", "w")
	for i in allWords:
		i = i + "\n"
		textFile.write(i)
	textFile.close()
	
def uniqueWords():
	with open("allWords.txt") as allWords:
		uniqueWords = set(allWords)
		textFile = open("uniqueWords.txt", "w")
		for i in uniqueWords:
			i = i + "\n"
			textFile.write(i)
		textFile.close()

def main():
	writeAllWords("TheInvisibleMan.txt")
	uniqueWords()

main()