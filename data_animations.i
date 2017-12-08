; -----------------------------------------------
; animation cycles
;
; byte 1
; 0000 0000
; |||| ||||
; |||| ++++ Reserved for flags, e.g for alternative timing controls
; ++++----- Number of meta sprite frames in animation cycle
;
; byte 2
; 0000 0000
; |||| ||||
; ++++ ++++ timing: number of NMI's between frames in this cycle
; -----------------------------------------------

; -----------------------------------------------

animationL:
	.db #> ANIM00			; 00 cursor
	.db #> ANIM01			; 01 active unit
	.db #> ANIM02			; 02 blocked node (LOS)
	.db #> ANIM03			; 03 obscure mask (small)
	.db #> ANIM04			; 04 obscure mask (large)
	.db #> ANIM05			; 05 explosion
	.db #> ANIM06			; 06 gun bullets
	.db #> ANIM07			; 07 hit percentage
	.db #> ANIM08			; 08 shield (close combat miss)
	.db #> ANIM09			; 09 NOT USED
	.db #> ANIM0A			; 0A waypoint
	.db #> ANIM0B			; 0B no sprites
	.db #> ANIM0C			; 0C shockwave
	.db #> ANIM0D			; 0D shockwave (upside down)
	.db #> ANIM0E			; 0E shutdown timer
	.db #> ANIM0F			; 0F dmg counter
	.db #> ANIM10			; ramulen diag down still
	.db #> ANIM11			; ramulen diag down walking
	.db #> ANIM12			; ramulen diag up still
	.db #> ANIM13			; ramulen diag up walking
	.db #> ANIM14			; ramulen down still
	.db #> ANIM15			; ramulen down walking
	.db #> ANIM16			; ramulen up still
	.db #> ANIM17			; ramulen up walking
	.db #> ANIM18			; t2
	.db #> ANIM19			; t2
	.db #> ANIM1A			; t2
	.db #> ANIM1B			; t2
	.db #> ANIM1C			; t2 m d5
	.db #> ANIM1D			; t2 m d6
	.db #> ANIM1E			; t2 m d4
	.db #> ANIM1F			; t2 m d1
	.db #> ANIM20
	.db #> ANIM21
	.db #> ANIM22
	.db #> ANIM23
	.db #> ANIM24

animationH:
	.db #< ANIM00
	.db #< ANIM01
	.db #< ANIM02
	.db #< ANIM03
	.db #< ANIM04
	.db #< ANIM05
	.db #< ANIM06
	.db #< ANIM07
	.db #< ANIM08
	.db #< ANIM09
	.db #< ANIM0A
	.db #< ANIM0B
	.db #< ANIM0C
	.db #< ANIM0D
	.db #< ANIM0E
	.db #< ANIM0F
	.db #< ANIM10
	.db #< ANIM11
	.db #< ANIM12
	.db #< ANIM13
	.db #< ANIM14
	.db #< ANIM15
	.db #< ANIM16
	.db #< ANIM17
	.db #< ANIM18
	.db #< ANIM19
	.db #< ANIM1A
	.db #< ANIM1B
	.db #< ANIM1C
	.db #< ANIM1D
	.db #< ANIM1E
	.db #< ANIM1F
	.db #< ANIM20
	.db #< ANIM21
	.db #< ANIM22
	.db #< ANIM23
	.db #< ANIM24

ANIM00:
	.db #$80, #$08
	.dw CS00
	.dw CS01
	.dw CS02
	.dw CS03
	.dw CS04
	.dw CS03
	.dw CS02
	.dw CS01
ANIM01:
	.db #$80, #$08
	.dw CS10
	.dw CS11
	.dw CS12
	.dw CS13
	.dw CS14
	.dw CS13
	.dw CS12
	.dw CS11
ANIM02:
	.db $20, $20
	.dw CS20
	.dw CS21
ANIM03:
	.db $10, $40
	.dw CS22
ANIM04:
	.db $10, $40
	.dw CS23
ANIM05:
	.db $20, $06
	.dw EF00
	.dw EF05
ANIM06:
	.db $10, $10
	.dw EF04
ANIM07:
	.db #$10, #$40
	.dw CS24
ANIM08:
	.db $10, $40
	.dw EF06

ANIM09:

ANIM0A:
	.db $10, $10
	.dw EF0A

ANIM0B:
	.db $10, $10
	.dw CS21

ANIM0C:
	.db $10, $10
	.dw EF0B

ANIM0D:
	.db $10, $10
	.dw EF0C

