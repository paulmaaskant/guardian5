
; IN Y (0-9)

setDamageTooltip:
  LDA damageUpperSprite, Y
  STA list3+40
  LDA damageLowerSprite, Y
  STA list3+41
  RTS


damageUpperSprite:
  .hex 6C 68 69 69 6A 6B 6B 6D 6C 6C


damageLowerSprite:
  .hex 7D 78 79 7B 7A 7B 7C 78 7C 7B
