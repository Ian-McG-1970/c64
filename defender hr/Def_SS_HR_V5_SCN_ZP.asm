*= $1000 

SCR_LO = 2 ; BANK_LO_HI+1
SCR_HI = SCR_LO+1
SCR = SCR_LO

REGA_BUF = SCR_HI +1
REGX_BUF = REGA_BUF+1
REGY_BUF = REGX_BUF+1
REGA_INT = REGY_BUF+1
REGX_INT = REGA_INT+1
REGY_INT = REGX_INT+1

JOYX = REGY_INT +1
JOYY = JOYX +1
JOYF = JOYY +1
XPOS = JOYF +1
YPOS = XPOS +2
MAP_POS = YPOS+1 ; map position (0-1023)
MAP_PIXEL = MAP_POS +2 ; map pixel pos (0-7)
MAP_CHAR = MAP_PIXEL+1 ; map char pos (0-255)
MAP_MSB = MAP_CHAR +1
SPRADDR0 = MAP_MSB +2
SPRADDR3 = SPRADDR0 +2
SPRADDR6 = SPRADDR3 +2

MAP_SCN_LO_ZP     = SPRADDR6 +2
MAP_SCN_LSB_HI_ZP = MAP_SCN_LO_ZP +2
MAP_SCN_MSB_HI_ZP = MAP_SCN_LSB_HI_ZP +2

SCN_LN_LFT_00 = MAP_SCN_MSB_HI_ZP +2
SCN_LN_RGT_00 = SCN_LN_LFT_00 +2

SCN_LN_LFT_01 = SCN_LN_RGT_00 +2 
SCN_LN_RGT_01 = SCN_LN_LFT_01 +2

SCN_LN_LFT_02 = SCN_LN_RGT_01 +2 
SCN_LN_RGT_02 = SCN_LN_LFT_02 +2

SCN_LN_LFT_03 = SCN_LN_RGT_02 +2 
SCN_LN_RGT_03 = SCN_LN_LFT_03 +2

SCN_LN_LFT_04 = SCN_LN_RGT_03 +2
SCN_LN_RGT_04 = SCN_LN_LFT_04 +2
 
SCN_LN_LFT_05 = SCN_LN_RGT_04 +2 
SCN_LN_RGT_05 = SCN_LN_LFT_05 +2 

SCN_LN_LFT_06 = SCN_LN_RGT_05 +2 
SCN_LN_RGT_06 = SCN_LN_LFT_06 +2 

SCN_LN_LFT_07 = SCN_LN_RGT_06 +2 
SCN_LN_RGT_07 = SCN_LN_LFT_07 +2 

SCN_LN_LFT_08 = SCN_LN_RGT_07 +2 
SCN_LN_RGT_08 = SCN_LN_LFT_08 +2 

SCN_LN_LFT_09 = SCN_LN_RGT_08 +2 
SCN_LN_RGT_09 = SCN_LN_LFT_09 +2 

SCN_LN_LFT_10 = SCN_LN_RGT_09 +2 
SCN_LN_RGT_10 = SCN_LN_LFT_10 +2 

SCN_LN_LFT_11 = SCN_LN_RGT_10 +2 
SCN_LN_RGT_11 = SCN_LN_LFT_11 +2 

SCN_LN_LFT_12 = SCN_LN_RGT_11 +2 
SCN_LN_RGT_12 = SCN_LN_LFT_12 +2 

SCN_LN_LFT_13 = SCN_LN_RGT_12 +2 
SCN_LN_RGT_13 = SCN_LN_LFT_13 +2 

SCN_LN_LFT_14 = SCN_LN_RGT_13 +2 
SCN_LN_RGT_14 = SCN_LN_LFT_14 +2 

SCN_LN_LFT_15 = SCN_LN_RGT_14 +2 
SCN_LN_RGT_15 = SCN_LN_LFT_15 +2 

SCN_LN_LFT_16 = SCN_LN_RGT_15 +2 
SCN_LN_RGT_16 = SCN_LN_LFT_16 +2 

SCN_LN_LFT_17 = SCN_LN_RGT_16 +2 
SCN_LN_RGT_17 = SCN_LN_LFT_17 +2 

SCN_LN_LFT_18 = SCN_LN_RGT_17 +2 
SCN_LN_RGT_18 = SCN_LN_LFT_18 +2 

SCN_LN_LFT_19 = SCN_LN_RGT_18 +2 
SCN_LN_RGT_19 = SCN_LN_LFT_19 +2 

SCN_LN_LFT_20 = SCN_LN_RGT_19 +2 
SCN_LN_RGT_20 = SCN_LN_LFT_20 +2 

SCN_LN_LFT_21 = SCN_LN_RGT_20 +2 
SCN_LN_RGT_21 = SCN_LN_LFT_21 +2 

SCN_LN_LFT_22 = SCN_LN_RGT_21 +2 
SCN_LN_RGT_22 = SCN_LN_LFT_22 +2 

SCN_LN_LFT_23 = SCN_LN_RGT_22 +2 
SCN_LN_RGT_23 = SCN_LN_LFT_23 +2 

SCN_LN_LFT_24 = SCN_LN_RGT_23 +2 
SCN_LN_RGT_24 = SCN_LN_LFT_24 +2 

SCN_LN_LFT_25 = SCN_LN_RGT_24 +2 
SCN_LN_RGT_25 = SCN_LN_LFT_25 +2 

SCN_LN_LFT_26 = SCN_LN_RGT_25 +2 
SCN_LN_RGT_26 = SCN_LN_LFT_26 +2 

SCN_LN_LFT_27 = SCN_LN_RGT_26 +2 
SCN_LN_RGT_27 = SCN_LN_LFT_27 +2 

SCN_LN_LFT_28 = SCN_LN_RGT_27 +2 
SCN_LN_RGT_28 = SCN_LN_LFT_28 +2 

SCN_LN_LFT_29 = SCN_LN_RGT_28 +2 
SCN_LN_RGT_29 = SCN_LN_LFT_29 +2 

SCN_LN_LFT_30 = SCN_LN_RGT_29 +2 
SCN_LN_RGT_30 = SCN_LN_LFT_30 +2 

SCN_LN_LFT_31 = SCN_LN_RGT_30 +2 
SCN_LN_RGT_31 = SCN_LN_LFT_31 +2 

SCN_LN_LFT_32 = SCN_LN_RGT_31 +2 
SCN_LN_RGT_32 = SCN_LN_LFT_32 +2 

SCN_LN_LFT_33 = SCN_LN_RGT_32 +2 
SCN_LN_RGT_33 = SCN_LN_LFT_33 +2 

SCN_LN_LFT_34 = SCN_LN_RGT_33 +2 
SCN_LN_RGT_34 = SCN_LN_LFT_34 +2 

SCN_LN_LFT_35 = SCN_LN_RGT_34 +2 
SCN_LN_RGT_35 = SCN_LN_LFT_35 +2 

SCN_LN_LFT_36 = SCN_LN_RGT_35 +2 
SCN_LN_RGT_36 = SCN_LN_LFT_36 +2 

SCN_LN_LFT_37 = SCN_LN_RGT_36 +2 
SCN_LN_RGT_37 = SCN_LN_LFT_37 +2 

