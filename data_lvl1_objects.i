levelOne:

	.db 8, 7
	.hex 00 01 02 03 04 05 06 20

	.db 23, 8
	.hex 10 11 12 13 14 15 16 17 18
	.hex 61 62 63 75 76 77 78
	.hex B0 B1 B3 B4 B5 B6 B7

	.db 16, 9
	.hex F2 E2 D2 C2
	.hex F8 E8 D8 C8
	.hex 29 39 49 59 69 89 99 A9

	.db 8, 10
	.hex 19 64 74 B2 79 7A B8 B9

	.db 7, 11
	.hex 1C 2B 1D 2C 3B 2D 3C

	.db 41, 128 ; impassable
	.hex 32 33 34 35 36 46 56 57 58 48 38 28 08
	.hex 92 93 94 95 96 86 87 88
	.hex 5A 5B 6A 6B 6C 6D 6E 6F 7A 7B 7C 7D 7E 7F 8A 8B 9A 9B AA AB

	.db 7, 128+64 ; impassable + los blocked
	.hex 30 40 50 60 70 80 90

	.db 0

	.db	9			; number of objects

	.db $04			; player pilot 4
	.db $03			; object grid position
	.db $24			; object type 1 & facing RD
	.db $01			; object wpns

	.db $01			; player pilot 2
	.db $05			; object grid position
	.db $14			; object type 1 & facing RD
	.db $01			; object wpns

	.db $00			; object 3 obstacle
	.db $45			; object 3 grid position
	.db $01			; object 3 type: obstacle | facing: 1

	.db $00			; object 3 building
	.db $23			; object 3 grid position
	.db $01			; object 3 type obstacle & tile D

	.db $00			; object 3 building
	.db $25			; object 3 grid position
	.db $01			; object 3 type obstacle & tile D

	.db $00			; object 3 building
	.db $E7			; object 3 grid position
	.db $01			; object 3 type obstacle & tile D

	.db $84			; Enemy pilot 4
	.db $E4			; object grid position
	.db $35			; object type 1 & facing RD
	.db $10			; object wpns

	;.db $84			; Enemy pilot 4
	;.db $E6			; object grid position
	;.db $35			; object type 1 & facing RD
	;.db $10			; object wpns

	.db $84			; Enemy pilot 4
	.db $E8			; object grid position
	.db $34			; object type 1 & facing RD
	.db $10			; object wpns

	.db $80			; Enemy pilot 4
	.db $D7			; object grid position
	.db $25			; object type 1 & facing RD
	.db $10			; object wpns
