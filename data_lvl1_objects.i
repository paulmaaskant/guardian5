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

	.db	6			; number of objects

	;.db $04			; player pilot 4
	;.db $03			; object grid position
	;.db $04			; object type & facing RD
	;.db $31			; object wpns

	.db $04			; player pilot 2
	.db $05			; object grid position
	.db $24			; object type 1 & facing RD
	.db $30			; object wpns

	.db $00			; object object building
	.db $25			; object grid position
	.db $41			; object type & facing RD

	.db $00			; object building
	.db $45			; object grid position
	.db $41			; object type & facing RD

	.db $00			; object building
	.db $C7			; object grid position
	.db $41			; object type & facing RD

	.db $80			; enemy pilot 0 (cruella)
	.db $18			; object grid position
	.db $35			; object type 1 & facing RD
	.db $10			; object wpns

	.db $01			; enemy pilot 4 (drone)
	.db $E4			; object grid position
	.db $55			; object type 1 & facing RD
	.db $20			; object wpns

	.db $84			; enemy pilot 4 (drone)
	.db $4C			; object grid position
	.db $54			; object type 1 & facing RD
	.db $20			; object wpns




missionOneEventStream:
; --------------
; byte 1			; mission event header
;							; - no more events (b7)
;							; - start turn event / end turn event
;					  	; - number of bytes to the next mission event

; byte 2			; mission event type
							; - dialog, inbound wave, wave arrival, mission accomplished, mission failed
; byte 3			; mission event type parameter

; byte 4+2n		; condition type
							; - mission round # equal or greater (check)
							; - grid node occupied by friendly
							; - specific pilot death
							; - all friendlies dead
							; - all enemies dead
							; - no more waves

; byte 5+2n		; condition parameter
							; - missionRound #
							; - grid node
							; - pilot ID

.db 2, mEventOpenDialog, 10 												 	; event 1
.db 4, mConditionRound, 2,  mEventOpenDialog, 13		 	; event 2
.db 3, mConditionOnlyHostiles, mEventOpenDialog, 12 	; event 5
.db 3, mConditionOnlyHostiles, mEventEndMission, 2 		; event 6
.db 3, mConditionOnlyFriendlies, mEventOpenDialog, 9 	; event 3
.db 3, mConditionOnlyFriendlies, mEventEndMission, 2 	; event 4

.db 0																								 	; end of stream
