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
	.db #> ANIM01			; 01 active unit marker
	.db #> ANIM02			; 02 blocked node marker (LOS)
	.db #> ANIM03			; 03 target lock marker
	.db #> ANIM04			; 04 small explosion
	.db #> ANIM05			; 05 explosion
	.db #> ANIM06			; 06 gun bullets
	.db #> ANIM07			; 07 hit percentage
	.db #> ANIM08			; 08 miss
	.db #> ANIM09			; 09 shadow
	.db #> ANIM0A			; 0A waypoint
	.db #> ANIM0B			; 0B no sprites
	.db #> ANIM0C			; 0C shockwave
	.db #> ANIM0D			; 0D shockwave (upside down)
	.db #> ANIM0E			; 0E shutdown marker
	.db #> ANIM0F			; 0F hit percentage
	.db #> ANIM10			; mech 03 stationary
	.db #> ANIM11			; mech 03 stationary
	.db #> ANIM12			; mech 03 stationary
	.db #> ANIM13			; mech 03 stationary
	.db #> ANIM14			; mech A legs moving d5
	.db #> ANIM15			; mech A legs moving d6
	.db #> ANIM16			; mech A legs moving d4
	.db #> ANIM17			; mech A legs moving d1
	.db #> ANIM18			; mech 02 stationary
	.db #> ANIM19			; mech 02 stationary
	.db #> ANIM1A			; mech 02 stationary
	.db #> ANIM1B			; mech 02 stationary
	.db #> ANIM1C			; mech 00 stationary
	.db #> ANIM1D			; mech 00 stationary
	.db #> ANIM1E			; mech 00 stationary
	.db #> ANIM1F			; mech 00 stationary
	.db #> ANIM20			; missile
	.db #> ANIM21			; missile
	.db #> ANIM22			; missile
	.db #> ANIM23			; missile
	.db #> ANIM24			; missile
	.db #> ANIM25			; NOT USED
	.db #> ANIM26			; obstacle
	.db #> ANIM27			; drone A d4
	.db #> ANIM28			; drone A d1
	.db #> ANIM29			; drone A d5
	.db #> ANIM2A			; drone A d6
	.db #> ANIM2B			; laser 0
	.db #> ANIM2C			; laser 32
	.db #> ANIM2D			; laser 64
	.db #> ANIM2E			; laser 16
	.db #> ANIM2F			; laser 48
	.db #> ANIM30			; mech 01 stationary
	.db #> ANIM31			; mech 01 stationary
	.db #> ANIM32			; mech 01 stationary
	.db #> ANIM33			; mech 01 stationary

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
	.db #< ANIM25
	.db #< ANIM26
	.db #< ANIM27
	.db #< ANIM28
	.db #< ANIM29
	.db #< ANIM2A
	.db #< ANIM2B			; laser vertical
	.db #< ANIM2C			; laser hor/ver
	.db #< ANIM2D
	.db #< ANIM2E
	.db #< ANIM2F
	.db #< ANIM30			; mech 01 stationary
	.db #< ANIM31			; mech 01 stationary
	.db #< ANIM32			; mech 01 stationary
	.db #< ANIM33			; mech 01 stationary

ANIM00:
	.db 8, 3
	.dw CS00
	.dw CS01
	.dw CS02
	.dw CS03
	.dw CS04
	.dw CS03
	.dw CS02
	.dw CS01
ANIM01:
	.db 8, 3
	.dw CS10
	.dw CS11
	.dw CS12
	.dw CS13
	.dw CS14
	.dw CS13
	.dw CS12
	.dw CS11
ANIM02:
	.db 2, 5
	.dw CS20
	.dw CS21
ANIM03:
	.db 1, 6
	.dw CS22
ANIM04:
	.db 2, 2
	.dw EF07
	.dw EF08

ANIM05:
	.db 4, 2
	.dw EF07
	.dw EF08
	.dw EF00
	.dw EF05

ANIM06:
	.db 1, 4
	.dw EF04
ANIM07:
	.db 1, 6
	.dw CS24
ANIM08:
	.db 2, 3
	.dw EF06
	.dw CS21

ANIM09:
	.db 1, 4
	.dw SH00

ANIM0A:
	.db 1, 4
	.dw EF0A

ANIM0B:
	.db 1, 4
	.dw CS21

ANIM0C:
	.db 1, 4
	.dw EF0B

ANIM0D:
	.db 1, 4
	.dw EF0C

ANIM0E:
	.db 1, 5
	.dw CS25

ANIM0F:
	.db 1, 6
	.dw CS26


