; uses vic bank 49152-65535

; 63k to 64k = unavailable
; 62.5k to 63k = hw sprites for screen 2
; 62k to 62.5k = hw sprites for screen 1
; 60k to 62k = charset
; 59k to 60k = screen 2
; 58k to 59k = screen 1
; sprite screen 1 = 224
; spries screen 2 = 232

*= 2049
!byte $0c,$08,$0a,$00,$9e   ; Line 10 SYS
!tx "2070"            ; Address for sys start in text 4096+11

MEM_FROM = SPR00
MEM_TO = SPR01
MEM_SIZE_LO = SPR02
MEM_SIZE_HI = SPR02+ 1

SPR00 = 2
SPR01 = SPR00 +2
SPR02 = SPR01 +2
SPR03 = SPR02 +2
SPR04 = SPR03 +2
SPR05 = SPR04 +2
SPR06 = SPR05 +2
SPR07 = SPR06 +2
SPR08 = SPR07 +2
SPR09 = SPR08 +2
SPR10 = SPR09 +2
SPR11 = SPR10 +2
SPR12 = SPR11 +2
SPR13 = SPR12 +2
SPR14 = SPR13 +2
SPR15 = SPR14 +2

FRAME = SPR15 +2
REGA = FRAME +1
REGX = REGA +1
REGY = REGX +1
MAP_H_START_POS_FIRST_LINE = REGY +1
MAP_H_START_POS_SECOND_LINE = MAP_H_START_POS_FIRST_LINE +1
MAP_V_OLD = MAP_H_START_POS_SECOND_LINE +1
MAP_H_OLD = MAP_V_OLD +1
SCROLL_V = MAP_H_OLD +1
SCROLL_H = SCROLL_V +1

PLAYER_H_LO = SCROLL_H +1
PLAYER_H_HI = PLAYER_H_LO +1
PLAYER_V_LO = PLAYER_H_HI +1
PLAYER_V_HI = PLAYER_V_LO +1
PIXEL_H = PLAYER_V_HI +1
CHAR_H = PIXEL_H +1
PIXEL_V = CHAR_H +1
CHAR_V = PIXEL_V +1
PREV_PIXEL_H = CHAR_V +1
PREV_PIXEL_V = PREV_PIXEL_H +1

STACK = 255

BORDER = $D020
SCRCOL0 = $D021
SCRCOL1 = $D022
SCRCOL2 = $D023
SCRCOL3 = $D024
SPRCOL1 = $D025
SPRCOL2 = $D026

SPRENBL = 53248+21
SPRXPX = 53248+29 
SPRXPY = 53248+23

S0X = 53248+0
S0Y = 53248+1
S0C = $D027
HW_SPRITE_0_SCN1 = HWSPRITE_SCREEN1
HW_SPRITE_0_SCN2 = HWSPRITE_SCREEN2

S1X = 53248+2
S1Y = 53248+3
S1C = $D028
HW_SPRITE_1_SCN1 = HW_SPRITE_0_SCN1 +64
HW_SPRITE_1_SCN2 = HW_SPRITE_0_SCN2 +64

S2X = 53248+4
S2Y = 53248+5
S2C = $D029
HW_SPRITE_2_SCN1 = HW_SPRITE_1_SCN1 +64
HW_SPRITE_2_SCN2 = HW_SPRITE_1_SCN2 +64

S3X = 53248+6
S3Y = 53248+7
S3C = $D02A
HW_SPRITE_3_SCN1 = HW_SPRITE_2_SCN1 +64
HW_SPRITE_3_SCN2 = HW_SPRITE_2_SCN2 +64

S4X = 53248+8
S4Y = 53248+9
S4C = $D02B
HW_SPRITE_4_SCN1 = HW_SPRITE_3_SCN1 +64
HW_SPRITE_4_SCN2 = HW_SPRITE_3_SCN2 +64

S5X = 53248+10
S5Y = 53248+11
S5C = $D02C
HW_SPRITE_5_SCN1 = HW_SPRITE_4_SCN1 +64
HW_SPRITE_5_SCN2 = HW_SPRITE_4_SCN2 +64

S6X = 53248+12
S6Y = 53248+13
S6C = $D02D
HW_SPRITE_6_SCN1 = HW_SPRITE_5_SCN1 +64
HW_SPRITE_6_SCN2 = HW_SPRITE_5_SCN2 +64

S7X = 53248+14
S7Y = 53248+15
S7C = $D02E
HW_SPRITE_7_SCN1 = HW_SPRITE_6_SCN1 +64
HW_SPRITE_7_SCN2 = HW_SPRITE_6_SCN2 +64

SPRXMSB = 53248+16

MP_RASTER_POS = 246-6
IRQ_042 = 84
IRQ_042 = 140

VIC_BANK = 49152
HWSPRITE_SCREEN1 = (62*1024)
HWSPRITE_SCREEN2 = (62*1024)+512
VIC_SCN1 = 58*1024
VIC_CHAR_SET = 60*1024
VIC_SCN2 = 59*1024

MAP_ADR = 32768 ; 49152
MAP_LEN = 128

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

  LDA   #$10
  STA   $D011 ; #7: Read: Current raster line (bit #8) / #6: 1 = Extended background mode on / #5: 0 = Text mode; 1 = Bitmap mode / #4: 0 = Screen off, complete screen is covered by border; 1 = Screen on, normal screen contents are visible / #3: Screen height; 0 = 24 rows; 1 = 25 rows / #0-#2: Vertical raster scroll.
  LDA   #$10
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
  LDA #2
  STA SCRCOL1
  LDA #3
  STA SCRCOL2

  LDA #4
  STA SPRCOL1
  LDA #5
  STA SPRCOL2

  LDA #255
  STA SPRENBL
  LDA #0
  STA SPRXPX
  STA SPRXPY

  LDA #60
  STA S0X
  STA S0Y
 
  LDA #85
  STA S1X
  STA S1Y

  LDA #110
  STA S2X
  STA S2Y

  LDA #135
  STA S3X
  STA S3Y

  LDA #160
  STA S4X
  STA S4Y

  LDA #185
  STA S5X
  STA S5Y

  LDA #210
  STA S6X
  STA S6Y

  LDA #225
  STA S7X
  STA S7Y
  
  LDX #0
  STX S0C
  INX
  STX S1C
  INX
  STX S2C
  INX
  STX S3C
  INX
  STX S4C
  INX
  STX S5C
  INX
  STX S6C
  INX
  STX S7C
  
;  LDA #50
;  STA MAP_V
;  LDA #50
;  STA MAP_H

  LDA #1
  STA PLAYER_H_LO
  STA PLAYER_H_HI
  STA PLAYER_V_LO
  STA PLAYER_V_HI
  
; setup both sets of sprites definition pointers for screen1 and screen2  
 LDX #224
 STX VIC_SCN1+1016
 INX
 STX VIC_SCN1+1017
 INX
 STX VIC_SCN1+1018
 INX
 STX VIC_SCN1+1019
 INX
 STX VIC_SCN1+1020
 INX
 STX VIC_SCN1+1021
 INX
 STX VIC_SCN1+1022
 INX
 STX VIC_SCN1+1023

 LDA #5 ; colour 11
 LDX #<$D800
 LDY #>$D800
 STX SPR00+0
 STY SPR00+1
 LDX #>1000 
 LDY #<1000
 JSR MEMSET

 LDA #2 ; screen1
 LDX #<VIC_SCN1
 LDY #>VIC_SCN1
 STX SPR00+0
 STY SPR00+1
 LDX #>1000 
 LDY #<1000
; JSR MEMSET

 LDA #2 ; screen2
 LDX #<VIC_SCN2
 LDY #>VIC_SCN2
 STX SPR00+0
 STY SPR00+1
 LDX #>1000 
 LDY #<1000
