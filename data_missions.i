mission00Setup:
	.db 1 ; number of player units
	.db 1 ; mission map settings
	.db #< map00
	.db #> map00

	.db 7, 8 ; road
	.hex 71 72 73 74 75 76 77
	.db 5, 9 ; road
	.hex 20 30 40 50 60
	.db 4, 10 ; road intersection
	.hex 10 70 72 76
	.db 2, 11
	.hex 37 47
	.db 2, 20
	.hex 05 06
	.db 8, 128+32 ; (b7) impassable (b5) BG is fixed
	.hex 32 33 34 35 36 46 56 57

	.db 0
	.db	2				; number of objects

	.db $06			; object grid position

	.db $00			; object building
	.db $45			; object grid position
	.db $40			; object type & facing RD
	.db $00			;

mission01Setup:
	.db 3 ; number of player units
	.db 2	; mission map settings
	.db #< map02
	.db #> map02

	; set grid backgrounds:
	; tile #, number of tiles,
	; list of grid positions

	.db 4, 8 ; road \
	.hex 10 11 B0 B1
	.db 13, 9 ; road /
	.hex 22 32 42 52 62 72 82 92 A2 C2 D2 E2 F2
	.db 1, 23 ; road intersection T
	.hex B2
	.db 1, 22 ; road intersection v
	.hex 12
	.db 2, 11
	.hex 37 47
;	.db 22, 128+32 ; (b7) impassable (b5) BG is fixed
;	.hex 0C 0D 0E 0F
;	.hex 1C 1D 1E 1F
;	.hex 51 52 53 55 56 57 58 59 5A 5B 5C 5D 5E 5F

;	.db 8, 7
;	.hex 00 01 02 03 04 05 06 20
;	.db 23, 8
;	.hex 10 11 12 13 14 15 16 17 18
;	.hex 61 62 63 75 76 77 78
;	.hex B0 B1 B3 B4 B5 B6 B7
;	.db 16, 9
;	.hex F2 E2 D2 C2
;	.hex F8 E8 D8 C8
;	.hex 29 39 49 59 69 89 99 A9
;	.db 8, 10
;	.hex 19 64 74 B2 79 7A B8 B9
;	.db 7, 11
;	.hex 1C 2B 1D 2C 3B 2D 3C
;	.db 41, 128+32 ; (b7) impassable (b5) BG is fixed
;	.hex 32 33 34 35 36 46 56 57 58 48 38 28 08
;	.hex 92 93 94 95 96 86 87 88
;	.hex 5A 5B 6A 6B 6C 6D 6E 6F 7A 7B 7C 7D 7E 7F 8A 8B 9A 9B AA AB
;	.db 7, 128+64 ; (b7) impassable + (b6) los blocked
;	.hex 30 40 50 60 70 80 90

	.db 0
	.db	9		; number of objects

	.db $01			; object grid position
	.db $03			; object grid position
	.db $05			; object grid position

	.db 128+6*4+2		; (b7) AI (b6-2) pilot (b1-0) player team
	.db $10			; (b7-0) object grid position
	.db $64			; (b7-4) object type (b2-0) facing direction
	.db $21			; (b7-4) equipment 1 (b3-0) equiment 2

	.db 12*4   	; object object building
	.db $25			; object grid position
	.db $40			; object type & facing RD
	.db $00			;

	.db 12*4		; object building
	.db $45			; object grid position
	.db $40			; object type & 12*4ing RD
	.db $00			;

	.db 128+11*4+2; enemy pilot 0 (unkown)
	.db $C5			; object grid position
	.db $75			; object type 1 & facing RD
	.db $12			; object wpns

	.db 128+11*4+2;			; enemy pilot 1 (unkown)
	.db $C7			; object grid position
	.db $75			; object type 1 & facing RD
	.db $32			; object wpns

	.db 128+40+2; (b7) AI (b6-2) pilot (b1-0) faction
	.db $E3			; (b7-0) object grid position
	.db $54			; (b7-4) object type (b2-0) facing direction
	.db $21			; (b7-4) equipment 1 (b3-0) equiment 2

