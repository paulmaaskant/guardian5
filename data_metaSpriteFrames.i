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
; tank animation frames
; -------------------------------------

tank01_stationary_d1_f:
  .db %00100000
	.db -22
	.dw tank01_d1_top
	.db %10100000
	.db -6
	.dw tank_all_d1_bottom

tank02_stationary_d1_f:
  .db %00100000
	.db -22
	.dw tank02_d1_top
	.db %10100000
	.db -6
	.dw tank_all_d1_bottom

tank01_stationary_d4_f:
	.db %00100000
	.db -22
	.dw tank01_d4_top
	.db %10100000
	.db -6
	.dw tank_all_d4_bottom

tank02_stationary_d4_f:
  .db %00100000
	.db -22
	.dw tank02_d4_top
	.db %10100000
	.db -6
	.dw tank_all_d4_bottom

tank01_stationary_d5_f:
  .db %00100000
  .db -13
  .dw tank01_d5_right
  .db %10100000
  .db -16
  .dw tank01_d5_left

tank02_stationary_d5_f:
  .db %00100000
  .db -13
  .dw tank02_d5_right
  .db %10100000
  .db -16
  .dw tank02_d5_left

tank01_stationary_d6_f:
	.db %00100000
	.db -16
	.dw tank01_d6_right
	.db %10100000
	.db -13
	.dw tank01_d6_left

tank02_stationary_d6_f:
	.db %00100000
	.db -16
	.dw tank02_d6_right
	.db %10100000
	.db -13
	.dw tank02_d6_left

tank01_moving_d5_fr01:
  .db %00100000
	.db -16
	.dw tank01_d5_top_left
	.db %00100000
	.db -13
	.dw tank01_d5_top_right_1
	.db %00100000
	.db 3
	.dw W1F05
	.db %10000000
	.dw W1F09

tank01_moving_d5_fr02:
  .db %00100000
	.db -16
	.dw tank01_d5_top_left
	.db #%00100000
	.db -13
	.dw tank01_d5_top_right_1
	.db %00100000
	.db 3
	.dw W1F06
	.db %10000000
	.dw W1F0A

tank01_moving_d5_fr03:
  .db %00100000
	.db -16
	.dw tank01_d5_top_left
	.db %00100000
	.db -13
	.dw tank01_d5_top_right_1
	.db %00100000
	.db 3
	.dw W1F07
	.db %10000000
	.dw W1F0B

tank01_moving_d5_fr04:
  .db %00100000
	.db -15
	.dw tank01_d5_top_left
	.db #%00100000
	.db -12
	.dw tank01_d5_top_right_1
	.db %00100000
	.db 4
	.dw W1F00
	.db %10100000
	.db 1
	.dw W1F0C

tank01_moving_d5_fr05:
  .db %00100000
	.db -16
	.dw tank01_d5_top_left
	.db %00100000
	.db -13
	.dw tank01_d5_top_right_2
	.db %00100000
	.db 3
	.dw W1F01
	.db %10000000
	.dw W1F0D

tank01_moving_d5_fr06:
  .db %00100000
	.db -16
	.dw tank01_d5_top_left
	.db %00100000
	.db -13
	.dw tank01_d5_top_right_2
	.db %00100000
	.db 3
	.dw W1F02
	.db %10000000
	.dw W1F0E

tank01_moving_d5_fr07:
  .db %00100000
	.db -16
	.dw tank01_d5_top_left
	.db %00100000
	.db -13
	.dw tank01_d5_top_right_2
	.db #%00100000
	.db 3
	.dw W1F03
	.db %10000000
	.dw W1F0F

tank01_moving_d5_fr08:
  .db %00100000
	.db -15
	.dw tank01_d5_top_left
	.db %00100000
	.db -12
	.dw tank01_d5_top_right_2
	.db %00100000
	.db 4
	.dw W1F04
	.db %10100000
	.db 1
	.dw W1F08

tank02_moving_d5_fr01:
  .db %00100000
	.db -16
	.dw tank02_d5_top_left
	.db %00100000
	.db -13
	.dw tank02_d5_top_right_1
	.db %00100000
	.db 3
	.dw W1F05
	.db %10000000
	.dw W1F09