SCN_LN_LFT_38 = SCN_LN_RGT_37 +2 
SCN_LN_RGT_38 = SCN_LN_LFT_38 +2 

SCN_LN_LFT_39 = SCN_LN_RGT_38 +2 
SCN_LN_RGT_39 = SCN_LN_LFT_39 +2 

LANDSCAPE_SIZE = 512

SCN = $A000 ; 40960 to 49152
SCNCOL = $8000 ; = $9c00
SPRBANK = $9000 ; 3k sprite bank
SCRNBANK = $01
BANK = %00001000 ; bitmap is at $2000 + screenmem is at $0000

RASTER1 = $DB ; f9

SPR00_ADDR = SPRBANK
SPR01_ADDR = SPR00_ADDR +64
SPR02_ADDR = SPR01_ADDR +64
SPR03_ADDR = SPR02_ADDR +64
SPR04_ADDR = SPR03_ADDR +64
SPR05_ADDR = SPR04_ADDR +64
SPR06_ADDR = SPR05_ADDR +64
SPR07_ADDR = SPR06_ADDR +64
SPR10_ADDR = SPR07_ADDR +64
SPR11_ADDR = SPR10_ADDR +64
SPR12_ADDR = SPR11_ADDR +64
SPR13_ADDR = SPR12_ADDR +64
SPR14_ADDR = SPR13_ADDR +64
SPR15_ADDR = SPR14_ADDR +64
SPR16_ADDR = SPR15_ADDR +64
SPR17_ADDR = SPR16_ADDR +64

SPRCLR1 = $D025
SPRCLR2 = $D026

SPRENBL = 53248+21
SPRMULTI = $D01C
  SPRPRI = $D01B

SPRXPX = 53248+29 
SPRXPY = 53248+23

S0X = 53248+0
S0Y = 53248+1
S0C = $D027

S1X = 53248+2
S1Y = 53248+3
S1C = $D028

S2X = 53248+4
S2Y = 53248+5
S2C = $D029

S3X = 53248+6
S3Y = 53248+7
S3C = $D02A

S4X = 53248+8
S4Y = 53248+9
S4C = $D02B

S5X = 53248+10
S5Y = 53248+11
S5C = $D02C

S6X = 53248+12
S6Y = 53248+13
S6C = $D02D

S7X = 53248+14
S7Y = 53248+15
S7C = $D02E

SPRXMSB = 53248+16
SPRMSB = %11000000

SPR1X = 24-8
SPR2X = 24+(48*1)-8
SPR3X = 24+(48*2)-8
SPR4X = 24+(48*3)-8
SPR5X = 24+(48*4)-8
SPR6X = 0
SPR7X = (48*1)

SEI        ; disable maskable IRQs

 LDX #$FF  ; max stack pointer
 TXS

 LDA #$7F
 STA $DC0D  ; disable timer interrupts which can be generated by the two CIA chips
 STA $DD0D  ; the kernal uses such an interrupt to flash the cursor and scan the keyboard, so we better stop it.

 LDA $DC0D  ; by reading this two registers we negate any pending CIA irqs.
 LDA $DD0D  ; if we don't do this, a pending CIA irq might occur after we finish setting up our irq. we don't want that to happen.

 LDA #$01   ; this is how to tell the VICII to generate a raster interrupt
 STA $D01A

 LDA #RASTER1 ; this is how to tell at which rasterline we want the irq to be triggered
 STA $D012

 LDA #$1B   ; as there are more than 256 rasterlines, the topmost bit of $d011 serves as
 STA $D011  ; the 9th bit for the rasterline we want our irq to be triggered. here we simply set up a character screen, leaving the topmost bit 0.

 LDA #$35   ; we turn off the BASIC and KERNAL rom here
 STA $01    ; the cpu now sees RAM everywhere except at $d000-$e000, where still the registers of SID/VICII/etc are visible

 lDA #<IRQ_1  ; this is how we set up
 STA $FFFE     ; the address of our interrupt code
 LDA #>IRQ_1
 STA $FFFF
  
 LDA #<NMI_NOP  ; lsb
 STA $FFFA      ; Create a nop, irq handler for NMI that gets called whenever RESTORE is pressed or similar.
 LDA #>NMI_NOP  ; msb
 STA $FFFB      ; We're putting our irq handler directly in the vector that usually points to the kernal's NMI handler since we have kernal banked out.

 LDA #$00       ; Force an NMI by setting up a timer. This will cause an NMI, that won't be acked. Any subsequent NMI's from RESTORE will be essentially disabled.
 STA $DD0E      ; Stop timer A
 STA $DD04      ; Set timer A to 0, NMI will occure immediately after start
 STA $DD0E

 LDA #$81
 STA $DD0D      ; Set timer A as source for NMI

 LDA #$01
 STA $DD0E       ; Start timer A -> NMI

 LDA #SCRNBANK
 STA $DD00 ; bank
 
 LDA #BANK
 STA $D018    ;VIC Memory Control Register
    
 LDA #$00     ; screen and border
 STA $D020
 LDA #$00 ; $00
 STA $D021
 LDA #$0B ; $00
 STA $D022
 LDA #$0F ; $00
 STA $D023

 LDA #%00111011 ; 0-2=SCRL 3=25/24 $3B ; 3B ; bitmap mode? - finding 0011=3 1011=b
 STA $D011    ;VIC Control Register 1

 LDA #%00010000;111 ;000 ; 0-2=SCRL 3=38/40 4=MCM 5-7=UNUSED
 STA $D016    ;VIC Control Register 2

; $1B for $D011 and $C8 for $D016.

  LDA #1
  STA SPRCLR1
  LDA #15
  STA SPRCLR2

  LDA #255
  STA SPRENBL
  STA SPRMULTI
  
  LDA #0
  STA SPRPRI
  
  LDA #254
  STA SPRXPX
  LDA #0
  STA SPRXPY
  LDA #SPRMSB
  STA SPRXMSB

  LDA #60
  STA S0X
  STA S0Y
 
  
  LDA #11
  STA S0C

  
 LDA #20
 STA XPOS
 STA YPOS
 
JSR SCREEN_SETUP
JSR BUILD_MAP_SCN_ADDR
JSR BUILD_LANDSCAPE

; draw a sprite on screen
; draw 7 sprites on screen
; draw 7 
; todo - setup sprites in memory
; 

CLI ; enable maskable interrupts again

MLOOP: JMP  MLOOP

; LDX TX
; LDA TY
; LDY #4
; JSR HEX16


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
          STA   JOYF
          STX   JOYX
          STY   JOYY
          LSR
          RTS

 
!ALIGN 255,0
!ZONE PUT
PUT     BMI   .PLOT1
.PLOT0  STA   .TEMP0+1
        LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_SCN_LSB_HI,Y 
        STA   SCR_HI

        LDA   PUT_LO,X  ; put colour address
        STA   .JUMP0+1
.TEMP0  LDX   #0        ; restore HOR   

        LDY   HOR_TAB,X
        LDA   (SCR),Y
      
.JUMP0  JMP   PLOTDBL00

.PLOT1  STA   .TEMP1+1
        LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_SCN_MSB_HI,Y 
        STA   SCR_HI

        LDA   PUT_LO,X  ; put colour address
        STA   .JUMP1+1
