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

	.db 0

	.db	3			; number of objects

	.db $04			; object 0 pilot 4
	.db $03			; object 0 grid position
	.db $13			; object 0 type 1 & facing RD

	.db $00			; object 3 building
	.db $23			; object 3 grid position
	.db $0D			; object 3 type obstacle & tile D

  .db $00			; object 3 building
	.db $25			; object 3 grid position
	.db $0D			; object 3 type obstacle & tile D

	.db $A0			; object 2 pilot
	.db $C4			; object 2 grid position
	.db $25			; object 2 type & facing LD
