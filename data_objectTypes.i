
; --- unit type attribute tables ---
objectTypeL:
	.dsb 1; reserved
	.dsb 1; reserved
	.dsb 1; reserved
	.db #< typeRamulen1

objectTypeH:
	.dsb 1; reserved
	.dsb 1; reserved
	.dsb 1; reserved
	.db #> typeRamulen1

typeRamulen1:
	; animations (13 bytes)
	.db #$05 ; 0 animation: not used
	.db #$16 ; 1 animation: facing U, still
	.db #$12 ; 2 animation: facing RU, still
	.db #$10 ; 3 animation: facing RD, still
	.db #$14 ; 4 animation: facing D, still
	.db #$10 ; 5 animation: facing LD, still
  .db #$12 ; 6 animation: facing LU, still
	.db #$17 ; 1 animation: facing U, walking
	.db #$13 ; 2 animation: facing RU, walking
	.db #$11 ; 3 animation: facing RD, walking
	.db #$15 ; 4 animation: facing D, walking
	.db #$11 ; 5 animation: facing LD, walking
  .db #$13 ; 6 animation: facing LU, walking
	; fixed stats (3 bytes)
	.db #%00110110					; Dail starting positions: (b7-b3) main dial, (b2-b1) heat dial, and cool down (b0)
	.db #%01100101					; Ranged weapon 1 max range (b7-4), min range (b3-2) and type  (b1-0)
	.db #%01101011					; Ranged weapon 2 max range (b7-4), min range (b3-2) and type  (b1-0)
	; dail stats
	; 00000000 00000000
	; |||||||| ||||||||
	; |||||||| |||||+++ weapon 1 damage
	; |||||||| ||+++--- weapon 2 damage
	; |||||||| ++------ movement (add 2)
	; |||||+++--------- armor (add 15)
	; ||+++------------ accuracy (add 5)
	.db #%00100100, #%01101001, #%00000000		; 01; 0-4-4, 1-5-1
	.db #%00100100, #%01101010, #%00000000		; 02; 0-4-4, 1-5-2
	.db #%00100100, #%01101011, #%00000000		; 03; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 04; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 05; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 06; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 07; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 08; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 09; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 10; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 11; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 12; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 13; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 14; 0-4-4, 1-5-3
	.db #%00100100, #%01101100, #%00000000		; 15; 0-4-4, 1-5-4
