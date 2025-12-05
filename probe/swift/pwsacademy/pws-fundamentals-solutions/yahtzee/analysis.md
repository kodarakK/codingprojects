# Analysis for Yahtzee

This is an analysis document for Challenge 3: “Yahtzee”. It describes the requirements and scenarios for the solution project. Your analysis may be different, depending on the rules you chose to implement, but it should contain approximately the same information.

This analysis follows the iterations suggested in the challenge. Each requirement and scenario mentions the iteration it belongs to.

## Requirements

The main requirement is to implement the rules of Yahtzee as described here. Other requirements are listed below these rules.

### Rules

Yahtzee is a dice game in which players roll dice and assign their roll to a field on their score card. Each field expects a particular combination of dice and awards points accordingly.

The game lasts until each player has taken thirteen turns, after which the player with the most points wins.

#### Rolling and rerolling (iteration 1)

On their turn, a player rolls five dice. The player can then use up to two rerolls to improve their roll.

Before every reroll, the player may reserve any dice; these dice aren’t rerolled. Dice reserved before the first reroll may be rerolled during the second reroll.

#### Scoring fields (iteration 2)

After the second reroll — or earlier, if the player is happy with their roll — the player assigns their roll to an empty field on their card and scores that field. 

A score card has thirteen fields:

- **Upper section fields**: The upper section of a card contains six fields that correspond with the numbers one through six. Each field scores only dice that match its number. For example, a roll of **3 3 4 5 6** scores six points when assigned to **Threes** or **Sixes**, four points when assigned to **Fours**, five points when assigned to **Fives**, and zero points when assigned to **Ones** or **Twos**.
- **Three of a kind**: If the roll contains a set of three or more matching dice, this field scores points equal to the sum of all dice. If not, this field scores zero points. For example, **2 2 2 5 6** scores 17 points but **2 2 3 6 6** scores zero points.
- **Four of a kind**: If the roll contains a set of four or more matching dice, this field scores points equal to the sum of all dice. If not, this field scores zero points. For example, **2 2 2 2 3** scores 11 points but **1 1 3 3 5** scores zero points.
- **Full house**: This field scores 25 points if the roll contains a set of three matching dice and a *different* set of two matching dice. For example, **1 1 1 3 3** scores 25 points but **4 4 4 4 4** scores zero points.
- **Small straight**: This field scores 30 points if the roll contains a set of four or more sequential dice. If not, this field scores zero points. For example, **1 2 3 4 6** scores 30 points but **1 2 3 5 6** scores zero points.
- **Large straight**: This field scores 40 points if the roll consists of five sequential dice. If not, this field scores zero points. For example, **2 3 4 5 6** scores 40 points but **1 2 3 4 6** scores zero points.
- **Chance**: This field scores points equal to the sum of all dice. For example, **3 4 5 6 6** scores 24 points.
- **Yahtzee**: This field scores 50 points if all five dice show the same number. If not, this field scores zero points. For example, **1 1 1 1 1** scores 50 points.

After a player scores a field on their card, the turn moves clockwise to the next player.

#### Bonus points (iteration 3)

A player can receive the following bonus points:

- **Upper section bonus**: If a player’s upper section fields total 63 or more points, that player receives 35 bonus points. A total of 63 points corresponds with three of each of the numbers one through six, although a player isn’t required to roll three of each number; only their total score counts.
- **Additional Yahtzees**: If a player rolls a Yahtzee when they’ve already scored a Yahtzee on their card, that player receives 100 bonus points for each additional Yahtzee they roll. A player cannot receive bonus Yahtzee points if they have a zero in their Yahtzee field.

#### Jokers (iteration 3)

Players must score a field at the end of their turn. If a player rolls a Yahtzee when they’ve already used their Yahtzee field — even if it has a zero in it — their roll becomes a **joker** they can use to score another field. The player must score this joker immediately; they cannot continue rerolling.

If the upper section field for the number matching the dice is empty, the player must assign the joker to that field. Otherwise, the player is free to assign the joker to any empty field.

A player can use a joker to score a full house or straight. The player is then awarded the points for that field as if they’d rolled the correct combination. For all other fields, a joker scores like a regular roll, even if that results in a zero.

