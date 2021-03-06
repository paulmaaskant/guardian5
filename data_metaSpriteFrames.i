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
; turret animation frames
; -------------------------------------
trt_d1_f0:
  .db %10101000
  .db -8
  .dw trt_1

trt_d4_f0:
  .db %10101000
  .db -8
  .dw trt_4

trt_d5_f0:
  .db %10101000
  .db -8
  .dw trt_5

trt_d6_f0:
  .db %10101000
  .db -8
  .dw trt_6


; -------------------------------------
; apc animation frames
; -------------------------------------
apc_d1_f0:
  .db %10101000
  .db -4
  .dw apc_1

apc_d4_f0:
  .db %10101000
  .db -12
  .dw apc_4

apc_d5_f0:
  .db %10101000
  .db -12
  .dw apc_5

apc_d6_f0:
  .db %10101000
  .db -4
  .dw apc_6

dronA_d4_f0:
  .db %00101000
  .db -16
  .dw dronA_00_f0
  .db %10101000
  .db -16
  .dw dronA_02_f0

dronA_d4_f1:
  .db %00101000
  .db -16
  .dw dronA_00_f1
  .db %10101000
  .db -16
  .dw dronA_02_f0

dronA_d4_f2:
  .db %00101000
  .db -16
  .dw dronA_00_f2
  .db %10101000
  .db -16
  .dw dronA_02_f0

dronA_d4_f3:
  .db %00101000
  .db -16
  .dw dronA_00_f3
  .db %10101000
  .db -16
  .dw dronA_02_f0

dronA_d1_f0:
  .db %00101000
  .db -16
  .dw dronA_00_f0
  .db %10101000
  .db -16
  .dw dronA_03_f0

dronA_d1_f1:
  .db %00101000
  .db -16
  .dw dronA_00_f1
  .db %10101000
  .db -16
  .dw dronA_03_f0

dronA_d1_f2:
  .db %00101000
  .db -16
  .dw dronA_00_f2
  .db %10101000
  .db -16
  .dw dronA_03_f0

dronA_d1_f3:
  .db %00101000
  .db -16
  .dw dronA_00_f3
  .db %10101000
  .db -16
  .dw dronA_03_f0

dronA_d5_f0:
  .db %00101000
  .db -16
  .dw dronA_56_f0
  .db %10101000
  .db -16
  .dw dronA_05_f0

dronA_d5_f1:
  .db %00101000
  .db -16
  .dw dronA_56_f1
  .db %10101000
  .db -16
  .dw dronA_05_f0

dronA_d5_f2:
  .db %00101000
  .db -16
  .dw dronA_56_f2
  .db %10101000
  .db -16
  .dw dronA_05_f0

dronA_d5_f3:
  .db %00101000
  .db -16
  .dw dronA_56_f3
  .db %10101000
  .db -16
  .dw dronA_05_f0


dronA_d6_f0:
  .db %00101001
  .db -16
  .dw dronA_56_f0
  .db %10101000
  .db -16
  .dw dronA_06_f0

dronA_d6_f1:
  .db %00101001
  .db -16
  .dw dronA_56_f1
  .db %10101000
  .db -16
  .dw dronA_06_f0

dronA_d6_f2:
  .db %00101001
  .db -16
  .dw dronA_56_f2
  .db %10101000
  .db -16
  .dw dronA_06_f0

dronA_d6_f3:
  .db %00101001
  .db -16
  .dw dronA_56_f3
  .db %10101000
  .db -16
  .dw dronA_06_f0

mech00_stationary_d1_f0:
  .db %10100000
	.db -16
	.dw mech00_d1

mech00_stationary_d4_f0:
  .db %10100000
	.db -16
	.dw mech00_d4

mech00_stationary_d5_f0:
  .db %10100000
  .db -16
  .dw mech00_d5

mech00_stationary_d6_f0:
	.db %10100000
	.db -16
	.dw mech00_d6

