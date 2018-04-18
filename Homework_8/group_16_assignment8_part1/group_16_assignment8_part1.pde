ArrayList<College> collegelist;
Table table;
Slider s;
int x=100;
int value=0;
void setup(){    
  size(500,500);
  s = new Slider(20,480,width,10,0,400);
  collegelist = new ArrayList<College>();
  table = loadTable("College.csv", "header");
  for (TableRow row: table.rows()){
    float accrate=row.getFloat("Accrate");
    int top10perc=row.getInt("Top10perc");

    College school=new College(accrate,top10perc);
    collegelist.add(school);    
     }
   
}

void draw(){
  int x = int(s.getVal());
  
  background(0);
  drawbar(x);  
  //noLoop();
  s.update(mouseX, mouseY);
  s.display();
  label();
}


void mousePressed() {
  s.pressed(mouseX, mouseY);
}

void mouseReleased() {
  s.released();
}

void drawbar(int w){
  //strokeWeight(2);
  //noFill();
  pushMatrix();
  translate(80,-130);
  
  scale(4,5);
  for (int i=0; i<(99);i=i+w){
    float counter = 0.00;
    float total = 0.00;
    float average = 0.00;
    for(College item: collegelist){
      if (item.top10perc>i && item.top10perc<i+w){
        counter+=1;
        total+=item.accrate;
      }
    }
    average= total/counter;
    if(counter==0){average=0;}    
    stroke(240,226,119);
    strokeWeight(0.5);
    fill(240,159,119);
    rect(i,100-average*50,w,average*50);
  }
  popMatrix();
  
}

void label(){
  stroke(#FFFFFF);
  strokeWeight(4);
  line(80,130,80,370);
  line(80,370,480,370);
  textSize(25);
  fill(222,120,92);
  text("Statistics for College Acceptance Rate",15,20);
  textSize(15);
  fill(247,245,217);
  text("Y-axis: Average acceptance rate for colleges with similar percent",15,40);
  text("of new students who were top 10% students in high school.",50,55);
  text("X-axis: Percent of new students from top 10% of highschool class.",15,70);
  text("0",55,390);text("10",118,390);text("20",156,390);text("30",194,390);text("40",232,390);text("50",270,390);
  text("60",308,390);text("70",346,390);text("80",384,390);text("90",422,390);text("100%",460,390);
  text("0.8",55,170);text("0.6",55,220);text("0.4",55,270);text("0.2",55,320);
  text("Avg Accpt Rate", 30,110);
  text("Pct new student from top10%HS class",200,420);
  text("Scroll bar to control range width",20,470);
  
}

void keyPressed(){
  if (value == 'a'){
    drawbar(x);
  
  if (x<=5){drawbar(5);}
  else{x-=1;}
  }
}
    