; JSR MEMSET

 LDA #3 ; charset
 LDX #<VIC_CHAR_SET
 LDY #>VIC_CHAR_SET
 STX SPR00+0
 STY SPR00+1
 LDX #>2048 
 LDY #<2048
; JSR MEMSET

 LDA #0 ; sprites
 LDX #<HW_SPRITE_0_SCN1
 LDY #>HW_SPRITE_0_SCN1
 STX SPR00+0
 STY SPR00+1
 LDX #>1024 
 LDY #<1024
 JSR MEMSET

  LDX #<2
  LDY #>2
  STX MEM_FROM+0
  STY MEM_FROM+1
  LDX #<MAP_ADR
  LDY #>MAP_ADR
  STX MEM_TO+0
  STY MEM_TO+1
  LDY #<8191
  LDX #>8191
  JSR MEMCPY
  LDX #<2
  LDY #>2
  STX MEM_FROM+0
  STY MEM_FROM+1
  LDX #<(MAP_ADR+8192)
  LDY #>(MAP_ADR+8192)
  STX MEM_TO+0
  STY MEM_TO+1
  LDY #<8191
  LDX #>8191
  JSR MEMCPY

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
  JSR MEMCPY

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
.LSB_LOOP      STA    (SPR00),Y   ; clear whole MSB
               DEY 
               BNE    .LSB_LOOP

              INC    SPR00+1      ; inc MSB
              DEX               ; dec MSB count
              BNE    .MSB_LOOP

.LSB_ONLY    LDY    #0          ; LSB count 
             BEQ    .MS_END     ; not needed

.LAST_LSB_LOOP STA   (SPR00),Y
               DEY 
               BNE   .LAST_LSB_LOOP
                
              STA   (SPR00),Y     ; clear last Y (0)
 
.MS_END      RTS

MLOOP:  JMP   MLOOP ; we better don't RTS, the ROMS are now switched off, there's no way back to the system

;!align 255, 0
!ZONE MP_IRQ
MP_IRQ    INC   $D019    ;VIC Interrupt Request Register (IRR)
          STA   .REG_A+1
          STX   .REG_X+1
          STY   .REG_Y+1
      INC FRAME
 DEC BORDER
  JSR   JOYSTICK2
 DEC BORDER
  JSR   MOVE_PLAYER
  DEC BORDER
  JSR   CALC_MAP_POS
 DEC BORDER
  JSR SPRITES
 DEC BORDER
  JSR BUILD_MAP

; DEC BORDER
;  JSR   JOYSTICK2
; DEC BORDER
;  JSR   MOVE_PLAYER
;  DEC BORDER
;  JSR   CALC_MAP_POS
  
 INC BORDER
 INC BORDER
 INC BORDER
 INC BORDER
 INC BORDER
  
.REG_A     LDA   #0
.REG_X     LDX   #0
.REG_Y     LDY   #0
NMI_NOP:  RTI ; This is the irq handler for the NMI. Just returns without acknowledge. This prevents subsequent NMI's from interfering.

!ZONE CALC_SCROLL_H 
!MACRO CALC_SCROLL_H HI, LO, CHAR, PIXEL {
  LAX   LO      ; 3 
  EOR   #$FF
  AND   #$07    ; 2
  ORA   #$10    ; 2
  STA   PIXEL   ; 3
  LDA   HI      ; 3
  LSR           ; 2
  STA   CHAR    ; 3 temp
  TXA           ; 2
  ROR           ; 2
  LSR   CHAR    ; 5 temp
  ROR           ; 2
  LSR           ; 2
  STA   CHAR    ; 3
}

!ZONE CALC_SCROLL_V 
!MACRO CALC_SCROLL_V HI, LO, CHAR, PIXEL {
  LAX   LO      ; 3 
  EOR   #$FF
  AND   #$07    ; 2
  ORA   #$10    ; 2
  STA   PIXEL   ; 3
  LDA   HI      ; 3
  LSR           ; 2
  STA   CHAR    ; 3 temp
  TXA           ; 2
  ROR           ; 2
  LSR   CHAR    ; 5 temp
  ROR           ; 2
  LSR           ; 2
  STA   CHAR    ; 3
}

!ZONE CALC_MAP_POS
CALC_MAP_POS
  +CALC_SCROLL_H PLAYER_H_HI, PLAYER_H_LO, CHAR_H, PIXEL_H
  +CALC_SCROLL_V PLAYER_V_HI, PLAYER_V_LO, CHAR_V, PIXEL_V
  RTS
  
!ZONE JOYSTICK
JOYSTICK1 LDA $DC01     ; PORT 1
          JMP .JOYSTICK
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
.LEFT   LDA   PLAYER_H_LO
    BNE   .L_TST
      DEC   PLAYER_H_HI
.L_TST  DEC   PLAYER_H_LO
    JMP   .VER
.RIGHT  INC   PLAYER_H_LO
    BNE   .VER
      INC   PLAYER_H_HI
.VER    TYA
    BEQ   .EXIT
    BPL   .DOWN
.UP     LDA   PLAYER_V_LO
    BNE   .U_TST
      DEC   PLAYER_V_HI
.U_TST  DEC   PLAYER_V_LO
    RTS
.DOWN   INC   PLAYER_V_LO
    BNE   .EXIT
      INC   PLAYER_V_HI
.EXIT   RTS
    
;!align 255, 0
;--------------------------------------
!ZONE MOVE_TEST
  rts

; set scroll registers

; lda map_h_hi
; lsr
; sta map_h         ; scroll h pos (0-127)
; lda map_h_lo

;;; ror
;;; tax
;;; lda map_scrl_h_d011,x ; H scroll register ( 32*111 / 32*110 / 32*101 / 32*100 / 32*011 / 32*010 / 32*001 / 32*000 )

;;; rol
;;; rol
;;; rol
;;; and #$07
;;; ora #$10

; sta map_h_scl_reg ; scroll register value




; lda map_v_hi
; lsr
; sta map_v         ; scroll v pos (0-127)
; lda map_v_lo

;;; ror
;;; tax
;;; lda map_scrl_v_d016,x ; V scroll register ( 32*111 / 32*110 / 32*101 / 32*100 / 32*011 / 32*010 / 32*001 / 32*000 )

;;; rol
;;; rol
;;; rol
;;; and #$07
;;; ora #$10

; sta map_v_scl_reg ; scroll register value

!ZONE BUILD_MAP
BUILD_MAP
; setup scroll pointers - for next screen to be shown
 inc BORDER

 LDX PREV_PIXEL_H
 LDY PREV_PIXEL_V
 STX $D016
 STY $D011
 LDX PIXEL_H
 LDY PIXEL_V
 STX PREV_PIXEL_H
 STY PREV_PIXEL_V
 
 dec BORDER
 
  LDY CHAR_H         ; GET MAP CHAR POS H
  LDA FRAME
  LSR
  BCC MAP01
  JMP MAP02
  
!ZONE MAP01
MAP01

; setup screen pointers - for next screen to be shown - screen2
;  LDA #%10101100 ; screen = $2800 + 48k = 58k / char = $3000 + 48k = 60k
;  STA $D018
  LDA #%10111100 ; screen = $2C00 + 48k = 59k / char = $3000 + 48k = 60k
  STA $D018

; draw on other screen - screen1

;  LDY MAP_H         ; GET MAP CHAR POS H
  LAX CHAR_V         ; GET MAP CHAR POS V
  LSR               ; MOVE LSB INTO CARRY
  LDA NUMBERS-19,Y      ; GET LEFT (-19) - BETWEEN 0 AND 127  
  LDY NUMBERS-12,X      ; GET TOP (-12) - BETWEEN 0 AND 127 
  LDX MAP_HI,Y        ; GET MAP V START POS

  BCS .MAP_ODD_LINE     ; POPULATE MAP STARTING FROM EVEN LINE (12*2 EVEN LINES THEN 1 ODD LINE)

