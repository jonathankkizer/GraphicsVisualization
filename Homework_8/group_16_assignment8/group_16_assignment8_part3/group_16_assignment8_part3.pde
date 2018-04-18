//Array of the 5 RSS feeds
RSS_Feed [] myRSSFeedArray = new RSS_Feed[5];

//Array of the titles of these feeds - hardcoded as they are not on the XML file
String [] arrayOfFeedTitles = new String[5];

//Specifying the source of the 5 RSS feeds, and creating an RSS_Feed object for each
String xmlSource1 = "https://www.nasa.gov/rss/dyn/shuttle_station.rss";
RSS_Feed my_RSS_Feed1; 
String xmlSource2 = "https://www.nasa.gov/rss/dyn/solar_system.rss";
RSS_Feed my_RSS_Feed2;
String xmlSource3 = "https://www.nasa.gov/rss/dyn/earth.rss";
RSS_Feed my_RSS_Feed3;
String xmlSource4 = "https://www.nasa.gov/rss/dyn/aeronautics.rss";
RSS_Feed my_RSS_Feed4;
String xmlSource5 = "https://www.nasa.gov/rss/dyn/hurricaneupdate.rss";
RSS_Feed my_RSS_Feed5;

//The canvas initially has the first (0th index) RSS feed selected and the current feed selected is stored as an object
int indexOfCurrentRSSFeedSelected = 0;
RSS_Feed currentRSSFeed;

//A description of article titles will be shown upon hovering the mouse, these are stores in this string
String descriptionToShow;

//The current page of the current RSS feed - each RSS reed has multiple pages of article titles
Page currentPage;

//Radio button globals - radio button class borrowed from Dr. Abraham's lecture notes
Radio[] radioButtons = new Radio[5]; 
ButtonRect previousButton;
ButtonRect nextButton;

//Animated rocket sprite globals
PImage frameToShow;
String fileNameOfDesiredFrame;



void setup() {
  
   frameRate(60);
   size(500,500);
   fill(0);
  
   //creating the previous and next button to navigate the pages in an RSS Feed
   previousButton = new ButtonRect(10, 325, 80, 20, color(0), color(0));
   nextButton = new ButtonRect(410, 325, 80, 20, color(0), color(0));
 
   //creating the RSS feed objects and storing them in the array of RSS feeds
   my_RSS_Feed1 = new RSS_Feed(xmlSource1);
   my_RSS_Feed2 = new RSS_Feed(xmlSource2);
   my_RSS_Feed3 = new RSS_Feed(xmlSource3);
   my_RSS_Feed4 = new RSS_Feed(xmlSource4);
   my_RSS_Feed5 = new RSS_Feed(xmlSource5);
   myRSSFeedArray[0] = my_RSS_Feed1;
   myRSSFeedArray[1] = my_RSS_Feed2;
   myRSSFeedArray[2] = my_RSS_Feed3;
   myRSSFeedArray[3] = my_RSS_Feed4;
   myRSSFeedArray[4] = my_RSS_Feed5;
   
   //hard coding the RSS feed titles since they were not on the XML files
   arrayOfFeedTitles[0] = "Space Station News";
   arrayOfFeedTitles[1] = "Solar System and Beyond News";
   arrayOfFeedTitles[2] = "Earth News";
   arrayOfFeedTitles[3] = "Aeronautics News";
   arrayOfFeedTitles[4] = "Hurricane Updates";
   
   //creating the radio buttons
   for (int i = 0; i < radioButtons.length; i++) {
    int x = 15 + i*35;
    radioButtons[i] = new Radio(x, 40, 10, color(255), color(0), i, radioButtons);
   }
  
   //radio button 1 (index 0) is pressed by default
   radioButtons[0].isChecked = true;
  
   //start by showing frame 1 of spaceship animation
   frameToShow =  loadImage("spaceshipFrame1.jpg");
   frameToShow.resize(35,35);
 
}

