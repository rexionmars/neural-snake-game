final int SIZE = 20;
final int hidden_nodes = 16;
final int hidden_layers = 2;
final int fps = 200;  //15 is ideal for self play, increasing for AI does not directly increase speed, speed is dependant on processing power

int highscore = 0;

float mutationRate = 0.10;
float defaultmutation = mutationRate;

boolean humanPlaying = false;  //false for AI, true to play yourself
boolean replayBest = true;  //shows only the best of each generation
boolean seeVision = true;  //see the snakes vision
boolean modelLoaded = false;

PFont font;

ArrayList<Integer> evolution;


Snake snake;
Snake model;

Population pop;

public void settings() {
  size(1200,680);
}

void setup() {
  font = createFont("agencyfb-bold.ttf",32);
  evolution = new ArrayList<Integer>();
  frameRate(fps);
  if(humanPlaying) {
    snake = new Snake();
  } else {
    pop = new Population(2000); //adjust size of population
  }
}

void draw() {
  background(#1C2128); // Window background
  noFill();
  //fill(#000000);
  //stroke(0);
  //line(400,0,400,height);
  rectMode(CORNER);
  rect(400 + SIZE,SIZE,width-400-40,height-40);
  textFont(font);
  if(humanPlaying) {
    snake.move();
    snake.show();
    fill(150);
    textSize(12);
    text("SCORE : "+snake.score,500,50);
    if(snake.dead) {
       snake = new Snake(); 
    }
  } else {
    if(!modelLoaded) {
      if(pop.done()) {
          highscore = pop.bestSnake.score;
          pop.calculateFitness();
          pop.naturalSelection();
      } else {
          pop.update();
          pop.show(); 
      }
      fill(150);
      textSize(12);
      textAlign(LEFT);
      text("GEN : "+pop.gen,120,60);
      text("BEST FITNESS : "+pop.bestFitness,120,50);
      text("MOVES LEFT : "+pop.bestSnake.lifeLeft,120,70);
      text("MUTATION RATE : "+mutationRate*100+"%",120,80);
      text("SCORE : "+pop.bestSnake.score,120,height-15);
      text("HIGHSCORE : "+highscore,120,height-5);
    } else {
      model.look();
      model.think();
      model.move();
      model.show();
      model.brain.show(0,0,360,790,model.vision, model.decision);
      if(model.dead) {
        Snake newmodel = new Snake();
        newmodel.brain = model.brain.clone();
        model = newmodel;
        
     }
     textSize(25);
     fill(150);
     textAlign(LEFT);
     text("SCORE : "+model.score,120,height-45);
    }
  }

}

void keyPressed() {
  if(humanPlaying) {
    if(key == CODED) {
       switch(keyCode) {
          case UP:
            snake.moveUp();
            break;
          case DOWN:
            snake.moveDown();
            break;
          case LEFT:
            snake.moveLeft();
            break;
          case RIGHT:
            snake.moveRight();
            break;
       }
    }
  }
}
