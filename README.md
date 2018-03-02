Owner:
Matei Adrian

Project title:
'Nu te supara, frate!'

Description:
This is a Romanian board game written in plain Ruby (version 2.4.3).

Prerequisites:
Install Ruby(version 2.4.3 for the best compatibility).

How to run:
In you console, access the game folder;
Type "ruby main.rb"

Game Rules:
The game can have between 2 and 4 players.
Each player has a number of 4 pawn.
The players take turns to roll one dice.
When a player hits 6, he gets another turn.
At the start of the game, all the pawns are disabled.
You enable a pawn by hitting 6 with the dice. 
When you do so, a pawn is activated and put on the table and you roll again.
You can go over other pawns but it you stop on an appointment's pawn, you steal he's place and disable he's pawn.
The board has 40 positions. Once you complete them with a pawn, you need to send the pawn to one of 4 finish positions.
When you roll and the position you land on is already taken by another pawn or you overshoot the positions, the pawn gets reset to its last position and you lose your turn.
The winner is the one who puts all of he's pawns in these finish positions first.

Technical description:
The game has 3 classes: game, player and pawn

The Pawn class:
It has two state types: "active" and "finished". When it gets instantiated, there are set to false.
When the pawn gets set on the board, active is set true and when the pawn is set on a finished position, finished is set to true.
There are two ways of keeping track of the pawn position. One is by how many steps it has made and, also by its position relative to the board. 
The Pawn class has a number of methods that change its state: move, activate, reset, reset_position, finish.

The Player class:
The functionalities of this class are to instantiate the pawns, act on the Pawn class and decide the actions to take, just like in real life.
Its main functions are to roll the dice, select the appropriate pawn and act on it as the rules dictate.

The Game class
The main duties of this class are to instantiate the players and determine the flow of the game.
This implies defining the player's turns.
