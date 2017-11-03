squareRoot:
; Example 5-14.  Simple 16-bit square root.
;
; Returns the 8-bit square root in A of the
; 16-bit number in par2 (low) and par1 (high). The
; remainder is in location par1.

  LDY #$01     ; lsby of first odd number = 1
  STY locVar1
  DEY
  STY locVar2      ; msby of first odd number (sqrt = 0)

-again:
  SEC
  LDA par2      ; save remainder in X register
  TAX          ; subtract odd lo from integer lo
  SBC locVar1
  STA par2
  LDA par1      ; subtract odd hi from integer hi
  SBC locVar2
  STA par1      ; is subtract result negative?
  BCC +nomore   ; no. increment square root
  INY
  LDA locVar1      ; calculate next odd number
  ADC #$01
  STA locVar1
  BCC -again
  INC locVar2
  JMP -again

nomore:
  ;STY par2      ; all done, store square root
  TYA
  STX par1      ; and remainder
  RTS
