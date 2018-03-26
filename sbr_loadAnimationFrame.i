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
	LDA animationH, Y
	STA pointer1
	LDA animationL, Y
	STA pointer1+1

	LDY #1
	LDA (pointer1), Y								; D (interval in # frames)
	TAY
	LDA currentObjectFrameCount

-loop:
	LSR
	DEY
	BNE -loop

	CMP (pointer1), Y								; total # of frames
	BCC +continue

	TYA															; reset to frame 0
	STA currentObjectFrameCount			; reset to start of animation

+continue:
	ASL															; * 2 because each address takes 2 bytes
	TAY
	INY
	INY															; add 2 to skip control bytes

	LDA (pointer1), Y
	STA pointer2+0
	INY
	LDA (pointer1), Y
	STA pointer2+1

	JMP loadSpriteMetaFrame			; tail chain!