.TEMP1  LDX   #0        ; restore HOR   

        LDY   HOR_TAB,X
        LDA   (SCR),Y
      
.JUMP1  JMP   PLOTDBL00
        
PLOTDBL00 ;LDA   (SCR),Y
          AND   AND_00_TAB,X
          STA   (SCR),Y 
          RTS

PLOTDBL01 ;LDA   (SCR),Y
          AND   AND_00_TAB,X
          ORA   OR_01_TAB,X
          STA   (SCR),Y 
          RTS

PLOTDBL10 ;LDA   (SCR),Y
          AND   AND_00_TAB,X
          ORA   OR_10_TAB,X
          STA   (SCR),Y 
          RTS
          
PLOTDBL11 ;LDA   (SCR),Y
          ORA   OR_11_TAB,X
          STA   (SCR),Y 
          RTS

!ZONE PLOT01
PLOT01  BMI   .PLOT1
.PLOT0  LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_SCN_LSB_HI,Y 
        STA   SCR_HI 
        LDY   HOR_TAB,X
        LDA   (SCR),Y
        AND   AND_00_TAB,X
        ORA   OR_01_TAB,X
        STA   (SCR),Y 
        RTS
.PLOT1  LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_SCN_MSB_HI,Y 
        STA   SCR_HI 
        LDY   HOR_TAB,X
        LDA   (SCR),Y
        AND   AND_00_TAB,X
        ORA   OR_01_TAB,X
        STA   (SCR),Y 
        RTS

!ZONE PLOT11
PLOT11  BMI   .PLOT1
.PLOT0  LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_SCN_LSB_HI,Y 
        STA   SCR_HI 
        LDY   HOR_TAB,X
        LDA   (SCR),Y
        ORA   OR_11_TAB,X
        STA   (SCR),Y 
        RTS
.PLOT1  LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_SCN_MSB_HI,Y 
        STA   SCR_HI 
        LDY   HOR_TAB,X
        LDA   (SCR),Y
        ORA   OR_11_TAB,X
        STA   (SCR),Y 
        RTS

!ZONE PLOT00
PLOT00  BMI   .PLOT1
.PLOT0  LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_SCN_LSB_HI,Y 
        STA   SCR_HI 
        LDY   HOR_TAB,X
        LDA   (SCR),Y
        AND   AND_00_TAB,X
        STA   (SCR),Y 
        RTS
.PLOT1  LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_SCN_MSB_HI,Y 
        STA   SCR_HI 
        LDY   HOR_TAB,X
        LDA   (SCR),Y
        AND   AND_00_TAB,X
        STA   (SCR),Y 
        RTS

!ZONE PLOT10
PLOT10  BMI   .PLOT1
.PLOT0  LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_SCN_LSB_HI,Y 
        STA   SCR_HI 
        LDY   HOR_TAB,X
        LDA   (SCR),Y
        AND   AND_00_TAB,X
        ORA   OR_10_TAB,X
        STA   (SCR),Y 
        RTS
.PLOT1  LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_SCN_MSB_HI,Y 
        STA   SCR_HI 
        LDY   HOR_TAB,X
        LDA   (SCR),Y
        AND   AND_00_TAB,X
        ORA   OR_10_TAB,X
        STA   (SCR),Y 
        RTS

;!ZONE DRAW_BLOCK
;DRAW_BLOCK
; set colour
; for x eq start to end
;  for y eq start to end
;   plot colour        
 
!ZONE BLOCK ; y=start / a=end / x=pattern
BLOCK STA  REGA_BUF
 STX  REGX_BUF
.LOOP
   STY  REGY_BUF
   LDX  REGX_BUF
   JSR  LINE
   
   LDY  REGY_BUF
   INY
   CPY  REGA_BUF
   BNE  .LOOP

 RTS
 
!ZONE LINE ; y = ver / x=pattern
LINE    LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_SCN_LSB_HI,Y 
        STA   SCR_HI
        LDA   #0
.LOOP_LSB TAY
          TXA     
          STA  (SCR),Y 
          TYA
          SEC
          SBC   #8
          BNE   .LOOP_LSB

        INC   SCR_HI
        LDA   #48

.LOOP_MSB TAY
          TXA     
          STA  (SCR),Y 
          TYA
          SEC
          SBC   #8
          BPL   .LOOP_MSB

        RTS
          

!ZONE MEMSET        
MEMSET       STY    .LSB_ONLY+1 ; store LSB count
             CPX    #0          ; MSB?     
             BEQ    .LSB_ONLY   ; no

             LDY    #0          ; yes so reset LSB
.MSB_LOOP  
.LSB_LOOP      STA    (SCR),Y   ; clear whole MSB
               DEY 
               BNE    .LSB_LOOP

              INC    SCR+1      ; inc MSB
              DEX               ; dec MSB count
              BNE    .MSB_LOOP

.LSB_ONLY    LDY    #0          ; LSB count 
             BEQ    .MS_END     ; not needed

.LAST_LSB_LOOP STA   (SCR),Y
               DEY 
               BNE   .LAST_LSB_LOOP
                
              STA   (SCR),Y     ; clear last Y (0)
 
.MS_END      RTS

; pass in 16 bit number
; 0123456789012345
; xxxxxhllllllllss
; pass in X=LSB Y=MSB
; return scroll var 0-3
; return char pos 0-255
; return msb 0-1

!ZONE CALC_LANDSCAPE_CHAR_MSB_PIXEL
CALC_LANDSCAPE_CHAR_MSB_PIXEL ; convert 0-1023 to 0-3 pixel pos + 0-255 map pos + 0-1 msb pos
  TXA
  EOR #%11111111
  AND #%00000011
  ORA #%00010000
  STA MAP_PIXEL

  STX MAP_CHAR
  TYA
  LSR
  ROR MAP_CHAR
  LSR
  ROR MAP_CHAR ; shift top 2 bits of msb into lsb
  
  AND #%00000001
  STA MAP_MSB
  RTS

!ZONE CALC_LANDSCAPE_CHAR_MSB_PIXEL_WORKS
CALC_LANDSCAPE_CHAR_MSB_PIXEL_WORKS ; convert 0-1023 to 0-3 pixel pos + 0-255 map pos + 0-1 msb pos
  TXA
  EOR #%11111111
  AND #%00000011
  ORA #%00010000
  STA MAP_PIXEL

  STY MAP_MSB
  TXA
  LSR MAP_MSB
  ROR
  LSR MAP_MSB
  ROR
  STA MAP_CHAR

  LDA MAP_MSB
  AND #%00000001
  STA MAP_MSB
  RTS


!ZONE IRQ_1
IRQ_1:
  INC $D019    ;VIC Interrupt Request Register (IRR)

    DEC $d020
    STA REGA_INT
    STX REGX_INT
    STY REGY_INT
