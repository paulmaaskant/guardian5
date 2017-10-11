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
	.db $30, $04
	.dw EF07
	.dw EF08
	.dw EF09

ANIM0A:

ANIM0B:

ANIM0C:

ANIM0D:

ANIM0E:

ANIM0F:

ANIM10:
		.db #$10, #$20
		.dw tank01_stationary_d5_f
ANIM11:
	.db #$80, #$04
	.dw OS1F01
	.dw OS1F02
	.dw OS1F03
	.dw OS1F04
	.dw OS1F05
	.dw OS1F06
	.dw OS1F07
	.dw OS1F08
ANIM12:
	.db #$10, #$20
	.dw tank01_stationary_d6_f
ANIM13:
	.db #$80, #$04
	.dw OS1F0A
	.dw OS1F0B
	.dw OS1F0C
	.dw OS1F0D
	.dw OS1F0E
	.dw OS1F0F
	.dw OS1F10
	.dw OS1F11
ANIM14:
	.db #$10, #$20
	.dw OS1F12
ANIM15:
	.db #$80, #$04
	.dw OS1F13
	.dw OS1F14
	.dw OS1F15
	.dw OS1F16
	.dw OS1F17
	.dw OS1F18
	.dw OS1F19
	.dw OS1F1A
ANIM16:
	.db #$10, #$20
	.dw OS1F1B
ANIM17:
	.db #$80, #$04
	.dw OS1F1C
	.dw OS1F1D
	.dw OS1F1E
	.dw OS1F1F
	.dw OS1F20
	.dw OS1F21
	.dw OS1F22
	.dw OS1F23

ANIM18:
	.db #$10, #$20
	.dw tank02_stationary_d6_f

ANIM19:
	.db #$10, #$20
	.dw tank02_stationary_d4_f

ANIM1A:
	.db #$10, #$20
	.dw tank02_stationary_d1_f

ANIM1B:
	.db #$10, #$20
	.dw tank02_stationary_d5_f

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
	.db #> ANIM09			; 09 cooldown flush
	.dsb 6
	.db #> ANIM10			; ramulen diag down still
	.db #> ANIM11			; ramulen diag down walking
	.db #> ANIM12			; ramulen diag up still
	.db #> ANIM13			; ramulen diag up walking
	.db #> ANIM14			; ramulen down still
	.db #> ANIM15			; ramulen down walking
	.db #> ANIM16			; ramulen up still
	.db #> ANIM17			; ramulen up walking
	.db #> ANIM18			;
	.db #> ANIM19			;
	.db #> ANIM1A
	.db #> ANIM1B

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
	.dsb 6
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
