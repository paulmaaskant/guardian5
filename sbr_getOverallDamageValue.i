; in: Y, object index
; in: X, range category
; local: locVar1, 2, 3
; out A: overal damage value

getOverallDamageValue:
  STY locVar1
  STX locVar2
  JSR getStatsAddress                     ; breaks X
  LDY #5																	; damage profile index, breaks Y
  LDA (pointer1), Y												; damage profile
  LDX locVar2
  JSR getDamageValue
  STA locVar3

  LDY locVar1                             ; restore object index
  LDX locVar2                             ; restore range category

  LDA object+6, Y													; add damage profile for EQ 1
  AND #$F0
  LSR
  TAY                                     ; Y = weapon type index
  LDA weaponType+1, Y
  JSR getDamageValue
  CLC
  ADC locVar3
  STA locVar3

  LDY locVar1                             ; restore object index
  LDX locVar2                             ; restore range category

  LDA object+7, Y													; add damage profile for EQ 1
  AND #$F0
  LSR
  TAY                                     ; Y = weapon type index
  LDA weaponType+1, Y
  JSR getDamageValue
  CLC
  ADC locVar3

  LDY locVar1                             ; restore object index
  LDX locVar2                             ; restore range category

  RTS
