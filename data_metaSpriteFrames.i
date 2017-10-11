; -----------------------------------------------
; meta sprite frames
;
; Control byte
; LXYpp?MM control byte per sprite frame
; ||||||||
; |||||||+ mirrors this sprite frame in its center vertical axis
; ||||||+- mirrors this sprite frame in its center horizontal axis [not implemented]
; |||||+-- not used
; |||++--- palette bits for all sprite frames in this meta sprite frame
; ||+----- this byte is followed by optional Y-offset byte
; |+------ this byte is followed by optional X-offset byte
; +------- this is the last sprite frame in the meta sprite frame
;
; X offset byte ( optional )
; Y offset byte ( optional )
; sprite frame address word
;
; -----------------------------------------------


; -------------------------------------
; tank 1 animation frames
; -------------------------------------

tank01_stationary_d5_f:
  .db %00100000
  .db -13
  .dw tank01_stationary_d5_right
  .db %10100000
  .db -16
  .dw tank01_stationary_d5_left

tank02_stationary_d5_f:
  .db %00100000
  .db -13
  .dw tank02_stationary_d5_right
  .db %10100000
  .db -16
  .dw tank02_stationary_d5_left

tank01_stationary_d6_f:
	.db %00100000
	.db -16
	.dw tank01_stationary_d6_right
	.db %10100000
	.db -13
	.dw tank01_stationary_d6_left

tank02_stationary_d6_f:
	.db %00100000
	.db -16
	.dw tank02_stationary_d6_right
	.db %10100000
	.db -13
	.dw tank02_stationary_d6_left




; tank 1 walking (diag down) 01
OS1F01
  .db #%00100000
	.db #$F0
	.dw O1F03
	.db #%00100000
	.db #$F3
	.dw O1F04
	.db #%00100000
	.db #$03
	.dw W1F05
	.db #%10000000
	.dw W1F09
; tank 1 walking (diag down) 02
OS1F02	.db #%00100000
		.db #$F0
		.dw O1F03
		.db #%00100000
		.db #$F3
		.dw O1F04
		.db #%00100000
		.db #$03
		.dw W1F06
		.db #%10000000
		.dw W1F0A
; tank 1 walking (diag down) 03
OS1F03	.db #%00100000
		.db #$F0
		.dw O1F03
		.db #%00100000
		.db #$F3
		.dw O1F04
		.db #%00100000
		.db #$03
		.dw W1F07
		.db #%10000000
		.dw W1F0B
; tank 1 walking (diag down) 04
OS1F04	.db #%00100000
		.db #$F1
		.dw O1F03
		.db #%00100000
		.db #$F4
		.dw O1F04
		.db #%00100000
		.db #$04
		.dw W1F00
		.db #%10100000
		.db #$01
		.dw W1F0C
; tank 1 walking (diag down) 05
OS1F05	.db #%00100000
		.db #$F0
		.dw O1F03
		.db #%00100000
		.db #$F3
		.dw O1F05
		.db #%00100000
		.db #$03
		.dw W1F01
		.db #%10000000
		.dw W1F0D
; tank 1 walking (diag down) 06
OS1F06	.db #%00100000
		.db #$F0
		.dw O1F03
		.db #%00100000
		.db #$F3
		.dw O1F05
		.db #%00100000
		.db #$03
		.dw W1F02
		.db #%10000000
		.dw W1F0E
; tank 1 walking (diag down) 07
OS1F07	.db #%00100000
		.db #$F0
		.dw O1F03
		.db #%00100000
		.db #$F3
		.dw O1F05
		.db #%00100000
		.db #$03
		.dw W1F03
		.db #%10000000
		.dw W1F0F
; tank 1 walking (diag down) 08
OS1F08	.db #%00100000
		.db #$F1
		.dw O1F03
		.db #%00100000
		.db #$F4
		.dw O1F05
		.db #%00100000
		.db #$04
		.dw W1F04
		.db #%10100000
		.db #$01
		.dw W1F08



; tank 1 walking (diag up) 01
OS1F0A	.db #%00100000
		.db #$F4
		.dw O1F0B
		.db #%00100000
		.db #$F1
		.dw O1F08
		.db #%00100000
		.db #$04
		.dw W1F10
		.db #%10100000
		.db #$01
		.dw W1F18
