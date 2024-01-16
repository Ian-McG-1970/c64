; uses vic bank 49152-65535
; 63k to 64k = unavailable
; 60k to 62k = charset
; 58k to 59k = screen

; could be 63k = bb / 62k = scn / 60k = charset

SCN = 2
SCN_LO = SCN
SCN_HI = SCN_LO +1
MEM_FROM = SCN +2
MEM_TO = MEM_FROM +2
MEM_SIZE = MEM_TO +2
MEM_SIZE_LO = MEM_SIZE
MEM_SIZE_HI = MEM_SIZE +1

REGA = MEM_SIZE +2
REGX = REGA +1
REGY = REGX +1
PLAYER_H = REGY +1
PLAYER_V = PLAYER_H +1

SPR_CNT = PLAYER_V +1

SN_V0H0LO = SPR_CNT +1
SN_V0H0HI = SN_V0H0LO +1
SN_V1H0LO = SN_V0H0HI +1
SN_V1H0HI = SN_V1H0LO +1

BB_V0H0LO = SN_V1H0HI +1
BB_V0H0HI = BB_V0H0LO +1
BB_V1H0LO = BB_V0H0HI +1
BB_V1H0HI = BB_V1H0LO +1

VPIX = BB_V1H0HI +1
HPIX = VPIX +1

BORDER = $D020
SCRCOL0 = $D021
SCRCOL1 = $D022
SCRCOL2 = $D023
SCRCOL3 = $D024

MP_RASTER_POS = 246-6

VIC_SCN = 58*1024
BB_SCN = VIC_SCN +1024
VIC_CHAR_SET = 60*1024

;START
*= 2049
!byte $0c,$08,$0a,$00,$9e   ; Line 10 SYS
!tx "2070"            ; Address for sys start in text 4096+11

*= 2070

  SEI        ; disable maskable IRQs
  CLV
  CLD
  LDX   #$FF   ; reset stack
  TXS
 
  LDA   #$7F
  STA   $DC0D  ; disable timer interrupts which can be generated by the two CIA chips
  STA   $DD0D  ; the kernal uses such an interrupt to flash the cursor and scan the keyboard, so we better stop it.

  LDA   $DC0D  ; by reading this two registers we negate any pending CIA irqs.
  LDA   $DD0D  ; if we don't do this, a pending CIA irq might occur after we finish setting up our irq. we don't want that to happen.

  LDA   #$01   ; this is how to tell the VICII to generate a raster interrupt
  STA   $D01A

  LDA   #%00011011 ; $10 
  STA   $D011 ; #7: Read: Current raster line (bit #8) / #6: 1 = Extended background mode on / #5: 0 = Text mode; 1 = Bitmap mode / #4: 0 = Screen off, complete screen is covered by border; 1 = Screen on, normal screen contents are visible / #3: Screen height; 0 = 24 rows; 1 = 25 rows / #0-#2: Vertical raster scroll.
  LDA   #%00001000 ; %00011000
  STA   $D016 ; #4: 1 = Multicolor mode on / #3: Screen width; 0 = 38 columns; 1 = 40 columns / #0-#2: Horizontal raster scroll.

  LDA   #$35   ; we turn off the BASIC and KERNAL rom here so cpu now sees RAM everywhere except $d000-$e000
  STA   $01

  LDA   #<MP_IRQ  ; interrupt code
  STA   $FFFE
  LDA   #>MP_IRQ
  STA   $FFFF
  LDA   #MP_RASTER_POS   ; this is how to tell at which rasterline we want the irq to be triggered
  STA   $D012

  LDA   #<NMI_NOP ; lsb
  STA   $FFFA ; Create a nop, irq handler for NMI that gets called whenever RESTORE is pressed or similar.
  LDA   #>NMI_NOP ; msb
  STA   $FFFB ; We're putting our irq handler directly in the vector that usually points to the kernal's NMI handler since we have kernal banked out.

  LDA   #$00  ; Force an NMI by setting up a timer. This will cause an NMI, that won't be acked. Any subsequent NMI's from RESTORE will be essentially disabled.
  STA   $DD0E       ; Stop timer A
  STA   $DD04       ; Set timer A to 0, NMI will occure immediately after start
  STA   $DD0E

  LDA   #$81
  STA   $DD0D       ; Set timer A as source for NMI

  LDA   #$01
  STA   $DD0E       ; Start timer A -> NMI

  LDA #%00000000 ; bank 3 (49152-65535)
  STA $DD00

  LDA #%10101100 ; screen = $2800 + 48k = 58k / char = $3000 + 48k = 60k ;  LDA #%10111100 ; screen = $2C00 + 48k = 59k / char = $3000 + 48k = 60k
  STA $D018

  LDA #0
  STA BORDER

  LDA #1
  STA SCRCOL0
  LDA #4
  STA SCRCOL1
  LDA #6
  STA SCRCOL2

  LDA #50
  STA PLAYER_H
  STA PLAYER_V
  
 LDA #10 ; colour 11
 LDX #<$D800
 LDY #>$D800
 STX MEM_TO+0
 STY MEM_TO+1
 LDX #>1000 
 LDY #<1000
 JSR MEMSET

 LDA #2 ; screen
 LDX #<VIC_SCN
 LDY #>VIC_SCN
 STX MEM_TO+0
 STY MEM_TO+1
 LDX #>1000 
 LDY #<1000
 JSR MEMSET
 
 LDA #3 ; charset
 LDX #<VIC_CHAR_SET
 LDY #>VIC_CHAR_SET
 STX MEM_TO+0
 STY MEM_TO+1
 LDX #>2048 
 LDY #<2048