.MAP_EVEN_LINE          ; POPULATE MAP STARTING FROM ODD LINE (1 ODD LINE THEN 12*23 EVEN LINES)
;  LDA NUMBERS-12,Y      ; GET LEFT (-12) - BETWEEN 0 AND 127 
  STA MAP_H_START_POS_FIRST_LINE  ; BACKUP HOR START POS (H POS + 0)
  EOR #128
  STA MAP_H_START_POS_SECOND_LINE ; BACKUP HOR START POS FOR NEXT LINE

;  LDY NUMBERS-12,X      ; GET TOP (-12) - BETWEEN 0 AND 127 
;  LDX MAP_HI,Y        ; GET MAP V START POS

    STX .MAP_SCN_01+2
    STX .MAP_SCN_02+2
  INX
    STX .MAP_SCN_03+2
    STX .MAP_SCN_04+2
  INX
    STX .MAP_SCN_05+2
    STX .MAP_SCN_06+2
  INX
    STX .MAP_SCN_07+2
    STX .MAP_SCN_08+2
  INX
    STX .MAP_SCN_09+2
    STX .MAP_SCN_10+2
  INX
    STX .MAP_SCN_11+2
    STX .MAP_SCN_12+2
  INX
    STX .MAP_SCN_13+2
    STX .MAP_SCN_14+2
  INX
    STX .MAP_SCN_15+2
    STX .MAP_SCN_16+2
  INX
    STX .MAP_SCN_17+2
    STX .MAP_SCN_18+2
  INX
    STX .MAP_SCN_19+2
    STX .MAP_SCN_20+2
  INX
    STX .MAP_SCN_21+2
    STX .MAP_SCN_22+2
  INX
    STX .MAP_SCN_23+2
    STX .MAP_SCN_24+2
  INX
    STX .MAP_SCN_25+2
  BVC .CONT ; JMP

.MAP_ODD_LINE         ; POPULATE MAP STARTING FROM EVEN LINE (12*2 EVEN LINES THEN 1 ODD LINE)
;  LDA NUMBERS-12,Y      ; GET LEFT (-12) - BETWEEN 0 AND 127
  STA MAP_H_START_POS_SECOND_LINE  ; BACKUP HOR START POS (128+H POS)
  EOR #128
  STA MAP_H_START_POS_FIRST_LINE ; BACKUP HOR START POS FOR NEXT LINE
  
;  LDY NUMBERS-12,X      ; GET TOP (-12) - BETWEEN 0 AND 127 
;  LDX MAP_HI,Y        ; GET MAP V START POS

    STX .MAP_SCN_01+2
  INX
    STX .MAP_SCN_02+2
    STX .MAP_SCN_03+2
  INX
    STX .MAP_SCN_04+2
    STX .MAP_SCN_05+2
  INX
    STX .MAP_SCN_06+2
    STX .MAP_SCN_07+2
  INX
    STX .MAP_SCN_08+2
    STX .MAP_SCN_09+2
  INX
    STX .MAP_SCN_10+2
    STX .MAP_SCN_11+2
  INX
    STX .MAP_SCN_12+2
    STX .MAP_SCN_13+2
  INX
    STX .MAP_SCN_14+2
    STX .MAP_SCN_15+2
  INX
    STX .MAP_SCN_16+2
    STX .MAP_SCN_17+2
  INX
    STX .MAP_SCN_18+2
    STX .MAP_SCN_19+2
  INX
    STX .MAP_SCN_20+2
    STX .MAP_SCN_21+2
  INX
    STX .MAP_SCN_22+2
    STX .MAP_SCN_23+2
  INX
    STX .MAP_SCN_24+2
    STX .MAP_SCN_25+2

.CONT
  LDX MAP_H_START_POS_FIRST_LINE
  LDY MAP_H_START_POS_SECOND_LINE

    STX .MAP_SCN_01+1
    STY .MAP_SCN_02+1
    STX .MAP_SCN_03+1
    STY .MAP_SCN_04+1
    STX .MAP_SCN_05+1
    STY .MAP_SCN_06+1
    STX .MAP_SCN_07+1
    STY .MAP_SCN_08+1
    STX .MAP_SCN_09+1
    STY .MAP_SCN_10+1
    STX .MAP_SCN_11+1
    STY .MAP_SCN_12+1
    STX .MAP_SCN_13+1
    STY .MAP_SCN_14+1
    STX .MAP_SCN_15+1
    STY .MAP_SCN_16+1
    STX .MAP_SCN_17+1
    STY .MAP_SCN_18+1
    STX .MAP_SCN_19+1
    STY .MAP_SCN_20+1
    STX .MAP_SCN_21+1
    STY .MAP_SCN_22+1
    STX .MAP_SCN_23+1
    STY .MAP_SCN_24+1
    STX .MAP_SCN_25+1
          
          LDY #39
.LOOP
.MAP_SCN_01  LDA  $1111,Y
            STA  VIC_SCN1+(40*00),Y
.MAP_SCN_02  LDA  $2222,Y
            STA  VIC_SCN1+(40*01),Y
.MAP_SCN_03  LDA  $3333,Y
            STA  VIC_SCN1+(40*02),Y
.MAP_SCN_04  LDA  $4444,Y
            STA  VIC_SCN1+(40*03),Y
.MAP_SCN_05  LDA  $5555,Y
            STA  VIC_SCN1+(40*04),Y
.MAP_SCN_06  LDA  $6666,Y
            STA  VIC_SCN1+(40*05),Y
.MAP_SCN_07  LDA  $7777,Y
            STA  VIC_SCN1+(40*06),Y
.MAP_SCN_08  LDA  $8888,Y
            STA  VIC_SCN1+(40*07),Y
.MAP_SCN_09  LDA  $9999,Y
            STA  VIC_SCN1+(40*08),Y
.MAP_SCN_10  LDA  $AAAA,Y
            STA  VIC_SCN1+(40*09),Y
.MAP_SCN_11  LDA  $BBBB,Y
            STA  VIC_SCN1+(40*10),Y
.MAP_SCN_12  LDA  $CCCC,Y
            STA  VIC_SCN1+(40*11),Y
.MAP_SCN_13  LDA  $DDDD,Y
            STA  VIC_SCN1+(40*12),Y
.MAP_SCN_14  LDA  $EEEE,Y
            STA  VIC_SCN1+(40*13),Y
.MAP_SCN_15  LDA  $1111,Y
            STA  VIC_SCN1+(40*14),Y
.MAP_SCN_16  LDA  $2222,Y
            STA  VIC_SCN1+(40*15),Y
.MAP_SCN_17  LDA  $3333,Y
            STA  VIC_SCN1+(40*16),Y
.MAP_SCN_18  LDA  $4444,Y
            STA  VIC_SCN1+(40*17),Y
.MAP_SCN_19  LDA  $5555,Y
            STA  VIC_SCN1+(40*18),Y
.MAP_SCN_20  LDA  $6666,Y
            STA  VIC_SCN1+(40*19),Y
.MAP_SCN_21  LDA  $7777,Y
            STA  VIC_SCN1+(40*20),Y
.MAP_SCN_22  LDA  $8888,Y
            STA  VIC_SCN1+(40*21),Y
.MAP_SCN_23  LDA  $9999,Y
            STA  VIC_SCN1+(40*22),Y
.MAP_SCN_24  LDA  $AAAA,Y
            STA  VIC_SCN1+(40*23),Y
