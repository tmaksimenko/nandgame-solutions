###
# This solution was made in its entirety by Tim Maksimenko
# --
# This program solves the "Network" level of NandGame (Software/Low Level/Network).
# The problem statement can be found in the file network-problem.md
# -- 
# Note that this was completed without the use of stack-operation macros.
# Therefore, some repetitive operations were hardcoded.
###

# Defined constants
DEFINE inaddr 0x6001
DEFINE cdata 1
DEFINE csync 2
DEFINE sync 1
DEFINE counter 2
DEFINE countercheck 0x10
DEFINE outaddr 3
DEFINE outsize 0x20

# initialize counter and sync at 0
A = counter
*A = 0

A = sync
*A = 0

# initialize address at 0x4000
A = 0x4000
D = A
A = outaddr
*A = D

start:
# wait for start

# get sync
A = inaddr
D = *A
A = csync
D = D & A
# if sync == 2 (+) D = 2

# else try again
A = start
D ; JEQ

# set the sync value
A = sync
*A = D

# get input
A = inaddr
D = *A
A = cdata
D = D & A
# if data == 0 D = 0

# if data is 0 end program
A = end
D ; JEQ
# else continue

control:
# check that first data in a given 16-
# bit transmission is 1

A = inaddr
D = *A
A = cdata
D = D & A
# if first bit is 1, D is 1, all good

A = end
D ; JEQ 
# if not, end program

# set sync variable to current value
# same as setsync but in different order

A = inaddr
D = *A
A = csync
D = D & A
# set D to value of sync

A = sync
*A = D

checksync:
# check sync has not changed

A = inaddr
D = *A
A = csync 
D = D & A
A = sync
D = D - *A
# if D != 0 sync has changed

A = checksync
D ; JEQ
# if sync has not changed, repeat
# check until it changes

setsync:
# set sync variable to current value

A = inaddr
D = *A
A = csync
D = D & A
# set D to value of sync

A = sync
*A = D

checkcounter:
# check if counter has exceeded max

A = counter
D = *A
A = countercheck
D = D & A
# if D != 0 the packet is ended

A = receive
D ; JEQ
# if D == 0 continue to next op

# otherwise
A = counter
*A = 0
# reset counter

# increment address
A = outsize
D = A
A = outaddr
*A = D + *A



# go back to control section for
# new packet
A = control
JMP
# unconditional jump

receive:
# get the currently incoming bit and
# push it to the output

# get the new data bit
A = cdata
D = A
A = inaddr
D = D & *A
# D = data
# if D = 0 just increment and skip

A = increment
D ; JEQ

# conditionals to decide data position

# if bit 15
A = counter
D = *A
A = bit15
D ; JEQ
# if counter = 0, D = 0x8000, push

# if bit 14
A = counter
D = 1
D = D - *A
A = bit14
D ; JEQ
# if counter = 1, D = 0x4000, push

# if 13
A = 2
D = A
A = counter
D = D - *A
A = bit13
D ; JEQ
# if counter = 2, D = 0x2000, push

# if 12
A = 3
D = A
A = counter
D = D - *A
A = bit12
D ; JEQ
# if counter = 3, D = 0x1000, push

# if 11
A = 4
D = A
A = counter
D = D - *A
A = bit11
D ; JEQ
# if counter = 4, D = 0x800, push

# if 10
A = 5
D = A
A = counter
D = D - *A
A = bit10
D ; JEQ
# if counter = 5, D = 0x400, push

# if 9
A = 6
D = A
A = counter
D = D - *A
A = bit9
D ; JEQ
# if counter = 6, D = 0x200, push

# if 8
A = 7
D = A
A = counter
D = D - *A
A = bit8
D ; JEQ
# if counter = 7, D = 0x100, push

# if 7
A = 8
D = A
A = counter
D = D - *A
A = bit7
D ; JEQ
# if counter = 8, D = 0x80, push

# if 6
A = 9
D = A
A = counter
D = D - *A
A = bit6
D ; JEQ
# if counter = 9, D = 0x40, push

# if 5
A = 0xa
D = A
A = counter
D = D - *A
A = bit5
D ; JEQ
# if counter = 0d10, D = 0x20, push

# if 4
A = 0xb
D = A
A = counter
D = D - *A
A = bit4
D ; JEQ
# if counter = 0d11, D = 0x10, push

# if 3
A = 0xc
D = A
A = counter
D = D - *A
A = bit3
D ; JEQ
# if counter = 0d12, D = 0x8, push

# if 2
A = 0xd
D = A
A = counter
D = D - *A
A = bit2
D ; JEQ
# if counter = 0d13, D = 0x4, push

# if 1
A = 0xe
D = A
A = counter
D = D - *A
A = bit1
D ; JEQ
# if counter = 0d14, D = 0x2, push

# if 0
A = bit0
JMP
# push unconditionally (last option)

bit15:
A = 0x4000
D = A
A = outaddr
A = *A
*A = D + *A
*A = D + *A
A = increment
JMP

bit14:
A = 0x4000
D = A
A = outaddr
A = *A
*A = D | *A
A = increment
JMP

bit13:
A = 0x2000
D = A
A = outaddr
A = *A
*A = D | *A
A = increment
JMP

bit12:
A = 0x1000
D = A
A = outaddr
A = *A
*A = D | *A
A = increment
JMP

bit11:
A = 0x800
D = A
A = outaddr
A = *A
*A = D | *A
A = increment
JMP

bit10:
A = 0x400
D = A
A = outaddr
A = *A
*A = D | *A
A = increment
JMP

bit9:
A = 0x200
D = A
A = outaddr
A = *A
*A = D | *A
A = increment
JMP

bit8:
A = 0x100
D = A
A = outaddr
A = *A
*A = D | *A
A = increment
JMP

bit7:
A = 0x80
D = A
A = outaddr
A = *A
*A = D | *A
A = increment
JMP

bit6:
A = 0x40
D = A
A = outaddr
A = *A
*A = D | *A
A = increment
JMP

bit5:
A = 0x20
D = A
A = outaddr
A = *A
*A = D | *A
A = increment
JMP

bit4:
A = 0x10
D = A
A = outaddr
A = *A
*A = D | *A
A = increment
JMP

bit3:
A = 0x8
D = A
A = outaddr
A = *A
*A = D | *A
A = increment
JMP

bit2:
A = 0x4
D = A
A = outaddr
A = *A
*A = D | *A
A = increment
JMP

bit1:
A = 0x2
D = A
A = outaddr
A = *A
*A = D | *A
A = increment
JMP

bit0:
A = 0x1
D = A
A = outaddr
A = *A
*A = D | *A
A = increment
JMP

#
# end switch case
#

increment:
# increment counter and return

# increment counter
A = counter
*A = *A + 1
# incremented

# go back to check for next bit
A = checksync
JMP
# unconditional jump

end:
