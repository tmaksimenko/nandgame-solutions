**Network**

Receive data from another computer over the network and display it on the screen

The payload will be an image 16 pixels in width.

See level help for details about the network protocol used.

The network wires are memory mapped to the address 6001 (hex), with two significant bits: **data** (bit 0) which is the current bit of data sent over the wire and **sync** (bit 1) which change to indicate that a new bit has arrived.

NOTE: This may be challenging to solve using only assembler. You may wish to implement the stack-operation macros and then return to this challenge, where you will be able to use them to simplify the code.