mech01_stationary_d1_f0:
  .db %10100000
	.db -16
	.dw mech01_d1

mech01_stationary_d4_f0:
  .db %10100000
	.db -16
	.dw mech01_d4

mech01_stationary_d5_f0:
  .db %10100000
  .db -16
  .dw mech01_d5

mech01_stationary_d6_f0:
	.db %10100000
	.db -16
	.dw mech01_d6

mech02_stationary_d1_f0:
  .db %10100000
	.db -16
	.dw mech02_d1

mech02_stationary_d4_f0:
  .db %10100000
	.db -16
	.dw mech02_d4

mech02_stationary_d5_f0:
  .db %10100000
  .db -16
  .dw mech02_d5

mech02_stationary_d6_f0:
	.db %10100000
	.db -16
	.dw mech02_d6

mech03_stationary_d1_f0:
  .db %10101000
	.db -16
	.dw mech03_d1

mech03_stationary_d4_f0:
  .db %10101000
	.db -16
	.dw mech03_d4

mech03_stationary_d5_f0:
  .db %10101000
  .db -16
  .dw mech03_d5

mech03_stationary_d6_f0:
	.db %10101000
	.db -16
	.dw mech03_d6





OB00:
  .db %10101000
  .db -24
  .dw OBS0

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
		.db #10
		.db #4
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
	.db #%10010000
	.dw CUR3

CS21:
	.db #%10010000
	.dw CLR0

CS22:
	.db #%10110000
	.db -32
	.dw CUR4

CS23:
	.db %00010000
	.dw CUR5
  .db %10110000
  .db 16
  .dw CUR6

CS24:
  .db %10110000
	.db -40
	.dw CUR9

CS25:
  .db %10110000
	.db -24
	.dw CURA

CS26:
  .db %10110000
  .db -40
  .dw CURB

  CS27:
  	.db %00010000
  	.dw CUR5
    .db %10110000
    .db 8
    .dw CUR6

  CS28:
  	.db %00010000
  	.dw CUR5
    .db %10110000
    .db 24
    .dw CUR6

  CS29:
    .db %00000000
    .dw mech00_d4
    .db %00100000
    .db 32
    .dw mech02_d4
    .db %01000000
    .db 24
    .dw mech01_d4
    .db %11100000
    .db 24, 32
    .dw mech03_d4








EF00: ; explosion
	.db #%10111000, -16
  .dw EFF0
EF05: ; explosion
	.db #%10111000, -16
	.dw EFF4



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
	.db #%10111000, -12
  .dw EFF3

EF06:
	.db #%10110000, -20
  .dw EFF5

EF07:
  .db %10111000, -12
  .dw EFF6

EF08:
  .db %10111000, -12
  .dw EFF9


EF09:


EF0A:
  .db #%10011000
  .dw EFF9

EF0B:
  .db #%10011000
  .dw EFFA
EF0C:
  .db #%10011000
  .dw EFFB

EF0D:
  .db #%10111000, -16
  .dw MIS0
EF0E:
  .db #%10111000, -16
  .dw MIS1

EF0F:
  .db #%10111000, -16
  .dw MIS2
EF10:
  .db #%10111000, -16
  .dw MIS3

EF11:
  .db #%10111000, -12
  .dw MIS4
EF12:
  .db #%10111000, -12
  .dw MIS5

EF13:
  .db #%10111000, -16
  .dw MIS6
EF14:
  .db #%10111000, -16
  .dw MIS7
EF15:
  .db #%10111000, -16
  .dw MIS8
EF16:
  .db #%10111000, -16
  .dw MIS9

EF17:
  .db #%10111000, -12
  .dw LAS0
EF18:
  .db #%10111000, -12
  .dw LAS1
EF19:
  .db #%10111000, -12
  .dw LAS2
EF1A:
  .db #%10111000, -12
  .dw LAS3
EF1B:
  .db #%10111000, -12
  .dw LAS4