; JSR MEMSET

; lda #255
; sta VIC_CHAR_SET +0
; sta VIC_CHAR_SET +1
; sta VIC_CHAR_SET +2
; sta VIC_CHAR_SET +3
; sta VIC_CHAR_SET +4
; sta VIC_CHAR_SET +5
; sta VIC_CHAR_SET +6
; sta VIC_CHAR_SET +7

; lda #0
; sta 60000
 
;  LDX #<2
;  LDY #>2
;  STX MEM_FROM+0
;  STY MEM_FROM+1
;  LDX #<MAP_ADR
;  LDY #>MAP_ADR
;  STX MEM_TO+0
;  STY MEM_TO+1
;  LDY #<8191
;  LDX #>8191
;;  JSR MEMCPY
;  LDX #<2
;  LDY #>2
;  STX MEM_FROM+0
;  STY MEM_FROM+1
;  LDX #<(MAP_ADR+8192)
;  LDY #>(MAP_ADR+8192)
;  STX MEM_TO+0
;  STY MEM_TO+1
;  LDY #<8191
;  LDX #>8191
;  JSR MEMCPY

  LDX #<2048
  LDY #>2048
  STX MEM_FROM+0
  STY MEM_FROM+1
  LDX #<VIC_CHAR_SET
  LDY #>VIC_CHAR_SET
  STX MEM_TO+0
  STY MEM_TO+1
  LDY #<2048
  LDX #>2048
;  JSR MEMCPY

  JSR FILL_CHARS
  JSR FILL_SCREEN_WITH_CHARS

 lda #%11000110
 sta VIC_CHAR_SET +0
 sta VIC_CHAR_SET +1
 sta VIC_CHAR_SET +2
 sta VIC_CHAR_SET +3
 sta VIC_CHAR_SET +4
 sta VIC_CHAR_SET +5
 sta VIC_CHAR_SET +6
 sta VIC_CHAR_SET +7

 LDA #0; 15; 13 ; 0 ; -1
 STA SPR_CNT
 
  CLI ; enable maskable interrupts again

  JMP MLOOP

FILL_SCREEN_WITH_CHARS
 LDX #<(BB_SCN+0)
 LDY #>(BB_SCN+0)
 STX .TEMP1 +1
 STY .TEMP1 +2

 LDX #<(BB_SCN+250)
 LDY #>(BB_SCN+250)
 STX .TEMP2 +1
 STY .TEMP2 +2

 LDX #<(BB_SCN+500)
 LDY #>(BB_SCN+500)
 STX .TEMP3 +1
 STY .TEMP3 +2

 LDX #<(BB_SCN+750)
 LDY #>(BB_SCN+750)
 STX .TEMP4 +1
 STY .TEMP4 +2

  LDX #251
