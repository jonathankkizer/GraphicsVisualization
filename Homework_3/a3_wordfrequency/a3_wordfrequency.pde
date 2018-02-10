String[] freqFile;

void setup() {
  size(500,500);
  //background(0);
  freqFile = loadStrings("wordfrequency.txt");
  fill(0);
}

void draw() {
  
  fill(26, 125, 198);
  text("ln(Word Frequency) vs. ln(Number of Words)", 175, 30);
  text("ln(Word Frequency)", 220, 490);
  text("l\nn\n(\nN\nu\nm\nb\ne\nr\n \no\nf\n \nW\no\nr\nd\ns\n)\n", 10, 90);
  fill(0);
  
  int x = 15;
  text("2", 187.5-x-5,470);
  text("4", 295-x-5,470);
  text("6", 402.5-x-5,470);
  text("8", 505-x+2,470);
  
  text("8", 35,187.5-175);
  text("6", 35,295-175);
  text("4", 35,402.5-175);
  text("2", 35,505-175);
  
  scale(1, -1);
  translate(0, -height);
  line(70, 70, 500, 70);
  line(70, 70, 70, 500);
  //rect(0,0,50,50);
  // iterate through each line of freqFile
  for (int i = 0; i < freqFile.length; i++) {
    String[] dotPosition = split(freqFile[i], ": ");
    Float xPos = (450/9) * log(Float.parseFloat(dotPosition[0])) + 80;
    Float yPos = (450/9) * log(Float.parseFloat(dotPosition[1])) + 80;
    strokeWeight(3);
    point(xPos, yPos);
    
  }
  fill(0);

  line(295-x,70,295-x,50);
  line(187.5-x,70,187.5-x,50);
  line(402.5-x,70,402.5-x,50);
  line(510-x,70,510-x,50);
  
  line(70, 295-x, 50, 295-x);
  line(70, 187.5-x, 50, 187.5-x);
  line(70, 402.5-x, 50, 402.5-x);
  line(70, 510-x, 50, 510-x);
  
}