.MAP_SCN_25  LDA  $BBBB,Y
            STA  VIC_SCN1+(40*24),Y
          DEY
          BMI .EXIT ; SHOULD THIS BE BMI ?  
         JMP .LOOP
.EXIT  RTS

!ZONE MAP02
MAP02
; setup screen pointers - for next screen to be shown - screen1
;  LDA #%10111100 ; screen = $2C00 + 48k = 59k / char = $3000 + 48k = 60k
;  STA $D018
  LDA #%10101100 ; screen = $2800 + 48k = 58k / char = $3000 + 48k = 60k
  STA $D018

;  LDY MAP_H         ; GET MAP CHAR POS H
  LAX CHAR_V         ; GET MAP CHAR POS V
  LSR             ; MOVE MSB INTO CARRY
  LDA NUMBERS-19,Y      ; GET LEFT (-19) - BETWEEN 0 AND 127  
  LDY NUMBERS-12,X      ; GET TOP (-12) - BETWEEN 0 AND 127 
  LDX MAP_HI,Y        ; GET MAP V START POS

  BCS .MAP_ODD_LINE     ; POPULATE MAP STARTING FROM EVEN LINE (12*2 EVEN LINES THEN 1 ODD LINE)

.MAP_EVEN_LINE          ; POPULATE MAP STARTING FROM ODD LINE (1 ODD LINE THEN 12*23 EVEN LINES)
;  LDA NUMBERS-12,Y      ; GET LEFT (-12) - BETWEEN 0 AND 127 
  STA MAP_H_START_POS_FIRST_LINE  ; BACKUP HOR START POS (H POS + 0)
  EOR #128
  STA MAP_H_START_POS_SECOND_LINE ; BACKUP HOR START POS FOR NEXT LINE

;  LDY NUMBERS-12,X      ; GET TOP (-12) - BETWEEN 0 AND 127 
;  LDX MAP_HI,Y        ; GET MAP V START POS

    STX .MAP_SCN_01+2
    STX .MAP_SCN_02+2
  INX
    STX .MAP_SCN_03+2
    STX .MAP_SCN_04+2
  INX
    STX .MAP_SCN_05+2
    STX .MAP_SCN_06+2
  INX
    STX .MAP_SCN_07+2
    STX .MAP_SCN_08+2
  INX
    STX .MAP_SCN_09+2
    STX .MAP_SCN_10+2
  INX
    STX .MAP_SCN_11+2
    STX .MAP_SCN_12+2
  INX
    STX .MAP_SCN_13+2
    STX .MAP_SCN_14+2
  INX
    STX .MAP_SCN_15+2
    STX .MAP_SCN_16+2
  INX
    STX .MAP_SCN_17+2
    STX .MAP_SCN_18+2
  INX
    STX .MAP_SCN_19+2
    STX .MAP_SCN_20+2
  INX
    STX .MAP_SCN_21+2
    STX .MAP_SCN_22+2
  INX
    STX .MAP_SCN_23+2
    STX .MAP_SCN_24+2
  INX
    STX .MAP_SCN_25+2
  BVC .CONT ; JMP

.MAP_ODD_LINE         ; POPULATE MAP STARTING FROM EVEN LINE (12*2 EVEN LINES THEN 1 ODD LINE)
;  LDA NUMBERS-12,Y      ; GET LEFT (-12) - BETWEEN 0 AND 127
  STA MAP_H_START_POS_SECOND_LINE  ; BACKUP HOR START POS (128+H POS)
  EOR #128
  STA MAP_H_START_POS_FIRST_LINE ; BACKUP HOR START POS FOR NEXT LINE
  
;  LDY NUMBERS-12,X      ; GET TOP (-12) - BETWEEN 0 AND 127 
;  LDX MAP_HI,Y        ; GET MAP V START POS

    STX .MAP_SCN_01+2
  INX
    STX .MAP_SCN_02+2
    STX .MAP_SCN_03+2
  INX
    STX .MAP_SCN_04+2
    STX .MAP_SCN_05+2
  INX
    STX .MAP_SCN_06+2
    STX .MAP_SCN_07+2
  INX
    STX .MAP_SCN_08+2
    STX .MAP_SCN_09+2
  INX
    STX .MAP_SCN_10+2
    STX .MAP_SCN_11+2
  INX
    STX .MAP_SCN_12+2
    STX .MAP_SCN_13+2
  INX
    STX .MAP_SCN_14+2
    STX .MAP_SCN_15+2
  INX
    STX .MAP_SCN_16+2
    STX .MAP_SCN_17+2
  INX
    STX .MAP_SCN_18+2
    STX .MAP_SCN_19+2
  INX
    STX .MAP_SCN_20+2
    STX .MAP_SCN_21+2
  INX
    STX .MAP_SCN_22+2
    STX .MAP_SCN_23+2
  INX
    STX .MAP_SCN_24+2
    STX .MAP_SCN_25+2

.CONT
  LDX MAP_H_START_POS_FIRST_LINE
  LDY MAP_H_START_POS_SECOND_LINE

    STX .MAP_SCN_01+1
    STY .MAP_SCN_02+1
    STX .MAP_SCN_03+1
    STY .MAP_SCN_04+1
    STX .MAP_SCN_05+1
    STY .MAP_SCN_06+1
    STX .MAP_SCN_07+1
    STY .MAP_SCN_08+1
    STX .MAP_SCN_09+1
    STY .MAP_SCN_10+1
    STX .MAP_SCN_11+1
    STY .MAP_SCN_12+1
    STX .MAP_SCN_13+1
    STY .MAP_SCN_14+1
    STX .MAP_SCN_15+1
    STY .MAP_SCN_16+1
    STX .MAP_SCN_17+1
    STY .MAP_SCN_18+1
    STX .MAP_SCN_19+1
    STY .MAP_SCN_20+1
    STX .MAP_SCN_21+1
    STY .MAP_SCN_22+1
    STX .MAP_SCN_23+1
    STY .MAP_SCN_24+1
    STX .MAP_SCN_25+1
          
          LDY #39
.LOOP
.MAP_SCN_01  LDA  $1111,Y
            STA  VIC_SCN2+(40*00),Y
.MAP_SCN_02  LDA  $2222,Y
            STA  VIC_SCN2+(40*01),Y
.MAP_SCN_03  LDA  $3333,Y
            STA  VIC_SCN2+(40*02),Y
.MAP_SCN_04  LDA  $4444,Y
            STA  VIC_SCN2+(40*03),Y
.MAP_SCN_05  LDA  $5555,Y
            STA  VIC_SCN2+(40*04),Y
.MAP_SCN_06  LDA  $6666,Y
            STA  VIC_SCN2+(40*05),Y
.MAP_SCN_07  LDA  $7777,Y
            STA  VIC_SCN2+(40*06),Y
.MAP_SCN_08  LDA  $8888,Y
            STA  VIC_SCN2+(40*07),Y
.MAP_SCN_09  LDA  $9999,Y
            STA  VIC_SCN2+(40*08),Y
.MAP_SCN_10  LDA  $AAAA,Y
            STA  VIC_SCN2+(40*09),Y
.MAP_SCN_11  LDA  $BBBB,Y
            STA  VIC_SCN2+(40*10),Y
.MAP_SCN_12  LDA  $CCCC,Y
            STA  VIC_SCN2+(40*11),Y
.MAP_SCN_13  LDA  $DDDD,Y
            STA  VIC_SCN2+(40*12),Y
.MAP_SCN_14  LDA  $EEEE,Y
            STA  VIC_SCN2+(40*13),Y
.MAP_SCN_15  LDA  $1111,Y
            STA  VIC_SCN2+(40*14),Y
.MAP_SCN_16  LDA  $2222,Y
            STA  VIC_SCN2+(40*15),Y