.LOOP TXA
.TEMP1  STA $ABCD,X
.TEMP2  STA $ABCD,X
.TEMP3  STA $ABCD,X
.TEMP4  STA $ABCD,X
    DEX
    BNE .LOOP

  RTS

;move memory down
;
; FROM = source start address
;   TO = destination start address
; SIZE = number of bytes to move
  
!ZONE MEMCPY
MEMCPY
    STY .LSB +1
    LDY #0
    TXA
    BEQ .LSB
.LOOPHI LDA (MEM_FROM),Y ; move a page at a time
        STA (MEM_TO),Y
        INY
        BNE .LOOPHI
      INC MEM_FROM+1
      INC MEM_TO+1
      DEX
      BNE .LOOPHI
.LSB    LDX #0
        BEQ .EXIT
.LOOPLO   LDA (MEM_FROM),Y ; move the remaining bytes
          STA (MEM_TO),Y
          INY
          DEX
          BNE .LOOPLO
.EXIT  RTS

!ZONE MEMSET        
MEMSET       STY    .LSB_ONLY+1 ; store LSB count
             CPX    #0          ; MSB?     
             BEQ    .LSB_ONLY   ; no

             LDY    #0          ; yes so reset LSB
.MSB_LOOP  
.LSB_LOOP      STA    (MEM_TO),Y   ; clear whole MSB
               DEY 
               BNE    .LSB_LOOP

              INC    MEM_TO+1      ; inc MSB
              DEX               ; dec MSB count
              BNE    .MSB_LOOP

.LSB_ONLY    LDY    #0          ; LSB count 
             BEQ    .MS_END     ; not needed

.LAST_LSB_LOOP STA   (MEM_TO),Y
               DEY 
               BNE   .LAST_LSB_LOOP
                
              STA   (MEM_TO),Y     ; clear last Y (0)
 
.MS_END      RTS

MLOOP:  JMP   MLOOP ; we better don't RTS, the ROMS are now switched off, there's no way back to the system

!ZONE MP_IRQ
MP_IRQ    INC   $D019    ;VIC Interrupt Request Register (IRR)
          STA   .REG_A+1
          STX   .REG_X+1
          STY   .REG_Y+1

 DEC BORDER
  JSR   JOYSTICK2

 INC BORDER
  JSR   MOVE_PLAYER ; move sprite
  
 DEC BORDER
 JSR CLEAR_SPRITES

 INC BORDER
  LDX PLAYER_V
  LDY PLAYER_H
  STX SPR_PXL_V
  STY SPR_PXL_H
 
 DEC BORDER
 JSR DRAW_SPRITES

 INC BORDER
  
.REG_A     LDA   #0
.REG_X     LDX   #0
.REG_Y     LDY   #0
NMI_NOP:  RTI ; This is the irq handler for the NMI. Just returns without acknowledge. This prevents subsequent NMI's from interfering.

!ZONE CLEAR_SPRITES
CLEAR_SPRITES
      LDX SPR_CNT
      BMI .EXIT
.LOOP   JSR CLEAR_SPRITE
        DEX
        BPL .LOOP
.EXIT RTS

!ZONE CLEAR_SPRITE
CLEAR_SPRITE
;  STX REGX
  CLC

  LDY SPR_CHR_V,X
  LDA VIC_SCN_HI,Y
  STA SN_V0H0HI ; screen hi
  ADC #4
  STA BB_V0H0HI ; back buffer hi
  LDA VIC_SCN_HI+1,Y
  STA SN_V1H0HI
  ADC #4
  STA BB_V1H0HI

  LDA VIC_SCN_LO,Y
  STA SN_V0H0LO
  STA BB_V0H0LO
;  CLC ; not needed due to adc above?
  ADC #40
  STA SN_V1H0LO
  STA BB_V1H0LO

  LDY SPR_CHR_H,X
  LDA (BB_V0H0LO),Y ; get back buffer
  STA (SN_V0H0LO),Y ; put screen
  LDA (BB_V1H0LO),Y
  STA (SN_V1H0LO),Y

  INY
  LDA (BB_V0H0LO),Y
  STA (SN_V0H0LO),Y
  LDA (BB_V1H0LO),Y
  STA (SN_V1H0LO),Y

;  LDX REGX
  RTS

!ZONE DRAW_SPRITES
DRAW_SPRITES
      LAX SPR_CNT
      BMI .EXIT
