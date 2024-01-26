; uses vic bank 49152-65535
; 63k to 64k = unavailable
; 60k to 62k = charset
; 58k to 59k = screen

*= 2049
!byte $0c,$08,$0a,$00,$9e   ; Line 10 SYS
!tx "2070"            ; Address for sys start in text 4096+11

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
SN_V2H0LO = SN_V1H0HI +1
SN_V2H0HI = SN_V2H0LO +1

BB_V0H0LO = SN_V2H0HI +1
BB_V0H0HI = BB_V0H0LO +1
BB_V1H0LO = BB_V0H0HI +1
BB_V1H0HI = BB_V1H0LO +1
BB_V2H0LO = BB_V1H0HI +1
BB_V2H0HI = BB_V2H0LO +1

VPIX = BB_V2H0HI +1
HPIX = VPIX +1

BORDER = $D020
SCRCOL0 = $D021
SCRCOL1 = $D022
SCRCOL2 = $D023
SCRCOL3 = $D024

MP_RASTER_POS = 246-6

;VIC_BANK = 49152
VIC_SCN = 58*1024
BB_SCN = VIC_SCN +1024
VIC_CHAR_SET = 60*1024

!ZONE CLR_CHR
!MACRO CLR_CHR R1 {
  STA R1+0
  STA R1+1
  STA R1+2
  STA R1+3
  STA R1+4
  STA R1+5
  STA R1+6
  STA R1+7
}

!ZONE CLR_CHR_2
!MACRO CLR_CHR_2 R1 {
  STA R1+00-(24*0),Y
  STA R1+01-(24*0),Y
  STA R1+02-(24*0),Y
  STA R1+03-(24*0),Y
  STA R1+04-(24*0),Y
  STA R1+05-(24*0),Y
  STA R1+06-(24*0),Y
  STA R1+07-(24*0),Y
  STA R1+08-(24*0),Y
  STA R1+09-(24*0),Y
  STA R1+10-(24*0),Y
  STA R1+11-(24*0),Y
  STA R1+12-(24*0),Y
  STA R1+13-(24*0),Y
  STA R1+14-(24*0),Y
  STA R1+15-(24*0),Y

  STA R1+00-(24*1),Y
  STA R1+01-(24*1),Y
  STA R1+02-(24*1),Y
  STA R1+03-(24*1),Y
  STA R1+04-(24*1),Y
  STA R1+05-(24*1),Y
  STA R1+06-(24*1),Y
  STA R1+07-(24*1),Y
  STA R1+08-(24*1),Y
  STA R1+09-(24*1),Y
  STA R1+10-(24*1),Y
  STA R1+11-(24*1),Y
  STA R1+12-(24*1),Y
  STA R1+13-(24*1),Y
  STA R1+14-(24*1),Y
  STA R1+15-(24*1),Y

  STA R1+00-(24*2),Y
  STA R1+01-(24*2),Y
  STA R1+02-(24*2),Y
  STA R1+03-(24*2),Y
  STA R1+04-(24*2),Y
  STA R1+05-(24*2),Y
  STA R1+06-(24*2),Y
  STA R1+07-(24*2),Y
  STA R1+08-(24*2),Y
  STA R1+09-(24*2),Y
  STA R1+10-(24*2),Y
  STA R1+11-(24*2),Y
  STA R1+12-(24*2),Y
  STA R1+13-(24*2),Y
  STA R1+14-(24*2),Y
  STA R1+15-(24*2),Y
}

!ZONE DRW_CHR
!MACRO DRW_CHR R1 {
    LDA VIC_CHAR_TAB_LO,X
    STA SCN_LO 
    LDA VIC_CHAR_TAB_HI,X
    STA SCN_HI
    STY REGY
    LDY #0
    LDA (SCN),Y
    STA R1+0
    INY
    LDA (SCN),Y
    STA R1+1
    INY
    LDA (SCN),Y
    STA R1+2
    INY
    LDA (SCN),Y
    STA R1+3
    INY
    LDA (SCN),Y
    STA R1+4
    INY
    LDA (SCN),Y
    STA R1+5
    INY
    LDA (SCN),Y
    STA R1+6
    INY
    LDA (SCN),Y
    STA R1+7
    LDY REGY
}

