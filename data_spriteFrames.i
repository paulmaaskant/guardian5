; sprite frame
; ppppHFNL - (ffffffff) - xxxxxxxx - sprite pattern (* p)
; pppp = number of patterns in row
; H = 1, not show if position is obscured
; F = 1, optional flip bit byte included
; N = 1, move one row down
; L = 1, last row
; ffffffff = (optional) flip bits for first 4 patterns
; xxxxxxxx = X offset from center vertical axis

tank_all_d4_bottom:
	.db %00101111, $04, -4, $91, $91

tank_all_d1_bottom:
	.db %00101111, $04, -4, $B1, $B1

tank01_d5_left:
	.db %00010000, -4, $82
	.db %00010010, -4, $92
	.db %00011011, -4, $84

tank02_d5_left:
	.db %00010000, -4, $86
	.db %00010010, -4, $96
	.db %00011011, -4, $84

tank01_d5_right:
	.db %00010000, 4, $83
	.db %00010010, 4, $93
	.db %00011011, 1, $84

tank02_d5_right:
	.db %00010000, 4, $87
	.db %00010010, 4, $97
	.db %00011011, 1, $84

tank01_d6_right:
	.db %00010000, 4, $A3
	.db %00010010, 4, $B3
	.db %00010011, 4, $85

tank02_d6_right:
	.db %00010000, 4, $A7
	.db %00010010, 4, $B7
	.db %00010011, 4, $85

tank01_d6_left:
	.db %00010000, -4, $A2
	.db %00010010, -1, $B2
	.db %00011011, -2, $85

tank02_d6_left:
	.db %00010000, -4, $A6
	.db %00010010, -1, $B6
	.db %00011011, -2, $85

tank01_d4_top:
	.db %00110110, $10, -8, $80, $81, $80
	.db %00100111, $04, -4, $90, $90

tank02_d4_top:
	.db %00110110, $10, -8, $94, $95, $94
	.db %00100111, $04, -4, $A4, $A4

tank01_d1_top:
	.db %00110110, $10, -8, $A0, $A1, $A0
	.db %00100111, $04, -4, $B0, $B0

tank02_d1_top:
	.db %00110110, $10, -8, $B4, $B5, $B4
	.db %00100111, $04, -4, $A5, $A5

tank01_d5_top_left:
	.db %00010000, -4, $82
	.db %00010011, -4, $92

tank02_d5_top_left:
	.db %00010000, -4, $86
	.db %00010011, -4, $96

tank01_d5_top_right_1:
	.db %00010000, 4, $83
	.db %00010011, 4, $93

tank02_d5_top_right_1:
	.db %00010000, 4, $87
	.db %00010011, 4, $97

tank01_d5_top_right_2:
	.db %00010000, 4, $83
	.db %00010011, 4, $75

tank02_d5_top_right_2:
	.db %00010000, 4, $87
	.db %00010011, 4, $66

tank01_d6_top_right_1:
	.db %00010000, 4, $A3
	.db %00010011, 4, $B3

tank02_d6_top_right_1:
	.db %00010000, 4, $A7
	.db %00010011, 4, $B7

tank01_d6_top_right_2:
	.db %00010000, 4, $A3
	.db %00010011, 4, $46

tank02_d6_top_right_2:
	.db %00010000, 4, $A7
	.db %00010011, 4, $76

tank01_d6_top_left_1:
	.db %00010000, -4, $A2
	.db %00010011, -1, $B2

tank02_d6_top_left_1:
	.db %00010000, -4, $A6
	.db %00010011, -1, $B6

tank01_d6_top_left_2:
	.db %00010000, -4, $A2
	.db %00010011, -2, $56

tank02_d6_top_left_2:
	.db %00010000, -4, $A6
	.db %00010011, -2, $47

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
	.db #%00100110, #$0E, #%11111100, #$32, #$32
	.db #%00100111, #$04, #%11111100, #$32, #$32
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
EFF9:
	.db #%00010001, #$00, #$37

EFFA: ; explosion shockwave upper
	.db %00100000, -4,  $28, $29
	.db %00100011, -4,  0, $39

EFFB: ; explosion shockwave upper
	.db %00100100, $08, -4,  $0, $39
	.db %00100111, $0A, -4,  $28, $29

MIS0:	; missile up 1
	.db %00010000, 0,  $2A
	.db %00010011, 0,  $3A

MIS1	; missile up 2
	.db %00010000, 0,  $2A
	.db %00010011, 0,  $3D


MIS2  ; missile right

MIS3	; missile down right

MIS4	; missile down