.LOOP   JSR DRAW_SPRITE
        DEX
        BPL .LOOP
.EXIT RTS

!ZONE DRAW_SPRITE
DRAW_SPRITE ; x=sprnum (0-12)

  STX REGX
  ASL
  STA .JMP+1
  
  LDY SPR_PXL_V,X
  LDA V_PIXEL,Y
  STA VPIX
  LDA V_CHAR,Y
  STA SPR_CHR_V,X
  TAX

  LDA VIC_SCN_HI,X
  STA SN_V0H0HI
  LDA VIC_SCN_HI+1,X
  STA SN_V1H0HI

  LDA VIC_SCN_LO,X
  STA SN_V0H0LO
;  CLC ; not needed due to asl above?
  ADC #40
  STA SN_V1H0LO

  LDY REGX
  LDX SPR_PXL_H,Y
  LDA H_PIXEL,X
  STA HPIX
  LDA H_CHAR,X
  STA SPR_CHR_H,Y
  TAY

.JMP JMP (SPR_DRW_TAB)

DRAW_SPRITE_01
DRAW_SPRITE_02
DRAW_SPRITE_03
DRAW_SPRITE_04
DRAW_SPRITE_05
DRAW_SPRITE_06
DRAW_SPRITE_07
DRAW_SPRITE_08
DRAW_SPRITE_09
DRAW_SPRITE_10
DRAW_SPRITE_11
DRAW_SPRITE_12
DRAW_SPRITE_13
DRAW_SPRITE_14
DRAW_SPRITE_15
DRAW_SPRITE_16
DRAW_SPRITE_17
; RTS
  
!ZONE DRAW_SPRITE_00
DRAW_SPRITE_00

 DEC BORDER

  LAX (SN_V0H0LO),Y
  LDA VIC_CHAR_TAB_LO,X
  STA .SRC_CHR_00 +1 
  LDA VIC_CHAR_TAB_HI,X
  STA .SRC_CHR_00 +2
  LDA #96
  STA (SN_V0H0LO),Y

  LAX (SN_V1H0LO),Y
  LDA VIC_CHAR_TAB_LO,X
  STA .SRC_CHR_01 +1
  LDA VIC_CHAR_TAB_HI,X
  STA .SRC_CHR_01 +2
  LDA #97
  STA (SN_V1H0LO),Y

  INY
  LAX (SN_V0H0LO),Y
  LDA VIC_CHAR_TAB_LO,X
  STA .SRC_CHR_10 +1
  LDA VIC_CHAR_TAB_HI,X
  STA .SRC_CHR_10 +2
  LDA #98
  STA (SN_V0H0LO),Y

  LAX (SN_V1H0LO),Y
  LDA VIC_CHAR_TAB_LO,X
  STA .SRC_CHR_11 +1
  LDA VIC_CHAR_TAB_HI,X
  STA .SRC_CHR_11 +2
  LDA #99
  STA (SN_V1H0LO),Y

  LDY #7
.SRC_CHR_00 LDA $ABCD,Y
            STA SPR_00_00_CHR_096,Y
.SRC_CHR_01 LDA $ABCD,Y
            STA SPR_00_10_CHR_097,Y
.SRC_CHR_10 LDA $ABCD,Y
            STA SPR_00_01_CHR_098,Y
.SRC_CHR_11 LDA $ABCD,Y
            STA SPR_00_11_CHR_099,Y
    DEY
    BPL .SRC_CHR_00

 LDX HPIX

 LDY SPR_AND_TAB_HI,X
 STY .SPR_AND_00 +2
 STY .SPR_AND_01 +2
 STY .SPR_AND_02 +2
 STY .SPR_AND_03 +2
 STY .SPR_AND_04 +2
 STY .SPR_AND_05 +2
 STY .SPR_AND_06 +2
 STY .SPR_AND_07 +2
 
 STY .SPR_ORA_00 +2
 STY .SPR_ORA_01 +2
 STY .SPR_ORA_02 +2
 STY .SPR_ORA_03 +2
 STY .SPR_ORA_04 +2
 STY .SPR_ORA_05 +2
 STY .SPR_ORA_06 +2
 STY .SPR_ORA_07 +2

 LDY SPR_AND_TAB_LO,X
 STY .SPR_AND_00 +1
 INY
 STY .SPR_AND_01 +1
 INY
 STY .SPR_AND_02 +1
 INY
 STY .SPR_AND_03 +1
 INY
 STY .SPR_AND_04 +1
 INY
 STY .SPR_AND_05 +1
 INY
 STY .SPR_AND_06 +1
 INY
 STY .SPR_AND_07 +1
 
 LDY SPR_ORA_TAB_LO,X
 STY .SPR_ORA_00 +1
 INY
 STY .SPR_ORA_01 +1
 INY
 STY .SPR_ORA_02 +1
 INY
 STY .SPR_ORA_03 +1
 INY
 STY .SPR_ORA_04 +1
 INY
 STY .SPR_ORA_05 +1
 INY
 STY .SPR_ORA_06 +1
 INY
 STY .SPR_ORA_07 +1

 LDX #8
 LDY VPIX
 SEC ; not needed?