!ZONE DRW_SPR
!MACRO DRW_SPR R1 {
 LDX HPIX

 LDY SPR_ORA_TAB_HI,X 
 STY .SPR_ORA_00 +2
 STY .SPR_ORA_01 +2
 STY .SPR_ORA_02 +2
 STY .SPR_ORA_03 +2
 STY .SPR_ORA_04 +2
 STY .SPR_ORA_05 +2
 STY .SPR_ORA_06 +2
 STY .SPR_ORA_07 +2
 STY .SPR_ORA_08 +2
 STY .SPR_ORA_09 +2
 STY .SPR_ORA_10 +2
 STY .SPR_ORA_11 +2
 STY .SPR_ORA_12 +2
 STY .SPR_ORA_13 +2
 STY .SPR_ORA_14 +2
 STY .SPR_ORA_15 +2

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
 INY
 STY .SPR_ORA_08 +1
 INY
 STY .SPR_ORA_09 +1
 INY
 STY .SPR_ORA_10 +1
 INY
 STY .SPR_ORA_11 +1
 INY
 STY .SPR_ORA_12 +1
 INY
 STY .SPR_ORA_13 +1
 INY
 STY .SPR_ORA_14 +1
 INY
 STY .SPR_ORA_15 +1

 LDX #32
 LDY VPIX
; SEC ; not needed?

.LOOP
            LDA R1+00,Y ; Y IS SET BETWEEN 0 AND 7 AND sub 24 each loop ?
.SPR_ORA_00 ORA $ABCD,X
            STA R1+00,Y

            LDA R1+01,Y
.SPR_ORA_01 ORA $ABCD,X
            STA R1+01,Y

            LDA R1+02,Y
.SPR_ORA_02 ORA $ABCD,X
            STA R1+02,Y

            LDA R1+03,Y
.SPR_ORA_03 ORA $ABCD,X
            STA R1+03,Y

            LDA R1+04,Y
.SPR_ORA_04 ORA $ABCD,X
            STA R1+04,Y

            LDA R1+05,Y
.SPR_ORA_05 ORA $ABCD,X
            STA R1+05,Y

            LDA R1+06,Y
.SPR_ORA_06 ORA $ABCD,X
            STA R1+06,Y

            LDA R1+07,Y
.SPR_ORA_07 ORA $ABCD,X
            STA R1+07,Y

            LDA R1+08,Y
.SPR_ORA_08 ORA $ABCD,X
            STA R1+08,Y

            LDA R1+09,Y
.SPR_ORA_09 ORA $ABCD,X
            STA R1+09,Y

            LDA R1+10,Y
.SPR_ORA_10 ORA $ABCD,X
            STA R1+10,Y

            LDA R1+11,Y
.SPR_ORA_11 ORA $ABCD,X
            STA R1+11,Y

            LDA R1+12,Y
.SPR_ORA_12 ORA $ABCD,X
            STA R1+12,Y

            LDA R1+13,Y
.SPR_ORA_13 ORA $ABCD,X
            STA R1+13,Y

            LDA R1+14,Y
.SPR_ORA_14 ORA $ABCD,X
            STA R1+14,Y

            LDA R1+15,Y
.SPR_ORA_15 ORA $ABCD,X
            STA R1+15,Y

    LDA #255
    SBX #16
    BMI .EXIT

   TYA
   SBC #24 ; next screen line to the left
   TAY
   JMP .LOOP

.EXIT
}

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
  LDA   #%00011000 ; $10
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

 LDA #0 ; screen
 LDX #<VIC_SCN
 LDY #>VIC_SCN
 STX MEM_TO+0
 STY MEM_TO+1
 LDX #>1000 
 LDY #<1000
 JSR MEMSET

 LDA #0 ; screen
 LDX #<BB_SCN
 LDY #>BB_SCN
 STX MEM_TO+0
 STY MEM_TO+1
 LDX #>1000 
 LDY #<1000
 JSR MEMSET
 
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

 lda #0 ; %11000110
 sta VIC_CHAR_SET +0
 sta VIC_CHAR_SET +1
 sta VIC_CHAR_SET +2
 sta VIC_CHAR_SET +3
 sta VIC_CHAR_SET +4
 sta VIC_CHAR_SET +5
 sta VIC_CHAR_SET +6
 sta VIC_CHAR_SET +7

 LDA #1 ; 1; 7 ; 0 ; -1
 STA SPR_CNT
 
  CLI ; enable maskable interrupts again

  JMP MLOOP

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

