class Food {
    PVector pos;
    
    Food() {
      int x = 500 + SIZE + floor(random(10))*SIZE;
      int y = SIZE + floor(random(10))*SIZE;
      pos = new PVector(x,y);
    }
    
    void show() {
       stroke(0);
       fill(#EDDC11);
       rect(pos.x,pos.y,SIZE,SIZE);
    }
    
    Food clone() {
       Food clone = new Food();
       clone.pos.x = pos.x;
       clone.pos.y = pos.y;
       
       return clone;
    }
}
