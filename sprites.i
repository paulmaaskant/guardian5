
; sprite frame
; pppp_FNL - (ffffffff) - xxxxxxxx - sprite pattern (* p)

; pppp = number of patterns in row
; F = 1, optional flip bit byte included
; N = 1, move one row down
; L = 1, last row
; ffffffff = (optional) flip bits for first 4 patterns
; xxxxxxxx = X offset from center vertical axis


; m1 down diag left column
O1F00:
	.db #%00010000, #%11111100, #$82
	.db #%00010010, #%11111100, #$92
	.db #%00010011, #%11111100, #$84
; m1 down diag right column
O1F01:
	.db #%00010000, #%00000100, #$83
	.db #%00010010, #%00000100, #$93
	.db #%00010011, #%00000001, #$84
; m1 down diag left column body
O1F03:	.db #%00010000, #%11111100, #$82
		.db #%00010011, #%11111100, #$92
; m1 down diag right column body frame 1
O1F04:	.db #%00010000, #%00000100, #$83
		.db #%00010011, #%00000100, #$93
; m1 down diag right column body frame 2
O1F05:	.db #%00010000, #%00000100, #$83
		.db #%00010011, #%00000100, #$75
; m1 up diag right column
O1F06:	.db #%00010000, #%00000100, #$A3
		.db #%00010010, #%00000100, #$A9
		.db #%00010011, #%00000100, #$89
; m1 up diag left column
O1F07:	.db #%00010000, #%11111100, #$A2
		.db #%00010010, #%11111111, #$B2
		.db #%00010011, #%11111110, #$89
; m1 up diag right column body
O1F08:	.db #%00010000, #%00000100, #$A3
		.db #%00010011, #%00000100, #$A9
; m1 up diag right column body
O1F09:	.db #%00010000, #%00000100, #$A3
		.db #%00010011, #%00000100, #$46

; m1 up diag right column body frame 1
O1F0A:	.db #%00010000, #%11111100, #$A2
		.db #%00010011, #%11111111, #$B2
; m1 up diag right column body frame 2
O1F0B:	.db #%00010000, #%11111100, #$A2
		.db #%00010011, #%11111110, #$56
; m1 down body
O1F0C:	.db #%00110110, #$10, #%11111000, #$80, #$81, #$80
		.db #%00100111, #$04, #%11111100, #$90, #$90
O1F0D:	.db #%00100111, #$04, #%11111100, #$91, #$91
; m1 up body
O1F0E:	.db #%00110110, #$10, #%11111000, #$A0, #$A1, #$A0
		.db #%00100111, #$04, #%11111100, #$B0, #$B0
O1F0F:	.db #%00100111, #$04, #%11111100, #$B1, #$B1


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
W1F11:	.db #%00010001, #$FD, #$89
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
W1F1D:	.db #%00010001, #$01, #$89
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


CLR0	.db #%00010001, #$00, #$00

CUR0	.db #%00010001, #$00, #$20
CUR1	.db #%00010001, #$00, #$30
CUR2	.db #%00010001, #$00, #$21
CUR3	.db #%00010001, #$00, #$32


CUR5	.db #%00100100, #%00000100, #%11111100, #$C0, #$C4
		.db #%00100111, #%00001110, #%11111100, #$C4, #$C0
CUR6	.db #%00100100, #%00000100, #%11111100, #$C1, #$C3
		.db #%00100111, #%00001110, #%11111100, #$C3, #$C1
CUR7	.db #%00100100, #%00000100, #%11111100, #$C2, #$C2
		.db #%00100111, #%00001110, #%11111100, #$C2, #$C2
CUR8	.db #%00100100, #%00000100, #%11111100, #$C3, #$C1
		.db #%00100111, #%00001110, #%11111100, #$C1, #$C3

CUR9	.db #%00100001, #%11111011, #$31, #$0A, #$31, #$0B


FIR0
	.db #%00100110, #$0E, #%11111100, #$22, #$22
	.db #%00100111, #$04, #%11111100, #$22, #$22