.LOOP
            LDA SPR_00_00_CHR_096+00,Y
.SPR_AND_00 AND $ABCD,X
.SPR_ORA_00 ORA $ABCD,X
            STA SPR_00_00_CHR_096+00,Y

            LDA SPR_00_00_CHR_096+01,Y
.SPR_AND_01 AND $ABCD,X
.SPR_ORA_01 ORA $ABCD,X
            STA SPR_00_00_CHR_096+01,Y

            LDA SPR_00_00_CHR_096+02,Y
.SPR_AND_02 AND $ABCD,X
.SPR_ORA_02 ORA $ABCD,X
            STA SPR_00_00_CHR_096+02,Y

            LDA SPR_00_00_CHR_096+03,Y
.SPR_AND_03 AND $ABCD,X
.SPR_ORA_03 ORA $ABCD,X
            STA SPR_00_00_CHR_096+03,Y

            LDA SPR_00_00_CHR_096+04,Y
.SPR_AND_04 AND $ABCD,X
.SPR_ORA_04 ORA $ABCD,X
            STA SPR_00_00_CHR_096+04,Y

            LDA SPR_00_00_CHR_096+05,Y
.SPR_AND_05 AND $ABCD,X
.SPR_ORA_05 ORA $ABCD,X
            STA SPR_00_00_CHR_096+05,Y

            LDA SPR_00_00_CHR_096+06,Y
.SPR_AND_06 AND $ABCD,X
.SPR_ORA_06 ORA $ABCD,X
            STA SPR_00_00_CHR_096+06,Y

            LDA SPR_00_00_CHR_096+07,Y
.SPR_AND_07 AND $ABCD,X
.SPR_ORA_07 ORA $ABCD,X
            STA SPR_00_00_CHR_096+07,Y

   TYA
   SBC #16 ; next screen line to the left
   TAY

    LDA #255
    SBX #8
    BPL .LOOP

 INC BORDER
  
  LAX REGX
  RTS

!ZONE JOYSTICK
JOYSTICK1 LDA $DC01
          BVC .JOYSTICK ; JMP
JOYSTICK2 LDA $DC00
.JOYSTICK LDX #0
          LDY #0
.UP       LSR
          BCS   .DOWN
            DEY
.DOWN     LSR
          BCS   .LEFT
            INY
.LEFT     LSR
          BCS   .RIGHT
            DEX
.RIGHT    LSR
          BCS   .FIRE
            INX
.FIRE     EOR   #255
          AND   #1
;          STA   JOYF
;          STX   JOYX
;          STY   JOYY
          LSR
          RTS

!ZONE MOVE_PLAYER
MOVE_PLAYER
    TXA
    BEQ   .VER
    BPL   .RIGHT
.LEFT   DEC   PLAYER_H
    BVC   .VER ; JMP
.RIGHT  INC   PLAYER_H
.VER    TYA
    BEQ   .EXIT
    BPL   .DOWN
.UP     DEC   PLAYER_V
    RTS
.DOWN   INC   PLAYER_V
.EXIT   RTS

FILL_CHAR
      LDY VIC_CHAR_TAB_LO,X
      STY .SCN+1
      LDY VIC_CHAR_TAB_HI,X  
      STY .SCN+2
      LDX #7
.SCN    STA $ABCD,X
        TAY
        ROR
        TYA
        ROR
        DEX
        BPL .SCN
      RTS

