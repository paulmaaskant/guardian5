; sprite frame
; ppppHFNL - (ffffffff) - xxxxxxxx - sprite pattern (* p)
; pppp = number of patterns in row
; H = 1, not show if position is obscured
; F = 1, optional flip bit byte included
; N = 1, move one row down
; L = 1, last row
; ffffffff = (optional) flip bits for first 4 patterns
; xxxxxxxx = X offset from center vertical axis

;-----------------------------------------------------
; mech 0, 1, 2 and 3
;-----------------------------------------------------

mech00_d1:		.db %00110100, $10, -8, $80, $81, $80
							.db %00110111, $10, -8, $90, $91, $90
mech00_d4:		.db %00110100, $10, -8, $82, $83, $82
							.db %00110111, $10, -8, $92, $93, $92
mech00_d5:		.db %00100000, 			-4, $A0, $A1
							.db %00100011, 			-4, $B0, $B1
mech00_d6:		.db %00100000, 			-4, $A2, $A3
							.db %00100011, 			-4, $B2, $B3

mech01_d1:		.db %00100100, $04, -4, $86, $86
							.db %00100111, $04, -4, $96, $96
mech01_d4:		.db %00100100, $04, -4, $87, $87
							.db %00100111, $04, -4, $97, $97
mech01_d5:		.db %00100000, 			-4, $A4, $A5
							.db %00100011, 			-4, $B4, $B5
mech01_d6:		.db %00100000, 			-4, $A6, $A7
							.db %00100011, 			-4, $B6, $B7

mech02_d1:		.db %00100100, $04, -4, $8A, $8A
							.db %00100111, $04, -4, $9A, $9A
mech02_d4:		.db %00100100, $04, -4, $8B, $8B
							.db %00100111, $04, -4, $9B, $9B
mech02_d5:		.db %00100000, 			-4, $A8, $A9
							.db %00100011, 			-4, $B8, $B9
mech02_d6:		.db %00100000, 			-4, $AA, $AB
							.db %00100011, 			-4, $BA, $BB

mech03_d1:		.db %00110100, $10, -8, $8C, $8D, $8C
							.db %00110111, $10, -8, $9C, $9D, $9C
mech03_d4:		.db %00110100, $10, -8, $8E, $8F, $8E
							.db %00110111, $10, -8, $9E, $9F, $9E
mech03_d5:		.db %00100000, 			-4, $AC, $AD
							.db %00100011, 			-4, $BC, $BD
mech03_d6:		.db %00100000, 			-4, $AE, $AF
							.db %00100011, 			-4, $BE, $BF

; ------------------------------------------
; mech leg animation frames, type A
; ------------------------------------------
mechA_d1_f0:	.db %00100111, $04, -4, $42, $63
mechA_d1_f1:	.db %00100111, $04, -4, $52, $73
mechA_d1_f2:	.db %00100110, $04, -4, $62, $44
							.db %00010011, 			-4, $72
mechA_d1_f3:	.db %00100110, $04, -4, $43, $73
							.db %00010011, 			-4, $53
mechA_d1_f4:	.db %00100111, $04, -4, $63, $42
mechA_d1_f5:	.db %00100111, $04, -4, $73, $52
mechA_d1_f6:	.db %00100110, $04, -4, $44, $62
							.db %00010111, $01,	 4, $72
mechA_d1_f7:	.db %00100110, $04, -4, $73, $43
							.db %00010111, $01,	 4, $53

mechA_d4_f0:	.db %00100110, $04, -4, $40, $41
							.db %00010011, 			-4, $50
mechA_d4_f1:	.db %00100110, $04, -4, $40, $51
							.db %00010011, 			-4, $50
mechA_d4_f2:	.db %00100111, $04, -4, $60, $61
mechA_d4_f3:	.db %00100111, $04, -4, $70, $71
mechA_d4_f4:	.db %00100110, $04, -4, $41, $40
							.db %00010111, $01,	 4, $50
mechA_d4_f5:	.db %00100110, $04, -4, $51, $40
							.db %00010111, $01,	 4, $50
mechA_d4_f6:	.db %00100111, $04, -4, $61, $60
mechA_d4_f7:	.db %00100111, $04, -4, $71, $70

mechA_d5_f0: 	.db %00100010, 			-1, $54, $64
							.db %00010011, 			-1, $74
mechA_d5_f1:  .db %00100010, 			-4, $45, $55
							.db %00010011, 			 1, $74
mechA_d5_f2:	.db %00100010, 			-5, $65, $75
							.db %00010011, 			 3, $46
mechA_d5_f3:	.db %00100010, 			-4, $56, $66
							.db %00010011, 			 4, $76
mechA_d5_f4:	.db %00100010, 			-5, $47, $57
							.db %00010011, 			-6, $76
mechA_d5_f5:	.db %00100010, 			-4, $67, $77
							.db %00010011, 			-4, $76
mechA_d5_f6:	.db %00100011, 			-3, $48, $58
mechA_d5_f7:	.db %00100010, 			-2, $68, $78
							.db %00010011, 			-2, $49

mechA_d6_f0:	.db %00110011, 			-6, $59, $69, $79
mechA_d6_f1:	.db %00100010, 			-4, $4A, $6A
							.db %00010011, 			-4, $5A
mechA_d6_f2:	.db %00100010, 			-4, $7A, $78
							.db %00010011, 			-2, $4B
mechA_d6_f3:	.db %00100010, 			-4, $5B, $6B
							.db %00010011, 			 1, $7B
mechA_d6_f4:	.db %00100010, 			-1, $4C, $64
							.db %00010011, 			-1, $49
