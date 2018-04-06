class Timer {
  
  float elapsedTime; //total time ellapsed, time is paused when the game/timer is paused
  float elapsedTimeOfAllPauses; //sum of the duration of all pauses
  float elapsedTimeOfMostRecentPause; //just the elapsed time of most recent pause
  float absoluteTimeAtMostRecentPause; //the mills() value at the most recent pause
  
  boolean currentlyRunning;
  
  Timer(boolean shouldTheTimerStartWhenCreated) {
   this.elapsedTime = millis();
   this. elapsedTimeOfAllPauses = 0.0;
   this.elapsedTimeOfMostRecentPause = 0.0;
   this.currentlyRunning = shouldTheTimerStartWhenCreated;
  }
  
  void resume() {
    if (!currentlyRunning)  { //meaning if the game is paused
      
      this.currentlyRunning = true;
      elapsedTimeOfMostRecentPause = millis() - absoluteTimeAtMostRecentPause;
      this.elapsedTimeOfAllPauses +=  elapsedTimeOfMostRecentPause;
      
      
    }
    //important: relooping after you do resume
    loop();
    
  }
  
  void pause() {
    if(currentlyRunning) {
      
      absoluteTimeAtMostRecentPause = millis();
      currentlyRunning = false;
    }
    //important: calling noLoop(); after pausing
    noLoop();

  }
  
  float getElapsedTime() {
    
    if (currentlyRunning == true) {
      
      this.elapsedTime = millis() - elapsedTimeOfAllPauses;
      return this.elapsedTime;
      
    } else {
      return millis() - this.absoluteTimeAtMostRecentPause; //this is fine because remember you call noLoop() after pausing
    }
  }
  

}