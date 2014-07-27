fun('main') {
  @counter = 251
  inc [@counter]
  jlt :fickle_main, [@counter], 3
  mov [@counter], 0
  #run0 'hunt_main'
}
fun('hunt_main') {
  int 3
  int 6 # a,b <= vit,dir
  # In theory, we should reverse if vitality is 1
  int 3 # a <= ghost
  int 5 # a,b <= x,y ghost
  @ghost_x = 254
  @ghost_y = 255
  mov [@ghost_x], $a
  mov [@ghost_y], $b
  int 1 # a,b <= x,y pac
  @pac_x = 252
  @pac_y = 253
  mov [@pac_x], $a
  mov [@pac_y], $b

  jlt :RIGHT,[@ghost_x],[@pac_x]
  jlt :GO_DOWN,[@ghost_y],[@pac_y]
  jgt :GO_UP,[@ghost_y],[@pac_y]

  label :GO_LEFT
  mov $a, $left
  goto :FINISH

  label :GO_DOWN
  mov $a, $down
  goto :FINISH

  label :GO_UP
  mov $a, $up
  goto :FINISH

  label :RIGHT
  jlt :GO_DOWN,[@ghost_y],[@pac_y]
  jgt :GO_UP,[@ghost_y],[@pac_y]

  label :GO_RIGHT
  mov $a, $right

  label :FINISH
  int 0  # from $a
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