.MAP_SCN_17  LDA  $3333,Y
            STA  VIC_SCN2+(40*16),Y
.MAP_SCN_18  LDA  $4444,Y
            STA  VIC_SCN2+(40*17),Y
.MAP_SCN_19  LDA  $5555,Y
            STA  VIC_SCN2+(40*18),Y
.MAP_SCN_20  LDA  $6666,Y
            STA  VIC_SCN2+(40*19),Y
.MAP_SCN_21  LDA  $7777,Y
            STA  VIC_SCN2+(40*20),Y
.MAP_SCN_22  LDA  $8888,Y
            STA  VIC_SCN2+(40*21),Y
.MAP_SCN_23  LDA  $9999,Y
            STA  VIC_SCN2+(40*22),Y
.MAP_SCN_24  LDA  $AAAA,Y
            STA  VIC_SCN2+(40*23),Y
.MAP_SCN_25  LDA  $BBBB,Y
            STA  VIC_SCN2+(40*24),Y
          DEY
          BMI .EXIT ; SHOULD THIS BE BMI ?  
         JMP .LOOP
.EXIT  RTS

!ZONE SPRITE_ZP_SETUP 
!MACRO SPRITE_ZP_SETUP {
  LDX SPR_ADR_LO,Y
  STX SPR00
  INX
  STX SPR01
  INX
  STX SPR02
  INX
  STX SPR03
  INX
  STX SPR04
  INX
  STX SPR05
  INX
  STX SPR06
  INX
  STX SPR07
  INX
  STX SPR08
  INX
  STX SPR09
  INX
  STX SPR10
  INX
  STX SPR11
  INX
  STX SPR12
  INX
  STX SPR13
  INX
  STX SPR14
  INX
  STX SPR15

  LDX SPR_ADR_HI,Y
  STX SPR00 +1
  STX SPR01 +1
  STX SPR02 +1
  STX SPR03 +1
  STX SPR04 +1
  STX SPR05 +1
  STX SPR06 +1
  STX SPR07 +1
  STX SPR08 +1
  STX SPR09 +1
  STX SPR10 +1
  STX SPR11 +1
  STX SPR12 +1
  STX SPR13 +1
  STX SPR14 +1
  STX SPR15 +1
}

!ZONE SPRITE_COLUMN 
!MACRO SPRITE_COLUMN ADDR {
  LDA (SPR00),Y
  STA ADDR+(0*3)+0
  LDA (SPR01),Y
  STA ADDR+(1*3)+0
  LDA (SPR02),Y
  STA ADDR+(2*3)+0
  LDA (SPR03),Y
  STA ADDR+(3*3)+0
  LDA (SPR04),Y
  STA ADDR+(4*3)+0
  LDA (SPR05),Y
  STA ADDR+(5*3)+0
  LDA (SPR06),Y
  STA ADDR+(6*3)+0
  LDA (SPR07),Y
  STA ADDR+(7*3)+0
  LDA (SPR08),Y
  STA ADDR+(8*3)+0
  LDA (SPR09),Y
  STA ADDR+(9*3)+0
  LDA (SPR10),Y
  STA ADDR+(10*3)+0
  LDA (SPR11),Y
  STA ADDR+(11*3)+0
  LDA (SPR12),Y
  STA ADDR+(12*3)+0
  LDA (SPR13),Y
  STA ADDR+(13*3)+0
  LDA (SPR14),Y
  STA ADDR+(14*3)+0
  LDA (SPR15),Y
  STA ADDR+(15*3)+0
}

!ZONE SPRITES
SPRITES
  LDY #0 ; sprite     ; get sprite address pointer
  +SPRITE_ZP_SETUP
  LDA FRAME
  LSR
  BCC SPRITE01
  JMP SPRITE02

!ZONE SPRITE01
SPRITE01 ; copy 16x16x2 software sprite to 2x24x21 hardware sprites
;  LDY #0      ; sprite
;  +SPRITE_ZP_SETUP
  
  LDY #0
  +SPRITE_COLUMN HW_SPRITE_0_SCN1
  LDY #16
  +SPRITE_COLUMN HW_SPRITE_0_SCN1+1
  LDY #32
  +SPRITE_COLUMN HW_SPRITE_1_SCN1
  LDY #48
  +SPRITE_COLUMN HW_SPRITE_1_SCN1+1

  LDY #0      ; sprite
  +SPRITE_ZP_SETUP
  LDY #0
  +SPRITE_COLUMN HW_SPRITE_2_SCN1
  LDY #16
  +SPRITE_COLUMN HW_SPRITE_2_SCN1+1
  LDY #32
  +SPRITE_COLUMN HW_SPRITE_3_SCN1
  LDY #48
  +SPRITE_COLUMN HW_SPRITE_3_SCN1+1

  LDY #0      ; sprite
  +SPRITE_ZP_SETUP
  LDY #0
  +SPRITE_COLUMN HW_SPRITE_4_SCN1
  LDY #16
  +SPRITE_COLUMN HW_SPRITE_4_SCN1+1
  LDY #32
  +SPRITE_COLUMN HW_SPRITE_5_SCN1
  LDY #48
  +SPRITE_COLUMN HW_SPRITE_5_SCN1+1

  LDY #0      ; sprite
  +SPRITE_ZP_SETUP
  LDY #0
  +SPRITE_COLUMN HW_SPRITE_6_SCN1
  LDY #16
  +SPRITE_COLUMN HW_SPRITE_6_SCN1+1
  LDY #32
  +SPRITE_COLUMN HW_SPRITE_7_SCN1
  LDY #48
  +SPRITE_COLUMN HW_SPRITE_7_SCN1+1

  RTS

!ZONE SPRITE02
SPRITE02 ; copy 16x16x2 software sprite to 2x24x21 hardware sprites
;  LDY #0 ; sprite     ; get sprite address pointer
;  +SPRITE_ZP_SETUP

  LDY #0
  +SPRITE_COLUMN HW_SPRITE_0_SCN2
  LDY #16
  +SPRITE_COLUMN HW_SPRITE_0_SCN2+1
  LDY #32
  +SPRITE_COLUMN HW_SPRITE_1_SCN2
  LDY #48
  +SPRITE_COLUMN HW_SPRITE_1_SCN2+1

  LDY #0
  +SPRITE_ZP_SETUP
  LDY #0
  +SPRITE_COLUMN HW_SPRITE_2_SCN2
  LDY #16
  +SPRITE_COLUMN HW_SPRITE_2_SCN2+1
  LDY #32
  +SPRITE_COLUMN HW_SPRITE_3_SCN2
  LDY #48
  +SPRITE_COLUMN HW_SPRITE_3_SCN2+1

  LDY #0      ; sprite
  +SPRITE_ZP_SETUP
  LDY #0
  +SPRITE_COLUMN HW_SPRITE_4_SCN2
  LDY #16
  +SPRITE_COLUMN HW_SPRITE_4_SCN2+1
  LDY #32
  +SPRITE_COLUMN HW_SPRITE_5_SCN2
  LDY #48
  +SPRITE_COLUMN HW_SPRITE_5_SCN2+1

  LDY #0      ; sprite
  +SPRITE_ZP_SETUP
  LDY #0
  +SPRITE_COLUMN HW_SPRITE_6_SCN2
  LDY #16
  +SPRITE_COLUMN HW_SPRITE_6_SCN2+1
  LDY #32
  +SPRITE_COLUMN HW_SPRITE_7_SCN2
  LDY #48
  +SPRITE_COLUMN HW_SPRITE_7_SCN2+1

  RTS


