PFont courier;
String[] wordHistory;
String currentLineString;
String[] uniqueWords;
int yPos;
int lineCounter;
int xPos;

void setup() {
  size(700,600);
  courier = createFont("Courier", 32);
  textFont(courier);
  
  uniqueWords = loadStrings("uniquewords.txt");
  
  currentLineString = "";
  lineCounter = 0;
  yPos = 32;
}

void draw() {
  if (lineCounter <= 17) {
    populateLineString();
  }
}

void populateLineString() {
  currentLineString = "";
  String currentWord = "";
  xPos = 5;
  while (textWidth(currentLineString) + textWidth(currentWord) < width) {
    //text(currentWord, xPos, yPos);
    if (currentWord.length() <= 5) {
      fill(255,0,0);
    } else if (currentWord.length() <= 9 & currentWord.length() > 5) {
      fill(0,255,0);
    } else if (currentWord.length() > 9) {
      fill(0,0, 255);
    }
    //currentWord = "";
    currentLineString += currentWord + " ";
    //println(currentLineString);
    text(currentWord, xPos, yPos);
    xPos += textWidth(currentWord) + textWidth(" ");
    int randomIndex = (int)random(3290);
    currentWord = uniqueWords[randomIndex];
  }
  yPos += 32;
  lineCounter += 1;
}