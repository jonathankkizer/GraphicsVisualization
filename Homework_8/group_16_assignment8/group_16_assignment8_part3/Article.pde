//Article class wraps the articles which are parsed from the XML file, code borrowed from a piazza post

class Article{
  String itemTitle;
  String itemLink;
  String itemDescription;
  
  Article(String itemTitle, String itemLink, String itemDescription){
    this.itemTitle = itemTitle;
    this.itemLink = itemLink;
    this.itemDescription = itemDescription;
  }
  
}