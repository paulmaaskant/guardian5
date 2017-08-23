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

	STY debug
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

	LDA #$01																; game state init story screen
	STA gameState

	LDA #$99																; tile stack empty position
	STA stackPointer2	;

	; --- set up sprite 0, used to split the screen ---
	LDA #$C0			; x pos, used for timing to hit h-blank
	STA $0203			; x pos
	LDA #$2E			; y pos
	STA $0200			; y pos
	LDA #$31			; pattern
	STA $0201			; pattern
	LDA #$20			; show behind background tiles
	STA $0202			; show behind background tiles

	; ---  iNES mapper 23 ---
	LDA #$00			; page 0: tiles
	STA $8000			; in switch bank 0
	LDA #$01			; page 1: byte streams
	STA $A000			; in switch bank 1

	LDA #$00			;
	STA $B000			; into CHR slot 0
	LDA #$01
	STA $B002
	LDA #$02
	STA $C000
	LDA #$03
	STA $C002

	LDA #$04			; bank 4
	STA $D000			; into CHR slot 4
	LDA #$05
	STA $D002
	LDA #$06
	STA $E000
	LDA #$07
	STA $E002

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

	JMP mainGameLoop
