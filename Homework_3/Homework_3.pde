PFont courier;
String[] wordHistory;
String currentLineString;
String[] uniqueWords;
int yPos;
int lineCounter;

void setup() {
  size(700,600);
  courier = createFont("Courier", 32);
  textFont(courier);
  
  uniqueWords = loadStrings("uniquewords.txt");
  
  currentLineString = "";
  lineCounter = 0;
}

void draw() {
  if (lineCounter <= 17) {
    populateLineString();
  }
  text(currentLineString, 0, yPos);
}

void populateLineString() {
  currentLineString = "";
  String currentWord = "";
  while (textWidth(currentLineString) + textWidth(currentWord) < width) {
    //currentWord = "";
    currentLineString += currentWord + " ";
    int randomIndex = (int)random(3290);
    currentWord = uniqueWords[randomIndex];
    //println(currentLineString);
  }
  yPos += 32;
  lineCounter += 1;
}