;!align 255, 0
!ZONE MP_IRQ
MP_IRQ    INC   $D019    ;VIC Interrupt Request Register (IRR)
          STA   .REG_A+1
          STX   .REG_X+1
          STY   .REG_Y+1

; clear sprites - read through all sprites and copy 9 sprite chars from temp screen to viv screen

 DEC BORDER
  JSR   JOYSTICK2
 DEC BORDER
  JSR   MOVE_PLAYER ; move sprite
  
 JSR CLEAR_SPRITES
 INC BORDER

  LDX PLAYER_V
  LDY PLAYER_H
  STX SPR_PXL_V
  STY SPR_PXL_H
 
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

  TXA
  ASL
  STA .JMP+1

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
  LDA VIC_SCN_HI+2,Y
  STA SN_V2H0HI
  ADC #4
  STA BB_V2H0HI

  LDA VIC_SCN_LO,Y
  STA SN_V0H0LO
  STA BB_V0H0LO
;  CLC ; not needed due to adc above?
  ADC #40
  STA SN_V1H0LO
  STA BB_V1H0LO
  CLC
  ADC #40
  STA SN_V2H0LO
  STA BB_V2H0LO

  LDY SPR_CHR_H,X
  LDA (BB_V0H0LO),Y ; get back buffer
  STA (SN_V0H0LO),Y ; put screen
  LDA (BB_V1H0LO),Y
  STA (SN_V1H0LO),Y
  LDA (BB_V2H0LO),Y
  STA (SN_V2H0LO),Y

  INY
  LDA (BB_V0H0LO),Y
  STA (SN_V0H0LO),Y
  LDA (BB_V1H0LO),Y
  STA (SN_V1H0LO),Y
  LDA (BB_V2H0LO),Y
  STA (SN_V2H0LO),Y

  INY
  LDA (BB_V0H0LO),Y
  STA (SN_V0H0LO),Y
  LDA (BB_V1H0LO),Y
  STA (SN_V1H0LO),Y
  LDA (BB_V2H0LO),Y
  STA (SN_V2H0LO),Y

  LDA #0
.JMP JMP (SPR_CLR_TAB)
;  LDX REGX

CLR_SPR_02
CLR_SPR_03
CLR_SPR_04
CLR_SPR_05
CLR_SPR_06
CLR_SPR_07
CLR_SPR_00
;  +CLR_CHR_2 SPR_00_00_CHR_242

  +CLR_CHR SPR_00_00_CHR_242
  +CLR_CHR SPR_00_00_CHR_242
  +CLR_CHR SPR_00_10_CHR_243
  +CLR_CHR SPR_00_20_CHR_244
  +CLR_CHR SPR_00_01_CHR_245
  +CLR_CHR SPR_00_11_CHR_246
  +CLR_CHR SPR_00_21_CHR_247
  +CLR_CHR SPR_00_02_CHR_248
  +CLR_CHR SPR_00_12_CHR_249
  +CLR_CHR SPR_00_22_CHR_250
  RTS

