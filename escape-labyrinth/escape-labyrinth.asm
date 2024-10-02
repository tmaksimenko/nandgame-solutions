###
# This solution was made in its entirety by Tim Maksimenko
# --
# This program solves the "Escape Labyrinth" level of NandGame (Software/Low Level/Escape Labyrinth).
# The problem statement can be found in the file escape-labyrinth-problem.md
###

# Defined constants
DEFINE io 0x7fff
DEFINE xaddr 0

DEFINE state 1
DEFINE sfront 0x4
DEFINE sright 0x8
DEFINE sleft 0x10

DEFINE mfront 0x4
DEFINE mleft 0x8
DEFINE mright 0x10

DEFINE cfront 0x100
DEFINE cturn 0x200
DEFINE cmovef 0x400

# set initial state as front
A = sfront
D = A
A = state
*A = D
# state = sfront

# check if the vehicle is currently
# moving or turning
checkmove:
# compare io with the moving check
A = cmovef
D = A
A = io
D = D & *A
# if (currently moving forward)
# D != 0

# store D
A = xaddr
*A = D
# *xaddr = D

# compare io with the turning check
A = cturn
D = A
A = io
D = D & *A
# if (currently turning)
# D != 0

# combine the values
A = xaddr
D = D | *A
# if (any move or turn)
# D != 0

# destination: go back to beginning
A = checkmove
D ; JNE
# if D != 0 just keep checking until
# movement or turning is complete

# else move on to checkfront
# (no jump required)

# check if front is obstructed
checkfront:
# compare io with the front check
A = cfront
D = A
A = io
D = D & *A
# if (any obstacle)
# D != 0

# set destination to checkstate
# to decide next turn
A = checkstate
D ; JNE
# if (obstacle exists)
# jump to checkstate

# else move forward

# set state as default
A = sfront
D = A
A = state
*A = D
# state = sfront = 0

# move forward
A = mfront
D = A
A = io
*A = D
# io = mfront

# set destination to restart program
A = checkmove
JMP
# jump unconditionally

# if blocked, what next?
# state = state + 1, repeat
checkstate:
#check if state is front
A = state

D = *A
A = sfront

D = D & A
# if (state = sfront)
# D != 0

# go to statefront handling
A = statefront
D ; JNE
# if state is front

#check if state is right
A = state

D = *A
A = sright

D = D & A
# if (state = sright)
# D != 0

# go to stateright handling
A = stateright
D ; JNE
# if state is right

# else final option of 3

# go to stateleft handling
A = stateleft
JMP
# unconditional jump

# if sfront, turn and set state right
statefront:
# set state to right
A = sright
D = A
A = state
*A = D
# state = sright

# set move command to right
A = mright
D = A
A = io
*A = D
# io = mright

# go back to start and repeat
A = checkmove
JMP
# jump unconditionally

# if sright, turn and set state left
# (2 part maneuver)
stateright:
# set state to left
A = sleft
D = A
A = state
*A = D
# state = sleft

# turn left first time of 2
A = mleft
D = A
A = io
*A = D
# io = mleft

# go back to start and repeat
A = checkmove
JMP
# jump unconditionally

# if sleft, complete turn and reset
stateleft:
# set state to front ( default)
A = sfront
D = A
A = state
*A = D
# state = sfront

# turn left final time
A = mleft
D = A
A = io
*A = D
# io = mleft

# go back to start with default state
# (program reset in different pos)
A = checkmove
JMP
# unconditional jump 
# to restart program