; ldy #0
; src_ptr_01 lda $ABCD,Y    ; sprite address
;       sta sprite_01_01  ; always the same sprite number (either 0+1 or 2+3 or 4+5 or 6+7)
;       iny
; src_ptr_02 lda $ABCD,Y
;       sta sprite_01_02
;     iny
; ..
; src_ptr_15 lda $ABCD,Y
;       sta sprite_01_15
;       iny
; src_ptr_16 lda $ABCD,Y
;       sta sprite_01_16
;     iny
; ..
; src_ptr_17 lda $ABCD,Y
;       sta sprite_02_01
;       iny
; src_ptr_18 lda $ABCD,Y
;       sta sprite_02_02
;     iny
; ..
; src_ptr_31 lda $ABCD,Y
;       sta sprite_02_15
;       iny
; src_ptr_32 lda $ABCD,Y
;       sta sprite_02_16
;;;;    iny
;     rts

; is it faster to setup 32 address with no loop (32 sta hi and 32 sta lo) or is it faster to loop through 8 addresses 4 times (reducing the setup time from 32 sta's to 8 sta's) ?



;SCN_HI !BYTE >(VIC_SCN+(40*00)),>(VIC_SCN+(40*01)),>(VIC_SCN+(40*02)),>(VIC_SCN+(40*03)),>(VIC_SCN+(40*04))
;       !BYTE >(VIC_SCN+(40*05)),>(VIC_SCN+(40*06)),>(VIC_SCN+(40*07)),>(VIC_SCN+(40*08)),>(VIC_SCN+(40*09))
;       !BYTE >(VIC_SCN+(40*10)),>(VIC_SCN+(40*11)),>(VIC_SCN+(40*12)),>(VIC_SCN+(40*13)),>(VIC_SCN+(40*14))
;       !BYTE >(VIC_SCN+(40*15)),>(VIC_SCN+(40*16)),>(VIC_SCN+(40*17)),>(VIC_SCN+(40*18)),>(VIC_SCN+(40*19))
;       !BYTE >(VIC_SCN+(40*20)),>(VIC_SCN+(40*21)),>(VIC_SCN+(40*22)),>(VIC_SCN+(40*23)),>(VIC_SCN+(40*24))
;SCN_LO !BYTE <(VIC_SCN+(40*00)),<(VIC_SCN+(40*01)),<(VIC_SCN+(40*02)),<(VIC_SCN+(40*03)),<(VIC_SCN+(40*04))
;       !BYTE <(VIC_SCN+(40*05)),<(VIC_SCN+(40*06)),<(VIC_SCN+(40*07)),<(VIC_SCN+(40*08)),<(VIC_SCN+(40*09))
;       !BYTE <(VIC_SCN+(40*10)),<(VIC_SCN+(40*11)),<(VIC_SCN+(40*12)),<(VIC_SCN+(40*13)),<(VIC_SCN+(40*14))
;       !BYTE <(VIC_SCN+(40*15)),<(VIC_SCN+(40*16)),<(VIC_SCN+(40*17)),<(VIC_SCN+(40*18)),<(VIC_SCN+(40*19))
;       !BYTE <(VIC_SCN+(40*20)),<(VIC_SCN+(40*21)),<(VIC_SCN+(40*22)),<(VIC_SCN+(40*23)),<(VIC_SCN+(40*24))

MAP_HI  !BYTE >(MAP_ADR+(MAP_LEN*000)),>(MAP_ADR+(MAP_LEN*001)),>(MAP_ADR+(MAP_LEN*002)),>(MAP_ADR+(MAP_LEN*003)),>(MAP_ADR+(MAP_LEN*004)),>(MAP_ADR+(MAP_LEN*005)),>(MAP_ADR+(MAP_LEN*006)),>(MAP_ADR+(MAP_LEN*007)),>(MAP_ADR+(MAP_LEN*008)),>(MAP_ADR+(MAP_LEN*009))
    !BYTE >(MAP_ADR+(MAP_LEN*010)),>(MAP_ADR+(MAP_LEN*011)),>(MAP_ADR+(MAP_LEN*012)),>(MAP_ADR+(MAP_LEN*013)),>(MAP_ADR+(MAP_LEN*014)),>(MAP_ADR+(MAP_LEN*015)),>(MAP_ADR+(MAP_LEN*016)),>(MAP_ADR+(MAP_LEN*017)),>(MAP_ADR+(MAP_LEN*018)),>(MAP_ADR+(MAP_LEN*019))
    !BYTE >(MAP_ADR+(MAP_LEN*020)),>(MAP_ADR+(MAP_LEN*021)),>(MAP_ADR+(MAP_LEN*022)),>(MAP_ADR+(MAP_LEN*023)),>(MAP_ADR+(MAP_LEN*024)),>(MAP_ADR+(MAP_LEN*025)),>(MAP_ADR+(MAP_LEN*026)),>(MAP_ADR+(MAP_LEN*027)),>(MAP_ADR+(MAP_LEN*028)),>(MAP_ADR+(MAP_LEN*029))
    !BYTE >(MAP_ADR+(MAP_LEN*030)),>(MAP_ADR+(MAP_LEN*031)),>(MAP_ADR+(MAP_LEN*032)),>(MAP_ADR+(MAP_LEN*033)),>(MAP_ADR+(MAP_LEN*034)),>(MAP_ADR+(MAP_LEN*035)),>(MAP_ADR+(MAP_LEN*036)),>(MAP_ADR+(MAP_LEN*037)),>(MAP_ADR+(MAP_LEN*038)),>(MAP_ADR+(MAP_LEN*039))
    !BYTE >(MAP_ADR+(MAP_LEN*040)),>(MAP_ADR+(MAP_LEN*041)),>(MAP_ADR+(MAP_LEN*042)),>(MAP_ADR+(MAP_LEN*043)),>(MAP_ADR+(MAP_LEN*044)),>(MAP_ADR+(MAP_LEN*045)),>(MAP_ADR+(MAP_LEN*046)),>(MAP_ADR+(MAP_LEN*047)),>(MAP_ADR+(MAP_LEN*048)),>(MAP_ADR+(MAP_LEN*049))
    !BYTE >(MAP_ADR+(MAP_LEN*050)),>(MAP_ADR+(MAP_LEN*051)),>(MAP_ADR+(MAP_LEN*052)),>(MAP_ADR+(MAP_LEN*053)),>(MAP_ADR+(MAP_LEN*054)),>(MAP_ADR+(MAP_LEN*055)),>(MAP_ADR+(MAP_LEN*056)),>(MAP_ADR+(MAP_LEN*057)),>(MAP_ADR+(MAP_LEN*058)),>(MAP_ADR+(MAP_LEN*059))
    !BYTE >(MAP_ADR+(MAP_LEN*060)),>(MAP_ADR+(MAP_LEN*061)),>(MAP_ADR+(MAP_LEN*062)),>(MAP_ADR+(MAP_LEN*063)),>(MAP_ADR+(MAP_LEN*064)),>(MAP_ADR+(MAP_LEN*065)),>(MAP_ADR+(MAP_LEN*066)),>(MAP_ADR+(MAP_LEN*067)),>(MAP_ADR+(MAP_LEN*068)),>(MAP_ADR+(MAP_LEN*069))
    !BYTE >(MAP_ADR+(MAP_LEN*070)),>(MAP_ADR+(MAP_LEN*071)),>(MAP_ADR+(MAP_LEN*072)),>(MAP_ADR+(MAP_LEN*073)),>(MAP_ADR+(MAP_LEN*074)),>(MAP_ADR+(MAP_LEN*075)),>(MAP_ADR+(MAP_LEN*076)),>(MAP_ADR+(MAP_LEN*077)),>(MAP_ADR+(MAP_LEN*078)),>(MAP_ADR+(MAP_LEN*079))
    !BYTE >(MAP_ADR+(MAP_LEN*080)),>(MAP_ADR+(MAP_LEN*081)),>(MAP_ADR+(MAP_LEN*082)),>(MAP_ADR+(MAP_LEN*083)),>(MAP_ADR+(MAP_LEN*084)),>(MAP_ADR+(MAP_LEN*085)),>(MAP_ADR+(MAP_LEN*086)),>(MAP_ADR+(MAP_LEN*087)),>(MAP_ADR+(MAP_LEN*088)),>(MAP_ADR+(MAP_LEN*089))
    !BYTE >(MAP_ADR+(MAP_LEN*090)),>(MAP_ADR+(MAP_LEN*091)),>(MAP_ADR+(MAP_LEN*092)),>(MAP_ADR+(MAP_LEN*093)),>(MAP_ADR+(MAP_LEN*094)),>(MAP_ADR+(MAP_LEN*095)),>(MAP_ADR+(MAP_LEN*096)),>(MAP_ADR+(MAP_LEN*097)),>(MAP_ADR+(MAP_LEN*098)),>(MAP_ADR+(MAP_LEN*099))
    !BYTE >(MAP_ADR+(MAP_LEN*100)),>(MAP_ADR+(MAP_LEN*101)),>(MAP_ADR+(MAP_LEN*102)),>(MAP_ADR+(MAP_LEN*103)),>(MAP_ADR+(MAP_LEN*104)),>(MAP_ADR+(MAP_LEN*105)),>(MAP_ADR+(MAP_LEN*106)),>(MAP_ADR+(MAP_LEN*107)),>(MAP_ADR+(MAP_LEN*108)),>(MAP_ADR+(MAP_LEN*109))
    !BYTE >(MAP_ADR+(MAP_LEN*110)),>(MAP_ADR+(MAP_LEN*111)),>(MAP_ADR+(MAP_LEN*112)),>(MAP_ADR+(MAP_LEN*113)),>(MAP_ADR+(MAP_LEN*114)),>(MAP_ADR+(MAP_LEN*115)),>(MAP_ADR+(MAP_LEN*116)),>(MAP_ADR+(MAP_LEN*117)),>(MAP_ADR+(MAP_LEN*118)),>(MAP_ADR+(MAP_LEN*119))