CLR_SPR_01
;  +CLR_CHR_2 SPR_00_00_CHR_233
  +CLR_CHR SPR_00_00_CHR_233
  +CLR_CHR SPR_00_10_CHR_234
  +CLR_CHR SPR_00_20_CHR_235
  +CLR_CHR SPR_00_01_CHR_236
  +CLR_CHR SPR_00_11_CHR_237
  +CLR_CHR SPR_00_21_CHR_238
  +CLR_CHR SPR_00_02_CHR_239
  +CLR_CHR SPR_00_12_CHR_240
  +CLR_CHR SPR_00_22_CHR_241
  RTS

!ZONE DRAW_SPRITES
DRAW_SPRITES
      LAX SPR_CNT
      BMI .EXIT
.LOOP   JSR DRAW_SPRITE
        DEX
        BPL .LOOP
.EXIT RTS

; pass in v / h / sprite number to be used (0-12?) / sprite number to be drawn (0-255)
; get sprite x and y
; convert to char pos
; store in v and h char pos to be cleared
; get 9 chars from screen
; store in 9 chars for sprite
; 9 chars allocated for this sprite
; put them on screen

!ZONE DRAW_SPRITE
DRAW_SPRITE
; x=sprnum (0-12)

  STX REGX
  TXA
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
  LDA VIC_SCN_HI+2,X
  STA SN_V2H0HI

  LDA VIC_SCN_LO,X
  STA SN_V0H0LO
;  CLC ; not needed due to asl above?
  ADC #40
  STA SN_V1H0LO
  CLC
  ADC #40
  STA SN_V2H0LO

  LDY REGX
  LDX SPR_PXL_H,Y
  LDA H_PIXEL,X
  STA HPIX
  LDA H_CHAR,X
  STA SPR_CHR_H,Y
  TAY

.JMP JMP (SPR_DRW_TAB)


DRW_SPR_02
DRW_SPR_03
DRW_SPR_04
DRW_SPR_05
DRW_SPR_06
DRW_SPR_07
; RTS
  
!ZONE DRW_SPR_00
DRW_SPR_00

 DEC BORDER

  LAX (SN_V0H0LO),Y ; put screen
  BEQ .EMPTY_00
    +DRW_CHR SPR_00_00_CHR_242
.EMPTY_00:
  LDA #242
  STA (SN_V0H0LO),Y

  LAX (SN_V1H0LO),Y
  BEQ .EMPTY_10
    +DRW_CHR SPR_00_10_CHR_243
.EMPTY_10:
  LDA #243
  STA (SN_V1H0LO),Y

  LAX (SN_V2H0LO),Y
  BEQ .EMPTY_20
    +DRW_CHR SPR_00_20_CHR_244
.EMPTY_20:
  LDA #244
  STA (SN_V2H0LO),Y

  INY
  LAX (SN_V0H0LO),Y
  BEQ .EMPTY_01
    +DRW_CHR SPR_00_01_CHR_245
.EMPTY_01:
  LDA #245
  STA (SN_V0H0LO),Y

  LAX (SN_V1H0LO),Y
  BEQ .EMPTY_11
    +DRW_CHR SPR_00_11_CHR_246
.EMPTY_11:
  LDA #246
  STA (SN_V1H0LO),Y

  LAX (SN_V2H0LO),Y
  BEQ .EMPTY_21
    +DRW_CHR SPR_00_21_CHR_247
.EMPTY_21:
  LDA #247
  STA (SN_V2H0LO),Y

  INY 
  LAX (SN_V0H0LO),Y
  BEQ .EMPTY_02
    +DRW_CHR SPR_00_02_CHR_248
.EMPTY_02:
  LDA #248
  STA (SN_V0H0LO),Y

  LAX (SN_V1H0LO),Y
  BEQ .EMPTY_12
    +DRW_CHR SPR_00_12_CHR_249
