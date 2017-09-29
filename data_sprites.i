
; sprite frame
; pppp_FNL - (ffffffff) - xxxxxxxx - sprite pattern (* p)

; pppp = number of patterns in row
; H = 1, not show if position is obscured
; F = 1, optional flip bit byte included
; N = 1, move one row down
; L = 1, last row
; ffffffff = (optional) flip bits for first 4 patterns
; xxxxxxxx = X offset from center vertical axis


; m1 down diag left column (stationary)
O1F00:
	.db #%00010000, #%11111100, #$82
	.db #%00010010, #%11111100, #$92
	.db #%00011011, #%11111100, #$84

; m1 down diag right column (stationary)
O1F01:
	.db #%00010000, #%00000100, #$83
	.db #%00010010, #%00000100, #$93
	.db #%00011011, #%00000001, #$84

; m1 down diag left column body
O1F03:
	.db #%00010000, #%11111100, #$82
	.db #%00010011, #%11111100, #$92

; m1 down diag right column body frame 1
O1F04:
	.db #%00010000, #%00000100, #$83
	.db #%00010011, #%00000100, #$93
; m1 down diag right column body frame 2
O1F05:
	.db #%00010000, #%00000100, #$83
	.db #%00010011, #%00000100, #$75
; m1 up diag right column
O1F06:
	.db #%00010000, #%00000100, #$A3
	.db #%00010010, #%00000100, #$B3
	.db #%00010011, #%00000100, #$85
; m1 up diag left column
O1F07:
	.db #%00010000, #%11111100, #$A2
	.db #%00010010, #%11111111, #$B2
	.db #%00011011, #%11111110, #$85
; m1 up diag right column body
O1F08:
	.db #%00010000, #%00000100, #$A3
	.db #%00010011, #%00000100, #$B3
; m1 up diag right column body
O1F09:
	.db #%00010000, #%00000100, #$A3
	.db #%00010011, #%00000100, #$46

; m1 up diag right column body frame 1
O1F0A:
	.db #%00010000, #%11111100, #$A2
	.db #%00010011, #%11111111, #$B2
; m1 up diag right column body frame 2
O1F0B:
	.db #%00010000, #%11111100, #$A2
	.db #%00010011, #%11111110, #$56
; m1 down body

O1F0C:  ; body front
	.db #%00110110, #$10, #%11111000, #$80, #$81, #$80
	.db #%00100111, #$04, #%11111100, #$90, #$90

O1F0D:	; legs front
	.db #%00101111, #$04, #%11111100, #$91, #$91

; m1 up body
O1F0E:
	.db #%00110110, #$10, #%11111000, #$A0, #$A1, #$A0
	.db #%00100111, #$04, #%11111100, #$B0, #$B0

O1F0F:
	.db #%00101111, #$04, #%11111100, #$B1, #$B1


