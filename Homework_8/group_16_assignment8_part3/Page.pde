//Each page gets an array of articles and bullet points
//the articles are so that the page has the titles and links and descriptions,
//the bullet points provide the bounds of each bulletpoint so the code can detect when the mouse is over them

class Page {
  
  Article[] arrayOfArticles;
  BulletPoint[] arrayOfBulletPoints;
  
  
  Page(Article[] arrayOfArticles) {
    this.arrayOfArticles = arrayOfArticles;
    
    //same number of bullet points as articles since each article has a bullet point
    arrayOfBulletPoints = new BulletPoint[arrayOfArticles.length];
    //create the bullet points
    createArrayOfBulletPoints(arrayOfArticles);
  }
  
  void createArrayOfBulletPoints(Article[] arrayOfArticles) {
    
    //each bullet point would like to know which number bullet point it is (hence passing in i) and also the article it gets attached to
    for(int i = 0; i < arrayOfArticles.length; i++ ) {
      //call a function to fill based on the description, maybe key word searh
      if (arrayOfArticles[i] != null) {
        //print(i);
        arrayOfBulletPoints[i] = new BulletPoint(arrayOfArticles[i], i);
        
      }
    }
  }
  

  void display() {
    
    //display all the bullet points
        for(int i = 0; i < arrayOfBulletPoints.length; i++) {
          arrayOfBulletPoints[i].display();
        }
        
        fill(0); //back to default black fill color
        
      }
        
  //called by the main function, the page detects if the mouse is over one of its bullet points and if so show the description
  String checkIfYouNeedToShowDescription() {

    //check if the mouse is over any of the bullet points and if so return its description
    for(int i = 0; i < arrayOfBulletPoints.length; i++) {
       if (mouseX > arrayOfBulletPoints[i].upperLeftX && mouseX < arrayOfBulletPoints[i].upperLeftX + arrayOfBulletPoints[i].clickBoxWidth 
       && mouseY > arrayOfBulletPoints[i].upperLeftY && mouseY < arrayOfBulletPoints[i].upperLeftY + arrayOfBulletPoints[i].clickBoxHeight) {
         
         return stringButWithNewLineCharacters(arrayOfBulletPoints[i].articlePassedIn.itemDescription);
      }
      
    }
    
    return "";
    
  }
  
  //changes the description to add new line characters so the description doesnt go off the screen
  String stringButWithNewLineCharacters(String myString) {
    //source of this genius code which adds a - and new line break every 70 characters: 
    //https://stackoverflow.com/questions/10530102/java-parse-string-and-add-line-break-every-100-characters
    return myString.replaceAll("(.{70})", "$1-\n");
    
  }
  
  //called by the main function, the page detects if the mouse clicks one of its bullet points and if so opens the link
  void checkIfYouNeedToOpenLink() {
    
    for(int i = 0; i < arrayOfBulletPoints.length; i++) {
       if (mouseX > arrayOfBulletPoints[i].upperLeftX && mouseX < arrayOfBulletPoints[i].upperLeftX + arrayOfBulletPoints[i].clickBoxWidth 
       && mouseY > arrayOfBulletPoints[i].upperLeftY && mouseY < arrayOfBulletPoints[i].upperLeftY + arrayOfBulletPoints[i].clickBoxHeight) {
         
         //println(i);
         link(arrayOfBulletPoints[i].articlePassedIn.itemLink);
      }
      
    }
    
  }
  
  
}