;    INC $d020

  LDA #%00010000
  STA $D016
 
  LDA #254 ; 194 ; off bottom of screen for now?
  STA S1Y
  STA S2Y
  STA S3Y
  STA S4Y
  STA S5Y
  STA S6Y
  STA S7Y

  LDA #12
  STA S1C
  STA S2C
  STA S3C
  STA S4C
  STA S5C
  STA S6C
  STA S7C

  LDA #(16+(48*0))
  STA S1X
  LDA #(16+(48*1))
  STA S2X
  LDA #(16+(48*2))
  STA S3X
  LDA #(16+(48*3))
  STA S4X
  LDA #(16+(48*4))
  STA S5X
  LDA #0 ; (16+(48*5))
  STA S6X
  LDA #48 ; (16+(48*5))
  STA S7X

 LDX #112+1
; STX SCRNCOL+1016
; INX
 STX SCNCOL+1017
 INX
 STX SCNCOL+1018
 INX
 STX SCNCOL+1019
 INX
 STX SCNCOL+1020
 INX
 STX SCNCOL+1021
 INX
 STX SCNCOL+1022
 INX
 STX SCNCOL+1023


 LDX #1
 LDY #198
 LDA #30
 JSR PUT

 LDX #0
 LDY #199
 LDA #40
 JSR PUT

 inc $D020
 JSR CLEAR_LANDSCAPE
 inc $D020

 JSR MOVE_PLR
 inc $d020
 JSR CALC_LANDSCAPE_CHAR_MSB_PIXEL
 dec $d020
 JSR BUILD_LANDSCAPE
 dec $d020
 JSR DRAW_LANDSCAPE
 dec $d020

 LDA MAP_PIXEL ; set scroll pos when raster is in border
 STA $D016

 LDA YPOS ; put new pos
 STA S0Y
 LDA XPOS
 ASL
 STA S0X
 LDA #SPRMSB
 ADC #0
 STA SPRXMSB