SH00:
  .db %10001000
  .dw SHW0

mechA_moving_d1_fr00:
  .db %10101000
  .db -8 ; -7
  .dw mechA_d1_f0
mechA_moving_d1_fr01:
  .db %10101000
  .db -8
  .dw mechA_d1_f1
mechA_moving_d1_fr02:
  .db %10101000
  .db -8
  .dw mechA_d1_f2
mechA_moving_d1_fr03:
  .db %10101000
  .db -8
  .dw mechA_d1_f3
mechA_moving_d1_fr04:
  .db %10101000
  .db -8 ; -7
  .dw mechA_d1_f4
mechA_moving_d1_fr05:
  .db %10101000
  .db -8
  .dw mechA_d1_f5
mechA_moving_d1_fr06:
  .db %10101000
  .db -8
  .dw mechA_d1_f6
mechA_moving_d1_fr07:
  .db %10101000
  .db -8
  .dw mechA_d1_f7

mechA_moving_d4_fr00:
  .db %10101000
  .db -8 ;-7
  .dw mechA_d4_f0
mechA_moving_d4_fr01:
  .db %10101000
  .db -8
  .dw mechA_d4_f1
mechA_moving_d4_fr02:
  .db %10101000
  .db -8
  .dw mechA_d4_f2
mechA_moving_d4_fr03:
  .db %10101000
  .db -8
  .dw mechA_d4_f3
mechA_moving_d4_fr04:
  .db %10101000
  .db -8 ; -7
  .dw mechA_d4_f4
mechA_moving_d4_fr05:
  .db %10101000
  .db -8
  .dw mechA_d4_f5
mechA_moving_d4_fr06:
  .db %10101000
  .db -8
  .dw mechA_d4_f6
mechA_moving_d4_fr07:
  .db %10101000
  .db -8
  .dw mechA_d4_f7

mechA_moving_d5_fr00:
  .db %10101000
  .db -8 ; -7
  .dw mechA_d5_f0
mechA_moving_d5_fr01:
  .db %10101000
  .db -8
  .dw mechA_d5_f1
mechA_moving_d5_fr02:
  .db %10101000
  .db -8
  .dw mechA_d5_f2
mechA_moving_d5_fr03:
  .db %10101000
  .db -8
  .dw mechA_d5_f3
mechA_moving_d5_fr04:
  .db %10101000
  .db -8 ; -7
  .dw mechA_d5_f4
mechA_moving_d5_fr05:
  .db %10101000
  .db -8
  .dw mechA_d5_f5
mechA_moving_d5_fr06:
  .db %10101000
  .db -8
  .dw mechA_d5_f6
mechA_moving_d5_fr07:
  .db %10101000
  .db -8
  .dw mechA_d5_f7

mechA_moving_d6_fr00:
  .db %10101000
  .db -8  ; -7
  .dw mechA_d6_f0
mechA_moving_d6_fr01:
  .db %10101000
  .db -8
  .dw mechA_d6_f1
mechA_moving_d6_fr02:
  .db %10100000
  .db -8
  .dw mechA_d6_f2
mechA_moving_d6_fr03:
  .db %10101000
  .db -8
  .dw mechA_d6_f3
mechA_moving_d6_fr04:
  .db %10101000
  .db -8  ; -1
  .dw mechA_d6_f4
mechA_moving_d6_fr05:
  .db %10101000
  .db -8
  .dw mechA_d6_f5
mechA_moving_d6_fr06:
  .db %10101000
  .db -8
  .dw mechA_d6_f6
mechA_moving_d6_fr07:
  .db %10101000
  .db -8
  .dw mechA_d6_f7

mechA_jumping_fr00:
  .db %00101000
  .db -8
  .dw mechA_j5_f0
  .db %10001000
  .dw EFF7

mechA_jumping_fr01:
  .db %00101000
  .db -8
  .dw mechA_j5_f0
  .db %10001000
  .dw EFF8
