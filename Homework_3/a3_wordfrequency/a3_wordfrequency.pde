String[] freqFile; // Declaring our global file which is populated in setup()

void setup() {
  size(500,500);
  freqFile = loadStrings("wordfrequency.txt"); //Load the file which lists the word frequency vs how many words had that frequency
  fill(0);
}

void draw() {
  
  fill(26, 125, 198); // Dark blue for title and axis labels
  text("ln(Number of Words) vs. ln(Word Frequency)", 175, 30);
  text("ln(Word Frequency)", 220, 490);
  text("l\nn\n(\nN\nu\nm\nb\ne\nr\n \no\nf\n \nW\no\nr\nd\ns\n)\n", 10, 90); //Printing vertially
  
  
  fill(0); // Black for the axis and tick marks
  
  //positions were determined using hand calculations, x is a constant we used as a shifting factor in the positions of certain elements
  int x = 15;
  
  // x-axis tick mark labels
  text("2", 187.5-x-5,470);
  text("4", 295-x-5,470);
  text("6", 402.5-x-5,470);
  text("8", 505-x+2,470);
  
  // y-axis tick mark labels
  text("8", 35,187.5-175);
  text("6", 35,295-175);
  text("4", 35,402.5-175);
  text("2", 35,505-175);
  
  // changing the coordinate systems to allow us to plot x,y points using the traditional/intuitive x-y coordinates
  scale(1, -1);
  translate(0, -height);
  
  // x and y axes
  line(70, 70, 500, 70);
  line(70, 70, 70, 500);
  
  
  // Iterate through each line of freqFile and add the point on the graph
  for (int i = 0; i < freqFile.length; i++) {
    
    // each line of the text file is an element of the frequency file, which we turn into an array that indicates the x and y position to be plotted
    String[] dotPosition = split(freqFile[i], ": ");
    // Natural log scale
    Float xPos = (450/9) * log(Float.parseFloat(dotPosition[0])) + 74;
    Float yPos = (450/9) * log(Float.parseFloat(dotPosition[1])) + 72;
    strokeWeight(3);
    point(xPos, yPos);
    
  }
  
  // These lines draw all of the black tick marks, with positions determined by hand 
  // calculations based on screen width, height, and other elements on the canvas
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