; m1 down diag front leg
W1F00:	.db #%00010001, #$00, #$40
W1F01:	.db #%00010001, #$02, #$40
W1F02:	.db #%00010001, #$04, #$50
W1F03:	.db #%00010001, #$06, #$60
W1F04:	.db #%00010001, #$03, #$70
W1F05:	.db #%00010001, #$01, #$41
W1F06:	.db #%00010001, #$FF, #$41
W1F07:	.db #%00010001, #$FF, #$51
; m1 down diag back leg
W1F08:	.db #%00010001, #$FC, #$40
W1F09:	.db #%00010001, #$FE, #$40
W1F0A:	.db #%00010001, #$00, #$50
W1F0B:	.db #%00010001, #$02, #$60
W1F0C:	.db #%00010001, #$FF, #$70
W1F0D:	.db #%00010001, #$FD, #$41
W1F0E:	.db #%00010001, #$FB, #$41
W1F0F:	.db #%00010001, #$FB, #$51
; m1 up diag front leg
W1F10:	.db #%00010001, #$FC, #$42
W1F11:	.db #%00010001, #$FD, #$85
W1F12:	.db #%00010001, #$FF, #$71
W1F13:	.db #%00010001, #$01, #$61
W1F14:	.db #%00010001, #$FF, #$52
W1F15:	.db #%00010001, #$FD, #$72
W1F16:	.db #%00010001, #$FB, #$72
W1F17:	.db #%00010001, #$FB, #$62
; m1 updiag back leg
W1F18:	.db #%00010001, #$04, #$52
W1F19:	.db #%00010001, #$03, #$72
W1F1A:	.db #%00010001, #$00, #$72
W1F1B:	.db #%00010001, #$00, #$62
W1F1C:	.db #%00010001, #$FF, #$42
W1F1D:	.db #%00010001, #$01, #$85
W1F1E:	.db #%00010001, #$03, #$71
W1F1F:	.db #%00010001, #$05, #$61
; m1 down legs
W1F20:	.db #%00100111, #$04, #%11111100, #$91, #$63
W1F21:	.db #%00100111, #$04, #%11111100, #$91, #$63
W1F22:	.db #%00100111, #$04, #%11111100, #$43, #$73
W1F23:	.db #%00100111, #$04, #%11111100, #$53, #$44
W1F24:	.db #%00100111, #$04, #%11111100, #$63, #$91
W1F25:	.db #%00100111, #$04, #%11111100, #$63, #$91
W1F26:	.db #%00100111, #$04, #%11111100, #$73, #$43
W1F27:	.db #%00100111, #$04, #%11111100, #$44, #$53
; m1 up legs
W1F28:	.db #%00100111, #$04, #%11111100, #$54, #$45
W1F29:	.db #%00100111, #$04, #%11111100, #$64, #$55
W1F2A:	.db #%00100111, #$04, #%11111100, #$B1, #$65
W1F2B:	.db #%00100111, #$04, #%11111100, #$74, #$55
W1F2C:	.db #%00100111, #$04, #%11111100, #$45, #$54
W1F2D:	.db #%00100111, #$04, #%11111100, #$55, #$64
W1F2E:	.db #%00100111, #$04, #%11111100, #$65, #$B1
W1F2F:	.db #%00100111, #$04, #%11111100, #$55, #$74


CLR0:
	.db #%00010001, #$00, #$00
CUR0:
	.db #%00010001, #$00, #$20
CUR1:
	.db #%00010001, #$00, #$30
CUR2:
	.db #%00010001, #$00, #$21
CUR3:
	.db #%00010001, #$00, #$32
CUR4:	; transparancy mask (small)
	.db #%00100111, #$04, #%11111100, #$25, #$25
CUR5: ; transparancy mask (large)
	.db #%00110110, #$14, #%11111100, $25, $25, $24
	.db #%00110111, #$00, #%11111001, $00, $35, $35
CUR9:	; hit percentage
	.db #%00100001, #%11111011, #$31, #$0A, #$31, #$0B

EFF0:	; explosion frame 1
	.db #%00100110, #$0E, #%11111100, #$22, #$22
	.db #%00100111, #$04, #%11111100, #$22, #$22
EFF4: ; explosion frame 2
	.db #%00100110, #$0E, #%11111100, #$33, #$33
	.db #%00100111, #$04, #%11111100, #$33, #$33
EFF1:
	.db #%00010001, #$00, #$E3
EFF2:
	.db #%00010001, #$00, #$F3
EFF3:
	.db #%00010001, #$00, #$23
EFF5:
	.db #%00010001, #$00, #$34

; flush effect for cooldown
EFF6
	.db #%00010001, #$00, #$26
EFF7
	.db #%00010001, #$00, #$36
EFF8
	.db #%00010001, #$00, #$27



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
; Mech 1 animation frames
; -------------------------------------

; mech 1 standing ()
OS1F00
		.db #%00100000
		.db #$F3				; -13
		.dw O1F01
		.db #%10100000
		.db #$F0
		.dw O1F00

; mech 1 walking (diag down) 01
OS1F01	.db #%00100000
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
; mech 1 walking (diag down) 02
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
; mech 1 walking (diag down) 03
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
; mech 1 walking (diag down) 04
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
; mech 1 walking (diag down) 05
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
; mech 1 walking (diag down) 06
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
; mech 1 walking (diag down) 07
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
; mech 1 walking (diag down) 08
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

