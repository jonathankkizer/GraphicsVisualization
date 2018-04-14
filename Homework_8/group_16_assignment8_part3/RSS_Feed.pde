//each RSS feed has a name, an arrayList of Articles (Article is a class)
//and will then create the feed - which is created by creating the pages as an array of pages

class RSS_Feed {
  
  String xmlFileName;
  ArrayList<Article> myArticles;
  String itemTitle;
  String itemLink;
  String itemDescription;
  
  Page[] arrayOfPages;
  int indexOfCurrentPage;
  int pageCounterIncrement;
  
  //constructor
  RSS_Feed(String xmlFileName) {
    this.xmlFileName = xmlFileName;
    this. indexOfCurrentPage = 0;
    this. pageCounterIncrement = 0;
    makeTheDashboard();
    makeThePages();
  }
  
  void makeTheDashboard() {
    //XML parsing code code borrowed from a piazza post
    XML root = loadXML(xmlFileName);
    //returns an array of XML objects that are the children of the Articles
    XML[] Articles = root.getChild("channel").getChildren("item"); 
    //make an array list of all the Articles which you're storing as Article objects
    myArticles = new ArrayList<Article>();

    for(XML l: Articles){
      itemTitle = l.getChild("title").getContent(); 
      itemLink = l.getChild("link").getContent();
      itemDescription = l.getChild("description").getContent();
      //the Article objects 
      Article article = new Article(itemTitle, itemLink, itemDescription); 
      myArticles.add(article);   
    }
  
  }
 
  
  void makeThePages() {
    float sizeOfArticleArrayAsFloat = float(myArticles.size());
    float numberOfPagesFloat = 1.0 + ((sizeOfArticleArrayAsFloat - 0.001) / 6.0); //6 elements per page
    int numberOfPages = int(numberOfPagesFloat);
    
    //make an array of the articles since the page class wants an array
    Article[] myArticlesArray = new Article[myArticles.size()];
    for(int i = 0; i < myArticles.size(); i++) {
      myArticlesArray[i] = myArticles.get(i);
    }
    
    //The RSS Feed's array of pages
    arrayOfPages = new Page[numberOfPages];
    
    //Hard coding right now: if there is one page then the array of pages if only the contents of one page
    if (numberOfPages == 1) {
      arrayOfPages[0] = new Page(myArticlesArray);
    }
    
    //if there are two pages then the first page gets the first 6 articles and the second page gets the remaining articles
    //note that I did not bother hard coding a third page as the max was 2...this could be improved for more modular code when more articles appear
      else {
      Article[] arrayOfArticlesForPage1 = new Article[6];
      Article[] arrayOfArticlesForPage2 = new Article[min(6,myArticlesArray.length -6)];
      
      //making array of articles for page 1
      for(int i = 0; i < arrayOfArticlesForPage1.length; i++) {
        arrayOfArticlesForPage1[i] = myArticlesArray[i];
      }
      
      //making array of articles for page 2
      for(int i = 0; i < arrayOfArticlesForPage2.length; i++) {
        arrayOfArticlesForPage2[i] = myArticlesArray[i+6];
      }
      
      arrayOfPages[0] = new Page(arrayOfArticlesForPage1);
      arrayOfPages[1] = new Page(arrayOfArticlesForPage2);
    }

  }
  
   void display() {
     //displaying an RSS feed really means display the current page of that RSS feed
     displayCurrentPage();
     
   }

  
   //how the Article titles are color coded: titles with the word NASA are red, titles with the word SpaceX are blue, both words is purple, neither word is black
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
  
  
  void displayCurrentPage() {
    //displaying the current page
    arrayOfPages[indexOfCurrentPage].display();
    
  }
  
  
  
  

}