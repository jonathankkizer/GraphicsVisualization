String[] freqFile;

void setup() {
  size(500,500);
  //background(0);
  freqFile = loadStrings("wordfrequency.txt");
}

void draw() {
  text("ln(Word Frequency)", 215, 30);
  text("X-Axis: These Words Appear ln(x) Times", 100, 480);
  //textAlign(CENTER,CENTER);
  //translate(100,100);
  rotate(HALF_PI);
  text("Y-Axis: ln(y) Distinct Words", 250, 250);
  rotate(-HALF_PI);
  scale(1, -1);
  translate(0, -height);
  line(0, 40, 500, 40);
  line(40, 0, 40, 500);
  //rect(0,0,50,50);
  // iterate through each line of freqFile
  for (int i = 0; i < freqFile.length; i++) {
    String[] dotPosition = split(freqFile[i], ": ");
    Float xPos = (450/9) * log(Float.parseFloat(dotPosition[0])) + 50;
    Float yPos = (450/9) * log(Float.parseFloat(dotPosition[1])) + 50;
    strokeWeight(3);
    point(xPos, yPos);
    
  }
  
}