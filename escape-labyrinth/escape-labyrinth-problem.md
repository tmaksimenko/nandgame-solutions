**Escape Labyrinth**

The computer is stuck in a labyrinth on Mars. Write a program that will make it escape the labyrinth.

The computer has connected wheels and a forward obstacle detector. Input/output to wheels and detector is memory-mapped on address 7FFF:

**Output signals to peripherals:**

| Bit |	Set to 1 to: |
| --- | --- |
| 2 |	Move forward (1 step) |
| 3 |	Turn left (90 degrees) |
| 4 |	Turn right (90 degrees) |

The movement/turn is started when a bit is changing from 0 to 1, but will take a moment to complete.

**Input from peripherals:**

| Bit |	When 1 |
| --- | --- |
| 8 |	Obstacle detected in front |
| 9 |	Device is turning |
| 10 |	Device is moving forward |