tank02_moving_d5_fr02:
  .db %00100000
	.db -16
	.dw tank02_d5_top_left
	.db #%00100000
	.db -13
	.dw tank02_d5_top_right_1
	.db %00100000
	.db 3
	.dw W1F06
	.db %10000000
	.dw W1F0A

tank02_moving_d5_fr03:
  .db %00100000
	.db -16
	.dw tank02_d5_top_left
	.db %00100000
	.db -13
	.dw tank02_d5_top_right_1
	.db %00100000
	.db 3
	.dw W1F07
	.db %10000000
	.dw W1F0B

tank02_moving_d5_fr04:
  .db %00100000
	.db -15
	.dw tank02_d5_top_left
	.db #%00100000
	.db -12
	.dw tank02_d5_top_right_1
	.db %00100000
	.db 4
	.dw W1F00
	.db %10100000
	.db 1
	.dw W1F0C

tank02_moving_d5_fr05:
  .db %00100000
	.db -16
	.dw tank02_d5_top_left
	.db %00100000
	.db -13
	.dw tank02_d5_top_right_2
	.db %00100000
	.db 3
	.dw W1F01
	.db %10000000
	.dw W1F0D

tank02_moving_d5_fr06:
  .db %00100000
	.db -16
	.dw tank02_d5_top_left
	.db %00100000
	.db -13
	.dw tank02_d5_top_right_2
	.db %00100000
	.db 3
	.dw W1F02
	.db %10000000
	.dw W1F0E

tank02_moving_d5_fr07:
  .db %00100000
	.db -16
	.dw tank02_d5_top_left
	.db %00100000
	.db -13
	.dw tank02_d5_top_right_2
	.db #%00100000
	.db 3
	.dw W1F03
	.db %10000000
	.dw W1F0F

tank02_moving_d5_fr08:
  .db %00100000
	.db -15
	.dw tank02_d5_top_left
	.db %00100000
	.db -12
	.dw tank02_d5_top_right_2
	.db %00100000
	.db 4
	.dw W1F04
	.db %10100000
	.db 1
	.dw W1F08

tank01_moving_d6_fr01:
  .db %00100000
	.db -12
	.dw tank01_d6_top_left_2
	.db %00100000
	.db -15
	.dw tank01_d6_top_right_1
	.db %00100000
	.db 4
	.dw W1F10
	.db %10100000
	.db 1
	.dw W1F18

tank01_moving_d6_fr02:
  .db %00100000
	.db -13
	.dw tank01_d6_top_left_1
	.db %00100000
	.db -16
	.dw tank01_d6_top_right_1
	.db %00100000
	.db 3
	.dw W1F11
	.db %10000000
	.dw W1F19

tank01_moving_d6_fr03:
  .db %00100000
	.db -13
	.dw tank01_d6_top_left_1
	.db %00100000
	.db -16
	.dw tank01_d6_top_right_2
	.db %00100000
	.db 3
	.dw W1F12
	.db %10000000
	.dw W1F1A

tank01_moving_d6_fr04:
  .db %00100000
	.db -13
	.dw tank01_d6_top_left_1
	.db %00100000
	.db -16
	.dw tank01_d6_top_right_2
	.db %00100000
	.db 3
	.dw W1F13
	.db %10000000
	.dw W1F1B

tank01_moving_d6_fr05:
  .db %00100000
	.db -12
	.dw tank01_d6_top_left_1
	.db %00100000
	.db -15
	.dw tank01_d6_top_right_2
	.db %00100000
	.db 4
	.dw W1F14
	.db %10100000
	.db 1
	.dw W1F1C

tank01_moving_d6_fr06:
  .db %00100000
	.db -13
	.dw tank01_d6_top_left_1
	.db %00100000
	.db -16
	.dw tank01_d6_top_right_1
	.db %00100000
	.db 3
	.dw W1F15
	.db %10000000
	.dw W1F1D

tank01_moving_d6_fr07:
	.db %00100000
	.db -13
	.dw tank01_d6_top_left_2
	.db %00100000
	.db -16
	.dw tank01_d6_top_right_1
	.db %00100000
	.db 3
	.dw W1F16
	.db %10000000
	.dw W1F1E

