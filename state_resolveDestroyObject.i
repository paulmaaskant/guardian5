; 2D

state_resolveDestroyObject:
  JSR initializeExplosion         ; initializes and sets running effect

  LDY cursorGridPos
  LDA #12                         ; load debris tile
  JSR setTile

  LDA targetObjectTypeAndNumber   ; remove object from list
	JSR deleteObject

  INC cameraYDest+1               ; start ground shake
                                  ; because camera move adjustments are mulitples of 2
                                  ; camera keeps trembling until camera destination
                                  ; is reset to an even number

  LDY #22                         ; sound: explosion
  JSR soundLoad

  JMP pullState
