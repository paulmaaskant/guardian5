RESET:
																					; turn things off and initialize
	SEI																			; tells the code to ignore interrupts for this routine
	LDA #$00																; load 0 into accumulator
	STA $2000																; disables NMI
	STA $2001																; disables rendering
	STA $4010
	STA $4015
	LDA #$40																;  64
	STA $4017
	CLD																			; disables decimal mode
	LDX #$FF																; load 255 into X
	TXS																			; initialize the stack

	BIT $2002
-	BIT $2002																; wait for vBlank
	BPL -

	; --- clear memory ---
	LDA #$00																; load zero into accumulator
	LDX #$00																; load zero into X
-	STA $0000, x														; clear all variables
	STA $0100, x														; clear the stack
	STA $0200, x														; clear all sprites
	STA $0300, x														; clear music variables
	STA $0400, x														; clear tables
	STA $0500, x														; clear tables
	STA $0600, x														; clear tables
	STA $0700, x														; clear tables
	INX
	BNE -

-	BIT $2002																; wait for vBlank
	BPL -
																					; check system
	LDX #$00
	LDY #$00

-count:
	BIT $2002
	BPL +notYet
	CPY #$0A
	BCS +continue
	LDA sysFlag_NTSC
	STA sysFlags
	BNE +continue

+notYet
	INX
	BNE -count
	INY
	BNE -count

+continue:
	LDA #%10010000 													;
	STA $2000																; turns NMI back on
	LDA #%00011110													;
	STA $2001																; turns PPU back on

	; --- initialize game variables ---
	LDA #%10011010
	STA seed+0															; used for sr random
	LDA #%11001000
	STA seed+1

	; sbr buildStateStack requies a return address
	LDA #> +returnPoint
	PHA
	LDA #< +returnPoint
	PHA

	;JSR buildStateStack
	;.db 5									; # items
	;.db $00, 5						; load screen 5: animation screen
	;.db $0D, 1						; change brightness 1: fade in
	;.db $30								; play animations
	; built in RTS

	JSR buildStateStack
	.db 14								; # stack items
	.db $00, 1						; load screen 01: story background
	.db $0D, 1						; change brightness 1: fade in
	.db $01, 0						; load stream 00: story text
	.db $0D, 0						; change brightness 0: fade out
	.db $00, 0						; load screen 00: title screen
	.db $1E								; load title menu
	.db $0D, 1						; change brightness 1: fade in
	.db $03								; title screen (wait for user)
	; built in RTS

+returnPoint:
	NOP

	LDA #$99																; tile stack empty position
	STA stackPointer2	;

	; --- set up sprite 0, used to split the screen ---
	LDA #$C0			; x pos, used for timing to hit h-blank
	STA $0203			; x pos
	LDA #$2E			; y pos
	STA $0200			; y pos
	LDA #$4F			; pattern
	STA $0201			; pattern
	LDA #$20			; show behind background tiles
	STA $0202			; show behind background tiles

	; ---  iNES mapper 23 ---
	LDA #$00			; page 0: tiles
	STA $8000			; in switch bank 0
	LDA #$01			; page 1: byte streams
	STA $A000			; in switch bank 1



	LDA #3			;
	STA $B000			; into CHR slot 0
	LDA #0
	STA softCHRBank1
	LDA #2
	STA $C000
	LDA #3
	STA $C001

	LDA #$04			; bank 4
	STA $D000			; into CHR slot 4

	LDA #$05
	STA $D001

	LDA #$06
	STA $E000

	LDA #$07
	STA $E001

	; --- set level 1 palettes ---
	LDY #$07

-loop:
	TYA
	STA currentPalettes, Y
	DEY
	BPL -loop

	LDA #$0F
	STA currentTransparant

	LDA #$C0
	JSR updatePalette

	JSR soundInitialize

	LDA #1													; start with sprite 1 (sprite 0 is permanently reserved)
	STA par3												;
	LDA #63													; clear up to (including) sprite 63
	JSR clearSprites

	JMP mainGameLoop
