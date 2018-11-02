; state 26
; 000-091 92 menu
; 092-129 38 equipped
; 130-171 3x14 text area
; 172-175 unit number
; 176-203 gauges
; 204-205 detail category
; 209-211 stats
;


state_initializeMechBay:
  LDA #4+0
  STA objectList+0  ; unit 0 pilot
  LDA #2+8
  STA objectList+1  ; unit 1 pilot
  LDA #1+16
  STA objectList+2  ; unit 2 pilot

  LDX #8

-loop:
  LDA initialObjectIndex, X
  TAY
  LDA initialObjectValue, X
  STA object, Y
  DEX
  BPL -loop

  ; copy object 0(0) to object 3(24)
  LDX #24
  LDY #0
  JSR copyObject

  JSR assignEquipment ; breaks Y

  LDY #17           ; assign tile set 17
  STY $E000         ; over
  LDY #$1
  STY $E008

  LDY #8
  STY $D001

  LDY #6
  STY $E001

  LDY #0
  STY $E009
  STY $D009

  LDX #17

-loop:
  LDA currentEffectValues, X
  STA currentEffects, X
  DEX
  BPL -loop

  LDA #1
  STA currentEffects+25
  STA currentEffects+26

  LDA #0
  STA list1+0               ; cursor position
  STA list1+1               ; object index
  STA effects
  STA activeObjectIndex

  JSR pullAndBuildStateStack
  .db 12
  .db $32, %00000010    ; clear sys flag: tile animation OFF
  .db $46, 15           ; mech legs
  .db $46, 4            ; left col frame
  .db $46, 5            ; right col frame
  .db $0D, 1						; change brightness 1: fade in
  .db $1F               ; load mech
  .db $35               ; mech bay

currentEffectValues:
  .hex  0  34 34 36 00 00
  .db   80, 72, 16, 24,  0,  0
  .db  117, 35, 35, 37,  0,  0

initialObjectValue:
  .hex 04 30 30 14 10 20 24 00 10
initialObjectIndex:
  .hex 00 06 07 08 0E 0F 10 16 17
