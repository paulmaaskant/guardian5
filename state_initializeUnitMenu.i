state_initializeUnitMenu:
  LDA #8
  STA $B000                 ; set portait sprites (1) in bank 0
  LDA #9
  STA $C001                 ; set portait sprites (2) in bank 3
  LDA #6
  STA effects               ; 3x mech sprites + cursor + selectet item + selected cursor

  LDX #14

-loop:
  LDA state_50_setup_effects, X
  STA currentEffects+3, X
  DEX
  BPL -loop

  LDX #11
  LDA #0

-loop:
  STA currentEffects+18, X
  DEX
  BPL -loop

  LDX #18

-loop:
  LDA state_50_setup_selection, X
  STA list1, X
  CPX #12
  BCS +skipUpdate
  JSR updateSelectedItem

+skipUpdate:
  DEX
  BPL -loop

  JSR pullAndBuildStateStack
  .db 5
  .db $46, 11     ; unit roster weapon tiles
  .db $46, 13     ; unit roster stat labels
  .db $51
  ; RTS

state_50_setup_effects:
  hex 34 0B 0B
  db 80, 80, 80, 36, 48, 36
  db 82, 114, 146, 63, 186, 167

state_50_setup_selection:
  db 4, 2, 1         ; pilots
  db 0, 1, 2         ; mechs
  db 3, 1, 0         ; slot 1 weapon
  db 3, 2, 1         ; slot 2 weapon
  db 4               ; list1+12 selected item value (pilot 4)
  db 0               ; list1+13 selected item #
  db 2               ; list1+14 pilot sprite loop control
  db 0               ; list1+15 current object index
  db 128             ; list1+16 first loop flag
  db 0               ; not used
  db 0               ; list1+18