tank01_moving_d6_fr08:
  .db %00100000
	.db -13
	.dw tank01_d6_top_left_2
	.db %00100000
	.db -16
	.dw tank01_d6_top_right_1
	.db %00100000
	.db 3
	.dw W1F17
	.db %10000000
	.dw W1F1F

tank02_moving_d6_fr01:
  .db %00100000
	.db -12
	.dw tank02_d6_top_left_2
	.db %00100000
	.db -15
	.dw tank02_d6_top_right_1
	.db %00100000
	.db 4
	.dw W1F10
	.db %10100000
	.db 1
	.dw W1F18

tank02_moving_d6_fr02:
  .db %00100000
	.db -13
	.dw tank02_d6_top_left_1
	.db %00100000
	.db -16
	.dw tank02_d6_top_right_1
	.db %00100000
	.db 3
	.dw W1F11
	.db %10000000
	.dw W1F19

tank02_moving_d6_fr03:
  .db %00100000
	.db -13
	.dw tank02_d6_top_left_1
	.db %00100000
	.db -16
	.dw tank02_d6_top_right_2
	.db %00100000
	.db 3
	.dw W1F12
	.db %10000000
	.dw W1F1A

tank02_moving_d6_fr04:
  .db %00100000
	.db -13
	.dw tank02_d6_top_left_1
	.db %00100000
	.db -16
	.dw tank02_d6_top_right_2
	.db %00100000
	.db 3
	.dw W1F13
	.db %10000000
	.dw W1F1B

tank02_moving_d6_fr05:
  .db %00100000
	.db -12
	.dw tank02_d6_top_left_1
	.db %00100000
	.db -15
	.dw tank02_d6_top_right_2
	.db %00100000
	.db 4
	.dw W1F14
	.db %10100000
	.db 1
	.dw W1F1C

tank02_moving_d6_fr06:
  .db %00100000
	.db -13
	.dw tank02_d6_top_left_1
	.db %00100000
	.db -16
	.dw tank02_d6_top_right_1
	.db %00100000
	.db 3
	.dw W1F15
	.db %10000000
	.dw W1F1D

tank02_moving_d6_fr07:
	.db %00100000
	.db -13
	.dw tank02_d6_top_left_2
	.db %00100000
	.db -16
	.dw tank02_d6_top_right_1
	.db %00100000
	.db 3
	.dw W1F16
	.db %10000000
	.dw W1F1E

tank02_moving_d6_fr08:
  .db %00100000
	.db -13
	.dw tank02_d6_top_left_2
	.db %00100000
	.db -16
	.dw tank02_d6_top_right_1
	.db %00100000
	.db 3
	.dw W1F17
	.db %10000000
	.dw W1F1F

tank01_moving_d4_fr01:
  .db %00100000
	.db -21
	.dw tank01_d4_top
	.db %10100000
	.db -5
	.dw W1F20

tank01_moving_d4_fr02:
  .db %00100000
	.db -22
	.dw tank01_d4_top
	.db %10100000
	.db -6
	.dw W1F21

tank01_moving_d4_fr03:
  .db %00100000
	.db -22
	.dw tank01_d4_top
	.db %10100000
	.db -6
	.dw W1F22

tank01_moving_d4_fr04:
  .db %00100000
	.db -22
	.dw tank01_d4_top
	.db %10100000
	.db -6
	.dw W1F23

tank01_moving_d4_fr05:
  .db %00100000
	.db -21
	.dw tank01_d4_top
	.db %10100000
	.db -5
	.dw W1F24

tank01_moving_d4_fr06:
  .db %00100000
	.db -22
	.dw tank01_d4_top
	.db %10100000
	.db -6
	.dw W1F25

tank01_moving_d4_fr07:
  .db %00100000
	.db -22
	.dw tank01_d4_top
	.db %10100000
	.db -6
	.dw W1F26

tank01_moving_d4_fr08:
  .db %00100000
	.db -22
	.dw tank01_d4_top
	.db %10100000
	.db -6
	.dw W1F27

