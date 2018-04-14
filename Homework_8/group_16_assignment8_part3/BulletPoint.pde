//each bulletpoint on a page
//the point of this class is so the page knows the bounds of each bullet points, so each bulletpoint has
//its bounds in addition to the article passed in

class BulletPoint {

  Article articlePassedIn;
  int upperLeftX;
  int upperLeftY;
  int clickBoxWidth;
  int clickBoxHeight;
  int numberBulletOnThisPage;
  
  BulletPoint(Article articlePassedIn, int numberBulletOnThisPage) {
    this.articlePassedIn = articlePassedIn;
    
    //the bulletpoint needs to know if it is the 2nd bullet point, for example, so it knows where to position itself
    this.numberBulletOnThisPage = numberBulletOnThisPage;
    
    this.upperLeftX = determineUpperLeftXValue();
    this.upperLeftY = determineUpperLeftYValue();
    this.clickBoxWidth = determineClickBoxWidth();
    this.clickBoxHeight = determineClickBoxHeight();
    
  }
  
  void display() {
       //determine fill color based on keyword, bullet point (the circle itself) is the same color as the text
        determineAndSetFillColor(articlePassedIn.itemTitle);
        ellipse(20, 100 + numberBulletOnThisPage*35, 15, 15);
        //the font size of the article title will scale based on how long the article title is so that it fits on the screen
        //potential improvement: have it span multiple lines instead
        
        float fontSizeScalingFactor = float(articlePassedIn.itemTitle.length())/75.0;
        float textSize = min(12.0,12.0/fontSizeScalingFactor);
        textSize(textSize);
        text(articlePassedIn.itemTitle,35, 105 + numberBulletOnThisPage*35);
  }
  
  
  void determineAndSetFillColor(String articleTitle) {
    
    if(articleTitle.indexOf("NASA") != -1 && articleTitle.indexOf("SpaceX") != -1)  {
      fill(255,0,255); //has spaceX and NASA in title
    } else {
      
      if (articleTitle.indexOf("NASA") != -1) {
        fill(255,0,0); //has just nasa
      }
      
      if (articleTitle.indexOf("SpaceX") != -1) {
        fill(0,0,255); //has just SpaceX
      } 
      
      if (articleTitle.indexOf("NASA") == -1 && articleTitle.indexOf("SpaceX") == -1) {
        fill(0); //default black
      } 
      
    }
 
  }
  
  //these values are sort of hard coded based on the spacing determined in the display class
  int determineUpperLeftXValue() {
    
    return 20; //all bulletpoints start at x value of 20
  }
  
  int determineUpperLeftYValue() {
    //2nd bullet point lower than 1st bullet point
    return 90 + this.numberBulletOnThisPage*35;
  }
  
  int determineClickBoxWidth() {
    
    return 500; //potential improvement: change to be based on how long the string is
  }
  
  int determineClickBoxHeight() {
    
    return 20; //guess and checked value, makes the article title clickbox seem decent
  }
  
  
}