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
	.db #> ANIM03			; 03 LOCK marker
	.db #> ANIM04			; 04 obscure mask (large) NOT USED
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
	.dsb 8
	.db #> ANIM18			; mech 02 stationary
	.db #> ANIM19			; mech 02 stationary
	.db #> ANIM1A			; mech 02 stationary
	.db #> ANIM1B			; mech 02 stationary
	.db #> ANIM1C			; mech 02 m d5
	.db #> ANIM1D			; mech 02 m d6
	.db #> ANIM1E			; mech 02 m d4
	.db #> ANIM1F			; mech 02 m d1
	.db #> ANIM20
	.db #> ANIM21
	.db #> ANIM22
	.db #> ANIM23
	.db #> ANIM24
	.dsb 1
	.db #> ANIM26

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
	.dsb 8
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
	.dsb 1
	.db #< ANIM26

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
	.db $10, $40
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
	.db #$10, #$40
	.dw CS26

ANIM18:
	.db $10, 24
	.dw mech02_stationary_d6_f0

ANIM19:
	.db $10, 24
	.dw mech02_stationary_d4_f0

ANIM1A:
	.db $10, 24
	.dw mech02_stationary_d1_f0

ANIM1B:
	.db $10, 24
	.dw mech02_stationary_d5_f0

ANIM1C:
	.db $80, 3
	.dw mech02_moving_d5_fr00
	.dw mech02_moving_d5_fr01
	.dw mech02_moving_d5_fr02
	.dw mech02_moving_d5_fr03
	.dw mech02_moving_d5_fr04
	.dw mech02_moving_d5_fr05
	.dw mech02_moving_d5_fr06
	.dw mech02_moving_d5_fr07
ANIM1D:
	.db $80, 3
	.dw mech02_moving_d6_fr00
	.dw mech02_moving_d6_fr01
	.dw mech02_moving_d6_fr02
	.dw mech02_moving_d6_fr03
	.dw mech02_moving_d6_fr04
	.dw mech02_moving_d6_fr05
	.dw mech02_moving_d6_fr06
	.dw mech02_moving_d6_fr07
ANIM1E:
	.db $80, 3
	.dw mech02_moving_d4_fr00
	.dw mech02_moving_d4_fr01
	.dw mech02_moving_d4_fr02
	.dw mech02_moving_d4_fr03
	.dw mech02_moving_d4_fr04
	.dw mech02_moving_d4_fr05
	.dw mech02_moving_d4_fr06
	.dw mech02_moving_d4_fr07
ANIM1F:
	.db $80, 3
	.dw mech02_moving_d1_fr00
	.dw mech02_moving_d1_fr01
	.dw mech02_moving_d1_fr02
	.dw mech02_moving_d1_fr03
	.dw mech02_moving_d1_fr04
	.dw mech02_moving_d1_fr05
	.dw mech02_moving_d1_fr06
	.dw mech02_moving_d1_fr07

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

ANIM26:
	.db $10, $20
	.dw OB00