mission02Setup:
	.db 3 ; number of player units
	.db 0 ; mission map settings
	.db #< map03
	.db #> map03

	.db 8, 8 ; road \
	.hex 10 11 12 13 85 D7 D8 D9
	.db 12, 9 ; road /
	.hex 24 34 44 54 64 74 96 A6 B6 C6 EA FA
	.db 3, 22 ; road intersection v
	.hex 14 86 DA
	.db 2, 24 ; road intersection v
	.hex 84 D6
	.db 4, 11	; ground fan
	.hex 63 73 83 93
	.db 2, 20	; ground fan
	.hex 94 95

	.db 74, 128+32 ; (b7) impassable (b5) BG is fixed
	.hex 0C 0D 0E 0F
	.hex 1C 1D 1E 1F
	.hex 2C 2D 2E 2F
	.hex 3C 3D 3E 3F
	.hex 4C 4D 4E 4F
	.hex 51 52 53 55 56 57 58 59 5A 5B 5C 5D 5E 5F
	.hex 61 62 69 6A 6B 6C 6D 6E 6F
	.hex 71 72 79 7B 7C 7D 7E 7F
	.hex 80 81 82 89 8A 8B
	.hex 90 91 92 99 9A 9B
	.hex A0 A1 A2 A3 A4 A5 A7 A8 A9 AA AB

	.db 0
	.db	7				; number of objects

	.db $01			; object grid position
	.db $03			; object grid position
	.db $05			; object grid position

	.db 128+11*4+2;			; enemy pilot 1 (unkown)
	.db $70			; object grid position
	.db $74			; object type 1 & facing RD
	.db $32			; object wpns

	.db 128+11*4+2;			; enemy pilot 1 (unkown)
	.db $7A			; object grid position
	.db $75			; object type 1 & facing RD
	.db $32			; object wpns

	.db 128+11*4+2;			; enemy pilot 1 (unkown)
	.db $98			; object grid position
	.db $75			; object type 1 & facing RD
	.db $32			; object wpns

	.db 128+11*4+2;			; enemy pilot 1 (unkown)
	.db $66			; object grid position
	.db $75			; object type 1 & facing RD
	.db $32			; object wpns



; --------------
; mission events
; --------------
; byte 1			; event header
;							; - number of bytes for this event
; byte 2			; event condition (optional)
							; - parameter bytes
; byte 3			; event type
							; - parameter bytes

mission00Events:
.db 2, mEventOpenDialog, 10 												 												; event 1 : dialog 10: enemy detected
.db 7, mConditionRound, 1,  mEventSpawnUnit, 128+32+2, $72, $35, $12
.db 5, mConditionRound, 1, mConditionOnlyHostiles, mEventOpenDialog, 12 												; event 4
.db 6, mConditionRound, 1, mConditionOnlyHostiles, mEventEndMission, 6, 7 											; event 5
.db 5, mConditionRound, 1, mConditionOnlyFriendlies, mEventOpenDialog, 9 												; event 6
.db 6, mConditionRound, 1, mConditionOnlyFriendlies, mEventEndMission, 5, 6											; event 7
.db 0																								 												; end of stream

mission01Events:
.db 2, mEventOpenDialog, 10 												 												; event 1 : dialog 10: enemy detected
.db 4, mConditionRound, 2,  mEventOpenDialog, 13		 												; event 2
.db 7, mConditionRound, 2,  mEventSpawnUnit, 128+40+2, $F2, $54, $11	 		 	; event 3
.db 3, mConditionOnlyHostiles, mEventOpenDialog, 12 												; event 4
.db 4, mConditionOnlyHostiles, mEventEndMission, 3, 7 											; event 5
.db 3, mConditionOnlyFriendlies, mEventOpenDialog, 9 												; event 4
.db 4, mConditionOnlyFriendlies, mEventEndMission, 2, 6
.db 4, mConditionPilotNotPresent, 6, mEventOpenDialog, 15
.db 0																								 												; end of stream

mission02Events:
.db 2, mEventOpenDialog, 10 												 												; event 1 : dialog 10: enemy detected
.db 7, mConditionRound, 4,  mEventSpawnUnit, 128+32+2, $3E, $55, $12
.db 7, mConditionRound, 4,  mEventSpawnUnit, 128+32+2, $2D, $55, $12
.db 5, mConditionRound, 1, mConditionOnlyHostiles, mEventOpenDialog, 12 												; event 4
.db 6, mConditionRound, 1, mConditionOnlyHostiles, mEventEndMission, 3, 7 											; event 5
.db 6, mConditionRound, 1, mConditionPilotNotPresent, 11, mEventOpenDialog, 9 												; event 6
.db 7, mConditionRound, 1, mConditionPilotNotPresent, 11, mEventEndMission, 2, 6											; event 7
.db 0																								 												; end of stream



; examples
;.db 3, mConditionNodeReached, mEventOpenDialog, 9 													; event 6
;.db 4, mConditionNodeReached, mEventEndMission, 2, 6												; event 7
