# Table Tennis

The deceptively simple game where you hit a ball across a net on top of a
table. Where the goal is to hit it in such a way that the other player misses.
Just how you like it on Wii Sports. Uses the Godot engine for graphics and game
logic. Uses an Android app to control the paddle via UDP networking.

## Networking

There are 3 types of UDP packets that are sent to the server:

- **player\_joined**: tells the server when a player has joined and signals to
  the server that, if there's a slot available, to let the player play. The
  server should send a packet back indicating the client's player number. If
  playing in single-player mode, there would only be a single player, and thus
  not much need to echo the client's player number.
- **player\_left**: tells the server when a player has left and signals to the
  server to free up a slot to allow another player a chance to play and
  connect.
- **paddle\_info**: tells the server the precise orientation of their device,
  along with the acceleration that the device is experiencing. The server then
  processes this and transforms the paddles accordingly. Because the actual
  position of the paddle cannot be calculated in 3D space (we will need at
  least 3 photo-receptors for that), the paddle hits the ball based on the
  acceleration of the device (if the device accelerates to the side quickly, we
  interpret that as an attempt to hit the ball an execute a swing proportional
  to the acceleration).