tank02_moving_d4_fr01:
  .db %00100000
	.db -21
	.dw tank02_d4_top
	.db %10100000
	.db -5
	.dw W1F20

tank02_moving_d4_fr02:
  .db %00100000
	.db -22
	.dw tank02_d4_top
	.db %10100000
	.db -6
	.dw W1F21

tank02_moving_d4_fr03:
  .db %00100000
	.db -22
	.dw tank02_d4_top
	.db %10100000
	.db -6
	.dw W1F22

tank02_moving_d4_fr04:
  .db %00100000
	.db -22
	.dw tank02_d4_top
	.db %10100000
	.db -6
	.dw W1F23

tank02_moving_d4_fr05:
  .db %00100000
	.db -21
	.dw tank02_d4_top
	.db %10100000
	.db -5
	.dw W1F24

tank02_moving_d4_fr06:
  .db %00100000
	.db -22
	.dw tank02_d4_top
	.db %10100000
	.db -6
	.dw W1F25

tank02_moving_d4_fr07:
  .db %00100000
	.db -22
	.dw tank02_d4_top
	.db %10100000
	.db -6
	.dw W1F26

tank02_moving_d4_fr08:
  .db %00100000
	.db -22
	.dw tank02_d4_top
	.db %10100000
	.db -6
	.dw W1F27

tank01_moving_d1_fr01:
	.db %00100000
	.db -21
	.dw tank01_d1_top
	.db %10100000
	.db -5
	.dw W1F28

tank01_moving_d1_fr02:
	.db %00100000
	.db -22
	.dw tank01_d1_top
	.db #%10100000
	.db -6
	.dw W1F29

tank01_moving_d1_fr03:
	.db %00100000
	.db -22
	.dw tank01_d1_top
	.db %10100000
	.db -6
	.dw W1F2A

tank01_moving_d1_fr04:
  .db %00100000
	.db -21
	.dw tank01_d1_top
	.db %10100000
	.db -5
	.dw W1F2B

tank01_moving_d1_fr05:
	.db %00100000
	.db -21
	.dw tank01_d1_top
	.db %10100000
	.db -5
	.dw W1F2C

tank01_moving_d1_fr06:
	.db %00100000
	.db -22
	.dw tank01_d1_top
	.db %10100000
	.db -6
	.dw W1F2D

tank01_moving_d1_fr07:
	.db %00100000
	.db -22
	.dw tank01_d1_top
	.db %10100000
	.db -6
	.dw W1F2E

tank01_moving_d1_fr08:
  .db %00100000
	.db -22
	.dw tank01_d1_top
	.db %10100000
	.db -6
	.dw W1F2F

tank02_moving_d1_fr01:
	.db %00100000
	.db -21
	.dw tank02_d1_top
	.db %10100000
	.db -5
	.dw W1F28

tank02_moving_d1_fr02:
	.db %00100000
	.db -22
	.dw tank02_d1_top
	.db #%10100000
	.db -6
	.dw W1F29

tank02_moving_d1_fr03:
	.db %00100000
	.db -22
	.dw tank02_d1_top
	.db %10100000
	.db -6
	.dw W1F2A

tank02_moving_d1_fr04:
  .db %00100000
	.db -21
	.dw tank02_d1_top
	.db %10100000
	.db -5
	.dw W1F2B

tank02_moving_d1_fr05:
	.db %00100000
	.db -21
	.dw tank02_d1_top
	.db %10100000
	.db -5
	.dw W1F2C

tank02_moving_d1_fr06:
	.db %00100000
	.db -22
	.dw tank02_d1_top
	.db %10100000
	.db -6
	.dw W1F2D

tank02_moving_d1_fr07:
	.db %00100000
	.db -22
	.dw tank02_d1_top
	.db %10100000
	.db -6
	.dw W1F2E

tank02_moving_d1_fr08:
  .db %00100000
	.db -22
	.dw tank02_d1_top
	.db %10100000
	.db -6
	.dw W1F2F



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

EF0A:
  .db #%10010000
  .dw EFF9

EF0B:
  .db #%10011000
  .dw EFFA
EF0C:
  .db #%10011000
  .dw EFFB