FIR1	.db #%00010001, #$00, #$E3
FIR2	.db #%00010001, #$00, #$F3
FIR3	.db #%00010001, #$00, #$23

FIR4
	.db #%00100110, #$0E, #%11111100, #$33, #$33
	.db #%00100111, #$04, #%11111100, #$33, #$33




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

; mech 1 standing (diag down)
OS1F00	.db #%00100000
		.db #$F3
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
OS1F09	.db #%00100000
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


CS22:	.db #%10000000
		.dw CUR5
CS23:	.db #%10000000
		.dw CUR6
CS24:	.db #%10000000
		.dw CUR7
CS25:	.db #%10000000
		.dw CUR8

CS26:	.db #%10110000
		.db #$E0
		.dw CUR9


FR00:		.db #%10111000
				.db #$F4
        .dw FIR0
FR01:		.db #%10011000
        .dw FIR1
FR02:   .db #%10011000
				.dw CLR0
FR03:   .db #%10011000
        .dw FIR2
FR04:   .db #%10011000
        .dw FIR3
FR05:		.db #%10111000
				.db #$F4
        .dw FIR4

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

ANIM00:	.db #$80, #$08
		.dw CS00
		.dw CS01
		.dw CS02
		.dw CS03
		.dw CS04
		.dw CS03
		.dw CS02
		.dw CS01

ANIM01:	.db #$80, #$08
		.dw CS10
		.dw CS11
		.dw CS12
		.dw CS13
		.dw CS14
		.dw CS13
		.dw CS12
		.dw CS11

ANIM02:	.db #$20, #$20
		.dw CS20
		.dw CS21

ANIM03:	.db #$40, #$10
		.dw CS22
		.dw CS23
		.dw CS24
		.dw CS25

ANIM04:	.db #$40, #$10
		.dw FR01
		.dw FR02
		.dw FR03
		.dw FR02

ANIM05:	.db #$20, #$06
		.dw FR00
		.dw FR05

ANIM06	.db #$10, #$10
		.dw FR04

ANIM07	.db #$10, #$40
		.dw CS26

; OS1F00 diag down
; OS1F09 diag up
; OS1F12 down
; OS1F1B up

ANIM18:
		.db	#$60, #$08
		.dw OS1F12
		.dw OS1F00
		.dw OS1F09
		.dw OS1F1B
		.dw OS1F09
		.dw OS1F00

ANIM10	.db #$10, #$20
		.dw OS1F00
ANIM11	.db #$80, #$04
		.dw OS1F01
		.dw OS1F02
		.dw OS1F03
		.dw OS1F04
		.dw OS1F05
		.dw OS1F06
		.dw OS1F07
		.dw OS1F08
ANIM12	.db #$10, #$20
		.dw OS1F09
ANIM13	.db #$80, #$04
		.dw OS1F0A
		.dw OS1F0B
		.dw OS1F0C
		.dw OS1F0D
		.dw OS1F0E
		.dw OS1F0F
		.dw OS1F10
		.dw OS1F11
ANIM14	.db #$10, #$20
		.dw OS1F12
ANIM15	.db #$80, #$04
		.dw OS1F13
		.dw OS1F14
		.dw OS1F15
		.dw OS1F16
		.dw OS1F17
		.dw OS1F18
		.dw OS1F19
		.dw OS1F1A
ANIM16	.db #$10, #$20
		.dw OS1F1B
ANIM17	.db #$80, #$04
		.dw OS1F1C
		.dw OS1F1D
		.dw OS1F1E
		.dw OS1F1F
		.dw OS1F20
		.dw OS1F21
		.dw OS1F22
		.dw OS1F23

; -----------------------------------------------

