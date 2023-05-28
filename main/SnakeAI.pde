final int SIZE = 10;
final int hidden_nodes = 16;
final int hidden_layers = 2;
final int fps = 100;  //15 is ideal for self play, increasing for AI does not directly increase speed, speed is dependant on processing power

int highscore = 0;

float mutationRate = 0.05;
float defaultmutation = mutationRate;

boolean humanPlaying = false;  //false for AI, true to play yourself
boolean replayBest = true;  //shows only the best of each generation
boolean seeVision = false;  //see the snakes vision
boolean modelLoaded = false;

PFont font;

ArrayList<Integer> evolution;

Button increaseMut;
Button decreaseMut;


Snake snake;
Snake model;

Population pop;

public void settings() {
  size(1000,660);
}

void setup() {
  font = createFont("agencyfb-bold.ttf",32);
  evolution = new ArrayList<Integer>();
  increaseMut = new Button(340,85,20,20,"+");
  decreaseMut = new Button(365,85,20,20,"-");
  frameRate(fps);
  if(humanPlaying) {
    snake = new Snake();
  } else {
    pop = new Population(2000); //adjust size of population
  }
}

void draw() {
  background(#E5E5E5);
  
  //background(255);
  //rect(0, 0, width, borderStroke); // Top
  //rect(width-borderStroke, 0, borderStroke, height); // Right
  //rect(0, height-borderStroke, width, borderStroke); // Bottom
  //rect(0, 0, borderStroke, height); // Left

  noFill();
  //fill(#000000);
  stroke(0);
  line(400,0,400,height);
  rectMode(CORNER);
  rect(400 + SIZE,SIZE,width-400-20,height-20);
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
      increaseMut.show();
      decreaseMut.show();
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
    /*
    textAlign(LEFT);
    textSize(18);
    fill(#FFB16F);
    text("ORANGE < 0",120,height-75);
    fill(#9B9B9B);
    text("GRAY > 0",200,height-75);
    graphButton.show();
    loadButton.show();
    saveButton.show();
    */
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
