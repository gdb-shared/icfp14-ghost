fun('main') {
  #@counter = 251
  #inc [@counter]
  #jlt :fickle_main, [@counter], 3
  #mov [@counter], 0
  # run0 'hunt_main'
}
fun('hunt_main') {
  @counter = 249
  @rand = 250
  @new_dir = 251
  @pac_x = 252
  @pac_y = 253
  @ghost_x = 254
  @ghost_y = 255
  int 3
  int 6 # a,b <= vit,dir
  # In theory, we should reverse if vitality is 1
  int 3 # a <= ghost
  int 5 # a,b <= x,y ghost
  mov [@ghost_x], $a
  mov [@ghost_y], $b
  int 1 # a,b <= x,y pac
  mov [@pac_x], $a
  mov [@pac_y], $b

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

  label :FINISH
  inc [@counter]
  mov $b, [@counter]
  int 3
  add $a,2
  int 8
  jlt :RANDOMIZE,[@counter],$a
  mov [@counter],0
  goto :SET_DIR

  label :RANDOMIZE
  # Compute a random number.
  add [@rand],[@pac_x]
  add [@rand],[@pac_x]
  add [@rand],[@ghost_x]
  add [@rand],[@ghost_x]
  mov [@new_dir],[@rand]
  and2 [@new_dir],3

  label :SET_DIR
  mov $a,[@new_dir]
  int 0  # from $a
  #int 8
  hlt
}
fun('fickle_main') {
  mov $a,255
  mov $b,0
  mov $c,255

  label :FICKLE_INC
  inc $c
  jgt :FICKLE_LOOP,[$c],$a

  mov $a,[$c]
  mov $b,$c
  label :FICKLE_LOOP
  jlt :FICKLE_INC,$c,3

  mov $a,$b
  int 0

  int 3
  int 6
  inc [$b]
  hlt
}
