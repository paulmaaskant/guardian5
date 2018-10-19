state_initializeDestroyObject:

  LDA #6
  STA effects
  JSR clearCurrentEffects
  LDX #5
  LDA #4

-loop:
  STA currentEffects+0, X
  DEX
  BPL -loop

  LDA #64
  STA list1+2

  BIT targetObjectTypeAndNumber
  BMI +enemyDestroyed

  JSR pullAndBuildStateStack
  db #11
  db $4E                  ; run implosion animation
  db $20, 0					      ; load hud menu BG 0: dialog
  db $01, 14					    ; load stream 14: "I am out!"
  db $30							    ; restore active unit portrait
  db $20, 1					      ; load hud menu BG 1: hud
  db $31, #eUpdateTarget  ; raise event: update target
  db $2D                  ; explode object

+enemyDestroyed:
  JSR pullAndBuildStateStack
  db #2
  db $4E                  ; run implosion animation
  db $2D                  ; explode object



  ;
