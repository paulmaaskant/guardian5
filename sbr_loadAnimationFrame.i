; -----------------------------------------------
; load sprite meta frame
; select the meta frame to show in the current animation cycle, based on the animation frame count
;
; byte 1 - ffff.????, number of meta frames in animation & reservation for flags (not implemented)
; byte 2 - iiii.iiii, interval between frames (number of NMI's)
; byte 3&4 - meta frame
; repeat
;
; IN Y, animation id
; PASS, par3 (srpite slot allocation)
; PASS, par4 (mirror and palette control)
; -----------------------------------------------
loadAnimationFrame:
	LDA par3									; store to pass on to next level sbr
	PHA
	LDA par4
	PHA

	LDA animationH, Y
	STA pointer1
	LDA animationL, Y
	STA pointer1+1

	LDY #$00
	LDA (pointer1), Y
	LSR															; optimze by putting the # freams in right nyble
	LSR
	LSR
	LSR
	PHA															; last meta frame # in the sequence

	LDA #$00
	STA par1												; N hi (always 0)
	LDA currentObjectFrameCount
	STA par2												; N lo (current object frame count)
	INY
	LDA (pointer1), Y								; D (interval in # frames)
	JSR divide											; frame count (N) / interval  (D) = current meta frame (Q)F
	PLA															; compare no of meta frames to
	CMP par4												; is the current meta frame the last meta frame?
	BNE +continue
	LDA #$00												; yes ->
	STA currentObjectFrameCount			; reset to start of animation
	STA par4												;

+continue:
	LDA par4
	ASL															; * 2 because each address takes 2 bytes
	TAY
	INY
	INY								; add 2 to skip control bytes

	LDA (pointer1), Y
	STA pointer2+0
	INY
	LDA (pointer1), Y
	STA pointer2+1

	PLA
	STA par4
	PLA
	STA par3

	JMP loadSpriteMetaFrame			; tail chain!