; tank 1 walking (diag up) 02
OS1F0B	.db #%00100000
		.db #$F3
		.dw O1F0A
		.db #%00100000
		.db #$F0
		.dw O1F08
		.db #%00100000
		.db #$03
		.dw W1F11
		.db #%10000000
		.dw W1F19
; tank 1 walking (diag up) 03
OS1F0C	.db #%00100000
		.db #$F3
		.dw O1F0A
		.db #%00100000
		.db #$F0
		.dw O1F09
		.db #%00100000
		.db #$03
		.dw W1F12
		.db #%10000000
		.dw W1F1A
; tank 1 walking (diag up) 04
OS1F0D	.db #%00100000
		.db #$F3
		.dw O1F0A
		.db #%00100000
		.db #$F0
		.dw O1F09
		.db #%00100000
		.db #$03
		.dw W1F13
		.db #%10000000
		.dw W1F1B
; tank 1 walking (diag up) 05
OS1F0E	.db #%00100000
		.db #$F4
		.dw O1F0A
		.db #%00100000
		.db #$F1
		.dw O1F09
		.db #%00100000
		.db #$04
		.dw W1F14
		.db #%10100000
		.db #$01
		.dw W1F1C
; tank 1 walking (diag up) 06
OS1F0F	.db #%00100000
		.db #$F3
		.dw O1F0A
		.db #%00100000
		.db #$F0
		.dw O1F08
		.db #%00100000
		.db #$03
		.dw W1F15
		.db #%10000000
		.dw W1F1D
; tank 1 walking (diag up) 07
OS1F10	.db #%00100000
		.db #$F3
		.dw O1F0B
		.db #%00100000
		.db #$F0
		.dw O1F08
		.db #%00100000
		.db #$03
		.dw W1F16
		.db #%10000000
		.dw W1F1E
; tank 1 walking (diag up) 08
OS1F11	.db #%00100000
		.db #$F3
		.dw O1F0B
		.db #%00100000
		.db #$F0
		.dw O1F08
		.db #%00100000
		.db #$03
		.dw W1F17
		.db #%10000000
		.dw W1F1F

; tank 1 still (down)
OS1F12	.db #%00100000
		.db #$EA
		.dw tank01_stationary_d4_top
		.db #%10100000
		.db #$FA
		.dw tank_all_stationary_d4_bottom

; tank 1 walking (down) 01
OS1F13	.db #%00100000
		.db #$EB
		.dw tank01_stationary_d4_top
		.db #%10100000
		.db #$FB
		.dw W1F20
; tank 1 walking (down) 02
OS1F14	.db #%00100000
		.db #$EA
		.dw tank01_stationary_d4_top
		.db #%10100000
		.db #$FA
		.dw W1F21
; tank 1 walking (down) 03
OS1F15	.db #%00100000
		.db #$EA
		.dw tank01_stationary_d4_top
		.db #%10100000
		.db #$FA
		.dw W1F22
; tank 1 walking (down) 04
OS1F16	.db #%00100000
		.db #$EA
		.dw tank01_stationary_d4_top
		.db #%10100000
		.db #$FA
		.dw W1F23
; tank 1 walking (down) 05
OS1F17	.db #%00100000
		.db #$EB
		.dw tank01_stationary_d4_top
		.db #%10100000
		.db #$FB
		.dw W1F24
; tank 1 walking (down) 06
OS1F18	.db #%00100000
		.db #$EA
		.dw tank01_stationary_d4_top
		.db #%10100000
		.db #$FA
		.dw W1F25
; tank 1 walking (down) 07
OS1F19	.db #%00100000
		.db #$EA
		.dw tank01_stationary_d4_top
		.db #%10100000
		.db #$FA
		.dw W1F26
; tank 1 walking (down) 08
OS1F1A	.db #%00100000
		.db #$EA
		.dw tank01_stationary_d4_top
		.db #%10100000
		.db #$FA
		.dw W1F27

; tank 1 still (up)
OS1F1B	.db #%00100000
		.db #$EA
		.dw tank01_stationary_d1_top
		.db #%10100000
		.db #$FA
		.dw tank_all_stationary_d1_bottom
; tank 1 walking (up) 01
OS1F1C	.db #%00100000
		.db #$EB
		.dw tank01_stationary_d1_top
		.db #%10100000
		.db #$FB
		.dw W1F28
; tank 1 walking (up) 02
OS1F1D	.db #%00100000
		.db #$EA
		.dw tank01_stationary_d1_top
		.db #%10100000
		.db #$FA
		.dw W1F29