;MAP_LO  !BYTE <(MAP_ADR+(MAP_LEN*000)),<(MAP_ADR+(MAP_LEN*001)),<(MAP_ADR+(MAP_LEN*002)),<(MAP_ADR+(MAP_LEN*003)),<(MAP_ADR+(MAP_LEN*004)),<(MAP_ADR+(MAP_LEN*005)),<(MAP_ADR+(MAP_LEN*006)),<(MAP_ADR+(MAP_LEN*007)),<(MAP_ADR+(MAP_LEN*008)),<(MAP_ADR+(MAP_LEN*009))
;    !BYTE <(MAP_ADR+(MAP_LEN*010)),<(MAP_ADR+(MAP_LEN*011)),<(MAP_ADR+(MAP_LEN*012)),<(MAP_ADR+(MAP_LEN*013)),<(MAP_ADR+(MAP_LEN*014)),<(MAP_ADR+(MAP_LEN*015)),<(MAP_ADR+(MAP_LEN*016)),<(MAP_ADR+(MAP_LEN*017)),<(MAP_ADR+(MAP_LEN*018)),<(MAP_ADR+(MAP_LEN*019))
;    !BYTE <(MAP_ADR+(MAP_LEN*020)),<(MAP_ADR+(MAP_LEN*021)),<(MAP_ADR+(MAP_LEN*022)),<(MAP_ADR+(MAP_LEN*023)),<(MAP_ADR+(MAP_LEN*024)),<(MAP_ADR+(MAP_LEN*025)),<(MAP_ADR+(MAP_LEN*026)),<(MAP_ADR+(MAP_LEN*027)),<(MAP_ADR+(MAP_LEN*028)),<(MAP_ADR+(MAP_LEN*029))
;    !BYTE <(MAP_ADR+(MAP_LEN*030)),<(MAP_ADR+(MAP_LEN*031)),<(MAP_ADR+(MAP_LEN*032)),<(MAP_ADR+(MAP_LEN*033)),<(MAP_ADR+(MAP_LEN*034)),<(MAP_ADR+(MAP_LEN*035)),<(MAP_ADR+(MAP_LEN*036)),<(MAP_ADR+(MAP_LEN*037)),<(MAP_ADR+(MAP_LEN*038)),<(MAP_ADR+(MAP_LEN*039))
;    !BYTE <(MAP_ADR+(MAP_LEN*040)),<(MAP_ADR+(MAP_LEN*041)),<(MAP_ADR+(MAP_LEN*042)),<(MAP_ADR+(MAP_LEN*043)),<(MAP_ADR+(MAP_LEN*044)),<(MAP_ADR+(MAP_LEN*045)),<(MAP_ADR+(MAP_LEN*046)),<(MAP_ADR+(MAP_LEN*047)),<(MAP_ADR+(MAP_LEN*048)),<(MAP_ADR+(MAP_LEN*049))
;    !BYTE <(MAP_ADR+(MAP_LEN*050)),<(MAP_ADR+(MAP_LEN*051)),<(MAP_ADR+(MAP_LEN*052)),<(MAP_ADR+(MAP_LEN*053)),<(MAP_ADR+(MAP_LEN*054)),<(MAP_ADR+(MAP_LEN*055)),<(MAP_ADR+(MAP_LEN*056)),<(MAP_ADR+(MAP_LEN*057)),<(MAP_ADR+(MAP_LEN*058)),<(MAP_ADR+(MAP_LEN*059))
;    !BYTE <(MAP_ADR+(MAP_LEN*060)),<(MAP_ADR+(MAP_LEN*061)),<(MAP_ADR+(MAP_LEN*062)),<(MAP_ADR+(MAP_LEN*063)),<(MAP_ADR+(MAP_LEN*064)),<(MAP_ADR+(MAP_LEN*065)),<(MAP_ADR+(MAP_LEN*066)),<(MAP_ADR+(MAP_LEN*067)),<(MAP_ADR+(MAP_LEN*068)),<(MAP_ADR+(MAP_LEN*069))
;    !BYTE <(MAP_ADR+(MAP_LEN*070)),<(MAP_ADR+(MAP_LEN*071)),<(MAP_ADR+(MAP_LEN*072)),<(MAP_ADR+(MAP_LEN*073)),<(MAP_ADR+(MAP_LEN*074)),<(MAP_ADR+(MAP_LEN*075)),<(MAP_ADR+(MAP_LEN*076)),<(MAP_ADR+(MAP_LEN*077)),<(MAP_ADR+(MAP_LEN*078)),<(MAP_ADR+(MAP_LEN*079))
;    !BYTE <(MAP_ADR+(MAP_LEN*080)),<(MAP_ADR+(MAP_LEN*081)),<(MAP_ADR+(MAP_LEN*082)),<(MAP_ADR+(MAP_LEN*083)),<(MAP_ADR+(MAP_LEN*084)),<(MAP_ADR+(MAP_LEN*085)),<(MAP_ADR+(MAP_LEN*086)),<(MAP_ADR+(MAP_LEN*087)),<(MAP_ADR+(MAP_LEN*088)),<(MAP_ADR+(MAP_LEN*089))
;    !BYTE <(MAP_ADR+(MAP_LEN*090)),<(MAP_ADR+(MAP_LEN*091)),<(MAP_ADR+(MAP_LEN*092)),<(MAP_ADR+(MAP_LEN*093)),<(MAP_ADR+(MAP_LEN*094)),<(MAP_ADR+(MAP_LEN*095)),<(MAP_ADR+(MAP_LEN*096)),<(MAP_ADR+(MAP_LEN*097)),<(MAP_ADR+(MAP_LEN*098)),<(MAP_ADR+(MAP_LEN*099))
;    !BYTE <(MAP_ADR+(MAP_LEN*100)),<(MAP_ADR+(MAP_LEN*101)),<(MAP_ADR+(MAP_LEN*102)),<(MAP_ADR+(MAP_LEN*103)),<(MAP_ADR+(MAP_LEN*104)),<(MAP_ADR+(MAP_LEN*105)),<(MAP_ADR+(MAP_LEN*106)),<(MAP_ADR+(MAP_LEN*107)),<(MAP_ADR+(MAP_LEN*108)),<(MAP_ADR+(MAP_LEN*109))
;    !BYTE <(MAP_ADR+(MAP_LEN*110)),<(MAP_ADR+(MAP_LEN*111)),<(MAP_ADR+(MAP_LEN*112)),<(MAP_ADR+(MAP_LEN*113)),<(MAP_ADR+(MAP_LEN*114)),<(MAP_ADR+(MAP_LEN*115)),<(MAP_ADR+(MAP_LEN*116)),<(MAP_ADR+(MAP_LEN*117)),<(MAP_ADR+(MAP_LEN*118)),<(MAP_ADR+(MAP_LEN*119))