ANIM0E:
	.db #$10, #$20
	.dw CS25

ANIM0F:
	.db #$10, #$20
	.dw CS26

ANIM10:
	.db $10, $20
	.dw tank01_stationary_d5_f
ANIM11:
	.db $80, $04
	.dw tank01_moving_d5_fr01
	.dw tank01_moving_d5_fr02
	.dw tank01_moving_d5_fr03
	.dw tank01_moving_d5_fr04
	.dw tank01_moving_d5_fr05
	.dw tank01_moving_d5_fr06
	.dw tank01_moving_d5_fr07
	.dw tank01_moving_d5_fr08
ANIM12:
	.db $10, $20
	.dw tank01_stationary_d6_f
ANIM13:
	.db $80, $04
	.dw tank01_moving_d6_fr01
	.dw tank01_moving_d6_fr02
	.dw tank01_moving_d6_fr03
	.dw tank01_moving_d6_fr04
	.dw tank01_moving_d6_fr05
	.dw tank01_moving_d6_fr06
	.dw tank01_moving_d6_fr07
	.dw tank01_moving_d6_fr08
ANIM14:
	.db $10, $20
	.dw tank01_stationary_d4_f
ANIM15:
	.db $80, $04
	.dw tank01_moving_d4_fr01
	.dw tank01_moving_d4_fr02
	.dw tank01_moving_d4_fr03
	.dw tank01_moving_d4_fr04
	.dw tank01_moving_d4_fr05
	.dw tank01_moving_d4_fr06
	.dw tank01_moving_d4_fr07
	.dw tank01_moving_d4_fr08
ANIM16:
	.db $10, $20
	.dw tank01_stationary_d1_f
ANIM17:
	.db $80, $04
	.dw tank01_moving_d1_fr01
	.dw tank01_moving_d1_fr02
	.dw tank01_moving_d1_fr03
	.dw tank01_moving_d1_fr04
	.dw tank01_moving_d1_fr05
	.dw tank01_moving_d1_fr06
	.dw tank01_moving_d1_fr07
	.dw tank01_moving_d1_fr08

ANIM18:
	.db $10, $20
	.dw tank02_stationary_d6_f

ANIM19:
	.db $10, $20
	.dw tank02_stationary_d4_f

ANIM1A:
	.db $10, $20
	.dw tank02_stationary_d1_f

ANIM1B:
	.db $10, $20
	.dw tank02_stationary_d5_f

ANIM1C:
	.db $80, $04
	.dw tank02_moving_d5_fr01
	.dw tank02_moving_d5_fr02
	.dw tank02_moving_d5_fr03
	.dw tank02_moving_d5_fr04
	.dw tank02_moving_d5_fr05
	.dw tank02_moving_d5_fr06
	.dw tank02_moving_d5_fr07
	.dw tank02_moving_d5_fr08
ANIM1D:
	.db $80, $04
	.dw tank02_moving_d6_fr01
	.dw tank02_moving_d6_fr02
	.dw tank02_moving_d6_fr03
	.dw tank02_moving_d6_fr04
	.dw tank02_moving_d6_fr05
	.dw tank02_moving_d6_fr06
	.dw tank02_moving_d6_fr07
	.dw tank02_moving_d6_fr08
ANIM1E:
	.db $80, $04
	.dw tank02_moving_d4_fr01
	.dw tank02_moving_d4_fr02
	.dw tank02_moving_d4_fr03
	.dw tank02_moving_d4_fr04
	.dw tank02_moving_d4_fr05
	.dw tank02_moving_d4_fr06
	.dw tank02_moving_d4_fr07
	.dw tank02_moving_d4_fr08
ANIM1F:
	.db $80, $04
	.dw tank02_moving_d1_fr01
	.dw tank02_moving_d1_fr02
	.dw tank02_moving_d1_fr03
	.dw tank02_moving_d1_fr04
	.dw tank02_moving_d1_fr05
	.dw tank02_moving_d1_fr06
	.dw tank02_moving_d1_fr07
	.dw tank02_moving_d1_fr08

ANIM20:
	.db $20, $04
	.dw EF0D
	.dw EF0E

ANIM21:
	.db $20, $04
	.dw EF0F
	.dw EF10

ANIM22:
	.db $20, $04
	.dw EF11
	.dw EF12

ANIM23:
	.db $20, $04
	.dw EF13
	.dw EF14

ANIM24:
	.db $20, $04
	.dw EF15
	.dw EF16
