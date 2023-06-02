## Download and Run
To run the program you will need [Processing](https://processing.org/)

## Snake
### Neural Network
Each snake contains a neural network. The neural network has an input layer of 24 neurons, 5 hidden layers of 18 neurons, and one output layer of 4 neurons. 
Note: Network can now be customized with the number of hidden layers as well as the number of neurons in the hidden layers.
### Vision
The snake can see in 8 directions. In each of these directions the snake looks for 3 things:
+ Distance to food
+ Distance to its own body
+ Distance to a wall

This project is based on: https://github.com/greerviau/SnakeAI