void draw() {
  
  frameRate(60);
  background(147,228,229); 
 
 
  textSize(16);
  text("Select an RSS feed:", 5, 20);
  
  //radio buttons - show them and check which is pressed
  displayRadioButtonsAndCheckWhichIsPressed();
  
  //previous button
  previousButton.update(mouseX, mouseY);
  previousButton.display();
  fill(255);
  textSize(16);
  text("Previous",15,340);
  
  //next button
  nextButton.update(mouseX, mouseY);
  nextButton.display();
  fill(255);
  textSize(16);
  text("Next",430,340);
  
  //show the rocketship frame
  if (frameCount % 10 == 0) {
    fileNameOfDesiredFrame = "spaceshipFrame" + nf((frameCount/10)%6 +1,1) + ".jpg";
    frameToShow = loadImage(fileNameOfDesiredFrame);
    frameToShow.resize(35,35);
    image(frameToShow,172,25);
    
  }
  image(frameToShow,172,25);
  
  //determine the current RSS feed, the current page of that RSS feed, and display that page
  currentRSSFeed = myRSSFeedArray[indexOfCurrentRSSFeedSelected];
  currentPage = currentRSSFeed.arrayOfPages[currentRSSFeed.indexOfCurrentPage];
  currentRSSFeed.display();

  //for the current page of the currrent RSS feed, check if you need to show the description
  descriptionToShow = currentPage.checkIfYouNeedToShowDescription();
  textSize(12);
  text("Description:\n" + descriptionToShow, 10, 380);
  
  //Lines which appear on the screen to denote different sections
  rect(0,60,500,2); //horizontal line
  rect(172,0,2,60); //vertical line
  rect(0,355,500,2); //horizontal line 
  rect(180,25,320,2); //horizontal line 
  
  //Who is providing the feed and date of creation
  text("NASA RSS - feeds created 03/11/2015",240,48);
  
}
 
 
 
void displayRadioButtonsAndCheckWhichIsPressed(){
   for (int i = 0; i < radioButtons.length; i++) {
      radioButtons[i].display();
      fill(0);
      if (radioButtons[i].isChecked) {
        textSize(16);
        text("Feed " + str(i+1) + ": " + arrayOfFeedTitles[i],180,18);
        //if the first radio button is pressed then RSSfeed index 0 is the one which has been selected
        indexOfCurrentRSSFeedSelected = i;
      }
   }
}
 
void mousePressed() {
  
  //on the current page, check is a description is clicked and if so then open browser to navigate to the link
  currentPage.checkIfYouNeedToOpenLink();
  
  //checks if the radio buttons are clicked
  for (Radio r : radioButtons) {
    r.isPressed(mouseX, mouseY);
  }
  
  //checks if previous button is clicked and if so then go to the previous page (the pages loop around, pressing back on the first page goes to the last page)
  //this is currently hard coded to go between the first and second page since the logic wasnt working and you didnt care to figure out why
   if (previousButton.isPressed()) {
      if ( myRSSFeedArray[indexOfCurrentRSSFeedSelected].indexOfCurrentPage == 1) {
       myRSSFeedArray[indexOfCurrentRSSFeedSelected].indexOfCurrentPage = 0;
     } else {
       myRSSFeedArray[indexOfCurrentRSSFeedSelected].indexOfCurrentPage = 1;
     }
     /*
    myRSSFeedArray[indexOfCurrentRSSFeedSelected].pageCounterIncrement -= 1;
    int indexOfPageToShow = ( myRSSFeedArray[indexOfCurrentRSSFeedSelected].pageCounterIncrement % myRSSFeedArray[indexOfCurrentRSSFeedSelected].arrayOfPages.length);
    
    //catching an index error = if you try to go to the -1 then actually go to the last one, and then reset the pageCounterIncrement to avoid future errors
    if (indexOfPageToShow == -1) {
      indexOfPageToShow = myRSSFeedArray[indexOfCurrentRSSFeedSelected].arrayOfPages.length - 1;
      myRSSFeedArray[indexOfCurrentRSSFeedSelected].pageCounterIncrement = 0;
    }
    
    println(myRSSFeedArray[indexOfCurrentRSSFeedSelected].indexOfCurrentPage);
    myRSSFeedArray[indexOfCurrentRSSFeedSelected].indexOfCurrentPage = indexOfPageToShow;
    */
   
  }
  
  //checks if next button is clicked and if so then go to the next page (the pages loop around, pressing next on the last page goes to the first page)
  //this is currently hard coded to go between the first and second page since the logic wasnt working and you didnt care to figure out why
   if (nextButton.isPressed()) {
     if ( myRSSFeedArray[indexOfCurrentRSSFeedSelected].indexOfCurrentPage == 1) {
       myRSSFeedArray[indexOfCurrentRSSFeedSelected].indexOfCurrentPage = 0;
     } else {
       myRSSFeedArray[indexOfCurrentRSSFeedSelected].indexOfCurrentPage = 1;
     }
     /*
    myRSSFeedArray[indexOfCurrentRSSFeedSelected].pageCounterIncrement += 1;
    int indexOfPageToShow = ( myRSSFeedArray[indexOfCurrentRSSFeedSelected].pageCounterIncrement % myRSSFeedArray[indexOfCurrentRSSFeedSelected].arrayOfPages.length);
    myRSSFeedArray[indexOfCurrentRSSFeedSelected].indexOfCurrentPage = indexOfPageToShow;
    */
  }
 
}