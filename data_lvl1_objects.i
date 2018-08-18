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

	.db 41, 128+32 ; (b7) impassable (b5) BG is fixed
	.hex 32 33 34 35 36 46 56 57 58 48 38 28 08
	.hex 92 93 94 95 96 86 87 88
	.hex 5A 5B 6A 6B 6C 6D 6E 6F 7A 7B 7C 7D 7E 7F 8A 8B 9A 9B AA AB

	.db 7, 128+64 ; (b7) impassable + (b6) los blocked
	.hex 30 40 50 60 70 80 90

	.db 0

	.db	9			; number of objects

	.db $01			; object grid position
	.db $03			; object grid position
	.db $05			; object grid position

	.db $00			; object object building
	.db $25			; object grid position
	.db $40			; object type & facing RD
	.db $00			;

	.db $00			; object building
	.db $45			; object grid position
	.db $40			; object type & facing RD
	.db $00			;

	.db $00			; object building
	.db $C7			; object grid position
	.db $40			; object type & facing RD
	.db $00			;

	.db $80			; enemy pilot 0 (unkown)
	.db $E5			; object grid position
	.db $35			; object type 1 & facing RD
	.db $11			; object wpns

	.db $82			; enemy pilot 1 (unkown)
	.db $E6			; object grid position
	.db $35			; object type 1 & facing RD
	.db $33			; object wpns

	.db $84			; enemy pilot 4 (drone)
	.db $F4			; object grid position
	.db $54			; object type 1 & facing RD
	.db $21			; object wpns




missionOneEventStream:
; --------------
; byte 1			; event header
;							; - number of bytes for this event

; byte 2			; event condition (optional)
							; - parameter bytes

; byte 3			; event type
							; - parameter bytes

.db 2, mEventOpenDialog, 10 												 			; event 1

.db 4, mConditionRound, 2,  mEventOpenDialog, 13		 			; event 2
.db 3, mConditionRound, 2,  mEventNewUnit		 		  				; event 2B

.db 3, mConditionOnlyHostiles, mEventOpenDialog, 12 			; event 3
.db 4, mConditionOnlyHostiles, mEventEndMission, 3, 7 		; event 4

.db 3, mConditionOnlyFriendlies, mEventOpenDialog, 9 			; event 5
.db 4, mConditionOnlyFriendlies, mEventEndMission, 2, 6		; event 6
.db 0																								 			; end of stream
