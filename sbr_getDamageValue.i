; IN A
; OUT A
; IN X range category

getDamageValue:
  CPX #3
  BCS +long
  CPX #2
  BCS +medium
  CPX #1
  BCS +short

+close:
  LSR
  LSR

+short:
  LSR
  LSR

+medium:
  LSR
  LSR

+long:
  AND #3
  RTS