### User interface (iteration 1)

The game uses a single terminal to interface with the players.

### Multiple players (iteration 4)

The game must support multiple players. Upon starting, the game should ask the number of players and the name of each player. Players then take turns rolling the dice and scoring a field on their card, until all players have taken thirteen turns and have completed their card.

## Scenarios

The following scenarios describe the interactions between the players and the game. Each scenario includes one or more examples that show the expected input and output. 

### Scenario 1 (iteration 1)

This scenario describes the process of rolling and rerolling the dice.

1. The game rolls all five dice and displays their values to the player.
2. The game asks the player if they want to score their roll, or reroll the dice.
3. If the player chooses to score their roll, the turn ends.
4. Otherwise, the game asks the player which dice they want to reserve and the player enters the values of these dice.
5. The game rerolls the unreserved dice and displays the new roll.
6. Repeat Steps 2 through 5 for the second reroll.

Example 1.1, in which the player accepts their first roll:

```
You rolled: 2 2 2 6 6
Would you like to (r)eroll or (s)core your roll? s
```

Example 1.2, in which the player uses both rerolls:

```
You rolled: 1 2 5 6 6
Would you like to (r)eroll or (s)core your roll? r
Which dice would you like to reserve?
6 6
You rolled: 3 4 5 6 6
Would you like to (r)eroll or (s)core your roll? r
Which dice would you like to reserve?
3 4 5 6
You rolled: 2 3 4 5 6
```

### Scenario 2 (iteration 2)

This scenario describes a complete turn for a single player. It doesn’t yet include bonus Yahtzees or jokers.

1. The game displays the player’s score card. This informs the player of their progress and lets them pick a target to roll for.
2. The player rolls the dice according to previous scenario, with the following change. The game asks the player if they want to score their roll only if that roll is worth any points for any of the empty fields on the player’s card. Otherwise, the game assumes the player wants to reroll.
3. If this is the player’s final turn, the game assigns the player’s roll to the last empty field on their card and the turn ends.
4. Otherwise, the game checks how much the player’s roll is worth for all of the empty fields on their card and displays a selection of these fields.
5. The player selects a field to score.
6. The game scores the selected field.

Example 2.1, which starts with an empty card:

```
Your score card:
Ones: --
Twos: --
Threes: --
Fours: --
Fives: --
Sixes: --
Three of a kind: --
Four of a kind: --
Full house: --
Small straight: --
Large straight: --
Chance: --
Yahtzee: --

You rolled: 1 3 4 4 6
Would you like to (r)eroll or (s)core your roll? r
Which dice would you like to reserve?
4 4
You rolled: 1 1 4 4 4
Would you like to (r)eroll or (s)core your roll? s
Which field would you like to score:
1. Ones: 2
2. Twos: 0
3. Threes: 0
4. Fours: 12
5. Fives: 0
6. Sixes: 0
7. Three of a kind: 14
8. Four of a kind: 0
9. Full house: 25
10. Small straight: 0
11. Large straight: 0
12. Chance: 14
13. Yahtzee: 0
Your selection: 9
```

Example 2.2, in which the game assumes the player wants to reroll their first roll:

```
Your score card:
Ones: 3
Twos: 6
Threes: 9
Fours: 12
Fives: 15
Sixes: 12
Three of a kind: --
Four of a kind: 21
Full house: --
Small straight: --
Large straight: --
Chance: 19
Yahtzee: --

You rolled: 3 3 4 4 6
Which dice would you like to reserve?
3 3 4 4
You rolled: 3 3 4 4 4
Would you like to (r)eroll or (s)core your roll? s
Which field would you like to score:
7. Three of a kind: 18
9. Full house: 25
10. Small straight: 0
11. Large straight: 0
13. Yahtzee: 0
Your selection: 9
```

Example 2.3, in which the player takes their final turn:

```
Your score card:
Ones: 3
Twos: 6
Threes: 9
Fours: 12
Fives: 15
Sixes: 12
Three of a kind: 18
Four of a kind: 21
Full house: 25
Small straight: 30
Large straight: 40
Chance: 19
Yahtzee: --

You rolled: 1 2 3 3 5
Which dice would you like to reserve?
3 3
You rolled: 2 3 3 3 6
Which dice would you like to reserve?
3 3 3
You rolled: 1 3 3 3 5
Automatically assigned to Yahtzee.
```

