; --------------------------------------------
; Sound headers
; --------------------------------------------
soundsLo:
  .db #< sound00
  .db #< sound01
  .db #< sound02
  .db #< sound03
  .db #< sound04
  .db #< sound05
  .db #< sound06
  .dsb 9, #< sound15
  .db #< sound10
  .db #< sound11
  .db #< sound12
  .db #< sound13
  .db #< sound14
  .db #< sound15
  .db #< sound16
  .db #< sound17
  .db #< sound18
  .db #< sound19
  .db #< sound1A
  .db #< sound1B
  .db #< sound1C
  .dsb 3, #< sound15

soundsHi:
  .db #> sound00
  .db #> sound01
  .db #> sound02
  .db #> sound03
  .db #> sound04
  .db #> sound05
  .db #> sound06
  .dsb 9, #> sound15
  .db #> sound10
  .db #> sound11
  .db #> sound12
  .db #> sound13
  .db #> sound14
  .db #> sound15
  .db #> sound16
  .db #> sound17
  .db #> sound18
  .db #> sound19
  .db #> sound1A
  .db #> sound1B
  .db #> sound1C
  .dsb 3, #> sound15


; --------------------------------------
; sound constants
; --------------------------------------

  ;Octave 1
  A1  = $00   ;"1" means octave 1.
  As1 = $01   ;"s" means "sharp"
  Bb1 = $01   ;"b" means "flat".  A == Bb
  B1  = $02

  ;Octave 2
  C2  = $03
  Cs2 = $04
  Db2 = $04
  D2  = $05
  Ds2 = $06
  Eb2 = $06
  E2  = $07
  F2  = $08
  Fs2 = $09
  Gb2 = $09
  G2  = $0A
  Gs2 = $0B
  Ab2 = $0B
  A2  = $0C
  As2 = $0D
  Bb2 = $0D
  B2  = $0E

  ;Octave 3
  C3  = $0F
  Cs3 = $10
  Db3 = $10
  D3  = $11
  Ds3 = $12
  Eb3 = $12
  E3  = $13
  F3  = $14
  Fs3 = $15
  Gb3 = $15
  G3  = $16
  Gs3 = $17
  Ab3 = $17
  A3  = $18
  As3 = $19
  Bb3 = $19
  B3  = $1A

  ;Octave 4
  C4  = $1B
  Cs4 = $1C
  Db4 = $1C
  D4  = $1D
  Ds4 = $1E
  Eb4 = $1E
  E4  = $1F
  F4  = $20
  Fs4 = $21
  Gb4 = $21
  G4  = $22
  Gs4 = $23
  Ab4 = $23
  A4  = $24
  As4 = $25
  Bb4 = $25
  B4  = $26

  C5  = $27
  Cs5 = $28
  Db5 = $28
  D5  = $29
  Ds5 = $2A
  Eb5 = $2A
  E5  = $2B
  F5  = $2C
  Fs5 = $2D
  Gb5 = $2D
  G5  = $2E
  Gs5 = $2F
  Ab5 = $2F
  A5  = $30
  As5 = $31
  Bb5 = $31
  B5  = $32

  C6  = $33
  Cs6 = $34
  Db6 = $34
  D6  = $35
  Ds6 = $36
  Eb6 = $36
  E6  = $37
  F6  = $38
  Fs6 = $39
  Gb6 = $39
  G6  = $3A
  Gs6 = $3B
  Ab6 = $3B
  A6  = $3C
  As6 = $3D
  Bb6 = $3D
  B6  = $3E

  REST = $50