ANIM10:
	.db 1, 5
	.dw mech03_stationary_d6_f0

ANIM11:
	.db 1, 5
	.dw mech03_stationary_d4_f0

ANIM12:
	.db 1, 5
	.dw mech03_stationary_d1_f0

ANIM13:
	.db 1, 5
	.dw mech03_stationary_d5_f0

ANIM14:
	.db 8, 2
	.dw mechA_moving_d5_fr00
	.dw mechA_moving_d5_fr01
	.dw mechA_moving_d5_fr02
	.dw mechA_moving_d5_fr03
	.dw mechA_moving_d5_fr04
	.dw mechA_moving_d5_fr05
	.dw mechA_moving_d5_fr06
	.dw mechA_moving_d5_fr07
ANIM15:
	.db 8, 2
	.dw mechA_moving_d6_fr00
	.dw mechA_moving_d6_fr01
	.dw mechA_moving_d6_fr02
	.dw mechA_moving_d6_fr03
	.dw mechA_moving_d6_fr04
	.dw mechA_moving_d6_fr05
	.dw mechA_moving_d6_fr06
	.dw mechA_moving_d6_fr07
ANIM16:
	.db 8, 2
	.dw mechA_moving_d4_fr00
	.dw mechA_moving_d4_fr01
	.dw mechA_moving_d4_fr02
	.dw mechA_moving_d4_fr03
	.dw mechA_moving_d4_fr04
	.dw mechA_moving_d4_fr05
	.dw mechA_moving_d4_fr06
	.dw mechA_moving_d4_fr07
ANIM17:
	.db 8, 2
	.dw mechA_moving_d1_fr00
	.dw mechA_moving_d1_fr01
	.dw mechA_moving_d1_fr02
	.dw mechA_moving_d1_fr03
	.dw mechA_moving_d1_fr04
	.dw mechA_moving_d1_fr05
	.dw mechA_moving_d1_fr06
	.dw mechA_moving_d1_fr07


ANIM18:
	.db 1, 5
	.dw mech02_stationary_d6_f0

ANIM19:
	.db 1, 5
	.dw mech02_stationary_d4_f0

ANIM1A:
	.db 1, 5
	.dw mech02_stationary_d1_f0

ANIM1B:
	.db 1, 5
	.dw mech02_stationary_d5_f0

ANIM1C:
	.db 1, 5
	.dw mech00_stationary_d6_f0

ANIM1D:
	.db 1, 5
	.dw mech00_stationary_d4_f0

ANIM1E:
	.db 1, 5
	.dw mech00_stationary_d1_f0

ANIM1F:
	.db 1, 5
	.dw mech00_stationary_d5_f0

ANIM20:
	.db 2, 2
	.dw EF0D
	.dw EF0E

ANIM21:
	.db 2, 2
	.dw EF0F
	.dw EF10

ANIM22:
	.db 2, 2
	.dw EF11
	.dw EF12

ANIM23:
	.db 2, 2
	.dw EF13
	.dw EF14

ANIM24:
	.db 2, 2
	.dw EF15
	.dw EF16

ANIM25:

ANIM26:
	.db 1, 5
	.dw OB00

ANIM27:
	.db 4, 2
	.dw dronA_d4_f0
	.dw dronA_d4_f1
	.dw dronA_d4_f2
	.dw dronA_d4_f3

ANIM28:
	.db 4, 2
	.dw dronA_d1_f0
	.dw dronA_d1_f1
	.dw dronA_d1_f2
	.dw dronA_d1_f3

ANIM29:
	.db 4, 2
	.dw dronA_d5_f0
	.dw dronA_d5_f1
	.dw dronA_d5_f2
	.dw dronA_d5_f3

ANIM2A:
	.db 4, 2
	.dw dronA_d6_f0
	.dw dronA_d6_f1
	.dw dronA_d6_f2
	.dw dronA_d6_f3

ANIM2B:
	.db 1, 5
	.dw EF17

ANIM2C:
	.db 1, 5
	.dw EF18

ANIM2D:
	.db 1, 5
	.dw EF19

ANIM2E:
	.db 1, 5
	.dw EF1A

ANIM2F:
	.db 1, 5
	.dw EF1B

ANIM30:
	.db 1, 5
	.dw mech01_stationary_d6_f0

ANIM31:
	.db 1, 5
	.dw mech01_stationary_d4_f0

ANIM32:
	.db 1, 5
	.dw mech01_stationary_d1_f0

ANIM33:
	.db 1, 5
	.dw mech01_stationary_d5_f0