; tank 1 walking (up) 03
OS1F1E	.db #%00100000
		.db #$EA
		.dw tank01_stationary_d1_top
		.db #%10100000
		.db #$FA
		.dw W1F2A
; tank 1 walking (up) 04
OS1F1F	.db #%00100000
		.db #$EA
		.dw tank01_stationary_d1_top
		.db #%10100000
		.db #$FA
		.dw W1F2B
; tank 1 walking (up) 05
OS1F20	.db #%00100000
		.db #$EB
		.dw tank01_stationary_d1_top
		.db #%10100000
		.db #$FB
		.dw W1F2C
; tank 1 walking (up) 06
OS1F21	.db #%00100000
		.db #$EA
		.dw tank01_stationary_d1_top
		.db #%10100000
		.db #$FA
		.dw W1F2D
; tank 1 walking (up) 07
OS1F22	.db #%00100000
		.db #$EA
		.dw tank01_stationary_d1_top
		.db #%10100000
		.db #$FA
		.dw W1F2E
; tank 1 walking (up) 08
OS1F23	.db #%00100000
		.db #$EA
		.dw tank01_stationary_d1_top
		.db #%10100000
		.db #$FA
		.dw W1F2F



; mech 2 still (down)
tank02_stationary_d4_f
    .db #%00100000
		.db #$EA
		.dw tank02_stationary_d4_top
		.db #%10100000
		.db #$FA
		.dw tank_all_stationary_d4_bottom

tank02_stationary_d1_f
    .db #%00100000
		.db #$EA
		.dw tank02_stationary_d1_top
		.db #%10100000
		.db #$FA
		.dw tank_all_stationary_d1_bottom


CS00:	.db #%00110000
		.db #$E8
		.dw CUR0
		.db #%01110000
		.db #$F2
		.db #$04
		.dw CUR1
		.db #%11110001
		.db #$0E
		.db #$04
		.dw CUR1
CS01:	.db #%00110000
		.db #$E9
		.dw CUR0
		.db #%01110000
		.db #$F3
		.db #$04
		.dw CUR1
		.db #%11110001
		.db #$0D
		.db #$04
		.dw CUR1
CS02:	.db #%00110000
		.db #$EA
		.dw CUR0
		.db #%01110000
		.db #$F4
		.db #$04
		.dw CUR1
		.db #%11110001
		.db #$0C
		.db #$04
		.dw CUR1
CS03:	.db #%00110000
		.db #$EB
		.dw CUR0
		.db #%01110000
		.db #$F5
		.db #$04
		.dw CUR1
		.db #%11110001
		.db #$0B
		.db #$04
		.dw CUR1
CS04:	.db #%00110000
		.db #$EC
		.dw CUR0
		.db #%01110000
		.db #$F6
		.db #$04
		.dw CUR1
		.db #%11110001
		.db #$0A
		.db #$04
		.dw CUR1
CS10:	.db #%10110000
		.db #$E8
		.dw CUR2
CS11:	.db #%10110000
		.db #$E9
		.dw CUR2
CS12:	.db #%10110000
		.db #$EA
		.dw CUR2
CS13:	.db #%10110000
		.db #$EB
		.dw CUR2
CS14:	.db #%10110000
		.db #$EC
		.dw CUR2

CS20:
	.db #%10110000
	.db #$F8
	.dw CUR3

CS21:
	.db #%10010000
	.dw CLR0

CS22:
	.db #%10100000
	.db #$F8
	.dw CUR4

CS23:
	.db #%10100000
	.db #$F8
	.dw CUR5

CS24:	.db #%10110000
		.db #$E0
		.dw CUR9


EF00:
	.db #%10111000
	.db #$F4
  .dw EFF0
EF01:
	.db #%10011000
  .dw EFF1
EF02:
	.db #%10011000
	.dw CLR0
EF03:
	.db #%10011000
  .dw EFF2
EF04:
	.db #%10011000
  .dw EFF3
EF05:
	.db #%10111000
	.db #$F4
	.dw EFF4
EF06:
	.db #%10010000
  .dw EFF5

EF07:			; flush
	.db #%10011000
	.dw EFF6
EF08:			; flush
	.db #%10011000
	.dw EFF7
EF09:			; flush
	.db #%10011000
	.dw EFF8