SCROLL_TAB    ; $10 for both hor $d011 and ver $d016
  !BYTE   $10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17
  !BYTE   $10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17
  !BYTE   $10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17
  !BYTE   $10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17
  !BYTE   $10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17
  !BYTE   $10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17
  !BYTE   $10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17
  !BYTE   $10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17,$10,$11,$12,$13,$14,$15,$16,$17

NUMBERS
    !BYTE $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
    !BYTE $10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F
    !BYTE $20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F
    !BYTE $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F
    !BYTE $40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F
    !BYTE $50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$5B,$5C,$5D,$5E,$5F
    !BYTE $60,$61,$62,$63,$64,$65,$66,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$6F
    !BYTE $70,$71,$72,$73,$74,$75,$76,$77,$78,$79,$7A,$7B,$7C,$7D,$7E,$7F
;    !BYTE $80,$81,$82,$83,$84,$85,$86,$87,$88,$89,$8A,$8B,$8C,$8D,$8E,$8F
;    !BYTE $90,$91,$92,$93,$94,$95,$96,$97,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F
;    !BYTE $A0,$A1,$A2,$A3,$A4,$A5,$A6,$A7,$A8,$A9,$AA,$AB,$AC,$AD,$AE,$AF
;    !BYTE $B0,$B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8,$B9,$BA,$BB,$BC,$BD,$BE,$BF
;    !BYTE $C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF
;    !BYTE $D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9,$DA,$DB,$DC,$DD,$DE,$DF
;    !BYTE $E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9,$EA,$EB,$EC,$ED,$0E,$EF
;    !BYTE $F0,$F1,$F2,$F3,$F4,$F5,$F6,$F7,$F8,$F9,$FA,$FB,$FC,$FD,$FE,$FF

SPR_ADR_LO
    !BYTE <SPRITE00
SPR_ADR_HI
    !BYTE >SPRITE00
  
!align 255, 0  
SPRITE00
    !BYTE %11111111
    !BYTE %10000000
    !BYTE %10000000
    !BYTE %10000000
    !BYTE %10000000
    !BYTE %10000000
    !BYTE %10000011
    !BYTE %10000010
    !BYTE %10000010
    !BYTE %10000011
    !BYTE %10000000
    !BYTE %10000000
    !BYTE %10000000
    !BYTE %10000000
    !BYTE %10000000
    !BYTE %11111111
    
    !BYTE %11111111
    !BYTE %00000001
    !BYTE %00000001
    !BYTE %00000001
    !BYTE %00000001
    !BYTE %00000001
    !BYTE %11000001
    !BYTE %01000001
    !BYTE %01000001
    !BYTE %11000001
    !BYTE %00000001
    !BYTE %00000001
    !BYTE %00000001
    !BYTE %00000001
    !BYTE %00000001
    !BYTE %11111111

    !BYTE %11111111
    !BYTE %10000000
    !BYTE %10111111
    !BYTE %10000000
    !BYTE %10000000
    !BYTE %10000000
    !BYTE %10000011
    !BYTE %10000010
    !BYTE %10000010
    !BYTE %10000011
    !BYTE %10000000
    !BYTE %10000000
    !BYTE %10000000
    !BYTE %10111111
    !BYTE %10000000
    !BYTE %11111111
    
    !BYTE %11111111
    !BYTE %00000001
    !BYTE %00000001
    !BYTE %00000001
    !BYTE %00000001
    !BYTE %00000001
    !BYTE %11000001
    !BYTE %01000001
    !BYTE %01000001
    !BYTE %11000001
    !BYTE %00000001
    !BYTE %00000001
    !BYTE %00000001
    !BYTE %00000001
    !BYTE %00000001
    !BYTE %11111111

; scrolling map

;512  1024  8 hw sprites
;1024 2024  screen
;2048 4096  char set
;4096 16384 code
;16384  32768 128 sprites
;32768  49152 12k compressed map put to 54272 + 128 x 128 generated map
;54272  65536 

; single screen
; character screen
; 512 = 8 hw sprites
; 16384 = 256 software sprites

; 80x50 (4 bit chars)
; rle compressed maps (bit 128 clear 000-127 (001-128 ?) = empty / bit 128 set 001-127 (001-128 ?) = full)
; char map
; each char = 
;   00 01
;   10 00
; where 00 = empty / 01 = not set / 10 = set
; using 256 characters - except any containing 11?????? / ??11???? / ????11?? / ??????11 - which should be 64 spare?

; single screen
; bitmap screen
; 512 = 8 hw sprites vic bank
; 8000 = bitmap screen vic bank
; 1000 = bitmap colour vic bank
; 4000 = hi-res map - under 49152 bank

; 16384 = 256 software sprites

; single screen
; character screen
; 512 = 8 hw sprites vic bank
; 1000 = bitmap screen vic bank
; 2000 = character set vic bank
; 4000 = hi-res map

; 16384 = 256 software sprites

; 49152-65535
; 4k used bank
; 2k char
; 1k screen1
; 1k screen2
; 0.5k sprites

; 512-1024 - 8 hw sprites
; 1024-2048 - screen1
; 2048-3k - screen2

; 49152-65535 - map
; setup code and data starts at 2k - and is overwritten by screen - with actual code starting at 3k

; 128 chars across which are each 8 pixels across
; 128*8 = 1024



; hi              lo
; 7 6 5 4 3 2 1 0 7 6 5 4 3 2 1 0
; C C C C C C C P P P ? ? ? ? ? ?

; char pos = hi LSR
; scroll pixel pos = lo ASL / hi ROL / hi ROL / hi and #7

; LDA HI
; LSR   ; /2 - LSB -> carry
; STA CHAR
; LDA LO
; ROR   ; /2 - carry -> MSB
; TAY
; LDA SCROLL,Y
; STA PIXEL
; RTS




; hi              lo
; 7 6 5 4 3 2 1 0 7 6 5 4 3 2 1 0
; ? ? ? ? ? ? C C C C C C C P P P

; lax lo    ; 
; and #$07    ; 2
; ora #$10    ; 2
; sta pixel   ; 
; lda hi    ; 
; lsr     ; 2
; stx hi_temp ; 3
; txa     ; 2
; ror     ; 2
; lsr hi_temp ; 5
; ror     ; 2
; lsr     ; 2
; sta char    ; 

; ldx hi      ; 3
; ldy lo      ; 3
; lda hiscroll,x  ; 4
; ora loscroll,y  ; 4
; ldx pixscroll,y ; 4
; sta char      ; 3
; stx pixel     ; 3