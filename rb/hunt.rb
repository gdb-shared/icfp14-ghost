fun('main') {
  @prev_dir = 247
  @vitality = 248
  @counter = 249
  @rand = 250
  @new_dir = 251
  @pac_x = 252
  @pac_y = 253
  @ghost_x = 254
  @ghost_y = 255
  int 3
  int 6 # a,b <= vit,dir
  mov [@vitality], $a
  mov [@prev_dir], $b
  int 3 # a <= ghost
  int 5 # a,b <= x,y ghost
  mov [@ghost_x], $a
  mov [@ghost_y], $b
  int 1 # a,b <= x,y pac
  mov [@pac_x], $a
  mov [@pac_y], $b

  # Choose preferred axis.
  int 3
  and2 $a, 1
  jeq :hunt_horz,$a,0
}
fun('hunt_vert') {
  jlt :RIGHT,[@ghost_x],[@pac_x]
  jlt :GO_DOWN,[@ghost_y],[@pac_y]
  jgt :GO_UP,[@ghost_y],[@pac_y]

  label :GO_LEFT
  mov [@new_dir], $left
  goto :FINISH

  label :GO_DOWN
  mov [@new_dir], $down
  goto :FINISH

  label :GO_UP
  mov [@new_dir], $up
  goto :FINISH

  label :RIGHT
  jlt :GO_DOWN,[@ghost_y],[@pac_y]
  jgt :GO_UP,[@ghost_y],[@pac_y]

  label :GO_RIGHT
  mov [@new_dir], $right
  goto :FINISH
}
fun('hunt_horz') {
  jlt :HDOWN,[@ghost_x],[@pac_x]
  jlt :HGO_RIGHT,[@ghost_y],[@pac_y]
  jgt :HGO_LEFT,[@ghost_y],[@pac_y]

  label :HGO_UP
  mov [@new_dir], $left
  goto :FINISH

  label :HGO_RIGHT
  mov [@new_dir], $down
  goto :FINISH

  label :HGO_LEFT
  mov [@new_dir], $up
  goto :FINISH

  label :HDOWN
  jlt :HGO_RIGHT,[@ghost_y],[@pac_y]
  jgt :HGO_LEFT,[@ghost_y],[@pac_y]

  label :HGO_UP
  mov [@new_dir], $right
  #goto :FINISH
}
fun("FINISH") {
  label :FINISH
  jeq :REVERSE,[@vitality],1
  inc [@counter]
  mov $b, [@counter]
  int 3
  add $a,2
  jlt :RANDOMIZE,[@counter],$a
  mov [@counter],0
  goto :SET_DIR

  label :RANDOMIZE
  # Compute a random number.
  add [@rand],[@pac_x]
  add [@rand],[@pac_x]
  add [@rand],[@ghost_x]
  add [@rand],[@ghost_x]
  #add [@rand],[@prev_dir]  # useful?
  mov [@new_dir],[@rand]
  and2 [@new_dir],3
  goto :SET_DIR

  label :REVERSE
  add [@new_dir],2

  label :SET_DIR
  mov $a,[@new_dir]
  int 0  # from $a
  hlt
}