mechA_d6_f5:	.db %00100011, 			-4, $5C, $6C
mechA_d6_f6:	.db %00100010, 			-4, $7C, $4D
							.db %00010011, 			 5, $72
mechA_d6_f7:	.db %00110010, 			-6, $5D, $6D, $7D
							.db %00010011, 			 6, $5A

mechA_j5_f0:	.db %00100010, 			-1, $40, $50
							.db %00100011, 			-1, $00, $60


dronA_00_f0: 	.db %00100101, $01, -4, $C4, $C5
dronA_00_f1: 	.db %00100101, $01, -4, $D5, $D4
dronA_00_f2: 	.db %00100101, $01, -4, $C5, $C4
dronA_00_f3: 	.db %00100101, $01, -4, $D4, $D5

dronA_01_f0: 	.db %00010001, 			 3, $C4
dronA_01_f1: 	.db %00010001, 			 3, $D5
dronA_01_f2: 	.db %00010001, 			 3, $C5
dronA_01_f3: 	.db %00010001, 		   3, $D4

dronA_02_f0		.db %00100111, $01,	-4, $E4, $E4
dronA_03_f0		.db %00100111, $01,	-4, $E5, $E5

dronA_04_f0		.db %00010001, 			-4, $C6
dronA_04_f1		.db %00010001, 			-4, $C7
dronA_04_f2		.db %00010001, 			-4, $D6
dronA_04_f3		.db %00010001, 			-4, $D7

dronA_05_f0		.db %00100011, 			-4, $E6, $E5
dronA_06_f0		.db %00100011, 			-4, $F4, $F5

dronA_56_f0: 	.db %00100001, 		  -4, $C6, $C5
dronA_56_f1: 	.db %00100001, 		  -4, $D7, $D4
dronA_56_f2: 	.db %00100001, 	    -4, $C7, $C4
dronA_56_f3: 	.db %00100001,      -4, $D6, $D5



OBS0: ; obstacle
	.db %00100010, -4, $C0, $C1
	.db %00100011, -4, $D0, $D1

CLR0: ; empty sprite
	.db %00010001, 0, $00
CUR0: ; cursor top
	.db %00010001, 0, $5E
CUR1: ; cursor side
	.db %00010001, 0, $5F
CUR2: ; active marker
	.db %00010001, 0, $7E
CUR3: ; LOS block marker
	.db %00110001, -8, $5B, $5C, $5D
CUR4:	; LOCK marker
	.db %00110001, -8, $58, $59, $5A

CUR5:	; unit select cursor
	.db %00110101, %00010000, 0, $52, 0, $52
	;.db %00010010, 0, 0

CUR6:
	.db %00110101, %00110010, 0, $52, 0, $52

CUR9:	; label / tooltip
	.db %00110011, -8, $31, 30, $31, 31, $31, 32
CURA:	; offline marker
	.db %00100001, -4, $52, $53
CURB: ; hit percentage tooltip
	.db %00110000, -8, $31, 30, $31, 31, $31, 32
	.db %00110011, -8, $31, 33, $31, 34, $31, 35

SHW0:	; shadow
	.db %00100100, $0E, -4, $50, $50
	.db %00100111, $04, -4, $50, $50

EFF0:	; explosion frame 1
	.db %00100100, $0E, -4, $6F, $6F
	.db %00100111, $04, -4, $6F, $6F

EFF1:

EFF2:

EFF3: ; machine bullets
	.db %00010001, 0, $71

EFF4: ; explosion frame 2
	.db %00100100, $0E, -4, $6E, $6E
	.db %00100111, $04, -4, $6E, $6E

EFF5: ; defence shield
	.db %00100001, -4, $4E, $4F

EFF6: ; ball
	.db %00010001, 0, $79

EFF7:
	.db %00010001, 12, $41

EFF8:
	.db %00010001, 12, $51

EFF9: ; waypoint
	.db #%00010001, #$00, #$60

EFFA: ; explosion shockwave upper
	.db %00100000, -4,  $66, $67
	.db %00100011, -4,  0, $77

EFFB: ; explosion shockwave upper
	.db %00100100, $08, -4,  $0, $77
	.db %00100111, $0A, -4,  $66, $67

LAS0: ; 0 degrees
	.db %00010001, 0,  $78

LAS1: ; 45 degrees
	.db %00010001, 0,  $68

LAS2: ; 90 degrees
	.db %00010001, 0,  $69

LAS3: ; 22.5 degrees
	.db %00010001, 0,  $7A

LAS4: ; 67.5 degrees
	.db %00010001, 0,  $6A



MIS0:	; missile up 1
	.db %00010000, 0,  $62
	.db %00010011, 0,  $72

MIS1:	; missile up 2
	.db %00010000, 0,  $62
	.db %00010011, 0,  $75

MIS2:  ; missile right up 1
	.db %00100000, -4,  $00, $63
	.db %00010011, -4,  $73

MIS3:	; missile right up 2
	.db %00100000, -4,  $00, $63
	.db %00010011, -4,  $76

MIS4:  ; missile right 1
	.db %00100001, -4,  $74, $64

MIS5:	; missile right 2
	.db %00100001, -4,  $65, $64

MIS6:  ; missile right down 1
	.db %00010100, %00000010, -4,  $73
	.db %00100111, %00001000, -4,  $00, $63

MIS7:	; missile right down 2
	.db %00010100, %00000010, -4,  $76
	.db %00100111, %00001000, -4,  $00, $63

MIS8:  ; missile right down 1
	.db %00010100, %00000010, 0,  $72
	.db %00010111, %00000010, 0,  $62

MIS9:	; missile right down 2
	.db %00010100, %00000010, 0,  $75
	.db %00010111, %00000010, 0,  $62
