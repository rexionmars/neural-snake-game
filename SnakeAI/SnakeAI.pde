final int SIZE = 20;
final int hidden_nodes = 22;
final int hidden_layers = 5;
final int fps = 200;  //15 is ideal for self play, increasing for AI does not directly increase speed, speed is dependant on processing power

int highscore = 0;

float mutationRate = 0.05;
float defaultmutation = mutationRate;

boolean humanPlaying = false;  //false for AI, true to play yourself
boolean replayBest = true;  //shows only the best of each generation
boolean seeVision = false;  //see the snakes vision
boolean modelLoaded = false;

PFont font;

ArrayList<Integer> evolution;


Snake snake;
Snake model;

Population pop;

public void settings() {
  size(1200,640);
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
  //stroke(0)
  strokeWeight(1);;
  //line(400,0,400,height);
  rectMode(CORNER);
  rect(400 + SIZE,SIZE,width-400-40,height-40);
  textFont(font);
  if(humanPlaying) {
    snake.move();
    snake.show();
    fill(130);
    textSize(12);
    text("SCORE : "+snake.score,300,30);
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
      fill(130);
      textSize(12);
      textAlign(LEFT);
      text("GEN : "+pop.gen,120,height-60);
      text("BEST FITNESS : "+pop.bestFitness,120,height-30);
      text("MOVES LEFT : "+pop.bestSnake.lifeLeft,120,height-40);
      text("MUTATION RATE : "+mutationRate*100+"%",120,height-50);
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
     fill(130);
     textAlign(LEFT);
     text("SCORE : "+model.score,120,height-45);
    }
  }

}
