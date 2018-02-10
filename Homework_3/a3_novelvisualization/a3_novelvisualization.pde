PFont courier;
String[] wordHistory;
String currentLineString;
String[] uniqueWords;
int yPos;
int lineCounter;
int xPos;

void setup() {
  size(700,600);
  background(0);
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
      fill(255,0 ,0);
    } else if (currentWord.length() <= 9 & currentWord.length() > 5) {
      fill(8,167,9);
    } else if (currentWord.length() > 9) {
      fill(0,255, 255);
    }
    //currentWord = "";
    currentLineString += currentWord + " ";
    //println(currentLineString);
    text(currentWord, xPos, yPos);
    xPos += textWidth(currentWord) + textWidth(" ");
    int randomIndex = (int)random(3270);
    currentWord = uniqueWords[randomIndex];
  }
  yPos += 32;
  lineCounter += 1;
}

void mouseClicked() {
  lineCounter = 0;
  background(0);
  yPos = 32;
}