.EMPTY_12:
  LDA #249
  STA (SN_V1H0LO),Y

  LAX (SN_V2H0LO),Y
  BEQ .EMPTY_22
    +DRW_CHR SPR_00_22_CHR_250
.EMPTY_22:
  LDA #250
  STA (SN_V2H0LO),Y

  +DRW_SPR SPR_00_00_CHR_242

 INC BORDER
  
  LAX REGX
  RTS

!ZONE DRW_SPR_01
DRW_SPR_01

 DEC BORDER

  LAX (SN_V0H0LO),Y ; put screen
  BEQ .EMPTY_00
    +DRW_CHR SPR_00_00_CHR_233
.EMPTY_00:
  LDA #233
  STA (SN_V0H0LO),Y

  LAX (SN_V1H0LO),Y
  BEQ .EMPTY_10
    +DRW_CHR SPR_00_10_CHR_234
.EMPTY_10:
  LDA #234
  STA (SN_V1H0LO),Y

  LAX (SN_V2H0LO),Y
  BEQ .EMPTY_20
    +DRW_CHR SPR_00_20_CHR_235
.EMPTY_20:
  LDA #235
  STA (SN_V2H0LO),Y

  INY
  LAX (SN_V0H0LO),Y
  BEQ .EMPTY_01
    +DRW_CHR SPR_00_01_CHR_236
.EMPTY_01:
  LDA #236
  STA (SN_V0H0LO),Y

  LAX (SN_V1H0LO),Y
  BEQ .EMPTY_11
    +DRW_CHR SPR_00_11_CHR_237
.EMPTY_11:
  LDA #237
  STA (SN_V1H0LO),Y

  LAX (SN_V2H0LO),Y
  BEQ .EMPTY_21
    +DRW_CHR SPR_00_21_CHR_238
.EMPTY_21:
  LDA #238
  STA (SN_V2H0LO),Y

  INY 
  LAX (SN_V0H0LO),Y
  BEQ .EMPTY_02
    +DRW_CHR SPR_00_02_CHR_239
.EMPTY_02:
  LDA #239
  STA (SN_V0H0LO),Y

  LAX (SN_V1H0LO),Y
  BEQ .EMPTY_12
    +DRW_CHR SPR_00_12_CHR_240
.EMPTY_12:
  LDA #240
  STA (SN_V1H0LO),Y

  LAX (SN_V2H0LO),Y
  BEQ .EMPTY_22
    +DRW_CHR SPR_00_22_CHR_241
.EMPTY_22:
  LDA #241
  STA (SN_V2H0LO),Y

  +DRW_SPR SPR_00_00_CHR_233

 INC BORDER
  
  LAX REGX
  RTS

!ZONE JOYSTICK
JOYSTICK1 LDA $DC01     ; PORT 1
          BVC .JOYSTICK
JOYSTICK2 LDA $DC00     ; PORT 2
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
    BVC   .VER
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
        DEX
        BPL .SCN
      RTS

FILL_CHARS
      LDX #0
.LOOP   TXA
        PHA
        JSR FILL_CHAR
        PLA
        TAX
        DEX
        BNE .LOOP
      RTS

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

!align 255,0
VIC_CHAR_TAB_HI
!for I = 0 TO 255
!BYTE >(VIC_CHAR_SET+(I*8))
!end
  
VIC_CHAR_TAB_LO
!for I = 0 TO 255
!BYTE <(VIC_CHAR_SET+(I*8))
!end

V_PIXEL:
!for I = 0 TO 24
!BYTE 0+48,1+48,2+48,3+48,4+48,5+48,6+48,7+48
!end

!align 255,0
SPR_DRW_TAB !WORD DRW_SPR_00,DRW_SPR_01,DRW_SPR_02,DRW_SPR_03,DRW_SPR_04,DRW_SPR_05,DRW_SPR_06,DRW_SPR_07

H_PIXEL:
!for I = 0 TO 39
!BYTE 0,1,2,3
!end

