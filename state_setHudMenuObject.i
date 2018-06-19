; state 47
; 0 hud with target object
; 1 hud with next object
; 2 hud with previous object

state_setHudMenuObject:
  LDA #15
  LDX #0

-loop:
  STA list8, X            ; clear list8
  INX
  CPX #252
  BCC -loop

  JSR pullParameter
  BEQ +setTargetObject
  LDX list8+252
  CMP #1
  BEQ +nextObject

-retry:
  DEX
  BPL +notNegative
  LDX objectListSize
  DEX

+notNegative:
  LDA objectList, X
  BIT pilotBits
  BEQ -retry
  BNE +set

+nextObject:
-retry:
  INX
  CPX objectListSize
  BCC +smaller
  LDX #0

+smaller:
  LDA objectList, X
  BIT pilotBits
  BEQ -retry
  BNE +set

+setTargetObject:
  STA list8+255

  LDA #$2F            ; tab selector
  STA list8+55
  LDA #$2E            ; tab selector
  STA list8+59

  LDA targetObjectTypeAndNumber
  BNE +set
  LDA activeObjectIndexAndPilot

+set:
  STA list8+254
  AND #%01111000
  STA list8+253

  LDX objectListSize
  DEX

-loop:
  LDA objectList, X
  CMP list8+254
  BEQ +foundObject
  DEX
  BPL -loop

+foundObject:
  STX list8+252

  RTS