### Scenario 3 (iteration 3)

This scenario extends Scenario 2 to include bonus Yahtzees and jokers. The steps deviate from Scenario 2 as follows:

1. After every roll, the game checks if the player rolled a Yahtzee that results in a joker. If not, the turn continues as described in Scenario 2.
2. If the player has a joker, they lose their remaining rerolls and must score the joker.
3. The game checks if the corresponding upper section field is empty. If so, the game scores this field. Proceed to Step 6.
4. If not, the game displays the empty fields the player can score.
5. The player selects a field and the game scores this field.
6. The game checks if the player has already scored a Yahtzee. If so, the roll is a bonus Yahtzee and the player receives 100 bonus points.

Example 3.1, in which the game assigns the joker to an upper section field:

```
Your score card:
Ones: 3
Twos: 6
Threes: 9
Fours: --
Fives: 15
Sixes: --
Three of a kind: --
Four of a kind: 21
Full house: --
Small straight: --
Large straight: --
Chance: --
Yahtzee: 50

You rolled: 4 4 4 4 4
Yahtzee! You can use this roll as a joker.
Automatically assigned to Fours.
```

Example 3.2, in which the player selects a field to score:

```
Your score card:
Ones: 3
Twos: 6
Threes: 9
Fours: 12
Fives: 15
Sixes: --
Three of a kind: --
Four of a kind: 21
Full house: --
Small straight: --
Large straight: --
Chance: --
Yahtzee: 50

You rolled: 5 5 5 5 5
Yahtzee! You can use this roll as a joker.
Which field would you like to score:
6. Sixes: 0
7. Three of a kind: 25
9. Full house: 25
10. Small straight: 30
11. Large straight: 40
12. Chance: 25
Your selection: 11
```

### Scenario 4 (iteration 3)

This scenario describes a full game for a single player.

1. Follow Scenario 3 to play a single turn.
2. Repeat the previous step twelve more times. At this point, the player has scored all of the fields on their card.
3. The game displays the player’s score card and their final score, including bonuses.

Example 4.1, which shows the output at the end of the game:

```
(...)

Your final score:
Ones: 1
Twos: 6
Threes: 15
Fours: 16
Fives: 15
Sixes: 24
Bonus (>= 63): 35
Three of a kind: 24
Four of a kind: 29
Full house: 25
Small straight: 30
Large straight: 40
Chance: 16
Yahtzee: 50
Bonus Yathzees (1): 100
Total: 426
```

### Scenario 5 (iteration 4)

This scenario describes a full game with multiple players.

1. The game asks the number of players.
2. The players enter a number greater than zero.
3. The game asks the name of each player.
4. The players each enter their name.
5. The game displays the current player.
6. Follow Scenario 3 to play a single turn.
7. The turn moves to the next player.
8. Repeat the previous three steps until all players have taken a turn.
9. Repeat the previous four steps twelve more times.
10. The game displays each player’s score card and their final score, including bonuses.
11. The game ranks the players from highest to lowest score.

Example 5.1, which shows the input and output at the start and at the end of the game:

```
How many players? 2
Player 1, what's your name? Alice
Player 2, what's your name? Bob

Alice, it's your turn.

(...)

Results:

Alice:
Ones: 1
Twos: 6
Threes: 15
Fours: 16
Fives: 15
Sixes: 24
Bonus (>= 63): 35
Three of a kind: 24
Four of a kind: 29
Full house: 25
Small straight: 30
Large straight: 40
Chance: 16
Yahtzee: 50
Bonus Yathzees (1): 100
Total: 426

Bob:
Ones: 2
Twos: 4
Threes: 12
Fours: 12
Fives: 15
Sixes: 24
Bonus (>= 63): 35
Three of a kind: 24
Four of a kind: 27
Full house: 25
Small straight: 30
Large straight: 40
Chance: 25
Yahtzee: 0
Total: 275

Ranking:

1. Alice: 426
2. Bob: 275
```