FILL_CHARS
      LAX #0
.LOOP   STX .BACKUP +1      
        TXA
        AND #3
        TAY
        LDA PATTERN,Y
        JSR FILL_CHAR
.BACKUP LDX #0
        DEX
        BNE .LOOP
      RTS

!align 255,0
H_CHAR:
!FILL 4,00
!FILL 4,01
!FILL 4,02
!FILL 4,03
!FILL 4,04
!FILL 4,05
!FILL 4,06
!FILL 4,07
!FILL 4,08
!FILL 4,09
!FILL 4,10
!FILL 4,11
!FILL 4,12
!FILL 4,13
!FILL 4,14
!FILL 4,15
!FILL 4,16
!FILL 4,17
!FILL 4,18
!FILL 4,19
!FILL 4,20
!FILL 4,21
!FILL 4,22
!FILL 4,23
!FILL 4,24
!FILL 4,25
!FILL 4,26
!FILL 4,27
!FILL 4,28
!FILL 4,29
!FILL 4,30
!FILL 4,31
!FILL 4,32
!FILL 4,33
!FILL 4,34
!FILL 4,35
!FILL 4,36
!FILL 4,37
!FILL 4,38
!FILL 4,39

!align 255,0
V_CHAR:
!FILL 8,00
!FILL 8,01
!FILL 8,02
!FILL 8,03
!FILL 8,04
!FILL 8,05
!FILL 8,06
!FILL 8,07
!FILL 8,08
!FILL 8,09
!FILL 8,10
!FILL 8,11
!FILL 8,12
!FILL 8,13
!FILL 8,14
!FILL 8,15
!FILL 8,16
!FILL 8,17
!FILL 8,18
!FILL 8,19
!FILL 8,20
!FILL 8,21
!FILL 8,22
!FILL 8,23
!FILL 8,24

VIC_SCN_LO
!for I = 0 TO 24
!BYTE <(VIC_SCN+(I*40))
!end

!align 255,0
VIC_CHAR_TAB_HI
!for I = 0 TO 255
!BYTE >(VIC_CHAR_SET+(I*8))
!end
  
VIC_CHAR_TAB_LO
!for I = 0 TO 255
!BYTE <(VIC_CHAR_SET+(I*8))
!end

!align 255,0
SPR_DRW_TAB !WORD DRAW_SPRITE_00,DRAW_SPRITE_01,DRAW_SPRITE_02,DRAW_SPRITE_03,DRAW_SPRITE_04,DRAW_SPRITE_05,DRAW_SPRITE_06,DRAW_SPRITE_07,DRAW_SPRITE_08,DRAW_SPRITE_09,DRAW_SPRITE_10,DRAW_SPRITE_11,DRAW_SPRITE_12,DRAW_SPRITE_13,DRAW_SPRITE_14,DRAW_SPRITE_15,DRAW_SPRITE_16,DRAW_SPRITE_17

V_PIXEL:
!for I = 0 TO 24
!BYTE 0+16,1+16,2+16,3+16,4+16,5+16,6+16,7+16
!end

VIC_SCN_HI
!for I = 0 TO 24
!BYTE >(VIC_SCN+(I*40))
!end

!align 255,0
H_PIXEL:
!for I = 0 TO 39
!BYTE 0,1,2,3
!end

; software sprites chars are from 128 onwards = blocks of chars
; #1 = 128 to 136
; #2 = 137 to 145
; #3 = 146 to 154
; #4 = 160 to 168 
; #5 = 169 to 177
; #5 = 178 to 186
; #6 = 192 to 200
; #7 = 201 to 209
; #8 = 210 to 218
; #9 = 224 to 232
; #10 = 233 to 241
; #11 = 242 to 250
; there are 20 spare chars between 128 and 255 (155 to 159 / 187 to 191 / 219 to 223 / 251 to 255)
; if these are reused between 1 and 128 this releases 20 chars in that range (reuse chars 96 to 113 for sprites)
; #12 = 96 to 104
; #13 = 105 to 113