animationL:
		.db #> ANIM00			; 00 cursor
		.db #> ANIM01			; 01 active unit
		.db #> ANIM02			; 02 blocked node (LOS)
		.db #> ANIM03			; 03 target cursor
		.db #> ANIM04			; 04 gunfire
		.db #> ANIM05			; 05 explosion
		.db #> ANIM06			; 06 laser
		.db #> ANIM07			; 07 hostile target cursor
		.dsb 8
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
		.dsb 8
		.db #< ANIM10
		.db #< ANIM11
		.db #< ANIM12
		.db #< ANIM13
		.db #< ANIM14
		.db #< ANIM15
		.db #< ANIM16
		.db #< ANIM17
		.db #< ANIM18







; -----------------------------------------------
; load sprite frame
;
; IN 		pointer1
; IN 		par1 X draw position
; IN 		par2 Y draw position
; IN 		par3 sprite address
; IN 		par4 b7, b6 -> mirror
; IN 		par4 b0 -> palette switch
;
; LOC		locVar1 X pixel position
; LOC		locVar2 Y rows (down from par1)
; LOC		locVar3 flip bits for current row
; LOC		locVar4 counter (no of patterns in row)
;
; OUT		$02XX
; pppp_FNL - (ffffffff) - xxxxxxxx - sprite pattern (* p)
; ------------------------------------------------
loadSpriteFrame:
	LDY #$00
	STY	locVar2
	STY locVar3
-nextRow:
	LDA (pointer1), Y
	LSR					; L into carry
	PHP					; carry flag 1 = last row
+continue:
	LSR					; N into carry move one row down?
	BCC +continue		; no -> continue
	INC locVar2 		; yes -> increase row count
+continue:
	LSR					; F into carry flip bits ?
	BCC	+continue		; no -> continue
	PHA
	INY					; yes -> get flip bits
	LDA (pointer1), Y	; flip bits
	STA locVar3
	PLA
+continue:
	LSR					; not used
	STA locVar4			; locVar4 := no. of sprites in current row
	INY
	LDA (pointer1), Y	; x offset
	BIT par4
	BVC +continue
	EOR #$FF			; negate offset in case sprite list is mirrored
	SEC					;
	ADC #$00			;
+continue:
	SEC
	SBC #$04			; default offset
	CLC
	ADC par1			;
	STA locVar1			; x write pos
-nextSprite:
	DEC locVar4
	BMI +prepNextRow
	LDA par3
	ASL
	ASL
	TAX
	LDA locVar2								; row
	ASL
	ASL
	ASL										; x8
	ADC par2
	STA $0200, X							; sprite Y pos
	INY

	LDA (pointer1), Y						; yes
	BNE +next								; pattern 00 means -> no sprite
	DEC par3								; decrement sprite index so that next sprite overwrites this one
+next:
	CMP #$31								; pattern 31 means -> variable
	BNE +next

	INY
	TYA
	PHA

	LDA (pointer1), Y
	TAY
	LDA list3, Y
	STA $0201, X							; pattern

	PLA
	TAY
	JMP +variable
	; retrieve variable
+next:
	STA $0201, X							; pattern
+variable:
	LDA #$00
	LSR locVar3								; shift flip bit to A
	ROR A
	LSR locVar3								; shift second flip bit to A
	ROR A 									; leaves CLC
	EOR par4								; set pallette and toggle flips
	STA $0202, X							; set flip bits (b7,6)

	LDA locVar1
	STA $0203, X 							; sprite X pos
	LDA #$08
	BIT par4
	BVC +continue
	EOR #$FF
	SEC
	ADC #$00
+continue:
	ADC locVar1								; guarantee CLC
	STA locVar1
	INC par3
	JMP -nextSprite
+prepNextRow:
	INY
	PLP
	BCS +done
	JMP -nextRow
+done:
	RTS

; -----------------------------------------------
; load sprite meta frame
;
; IN 		pointer2
; IN 		par3 sprite address
; IN 		par4 (b7, b6) mirror (only b6 implemented), (b0) palette switch
; LOC		pointer2
; LOC		locVar5
;
; OUT		par1 X draw position
; OUT 		par2 Y draw position
; OUT 		par3 address
; calls sprite frame
; ------------------------------------------------
loadSpriteMetaFrame:
	LDA par4					; take par4
	AND #%11000001				; keep mirror bits and 1 palette intact and clear all else
	STA locVar5					; shadow copy of par4

	LDY #$00
