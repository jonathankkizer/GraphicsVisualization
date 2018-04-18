class College{
  float accrate;
  int top10perc;
  int x=20;
  int y=20;
  
  College(float accrate, int top10perc){
    this.accrate = accrate;
    this.top10perc=top10perc;
  }
  
  void display(){
   
    text(accrate,10,10);
  }
  
}