;SPR_00 !BYTE 096,105,128,137,146,160,169,178,192,201,210,224,233,242
;SPR_01 !BYTE 097,106,129,138,147,161,170,179,193,202,211,225,234,243
;SPR_02 !BYTE 098,107,130,139,148,162,171,180,194,203,212,226,235,244
;SPR_10 !BYTE 099,108,131,140,149,163,172,181,195,204,213,227,236,245
;SPR_11 !BYTE 100,109,132,141,150,164,173,182,196,205,214,228,237,246
;SPR_12 !BYTE 101,110,133,142,151,165,174,183,197,206,215,229,238,247
;SPR_20 !BYTE 102,111,134,143,152,166,175,184,198,207,216,230,239,248
;SPR_21 !BYTE 103,112,135,144,153,167,176,185,199,208,217,231,240,249
;SPR_22 !BYTE 104,113,136,145,154,168,177,186,200,209,218,232,241,250

SPR_00_00_CHR_096 = VIC_CHAR_SET + (96*8)
SPR_00_10_CHR_097 = SPR_00_00_CHR_096 +8
SPR_00_01_CHR_098 = SPR_00_10_CHR_097 +8
SPR_00_11_CHR_099 = SPR_00_01_CHR_098 +8

SPR_01_00_CHR_105 = VIC_CHAR_SET + (105*8)
SPR_01_10_CHR_106 = SPR_01_00_CHR_105 +8
SPR_01_20_CHR_107 = SPR_01_10_CHR_106 +8
SPR_01_01_CHR_108 = SPR_01_20_CHR_107 +8
SPR_01_11_CHR_109 = SPR_01_01_CHR_108 +8
SPR_01_21_CHR_110 = SPR_01_11_CHR_109 +8
SPR_01_02_CHR_111 = SPR_01_21_CHR_110 +8
SPR_01_12_CHR_112 = SPR_01_02_CHR_111 +8
SPR_01_22_CHR_113 = SPR_01_12_CHR_112 +8

PATTERN
; !BYTE %00000000,%00010001,%00100010,%00110011,%01000100,%01010101,%01100110,%01110111,%10001000,%10011001,%10101010,%10111011,%11001100,%11011101,%11101110,%11111111
 !BYTE %00000000,%01010101,%10101010,%11111111
 !BYTE %00000000,%01010101,%10101010,%11111111
 !BYTE %00000000,%01010101,%10101010,%11111111
 !BYTE %00000000,%01010101,%10101010,%11111111

!align 127,0
SPR_AND_000_00:
!for I = 0 TO 7
!BYTE %00000000
!end
!for I = 0 TO 7
!BYTE %11111111
!end

SPR_ORA_000_00:
!for I = 0 TO 7
!BYTE %11111111
!end
!for I = 0 TO 7
!BYTE %00000000
!end

SPR_AND_000_01:
!for I = 0 TO 7
!BYTE %11000000
!end
!for I = 0 TO 7
!BYTE %00111111
!end

SPR_ORA_000_01:
!for I = 0 TO 7
!BYTE %00111111
!end
!for I = 0 TO 7
!BYTE %11000000
!end

SPR_AND_000_02:
!for I = 0 TO 7
!BYTE %11110000
!end
!for I = 0 TO 7
!BYTE %00001111
!end

SPR_ORA_000_02:
!for I = 0 TO 7
!BYTE %00001111
!end
!for I = 0 TO 7
!BYTE %11110000
!end

SPR_AND_000_03:
!for I = 0 TO 7
!BYTE %11111100
!end
!for I = 0 TO 7
!BYTE %00000011
!end

SPR_ORA_000_03:
!for I = 0 TO 7
!BYTE %00000011
!end
!for I = 0 TO 7
!BYTE %11111100
!end

SPR_PXL_V !BYTE 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; pixel pos
SPR_PXL_H !BYTE 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
SPR_CHR_V !BYTE 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; char pos
SPR_CHR_H !BYTE 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

!align 255,0
SPR_AND_TAB_LO !BYTE <SPR_AND_000_00,<SPR_AND_000_01,<SPR_AND_000_02,<SPR_AND_000_03
SPR_AND_TAB_HI !BYTE >SPR_AND_000_00,>SPR_AND_000_01,>SPR_AND_000_02,>SPR_AND_000_03
SPR_ORA_TAB_LO !BYTE <SPR_ORA_000_00,<SPR_ORA_000_01,<SPR_ORA_000_02,<SPR_ORA_000_03

