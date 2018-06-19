; Y in, grid position
; A in, settings + tile

setTile:
  STA tileIndex             ; new node map entry
  STY tileGridPos
                            ; consisting of collision data (b7,6) and meta tile (b4-0)
  LDA nodeMap, Y            ; dont overwrite the tile if the tile is fixed
  AND #%00100000            ; (b5) fixed tile
  BEQ +continue             ; not fixed -> overwrite tile
  LDA nodeMap, Y
  ORA #%01000000            ; block LOS
  STA nodeMap, Y
  RTS

+continue:
  LDA tileIndex
  STA nodeMap, Y            ; update node map
                            ; next, check if immediate tile overwrite is neccessary

  TYA                       ; grid pos to A
  JSR gridPosToScreenPos
  BCS +onScreen             ; grid pos is currently on screen, so update tile immediately
                            ; tile is offscreen or on the border

  LDA currentObjectYScreen  ; additional check for top border
  ORA currentObjectXScreen
  BEQ +onScreen             ; because tile (unlike sprites) still needs to be overwritten if its behind the status bar

+offScreen
  RTS                       ; because there is no guarantee that regular scrolling wont update tiles behind the bar

+onScreen:
  LDA events
  ORA event_refreshTile
  STA events
  RTS