-nextSpriteFrame:
	LDA currentObjectXPos		; reset X
	STA par1
	LDA currentObjectYPos		; reset Y
	STA par2

	LDA (pointer2), Y			; A is 'LXYpp?MM'
	ASL							; set carry
	PHP							; L(ast frame) in carry, save for later
	ASL
	BCC	+noX					; X byte present?
	PHA							; save control byte for later
	INY
	LDA (pointer2), Y			; read the X byte
	CLC
	ADC currentObjectXPos
	STA par1
	PLA							; restore the control byte
+noX:
	ASL							; Y into carry
	BCC +noY					; Y byte present?
	PHA							; save the control byte
	INY
	LDA (pointer2), Y			; read the Y byte
	CLC
	ADC currentObjectYPos
	STA par2
	PLA
+noY:							; move the pallette bits to b1 and b0
	CLC							; 'pp?MM000' Carry = 0
	ROL							; 'p?MM0000, Carry = p
	ROL							; '?MM0000p, Carry = p
	PHP
	ROL							; 'MM0000pp, Carry = ?
	EOR locVar5					; apply mirror flips and palette bits
	PLP							; EOR, through trick with carry & ADC
	BCC +
	ORA #$01					; last palette bit is ORA instead of EOR 11
+	STA par4
	INY
	LDA (pointer2), Y			; sprite data address
	STA pointer1+0
	INY
	LDA (pointer2), Y			; sprite data address
	STA pointer1+1
	TYA							; save Y
	PHA							; on stack
	JSR loadSpriteFrame
	PLA							; restore Y
	TAY							; from stack
	INY
	LDA locVar5
	STA par4					; restore par4 to original value for next sprite frame
	PLP
	BCC -nextSpriteFrame
	RTS


; -----------------------------------------------
; load sprite meta frame
; select the meta frame to show in the current animation cycle, based on the animation frame count
;
; byte 1 - ffff.????, number of meta frames in animation & reservation for flags (not implemented)
; byte 2 - iiii.iiii, interval between frames (number of NMI's)
; byte 3&4 - meta frame
; repeat
;
; -----------------------------------------------
loadAnimationFrame:
	LDA par3
	PHA
	LDA par4
	PHA

	LDA animationH, Y
	STA pointer1
	LDA animationL, Y
	STA pointer1+1

	LDY #$00
	LDA (pointer1), Y
	LSR
	LSR
	LSR
	LSR
	PHA								; last meta frame # in the sequence

	LDA #$00
	STA par1						; N hi
	LDA currentObjectFrameCount
	STA par2						; N lo
	INY
	LDA (pointer1), Y				; D
	JSR divide						; frame count (N) / interval  (D) = current meta frame (Q)F
	PLA								; compare no of meta frames to
	CMP par4						; current meta frame #
	BNE +continue
	LDA #$00
	STA currentObjectFrameCount		; reset to start of animation
	STA par4						; reset to start of animation
+continue:
	LDA par4
	ASL								; * 2 because each address takes 2 bytes
	TAY
	INY
	INY								; add 2 to skip control bytes

	LDA (pointer1), Y
	STA pointer2+0
	INY
	LDA (pointer1), Y
	STA pointer2+1

	PLA
	STA par4
	PLA
	STA par3

	JMP loadSpriteMetaFrame			; tail chain!

;------------------------------------------
; clear sprites v2
; IN 	par3 = from sprite (0-63)
; IN 	A = through sprite (0-63)
; LOC	X, Y
;-----------------------------------------
clearSprites:
	TAY
-loop:
	CPY par3
	BCC +done		; locvar < par3
	ASL
	ASL
	TAX
	LDA #$FF
	STA $0200, X
	DEY
	TYA
	JMP -loop
+done:
	RTS
