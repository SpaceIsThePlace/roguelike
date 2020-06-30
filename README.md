## Introduction
This is my entry for /r/roguelikedev Roguelike tutorial.
I will start by making a very simple roguelike (movement, randomly generated dungeon, permadeath, monster with limited IA), and then plan to expand it once the basics are done.
The idea is to develop a full roguelike with some light tower-defense mechanics (not sure how they're going to work yet in a turn-based game).
The roguelike will be fully developed using Godot + GDScript. Tiles are from here: https://www.kenney.nl/assets/bit-pack.

## Mechanics
* Turn-based (everything moves after the player makes his/her movement)
* Randomly generated dungeon
* Permadeath
* Different classes
* Light tower-defense mechanics:
** Enemies keeps spawning for n number of rounds 
** The player has to defend a static item (probably a tree) for n + x turns
** The player can set up traps, turrets, and spawn creatures (might be class-based)
** After n + x turns, the item no longer needs protecting, and the player can access a portal to go to a new stage

## Implementation
* I've created a Game scene that is in charge of drawing the map (TBD) instantiating player and enemies, and update the world when the player moves
* I've decided not to use _process(delta) for the main game loop. Instead, the Player scene instance uses an _input() function that register the moves, instructs the player to move (if move is available), sends a signal to the Scene that in turn instructs the enemies group to perform their next action (for now, they just move to a random direction)
* The Game scene holds a list with a dictionary corresping to all the tiles. Each tile as an id (TBD), a type (tileset id), coordinates, a bool that defines if it walkable, and a bool that defines if it blocks the view.