; mech 1 standing (diag up)
OS1F09
		.db #%00100000
		.db #$F0
		.dw O1F06
		.db #%10100000
		.db #$F3
		.dw O1F07

; mech 1 walking (diag up) 01
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
; mech 1 walking (diag up) 02
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
; mech 1 walking (diag up) 03
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
; mech 1 walking (diag up) 04
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
; mech 1 walking (diag up) 05
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
; mech 1 walking (diag up) 06
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
; mech 1 walking (diag up) 07
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
; mech 1 walking (diag up) 08
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

; mech 1 still (down)
OS1F12	.db #%00100000
		.db #$EA
		.dw O1F0C
		.db #%10100000
		.db #$FA
		.dw O1F0D

; mech 1 walking (down) 01
OS1F13	.db #%00100000
		.db #$EB
		.dw O1F0C
		.db #%10100000
		.db #$FB
		.dw W1F20
; mech 1 walking (down) 02
OS1F14	.db #%00100000
		.db #$EA
		.dw O1F0C
		.db #%10100000
		.db #$FA
		.dw W1F21
; mech 1 walking (down) 03
OS1F15	.db #%00100000
		.db #$EA
		.dw O1F0C
		.db #%10100000
		.db #$FA
		.dw W1F22
; mech 1 walking (down) 04
OS1F16	.db #%00100000
		.db #$EA
		.dw O1F0C
		.db #%10100000
		.db #$FA
		.dw W1F23
; mech 1 walking (down) 05
OS1F17	.db #%00100000
		.db #$EB
		.dw O1F0C
		.db #%10100000
		.db #$FB
		.dw W1F24
; mech 1 walking (down) 06
OS1F18	.db #%00100000
		.db #$EA
		.dw O1F0C
		.db #%10100000
		.db #$FA
		.dw W1F25
; mech 1 walking (down) 07
OS1F19	.db #%00100000
		.db #$EA
		.dw O1F0C
		.db #%10100000
		.db #$FA
		.dw W1F26
; mech 1 walking (down) 08
OS1F1A	.db #%00100000
		.db #$EA
		.dw O1F0C
		.db #%10100000
		.db #$FA
		.dw W1F27

; mech 1 still (up)
OS1F1B	.db #%00100000
		.db #$EA
		.dw O1F0E
		.db #%10100000
		.db #$FA
		.dw O1F0F
; mech 1 walking (up) 01
OS1F1C	.db #%00100000
		.db #$EB
		.dw O1F0E
		.db #%10100000
		.db #$FB
		.dw W1F28
; mech 1 walking (up) 02
OS1F1D	.db #%00100000
		.db #$EA
		.dw O1F0E
		.db #%10100000
		.db #$FA
		.dw W1F29
; mech 1 walking (up) 03
OS1F1E	.db #%00100000
		.db #$EA
		.dw O1F0E
		.db #%10100000
		.db #$FA
		.dw W1F2A
; mech 1 walking (up) 04
OS1F1F	.db #%00100000
		.db #$EA
		.dw O1F0E
		.db #%10100000
		.db #$FA
		.dw W1F2B
; mech 1 walking (up) 05
OS1F20	.db #%00100000
		.db #$EB
		.dw O1F0E
		.db #%10100000
		.db #$FB
		.dw W1F2C
; mech 1 walking (up) 06
OS1F21	.db #%00100000
		.db #$EA
		.dw O1F0E
		.db #%10100000
		.db #$FA
		.dw W1F2D
; mech 1 walking (up) 07
OS1F22	.db #%00100000
		.db #$EA
		.dw O1F0E
		.db #%10100000
		.db #$FA
		.dw W1F2E
; mech 1 walking (up) 08
OS1F23	.db #%00100000
		.db #$EA
		.dw O1F0E
		.db #%10100000
		.db #$FA
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

CS20:	.db #%10010000
		.dw CUR3

CS21:	.db #%10010000
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
;
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
		.dw OS1F00
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
	.dw OS1F09
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
	.db	#$60, #$08
	.dw OS1F12
	.dw OS1F00
	.dw OS1F09
	.dw OS1F1B
	.dw OS1F09
	.dw OS1F00

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
	.db #> ANIM18			; ramulen rotate

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