!align 255,0
SPR_CLR_TAB !WORD CLR_SPR_00,CLR_SPR_01,CLR_SPR_02,CLR_SPR_03,CLR_SPR_04,CLR_SPR_05,CLR_SPR_06,CLR_SPR_07

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

SPR_00_00_CHR_242 = VIC_CHAR_SET + (242*8)
SPR_00_10_CHR_243 = SPR_00_00_CHR_242 +8
SPR_00_20_CHR_244 = SPR_00_10_CHR_243 +8
SPR_00_01_CHR_245 = SPR_00_20_CHR_244 +8
SPR_00_11_CHR_246 = SPR_00_01_CHR_245 +8
SPR_00_21_CHR_247 = SPR_00_11_CHR_246 +8
SPR_00_02_CHR_248 = SPR_00_21_CHR_247 +8
SPR_00_12_CHR_249 = SPR_00_02_CHR_248 +8
SPR_00_22_CHR_250 = SPR_00_12_CHR_249 +8

SPR_00_00_CHR_233 = VIC_CHAR_SET + (233*8)
SPR_00_10_CHR_234 = SPR_00_00_CHR_233 +8
SPR_00_20_CHR_235 = SPR_00_10_CHR_234 +8
SPR_00_01_CHR_236 = SPR_00_20_CHR_235 +8
SPR_00_11_CHR_237 = SPR_00_01_CHR_236 +8
SPR_00_21_CHR_238 = SPR_00_11_CHR_237 +8
SPR_00_02_CHR_239 = SPR_00_21_CHR_238 +8
SPR_00_12_CHR_240 = SPR_00_02_CHR_239 +8
SPR_00_22_CHR_241 = SPR_00_12_CHR_240 +8

SPR_ORA_TAB_LO !BYTE <SPR_ORA_000_00,<SPR_ORA_000_01,<SPR_ORA_000_02,<SPR_ORA_000_03
SPR_ORA_TAB_HI !BYTE >SPR_ORA_000_00,>SPR_ORA_000_01,>SPR_ORA_000_02,>SPR_ORA_000_03

VIC_SCN_HI
!for I = 0 TO 24
!BYTE >(VIC_SCN+(I*40))
!end

VIC_SCN_LO
!for I = 0 TO 24
!BYTE <(VIC_SCN+(I*40))
!end

;BB_SCN_HI
;!for I = 0 TO 24
;!BYTE >(BB_SCN+(I*40))
;!end

;BB_SCN_LO
;!for I = 0 TO 24
;!BYTE <(BB_SCN+(I*40))
;!end

SPR_PXL_V !BYTE 0,100,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; pixel pos
SPR_PXL_H !BYTE 0,100,0,0,0,0,0,0,0,0,0,0,0,0,0,0
SPR_CHR_V !BYTE 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; char pos
SPR_CHR_H !BYTE 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

!align 127,0
SPR_ORA_000_00:
!for I = 0 TO 15
!BYTE %11111111
!end
!for I = 0 TO 15
!BYTE %11111111
!end
!for I = 0 TO 15
!BYTE %00000000
!end

SPR_ORA_000_01:
!for I = 0 TO 15
!BYTE %00111111
!end
!for I = 0 TO 15
!BYTE %11111111
!end
!for I = 0 TO 15
!BYTE %11000000
!end

SPR_ORA_000_02:
!for I = 0 TO 15
;!BYTE %00001111,%11111111,%11110000
!BYTE %00001111
!end
!for I = 0 TO 15
!BYTE %11111111
!end
!for I = 0 TO 15
!BYTE %11110000
!end

SPR_ORA_000_03:
!for I = 0 TO 15
;!BYTE %00000011,%11111111,%11111100
!BYTE %00000011
!end
!for I = 0 TO 15
!BYTE %11111111
!end
!for I = 0 TO 15
!BYTE %11111100
!end
