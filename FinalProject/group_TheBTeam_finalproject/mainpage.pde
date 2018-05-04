class Mainpage{
  boolean isMouseOverPhase1;
  boolean isMouseOverPhase2;
  boolean isMouseOverBoss;
  boolean isMouseOverSound;
  
void display(){
  
  image(backgroundPicture,0,0);
  image(beeicon,250,100);   
  image(sound, 720,30);
  fill(60*sin(frameCount*0.1)+122,60*sin(frameCount*0.1)+122,0);
    textSize(50);
    text("BEE GAME",290,500);
  fill(224,68,25);
  textSize(20);
  text("HOW TO PLAY: Control bees with mouse, avoid birds and other obstacles.\nAchieve the fastest time! Press Spacebar to use collected powerups.\nTip: Don't Start your mouse in the middle of the canvas.",50,700);
  
  if(isMouseOverPhase1){
      
      fill(34,113,10); 
      textSize(30);
      
      text("level 1 high score:"+str(level1HighScore),20,650);
      fill(177,232,138);
    
  }else{
   
  fill(92,175,105);}
  rect(100,550,150,50);
  fill(0);
  textSize(30);
  text("Level 1",130,585);

  if(isMouseOverPhase2){
      fill(234,184,17); 
      textSize(30);
      
      text("level 2 high score:"+str(level2HighScore),230,650);
  fill(252,238,125);
  
}
  else{
  fill(216,192,52);
}
  rect(325,550,150,50);
  fill(0);
  textSize(30);
  text("Level 2",355,585);
  
  if(isMouseOverBoss){
      fill(209,61,78); 
      textSize(30);
      
      text("Level 3 high score:"+str(bossHighScore),470,650);
    fill(252,129,115);
  }
    else{
      fill(188,92,82);
  }
  rect(550,550,150,50);
  fill(0);
  textSize(30);
  text("Level 3 ",580,585);
 
}




  void update(int mx, int my){
    if(mx>720 && mx<720+sound.width && my>35 && my<35+sound.height){
      isMouseOverSound=true;}
      else{isMouseOverSound=false;}
    if(mx>100 && mx<250 && my>550 && my<600){
      isMouseOverPhase1=true;}
      else{isMouseOverPhase1=false;
      }
    if(mx>325 && mx<475 && my>550 && my<600){
      isMouseOverPhase2=true;}
      else{isMouseOverPhase2=false;
      }
    if(mx>550 && mx<700 && my>550 && my<600){
      isMouseOverBoss=true;}
      else{isMouseOverBoss=false;
      }
    }
    
    
}