`
 LDA MAP_PIXEL
 LDX #16
 LDY #185
 JSR HEX8
 LDA MAP_CHAR
 LDX #48
 LDY #185
 JSR HEX8
 LDA MAP_MSB
 LDX #72
 LDY #185
 JSR HEX8

 LDA XPOS
 LDX #48
 LDY #179
 JSR HEX8
 LDA XPOS +1
 LDX #16
 LDY #179
 JSR HEX8
 
; LDA TEST1
; LDX #72
; LDY #179
; JSR HEX8
; LDA TEST2
; LDX #72
; LDY #185
; JSR HEX8


 LDA #<IRQ_1
 STA $FFFE
 LDA #>IRQ_1
 STA $FFFF

; LDA #RASTER1
; STA $D012

;  DEC $d020
  LDA REGA_INT
  LDX REGX_INT
  LDY REGY_INT
  INC $d020

NMI_NOP:
RTI ; This is the irq handler for the NMI. Just returns without acknowledge. This prevents subsequent NMI's from interfering.

!ZONE SCREEN_SETUP
SCREEN_SETUP

  ldy #31
  ldx #62
.loop 
    lda VER_TAB_0_LO+64,y
    sta 128,x
    sta 128+64,x
    lda VER_TAB_SCN_LSB_HI+64,y
    sta 128+1,x
    lda VER_TAB_SCN_MSB_HI+64,y
    sta 128+64+1,x
    dex
    dex
    dey
    bpl .loop    

;  LDX  #<MAP2 ; needs moved to setup screen? once only
;  LDY  #>MAP2
;  STX MAPADDR2
;  STY MAPADDR2+1

 LDA #0 ; $65 ; 0 ;$65 ; colour 01 (0000????) and colour 10 (????0000) - bank 1
 LDX #<SCN
 LDY #>SCN
 STX SCR+0
 STY SCR+1
 LDX #>8000 
 LDY #<8000
 JSR MEMSET
 
 LDA #$01 ; $01 ; colour 11 
 LDX #<$D800
 LDY #>$D800
 STX SCR+0
 STY SCR+1
 LDX #>1000 
 LDY #<1000
 JSR MEMSET

 LDA #$BC ;$65 ; colour 01 (0000????) and colour 10 (????0000) - bank 1
 LDX #<SCNCOL
 LDY #>SCNCOL
 STX SCR+0
 STY SCR+1
 LDX #>1000 
 LDY #<1000
 JSR MEMSET

 LDA #%00010001
 LDX #<SPR00_ADDR
 LDY #>SPR00_ADDR
 STX SCR+0
 STY SCR+1
 LDX #>63 
 LDY #<63
 JSR MEMSET

 LDA #0 ; %00100010
 LDX #<SPR01_ADDR
 LDY #>SPR01_ADDR
 STX SCR+0
 STY SCR+1
 LDX #>63 
 LDY #<63
 JSR MEMSET

 LDA #0 ; %00110011
 LDX #<SPR02_ADDR
 LDY #>SPR02_ADDR
 STX SCR+0
 STY SCR+1
 LDX #>63 
 LDY #<63
 JSR MEMSET

 LDA #0 ; %01000100
 LDX #<SPR03_ADDR
 LDY #>SPR03_ADDR
 STX SCR+0
 STY SCR+1
 LDX #>63 
 LDY #<63
 JSR MEMSET

 LDA #0 ; %01010101
 LDX #<SPR04_ADDR
 LDY #>SPR04_ADDR
 STX SCR+0
 STY SCR+1
 LDX #>63 
 LDY #<63
 JSR MEMSET

 LDA #0 ; %01100110
 LDX #<SPR05_ADDR
 LDY #>SPR05_ADDR
 STX SCR+0
 STY SCR+1
 LDX #>63 
 LDY #<63
 JSR MEMSET

 LDA #0 ; %01110111
 LDX #<SPR06_ADDR
 LDY #>SPR06_ADDR
 STX SCR+0
 STY SCR+1
 LDX #>63 
 LDY #<63
 JSR MEMSET

 LDA #0 ; %10001000
 LDX #<SPR07_ADDR
 LDY #>SPR07_ADDR
 STX SCR+0
 STY SCR+1
 LDX #>63 
 LDY #<63
 JSR MEMSET

 LDA #%10101010
 LDX #<SPR10_ADDR
 LDY #>SPR10_ADDR
 STX SCR+0
 STY SCR+1
 LDX #>63 
 LDY #<63
 JSR MEMSET

 LDA #%10101010
 LDX #<SPR11_ADDR
 LDY #>SPR11_ADDR
 STX SCR+0
 STY SCR+1
 LDX #>63 
 LDY #<63
 JSR MEMSET

 LDA #%10101010
 LDX #<SPR12_ADDR
 LDY #>SPR12_ADDR
 STX SCR+0
 STY SCR+1
 LDX #>63 
 LDY #<63
 JSR MEMSET

 LDA #%10101010
 LDX #<SPR13_ADDR
 LDY #>SPR13_ADDR
 STX SCR+0
 STY SCR+1
 LDX #>63 
 LDY #<63
 JSR MEMSET

 LDA #%10101010
 LDX #<SPR14_ADDR
 LDY #>SPR14_ADDR
 STX SCR+0
 STY SCR+1
 LDX #>63 
 LDY #<63
 JSR MEMSET

 LDA #%10101010
 LDX #<SPR15_ADDR
 LDY #>SPR15_ADDR
 STX SCR+0
 STY SCR+1
 LDX #>63 
 LDY #<63
 JSR MEMSET

 LDA #%10101010
 LDX #<SPR16_ADDR
 LDY #>SPR16_ADDR
 STX SCR+0
 STY SCR+1
 LDX #>63 
 LDY #<63
 JSR MEMSET

 LDA #%10101010
 LDX #<SPR17_ADDR
 LDY #>SPR17_ADDR
 STX SCR+0
 STY SCR+1
 LDX #>63 
 LDY #<63
 JSR MEMSET

  LDY  #0
  LDX  #%11111111
  JSR  LINE
 
  LDY  #169
  LDX  #%11111111
  JSR  LINE

  LDY #170
  LDA #176
  LDX #%10101010
  JSR  BLOCK

  LDY  #170
  LDX  #0
  JSR  LINE
 
  LDY  #176
  LDX  #0
  JSR  LINE

  LDY #177
  LDA #199
  LDX #%01010101
  JSR  BLOCK

  LDY  #177
  LDX  #%11111111
  JSR  LINE

  LDY  #199
  LDX  #%11111111
  JSR  LINE

 RTS

; 1 full line ; line 0
; 168 21*8 lines (4*8=ground) ; 1 to 168
; 1 full line ; line 169 
; 1 empty line ; line 170
; 5 status lines ; ine 171 to 175
; 1 empty line ; line 176
; 1 fill line ; line 177
; 21  map lines
; 1 full line ; 199
; =200 lines  

;TEST1 !BYTE 0
;TEST2 !BYTE 0

!ZONE MOVE_PLR
MOVE_PLR  JSR JOYSTICK2 ; x and y already contain x and y joy pos?
          TYA
          CLC
          ADC   YPOS
          STA   YPOS  ; vertical

          TXA
          BEQ   .EXIT
          BMI   .RIGHT

.LEFT     STA   .LFT +1
;          STA TEST1
          LDA   XPOS
          CLC
.LFT      ADC   #0 
          STA   XPOS
          TAX
          LDA   XPOS +1
          ADC   #0
          AND   #7
          STA   XPOS +1
          TAY
          RTS

.RIGHT    EOR   #$FF
          CLC
          ADC   #1    ; carry is clear
          STA   .RGT +1
;          STA TEST2
          SEC
          LDA   XPOS
.RGT      SBC   #0 
          STA   XPOS
          TAX
          LDA   XPOS +1
          SBC   #0
          AND   #7
          STA   XPOS +1
          TAY
          RTS

.EXIT     LDX XPOS
          LDY XPOS +1
          RTS

HOR_TAB:
!FILL 4,00*8
!FILL 4,01*8
!FILL 4,02*8
!FILL 4,03*8
!FILL 4,04*8
!FILL 4,05*8
!FILL 4,06*8
!FILL 4,07*8
!FILL 4,08*8
!FILL 4,09*8
!FILL 4,10*8
!FILL 4,11*8
!FILL 4,12*8
!FILL 4,13*8
!FILL 4,14*8
!FILL 4,15*8
!FILL 4,16*8
!FILL 4,17*8
!FILL 4,18*8
!FILL 4,19*8
!FILL 4,20*8
!FILL 4,21*8
!FILL 4,22*8
!FILL 4,23*8
!FILL 4,24*8
!FILL 4,25*8
!FILL 4,26*8
!FILL 4,27*8
!FILL 4,28*8
!FILL 4,29*8
!FILL 4,30*8
!FILL 4,31*8
!FILL 4,00*8
!FILL 4,01*8
!FILL 4,02*8
!FILL 4,03*8
!FILL 4,04*8
!FILL 4,05*8
!FILL 4,06*8
!FILL 4,07*8

AND_00_TAB:
!for I = 1 TO 80
!BYTE $3F,$CF,$F3,$FC
!end

OR_11_TAB:
!for I = 1 TO 80
!BYTE $C0,$30,$0C,$03
!end

OR_01_TAB:
!for I = 1 TO 80
!BYTE $40,$10,$04,$01
!end

OR_10_TAB:
!for I = 1 TO 80
!BYTE $80,$20,$08,$02
!end


!align 255,0
VER_TAB_SCN_LSB_HI
!for I = 0 TO 24
!BYTE >(SCN+(I*320)+0),>(SCN+(I*320)+1),>(SCN+(I*320)+2),>(SCN+(I*320)+3),>(SCN+(I*320)+4),>(SCN+(I*320)+5),>(SCN+(I*320)+6),>(SCN+(I*320)+7)
!end

!align 255,0
VER_TAB_SCN_MSB_HI
!for I = 0 TO 24
!BYTE >((SCN+256)+(I*320)+0),>((SCN+256)+(I*320)+1),>((SCN+256)+(I*320)+2),>((SCN+256)+(I*320)+3),>((SCN+256)+(I*320)+4),>((SCN+256)+(I*320)+5),>((SCN+256)+(I*320)+6),>((SCN+256)+(I*320)+7)
!end

!align 255,0
VER_TAB_0_LO
!for I = 0 TO 24
!BYTE <(SCN+(I*320)+0),<(SCN+(I*320)+1),<(SCN+(I*320)+2),<(SCN+(I*320)+3),<(SCN+(I*320)+4),<(SCN+(I*320)+5),<(SCN+(I*320)+6),<(SCN+(I*320)+7)
!end

PUT_LO !BYTE <PLOTDBL00,<PLOTDBL01,<PLOTDBL10,<PLOTDBL11

!align 255,0
MAP2
 !BYTE 100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131
 !BYTE 130,129,128,127,126,125,124,123,122,121,120,119,118,117,116,115,114,113,112,111,110,109,108,107,106,105,104,103,102,101,100,099

 !BYTE 100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131
 !BYTE 130,129,128,127,126,125,124,123,122,121,120,119,118,117,116,115,114,113,112,111,110,109,108,107,106,105,104,103,102,101,100,099

 !BYTE 100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131
 !BYTE 130,129,128,127,126,125,124,123,122,121,120,119,118,117,116,115,114,113,112,111,110,109,108,107,106,105,104,103,102,101,100,099

 !BYTE 100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131
 !BYTE 130,129,128,127,126,125,124,123,122,121,120,119,118,117,116,115,114,113,112,111,110,109,108,107,106,105,104,103,102,101,100,099

 !BYTE 100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131
 !BYTE 130,129,128,127,126,125,124,123,122,121,120,119,118,117,116,115,114,113,112,111,110,109,108,107,106,105,104,103,102,101,100,099

 !BYTE 100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131
 !BYTE 130,129,128,127,126,125,124,123,122,121,120,119,118,117,116,115,114,113,112,111,110,109,108,107,106,105,104,103,102,101,100,099

 !BYTE 100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131
 !BYTE 130,129,128,127,126,125,124,123,122,121,120,119,118,117,116,115,114,113,112,111,110,109,108,107,106,105,104,103,102,101,100,099

 !BYTE 100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131
 !BYTE 130,129,128,127,126,125,124,123,122,121,120,119,118,117,116,115,114,113,112,111,110,109,108,107,106,105,104,103,102,101,100,099

 !BYTE 100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131
 !BYTE 130,129,128,127,126,125,124,123,122,121,120,119,118,117,116,115,114,113,112,111,110,109,108,107,106,105,104,103,102,101,100,099

 !BYTE 100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131
 !BYTE 130,129,128,127,126,125,124,123,122,121,120,119,118,117,116,115,114,113,112,111,110,109,108,107,106,105,104,103,102,101,100,099
 
HEXCHAR   LDA   HEX0,Y
HEX_NUMBER0 STA   $ABCD,X
      LDA   HEX1,Y
HEX_NUMBER1 STA   $ABCD,X
      LDA   HEX2,Y
HEX_NUMBER2 STA   $ABCD,X
      LDA   HEX3,Y
HEX_NUMBER3 STA   $ABCD,X
      LDA   HEX4,Y
HEX_NUMBER4 STA   $ABCD,X
      RTS

HEX16 STY   REGY_BUF  ; Y = YPOS / A = HI / X = LO
      STX   REGX_BUF    
      LDX   #0
      JSR   HEX8
      LDA   REGX_BUF
      LDY   REGY_BUF
      LDX   #16
      JSR   HEX8
      RTS

HEX8 ; A = NUM / Y = YPOS / X = XPOS

      STA   REGA_BUF
      LDA   VER_TAB_0_LO+0,Y
      STA   HEX_NUMBER0+1
      
      LDA   VER_TAB_SCN_LSB_HI+0,Y
      STA   HEX_NUMBER0+2

      LDA   VER_TAB_0_LO+1,Y
      STA   HEX_NUMBER1+1
      
      LDA   VER_TAB_SCN_LSB_HI+1,Y 
      STA   HEX_NUMBER1+2

      LDA   VER_TAB_0_LO+2,Y
      STA   HEX_NUMBER2+1
      
      LDA   VER_TAB_SCN_LSB_HI+2,Y 
      STA   HEX_NUMBER2+2

      LDA   VER_TAB_0_LO+3,Y
      STA   HEX_NUMBER3+1
      
      LDA   VER_TAB_SCN_LSB_HI+3,Y 
      STA   HEX_NUMBER3+2

      LDA   VER_TAB_0_LO+4,Y
      STA   HEX_NUMBER4+1
      
      LDA   VER_TAB_SCN_LSB_HI+4,Y 
      STA   HEX_NUMBER4+2

      LDA   REGA_BUF
      LSR
      LSR
      LSR
      LSR
      TAY
      JSR   HEXCHAR

      TXA
      CLC
      ADC   #8
      TAX

      LDA   REGA_BUF
      AND   #15
      TAY
      JSR   HEXCHAR

      RTS

HEX0  !BYTE %10000000,%10100010,%10000000,%10000000,%10001000,%10000000,%10000000,%10000000,%10000000,%10000000,%10000000,%10000000,%10000000,%10000010,%10000000,%10000000 
HEX1  !BYTE %10001000,%10000010,%10101000,%10101000,%10001000,%10001010,%10001010,%10101000,%10001000,%10001000,%10001000,%10001000,%10001010,%10001000,%10001010,%10001010 
HEX2  !BYTE %10001000,%10100010,%10000000,%10000000,%10000000,%10000000,%10000000,%10101000,%10000000,%10000000,%10000000,%10000010,%10001010,%10001000,%10000000,%10000000
HEX3  !BYTE %10001000,%10100010,%10001010,%10101000,%10101000,%10101000,%10001000,%10101000,%10001000,%10101000,%10001000,%10001000,%10001010,%10001000,%10001010,%10001010
HEX4  !BYTE %10000000,%10000000,%10000000,%10000000,%10101000,%10000000,%10000000,%10101000,%10000000,%10000000,%10001000,%10000000,%10100000,%10000010,%10000000,%10001010

!ZONE SET_CHR_LSB
!MACRO SET_CHR_LSB R1 {
    LDA (MAP_SCN_LO_ZP),Y
    STA R1 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA R1 +1
}

!ZONE SET_CHR_MSB
!MACRO SET_CHR_MSB R1 {
    LDA (MAP_SCN_LO_ZP),Y
    STA R1 +0
    LDA (MAP_SCN_MSB_HI_ZP),Y
    STA R1 +1
}

!ZONE BUILD_LANDSCAPE
BUILD_LANDSCAPE
    LDA #<MAP_SCN_LO
    CLC
    ADC MAP_CHAR
    STA MAP_SCN_LO_ZP +0
    LDA #>MAP_SCN_LO
    CLC
    ADC MAP_MSB
    STA MAP_SCN_LO_ZP +1

    LDA #<MAP_SCN_LSB_HI
    CLC
    ADC MAP_CHAR
    STA MAP_SCN_LSB_HI_ZP +0
    LDA #>MAP_SCN_LSB_HI
    CLC
    ADC MAP_MSB
    STA MAP_SCN_LSB_HI_ZP +1

    LDA #<MAP_SCN_MSB_HI
    CLC
    ADC MAP_CHAR
    STA MAP_SCN_MSB_HI_ZP +0
    LDA #>MAP_SCN_MSB_HI
    CLC
    ADC MAP_MSB
    STA MAP_SCN_MSB_HI_ZP +1

    LDY #0
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_00 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_00 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_00 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_00 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_01 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_01 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_01 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_01 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_02 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_02 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_02 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_02 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_03 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_03 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_03 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_03 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_04 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_04 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_04 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_04 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_05 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_05 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_05 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_05 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_06 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_06 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_06 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_06 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_07 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_07 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_07 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_07 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_08 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_08 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_08 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_08 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_09 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_09 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_09 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_09 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_10 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_10 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_10 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_10 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_11 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_11 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_11 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_11 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_12 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_12 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_12 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_12 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_13 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_13 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_13 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_13 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_14 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_14 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_14 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_14 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_15 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_15 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_15 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_15 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_16 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_16 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_16 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_16 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_17 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_17 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_17 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_17 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_18 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_18 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_18 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_18 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_19 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_19 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_19 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_19 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_20 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_20 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_20 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_20 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_21 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_21 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_21 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_21 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_22 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_22 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_22 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_22 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_23 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_23 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_23 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_23 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_24 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_24 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_24 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_24 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_25 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_25 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_25 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_25 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_26 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_26 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_26 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_26 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_27 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_27 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_27 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_27 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_28 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_28 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_28 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_28 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_29 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_29 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_29 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_29 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_30 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_30 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_30 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_30 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_31 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_LFT_31 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_31 +0
    LDA (MAP_SCN_LSB_HI_ZP),Y
    STA SCN_LN_RGT_31 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_32 +0
    LDA (MAP_SCN_MSB_HI_ZP),Y
    STA SCN_LN_LFT_32 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_32 +0
    LDA (MAP_SCN_MSB_HI_ZP),Y
    STA SCN_LN_RGT_32 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_33 +0
    LDA (MAP_SCN_MSB_HI_ZP),Y
    STA SCN_LN_LFT_33 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_33 +0
    LDA (MAP_SCN_MSB_HI_ZP),Y
    STA SCN_LN_RGT_33 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_34 +0
    LDA (MAP_SCN_MSB_HI_ZP),Y
    STA SCN_LN_LFT_34 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_34 +0
    LDA (MAP_SCN_MSB_HI_ZP),Y
    STA SCN_LN_RGT_34 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_35 +0
    LDA (MAP_SCN_MSB_HI_ZP),Y
    STA SCN_LN_LFT_35 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_35 +0
    LDA (MAP_SCN_MSB_HI_ZP),Y
    STA SCN_LN_RGT_35 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_36 +0
    LDA (MAP_SCN_MSB_HI_ZP),Y
    STA SCN_LN_LFT_36 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_36 +0
    LDA (MAP_SCN_MSB_HI_ZP),Y
    STA SCN_LN_RGT_36 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_37 +0
    LDA (MAP_SCN_MSB_HI_ZP),Y
    STA SCN_LN_LFT_37 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_37 +0
    LDA (MAP_SCN_MSB_HI_ZP),Y
    STA SCN_LN_RGT_37 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_38 +0
    LDA (MAP_SCN_MSB_HI_ZP),Y
    STA SCN_LN_LFT_38 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_38 +0
    LDA (MAP_SCN_MSB_HI_ZP),Y
    STA SCN_LN_RGT_38 +1

    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_LFT_39 +0
    LDA (MAP_SCN_MSB_HI_ZP),Y
    STA SCN_LN_LFT_39 +1
    INY
    LDA (MAP_SCN_LO_ZP),Y
    STA SCN_LN_RGT_39 +0
    LDA (MAP_SCN_MSB_HI_ZP),Y
    STA SCN_LN_RGT_39 +1

    RTS

!ZONE DRAW_LANDSCAPE
DRAW_LANDSCAPE
          LDA #$F0
          LDY #0*8
          STA (SCN_LN_LFT_00),Y
          LDY #1*8
          STA (SCN_LN_LFT_01),Y
          LDY #2*8
          STA (SCN_LN_LFT_02),Y
          LDY #3*8
          STA (SCN_LN_LFT_03),Y
          LDY #4*8
          STA (SCN_LN_LFT_04),Y
          LDY #5*8
          STA (SCN_LN_LFT_05),Y
          LDY #6*8
          STA (SCN_LN_LFT_06),Y
          LDY #7*8
          STA (SCN_LN_LFT_07),Y
          LDY #8*8
          STA (SCN_LN_LFT_08),Y
          LDY #9*8
          STA (SCN_LN_LFT_09),Y
          LDY #10*8
          STA (SCN_LN_LFT_10),Y
          LDY #11*8
          STA (SCN_LN_LFT_11),Y
          LDY #12*8
          STA (SCN_LN_LFT_12),Y
          LDY #13*8
          STA (SCN_LN_LFT_13),Y
          LDY #14*8
          STA (SCN_LN_LFT_14),Y
          LDY #15*8
          STA (SCN_LN_LFT_15),Y
          LDY #16*8
          STA (SCN_LN_LFT_16),Y
          LDY #17*8
          STA (SCN_LN_LFT_17),Y
          LDY #18*8
          STA (SCN_LN_LFT_18),Y
          LDY #19*8
          STA (SCN_LN_LFT_19),Y
          LDY #20*8
          STA (SCN_LN_LFT_20),Y
          LDY #21*8
          STA (SCN_LN_LFT_21),Y
          LDY #22*8
          STA (SCN_LN_LFT_22),Y
          LDY #23*8
          STA (SCN_LN_LFT_23),Y
          LDY #24*8
          STA (SCN_LN_LFT_24),Y
          LDY #25*8
          STA (SCN_LN_LFT_25),Y
          LDY #26*8
          STA (SCN_LN_LFT_26),Y
          LDY #27*8
          STA (SCN_LN_LFT_27),Y
          LDY #28*8
          STA (SCN_LN_LFT_28),Y
          LDY #29*8
          STA (SCN_LN_LFT_29),Y
          LDY #30*8
          STA (SCN_LN_LFT_30),Y
          LDY #31*8
          STA (SCN_LN_LFT_31),Y
          LDY #0*8
          STA (SCN_LN_LFT_32),Y
          LDY #1*8
          STA (SCN_LN_LFT_33),Y
          LDY #2*8
          STA (SCN_LN_LFT_34),Y
          LDY #3*8
          STA (SCN_LN_LFT_35),Y
          LDY #4*8
          STA (SCN_LN_LFT_36),Y
          LDY #5*8
          STA (SCN_LN_LFT_37),Y 
          LDY #6*8
          STA (SCN_LN_LFT_38),Y
          LDY #7*8
          STA (SCN_LN_LFT_39),Y
 
          LDA #$0F
          LDY #0*8
          STA (SCN_LN_RGT_00),Y
          LDY #1*8
          STA (SCN_LN_RGT_01),Y
          LDY #2*8
          STA (SCN_LN_RGT_02),Y
          LDY #3*8
          STA (SCN_LN_RGT_03),Y
          LDY #4*8
          STA (SCN_LN_RGT_04),Y
          LDY #5*8
          STA (SCN_LN_RGT_05),Y
          LDY #6*8
          STA (SCN_LN_RGT_06),Y
          LDY #7*8
          STA (SCN_LN_RGT_07),Y
          LDY #8*8
          STA (SCN_LN_RGT_08),Y
          LDY #9*8
          STA (SCN_LN_RGT_09),Y
          LDY #10*8
          STA (SCN_LN_RGT_10),Y
          LDY #11*8
          STA (SCN_LN_RGT_11),Y
          LDY #12*8
          STA (SCN_LN_RGT_12),Y
          LDY #13*8
          STA (SCN_LN_RGT_13),Y
          LDY #14*8
          STA (SCN_LN_RGT_14),Y
          LDY #15*8
          STA (SCN_LN_RGT_15),Y
          LDY #16*8
          STA (SCN_LN_RGT_16),Y
          LDY #17*8
          STA (SCN_LN_RGT_17),Y
          LDY #18*8
          STA (SCN_LN_RGT_18),Y
          LDY #19*8
          STA (SCN_LN_RGT_19),Y
          LDY #20*8
          STA (SCN_LN_RGT_20),Y
          LDY #21*8
          STA (SCN_LN_RGT_21),Y
          LDY #22*8
          STA (SCN_LN_RGT_22),Y
          LDY #23*8
          STA (SCN_LN_RGT_23),Y
          LDY #24*8
          STA (SCN_LN_RGT_24),Y
          LDY #25*8
          STA (SCN_LN_RGT_25),Y
          LDY #26*8
          STA (SCN_LN_RGT_26),Y
          LDY #27*8
          STA (SCN_LN_RGT_27),Y
          LDY #28*8
          STA (SCN_LN_RGT_28),Y
          LDY #29*8
          STA (SCN_LN_RGT_29),Y
          LDY #30*8
          STA (SCN_LN_RGT_30),Y
          LDY #31*8
          STA (SCN_LN_RGT_31),Y
          LDY #0*8
          STA (SCN_LN_RGT_32),Y
          LDY #1*8
          STA (SCN_LN_RGT_33),Y
          LDY #2*8
          STA (SCN_LN_RGT_34),Y
          LDY #3*8
          STA (SCN_LN_RGT_35),Y
          LDY #4*8
          STA (SCN_LN_RGT_36),Y
          LDY #5*8
          STA (SCN_LN_RGT_37),Y 
          LDY #6*8
          STA (SCN_LN_RGT_38),Y
          LDY #7*8
          STA (SCN_LN_RGT_39),Y
    RTS

!ZONE CLEAR_LANDSCAPE
CLEAR_LANDSCAPE
          LDA #%0
          TAY
;          LDY #0*8
          STA (SCN_LN_LFT_00),Y
          STA (SCN_LN_RGT_00),Y
          LDY #1*8
          STA (SCN_LN_LFT_01),Y
          STA (SCN_LN_RGT_01),Y
          LDY #2*8
          STA (SCN_LN_LFT_02),Y
          STA (SCN_LN_RGT_02),Y
          LDY #3*8
          STA (SCN_LN_LFT_03),Y
          STA (SCN_LN_RGT_03),Y
          LDY #4*8
          STA (SCN_LN_LFT_04),Y
          STA (SCN_LN_RGT_04),Y
          LDY #5*8
          STA (SCN_LN_LFT_05),Y
          STA (SCN_LN_RGT_05),Y
          LDY #6*8
          STA (SCN_LN_LFT_06),Y
          STA (SCN_LN_RGT_06),Y
          LDY #7*8
          STA (SCN_LN_LFT_07),Y
          STA (SCN_LN_RGT_07),Y
          LDY #8*8
          STA (SCN_LN_LFT_08),Y
          STA (SCN_LN_RGT_08),Y
          LDY #9*8
          STA (SCN_LN_LFT_09),Y
          STA (SCN_LN_RGT_09),Y
          LDY #10*8
          STA (SCN_LN_LFT_10),Y
          STA (SCN_LN_RGT_10),Y
          LDY #11*8
          STA (SCN_LN_LFT_11),Y
          STA (SCN_LN_RGT_11),Y
          LDY #12*8
          STA (SCN_LN_LFT_12),Y
          STA (SCN_LN_RGT_12),Y
          LDY #13*8
          STA (SCN_LN_LFT_13),Y
          STA (SCN_LN_RGT_13),Y
          LDY #14*8
          STA (SCN_LN_LFT_14),Y
          STA (SCN_LN_RGT_14),Y
          LDY #15*8
          STA (SCN_LN_LFT_15),Y
          STA (SCN_LN_RGT_15),Y
          LDY #16*8
          STA (SCN_LN_LFT_16),Y
          STA (SCN_LN_RGT_16),Y
          LDY #17*8
          STA (SCN_LN_LFT_17),Y
          STA (SCN_LN_RGT_17),Y
          LDY #18*8
          STA (SCN_LN_LFT_18),Y
          STA (SCN_LN_RGT_18),Y
          LDY #19*8
          STA (SCN_LN_LFT_19),Y
          STA (SCN_LN_RGT_19),Y
          LDY #20*8
          STA (SCN_LN_LFT_20),Y
          STA (SCN_LN_RGT_20),Y
          LDY #21*8
          STA (SCN_LN_LFT_21),Y
          STA (SCN_LN_RGT_21),Y
          LDY #22*8
          STA (SCN_LN_LFT_22),Y
          STA (SCN_LN_RGT_22),Y
          LDY #23*8
          STA (SCN_LN_LFT_23),Y
          STA (SCN_LN_RGT_23),Y
          LDY #24*8
          STA (SCN_LN_LFT_24),Y
          STA (SCN_LN_RGT_24),Y
          LDY #25*8
          STA (SCN_LN_LFT_25),Y
          STA (SCN_LN_RGT_25),Y
          LDY #26*8
          STA (SCN_LN_LFT_26),Y
          STA (SCN_LN_RGT_26),Y
          LDY #27*8
          STA (SCN_LN_LFT_27),Y
          STA (SCN_LN_RGT_27),Y
          LDY #28*8
          STA (SCN_LN_LFT_28),Y
          STA (SCN_LN_RGT_28),Y
          LDY #29*8
          STA (SCN_LN_LFT_29),Y
          STA (SCN_LN_RGT_29),Y
          LDY #30*8
          STA (SCN_LN_LFT_30),Y
          STA (SCN_LN_RGT_30),Y
          LDY #31*8
          STA (SCN_LN_LFT_31),Y
          STA (SCN_LN_RGT_31),Y
          TAY ; LDY #0*8
          STA (SCN_LN_LFT_32),Y
          STA (SCN_LN_RGT_32),Y
          LDY #1*8
          STA (SCN_LN_LFT_33),Y
          STA (SCN_LN_RGT_33),Y
          LDY #2*8
          STA (SCN_LN_LFT_34),Y
          STA (SCN_LN_RGT_34),Y
          LDY #3*8
          STA (SCN_LN_LFT_35),Y
          STA (SCN_LN_RGT_35),Y
          LDY #4*8
          STA (SCN_LN_LFT_36),Y
          STA (SCN_LN_RGT_36),Y
          LDY #5*8
          STA (SCN_LN_LFT_37),Y
          STA (SCN_LN_RGT_37),Y 
          LDY #6*8
          STA (SCN_LN_LFT_38),Y
          STA (SCN_LN_RGT_38),Y
          LDY #7*8
          STA (SCN_LN_LFT_39),Y
          STA (SCN_LN_RGT_39),Y
     RTS

!ZONE BUILD_MAP_SCN_ADDR
BUILD_MAP_SCN_ADDR
  LDY #2 ; 512
  LDX #0

.YLOOP  STY REGY_BUF ; backup msb

.XLOOP
.MAP        LDY MAP2,X          ; get map height
            LDA VER_TAB_0_LO,Y      ; get screen pos
.MAP_LO     STA MAP_SCN_LO,X      ; store in table
            LDA VER_TAB_SCN_LSB_HI,Y
.MAP_LSB_HI STA MAP_SCN_LSB_HI,X
            LDA VER_TAB_SCN_MSB_HI,Y
.MAP_MSB_HI STA MAP_SCN_MSB_HI,X

            INX
            BNE .XLOOP

        INC .MAP +2
        INC .MAP_LO +2
        INC .MAP_LSB_HI +2
        INC .MAP_MSB_HI +2

        LDY REGY_BUF  ; restore msb
        DEY
        BNE .YLOOP

  RTS

  LDX #127 ; copy 128 of each table from start to end
.LOOP
    LDA MAP_SCN_LO,X
    STA MAP_SCN_LO+LANDSCAPE_SIZE,X
    LDA MAP_SCN_LSB_HI,X
    STA MAP_SCN_LSB_HI+LANDSCAPE_SIZE,X
    LDA MAP_SCN_MSB_HI,X
    STA MAP_SCN_MSB_HI+LANDSCAPE_SIZE,X
    DEX
    BPL .LOOP
  RTS

!align 255,0
MAP_SCN_LO
!FILL 768,0 ; 512+128
MAP_SCN_LSB_HI
!FILL 768,0 ; 512+128
MAP_SCN_MSB_HI
!FILL 768,0 ; 512+128

; 1 full line
; 168 21*8 lines (4*8=ground)
; 1 full line
; 1 empty line
; 5 status lines
; 1 empty line
; 1 fill line
; 21  map lines
; 1 full line
; =200 lines  

; 1 white line at top of display ; 0
; 168 (21*8) lines for display ; 1 to 168 
; 1 white line at bottom of display ; 169
; 1 black line at top of status ; 170 
; 5 lines for status ; 171 to 175
; 1 black line at bottom of status ; 176
; 1 white line at top of map ; 177
; 21 lines for map ; 178 to 198 
; 1 white line at bottom of map ; 199
