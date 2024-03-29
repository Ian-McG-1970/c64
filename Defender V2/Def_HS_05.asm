*= $1000 

; defender 
; screen at top and map at bottom? or screen at top and map at bottom?
; - raster interupt to
; - clear software sprites (1x1) (2x2) (4x4) (6x6)
; - clear and calc and draw sprite mountains
; - move player sprite
; - draw software sprites (1x1) (2x2) (4x4) (6x6)
; 2 highres screens - being swapped - not enough memory?
; need to remove 5 lines from the screen somewhere?
; 1024 needed for colours
; 64x8 needed for mountain sprites
; 64x8 needed for map sprites
; 24 across    
; todo - init sprites
; draw spries along bottom

; screen format 200x160
; #3 = sprites for map - expanded sprites x+y = 42 lines = lines 0 to 41
; #1 = bitmap screen - lines 42 to 199
; #2 = mountains of sprites + player sprite = 21 lines
; #4 = hidden line 25 -lines 192 to 199

; todo - change to 38 column mode - check by changing it and changing it back

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
BANK = JOYF +1
XPOS = BANK +1
YPOS = XPOS +1
MAPADDR = YPOS+1
SPRADDR0 = MAPADDR +2
SPRADDR3 = SPRADDR0 +2
SPRADDR6 = SPRADDR3 +2

SCRN0 = $4000
SCRN1 = $6000
SCRNCOL = $7c00 ; $4000 ; $7c00 ; $4000 ; screen colour at bottom of scrn1
SPRBANK = $5c00 ; sprite bank at bottom of scrn0
SCRNBANK = $02 ; $01
BANK0 = %11110000 ; %00000000 ; %11110000 ; bitmap is at $0000 + screenmem is at $4000 + $3c00 / %00000000 ; bitmap is at $0000 + screenmem is at $4000 + $0000
BANK1 = %11111000 ; %00001000 ; %11111000 ; bitmap is at $2000 + screenmem is at $4000 + $3c00 / %00001000 ; bitmap is at $2000 + screenmem is at $4000 + $0000

RASTER0 = $DC
RASTER1 = $F5

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

SPR1X = 24
SPR2X = 24+(48*1)
SPR3X = 24+(48*2)
SPR4X = 24+(48*3)
SPR5X = 24+(48*4)
SPR6X = 8
SPR7X = 8+(48*1)

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

 LDA #RASTER0 ; this is how to tell at which rasterline we want the irq to be triggered
 STA $D012

 LDA #$1B   ; as there are more than 256 rasterlines, the topmost bit of $d011 serves as
 STA $D011  ; the 9th bit for the rasterline we want our irq to be triggered. here we simply set up a character screen, leaving the topmost bit 0.

 LDA #$35   ; we turn off the BASIC and KERNAL rom here
 STA $01    ; the cpu now sees RAM everywhere except at $d000-$e000, where still the registers of SID/VICII/etc are visible

 lDA #<IRQ_0  ; this is how we set up
 STA $FFFE     ; the address of our interrupt code
 LDA #>IRQ_0
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
 
 LDA #BANK0
 STA $D018    ;VIC Memory Control Register
 STA BANK
    
 LDA #$00     ; screen and border
 STA $D020
 LDA #$00 ; $00
 STA $D021
 LDA #$0B ; $00
 STA $D022
 LDA #$0F ; $00
 STA $D023

 LDA #%00110111 ; 0-2=SCRL 3=25/24 $3B ; 3B ; bitmap mode? - finding 0011=3 1011=b
 STA $D011    ;VIC Control Register 1

 LDA #%00010000 ; 0-2=SCRL 3=38/40 4=MCM 5-7=UNUSED
 STA $D016    ;VIC Control Register 2


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
 
  
  LDX #11
  STX S0C
  INX
  STX S1C ; 12
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
  
 LDA #20
 STA XPOS
 STA YPOS
 
JSR SCREEN_SETUP

; draw a sprite on screen
; draw 7 sprites on screen
; draw 7 
; todo - setup sprites in memory
; 

CLI ; enable maskable interrupts again

MLOOP: JMP  MLOOP

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
        LDA   VER_TAB_SCN0_LSB_HI,Y 
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
        LDA   VER_TAB_SCN0_MSB_HI,Y 
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
        LDA   VER_TAB_SCN0_LSB_HI,Y 
        STA   SCR_HI 
        LDY   HOR_TAB,X
        LDA   (SCR),Y
        AND   AND_00_TAB,X
        ORA   OR_01_TAB,X
        STA   (SCR),Y 
        RTS
.PLOT1  LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_SCN0_MSB_HI,Y 
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
        LDA   VER_TAB_SCN0_LSB_HI,Y 
        STA   SCR_HI 
        LDY   HOR_TAB,X
        LDA   (SCR),Y
        ORA   OR_11_TAB,X
        STA   (SCR),Y 
        RTS
.PLOT1  LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_SCN0_MSB_HI,Y 
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
        LDA   VER_TAB_SCN0_LSB_HI,Y 
        STA   SCR_HI 
        LDY   HOR_TAB,X
        LDA   (SCR),Y
        AND   AND_00_TAB,X
        STA   (SCR),Y 
        RTS
.PLOT1  LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_SCN0_MSB_HI,Y 
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
        LDA   VER_TAB_SCN0_LSB_HI,Y 
        STA   SCR_HI 
        LDY   HOR_TAB,X
        LDA   (SCR),Y
        AND   AND_00_TAB,X
        ORA   OR_10_TAB,X
        STA   (SCR),Y 
        RTS
.PLOT1  LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_SCN0_MSB_HI,Y 
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
        LDA   VER_TAB_SCN0_LSB_HI,Y 
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

!ZONE IRQ_0
IRQ_0:
  INC $D019    ;VIC Interrupt Request Register (IRR)

    INC $d020
    STA REGA_INT
    STX REGX_INT
    STY REGY_INT
    DEC $d020


  LDA #225
  STA S1Y
  STA S2Y
  STA S3Y
  STA S4Y
  STA S5Y
  STA S6Y
  STA S7Y

  LDA #SPR1X
  STA S1X
  LDA #SPR2X
  STA S2X
  LDA #SPR3X
  STA S3X
  LDA #SPR4X
  STA S4X
  LDA #SPR5X
  STA S5X
  LDA #SPR6X
  STA S6X
  LDA #SPR7X
  STA S7X

 LDX #120
 STX SCRNCOL+1016
 INX
 STX SCRNCOL+1017
 INX
 STX SCRNCOL+1018
 INX
 STX SCRNCOL+1019
 INX
 STX SCRNCOL+1020
 INX
 STX SCRNCOL+1021
 INX
 STX SCRNCOL+1022
 INX
 STX SCRNCOL+1023


 LDA #<IRQ_1
 STA $FFFE
 LDA #>IRQ_1
 STA $FFFF

 LDA #RASTER1
 STA $D012

  INC $d020
  LDA REGA_INT
  LDX REGX_INT
  LDY REGY_INT
  DEC $d020

NMI_NOP:
RTI ; This is the irq handler for the NMI. Just returns without acknowledge. This prevents subsequent NMI's from interfering.

!ZONE IRQ_1
IRQ_1:
  INC $D019    ;VIC Interrupt Request Register (IRR)

    DEC $d020
    STA REGA_INT
    STX REGX_INT
    STY REGY_INT
    INC $d020

  LDA #194
  STA S1Y
  STA S2Y
  STA S3Y
  STA S4Y
  STA S5Y
  STA S6Y
  STA S7Y

  LDA XPOS
  AND #3 ;7
;  ASL
  TAY

 LDA SPRTAB1,Y
;  LDA #24
  STA S1X


;  LDA #24+(48*1)
 LDA SPRTAB2,Y
  STA S2X

;  LDA #24+(48*2)
 LDA SPRTAB3,Y
  STA S3X

;  LDA #24+(48*3)
 LDA SPRTAB4,Y
  STA S4X

;  LDA #24+(48*4)
 LDA SPRTAB5,Y
  STA S5X

;  LDA #8
 LDA SPRTAB6,Y
  STA S6X

;  LDA #8+(48*1)
 LDA SPRTAB7,Y
  STA S7X

 LDX #112+1
; STX SCRNCOL+1016
; INX
 STX SCRNCOL+1017
 INX
 STX SCRNCOL+1018
 INX
 STX SCRNCOL+1019
 INX
 STX SCRNCOL+1020
 INX
 STX SCRNCOL+1021
 INX
 STX SCRNCOL+1022
 INX
 STX SCRNCOL+1023

 JSR SWAP_SCN
 JSR MOVE_PLR

 LDA YPOS ; put new pos
 STA S0Y
 LDA XPOS
 ASL
 STA S0X
 LDA #SPRMSB
 ADC #0
 STA SPRXMSB
`
 JSR CLEAR_LANDSCAPE
 JSR DRAW_LANDSCAPE

 LDA #<IRQ_0
 STA $FFFE
 LDA #>IRQ_0
 STA $FFFF

 LDA #RASTER0
 STA $D012

  DEC $d020
  LDA REGA_INT
  LDX REGX_INT
  LDY REGY_INT
  INC $d020

RTI ; This is the irq handler for the NMI. Just returns without acknowledge. This prevents subsequent NMI's from interfering.

DRAW_LANDSCAPE
 INC $D020

   LDA  #>SPR01_ADDR
   STA  SPRADDR0 +1
   LDX  #<MAP
   LDY  #>MAP
   LDA  #<SPR01_ADDR
   JSR  DRAW_LANDSCAPE_SPRITE

   LDA  #>SPR02_ADDR
   STA  SPRADDR0 +1
   LDX  #<(MAP+3)
   LDY  #>(MAP+3)
   LDA  #<SPR02_ADDR
   JSR  DRAW_LANDSCAPE_SPRITE

   LDA  #>SPR03_ADDR
   STA  SPRADDR0 +1
   LDX  #<(MAP+6)
   LDY  #>(MAP+6)
   LDA  #<SPR03_ADDR
   JSR  DRAW_LANDSCAPE_SPRITE

   LDA  #>SPR04_ADDR
   STA  SPRADDR0 +1
   LDX  #<(MAP+9)
   LDY  #>(MAP+9)
   LDA  #<SPR04_ADDR
   JSR  DRAW_LANDSCAPE_SPRITE

   LDA  #>SPR05_ADDR
   STA  SPRADDR0 +1
   LDX  #<(MAP+12)
   LDY  #>(MAP+12)
   LDA  #<SPR05_ADDR
   JSR  DRAW_LANDSCAPE_SPRITE

   LDA  #>SPR06_ADDR
   STA  SPRADDR0 +1
   LDX  #<(MAP+15)
   LDY  #>(MAP+15)
   LDA  #<SPR06_ADDR
   JSR  DRAW_LANDSCAPE_SPRITE

   LDA  #>SPR07_ADDR
   STA  SPRADDR0 +1
   LDX  #<(MAP+18)
   LDY  #>(MAP+18)
   LDA  #<SPR07_ADDR
   JSR  DRAW_LANDSCAPE_SPRITE

 DEC $D020
 
 RTS

CLEAR_LANDSCAPE
 DEC $D020

   LDA  #>SPR01_ADDR
   STA  SPRADDR0 +1
   LDX  #<MAP
   LDY  #>MAP
   LDA  #<SPR01_ADDR
   JSR  CLEAR_LANDSCAPE_SPRITE

   LDA  #>SPR02_ADDR
   STA  SPRADDR0 +1
   LDX  #<(MAP+3)
   LDY  #>(MAP+3)
   LDA  #<SPR02_ADDR
   JSR  CLEAR_LANDSCAPE_SPRITE

   LDA  #>SPR03_ADDR
   STA  SPRADDR0 +1
   LDX  #<(MAP+6)
   LDY  #>(MAP+6)
   LDA  #<SPR03_ADDR
   JSR  CLEAR_LANDSCAPE_SPRITE

   LDA  #>SPR04_ADDR
   STA  SPRADDR0 +1
   LDX  #<(MAP+9)
   LDY  #>(MAP+9)
   LDA  #<SPR04_ADDR
   JSR  CLEAR_LANDSCAPE_SPRITE

   LDA  #>SPR05_ADDR
   STA  SPRADDR0 +1
   LDX  #<(MAP+12)
   LDY  #>(MAP+12)
   LDA  #<SPR05_ADDR
   JSR  CLEAR_LANDSCAPE_SPRITE

   LDA  #>SPR06_ADDR
   STA  SPRADDR0 +1
   LDX  #<(MAP+15)
   LDY  #>(MAP+15)
   LDA  #<SPR06_ADDR
   JSR  CLEAR_LANDSCAPE_SPRITE

   LDA  #>SPR07_ADDR
   STA  SPRADDR0 +1
   LDX  #<(MAP+18)
   LDY  #>(MAP+18)
   LDA  #<SPR07_ADDR
   JSR  CLEAR_LANDSCAPE_SPRITE

 INC $D020
 
 RTS

!ZONE SWAP_SCN
SWAP_SCN
 LDA BANK
 CMP #BANK0
 BEQ SCN1

SCN0
 LDA #BANK0
 STA $D018
 STA BANK
 RTS

SCN1
 LDA #BANK1
 STA $D018
 STA BANK
 RTS
          
!ZONE SCREEN_SETUP
SCREEN_SETUP
 
 LDA #$0 ;$65 ; colour 01 (0000????) and colour 10 (????0000) - bank 1
 LDX #<SCRN0
 LDY #>SCRN0
 STX SCR+0
 STY SCR+1
 LDX #>8000 
 LDY #<8000
 JSR MEMSET

 LDA #0 ;$56 ; colour 01 (0000????) and colour 10 (????0000) - bank 1
 LDX #<SCRN1
 LDY #>SCRN1
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
 LDX #<SCRNCOL
 LDY #>SCRNCOL
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

 RTS

!ZONE MOVE_PLR
MOVE_PLR  
          JSR JOYSTICK2 ; x and y already contain x and y joy pos?
          TXA
          CLC
          ADC   XPOS
          STA   XPOS
          TYA
          CLC
          ADC   YPOS
          STA   YPOS
          RTS

; clear screen
; fill lines in corners as 0
; fill 2 lines inside with 3
; you are 

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

VER_TAB_SCN0_LSB_HI
!for I = 0 TO 24
!BYTE >(SCRN0+(I*320)+0),>(SCRN0+(I*320)+1),>(SCRN0+(I*320)+2),>(SCRN0+(I*320)+3),>(SCRN0+(I*320)+4),>(SCRN0+(I*320)+5),>(SCRN0+(I*320)+6),>(SCRN0+(I*320)+7)
!end

VER_TAB_SCN0_MSB_HI
!for I = 0 TO 24
!BYTE >((SCRN0+256)+(I*320)+0),>((SCRN0+256)+(I*320)+1),>((SCRN0+256)+(I*320)+2),>((SCRN0+256)+(I*320)+3),>((SCRN0+256)+(I*320)+4),>((SCRN0+256)+(I*320)+5),>((SCRN0+256)+(I*320)+6),>((SCRN0+256)+(I*320)+7)
!end

VER_TAB_SCN1_LSB_HI
!for I = 0 TO 24
!BYTE >(SCRN1+(I*320)+0),>(SCRN1+(I*320)+1),>(SCRN1+(I*320)+2),>(SCRN1+(I*320)+3),>(SCRN1+(I*320)+4),>(SCRN1+(I*320)+5),>(SCRN1+(I*320)+6),>(SCRN1+(I*320)+7)
!end

VER_TAB_SCN1_MSB_HI
!for I = 0 TO 24
!BYTE >((SCRN1+256)+(I*320)+0),>((SCRN1+256)+(I*320)+1),>((SCRN1+256)+(I*320)+2),>((SCRN1+256)+(I*320)+3),>((SCRN1+256)+(I*320)+4),>((SCRN1+256)+(I*320)+5),>((SCRN1+256)+(I*320)+6),>((SCRN1+256)+(I*320)+7)
!end

VER_TAB_0_LO
!for I = 0 TO 24
!BYTE <(SCRN0+(I*320)+0),<(SCRN0+(I*320)+1),<(SCRN0+(I*320)+2),<(SCRN0+(I*320)+3),<(SCRN0+(I*320)+4),<(SCRN0+(I*320)+5),<(SCRN0+(I*320)+6),<(SCRN0+(I*320)+7)
!end

PUT_LO !BYTE <PLOTDBL00,<PLOTDBL01,<PLOTDBL10,<PLOTDBL11

SPRTAB1 !BYTE SPR1X+0,SPR1X+2,SPR1X+4,SPR1X+6,SPR1X+8,SPR1X+10,SPR1X+12,SPR1X+14
SPRTAB2 !BYTE SPR2X+0,SPR2X+2,SPR2X+4,SPR2X+6,SPR2X+8,SPR2X+10,SPR2X+12,SPR2X+14
SPRTAB3 !BYTE SPR3X+0,SPR3X+2,SPR3X+4,SPR3X+6,SPR3X+8,SPR3X+10,SPR3X+12,SPR3X+14
SPRTAB4 !BYTE SPR4X+0,SPR4X+2,SPR4X+4,SPR4X+6,SPR4X+8,SPR4X+10,SPR4X+12,SPR4X+14
SPRTAB5 !BYTE SPR5X+0,SPR5X+2,SPR5X+4,SPR5X+6,SPR5X+8,SPR5X+10,SPR5X+12,SPR5X+14
SPRTAB6 !BYTE SPR6X+0,SPR6X+2,SPR6X+4,SPR6X+6,SPR6X+8,SPR6X+10,SPR6X+12,SPR6X+14
SPRTAB7 !BYTE SPR7X+0,SPR7X+2,SPR7X+4,SPR7X+6,SPR7X+8,SPR7X+10,SPR7X+12,SPR7X+14

SPRCOL0 !BYTE (0*3)+0,(1*3)+0,(2*3)+0,(3*3)+0,(4*3)+0,(5*3)+0,(6*3)+0,(7*3)+0,(8*3)+0,(9*3)+0,(10*3)+0,(11*3)+0,(12*3)+0,(13*3)+0,(14*3)+0,(15*3)+0,(16*3)+0,(17*3)+0,(18*3)+0,(19*3)+0,(20*3)+0
SPRCOL1 !BYTE (0*3)+1,(1*3)+1,(2*3)+1,(3*3)+1,(4*3)+1,(5*3)+1,(6*3)+1,(7*3)+1,(8*3)+1,(9*3)+1,(10*3)+1,(11*3)+1,(12*3)+1,(13*3)+1,(14*3)+1,(15*3)+1,(16*3)+1,(17*3)+1,(18*3)+1,(19*3)+1,(20*3)+1
SPRCOL2 !BYTE (0*3)+2,(1*3)+2,(2*3)+2,(3*3)+2,(4*3)+2,(5*3)+2,(6*3)+2,(7*3)+2,(8*3)+2,(9*3)+2,(10*3)+2,(11*3)+2,(12*3)+2,(13*3)+2,(14*3)+2,(15*3)+2,(16*3)+2,(17*3)+2,(18*3)+2,(19*3)+2,(20*3)+2

MAP !BYTE 4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0,1,2,3,4,5,6,7,8

DRAW_LANDSCAPE_SPRITE2:

  STX MAPADDR
  STY MAPADDR+1
  STA SPRADDR0
  
  LDY #0
  LAX (MAPADDR),Y    ; get first height
  LDY SPRCOL0,X   ; get column1 sprite pos based on height
  LDA #%01010101    ; pattern
  STA (SPRADDR0),Y

  LDY #1
  LAX (MAPADDR),Y    ; get first height
  LDY SPRCOL1,X   ; get column1 sprite pos based on height
  LDA #%01010101    ; pattern
  STA (SPRADDR0),Y

  LDY #2
  LAX (MAPADDR),Y    ; get first height
  LDY SPRCOL2,X   ; get column1 sprite pos based on height
  LDA #%01010101    ; pattern
  STA (SPRADDR0),Y

 RTS

DRAW_LANDSCAPE_SPRITE:

  STX MAPADDR
  STY MAPADDR+1

 LDX SPRADDR0+1
 STX SPRADDR3+1
 STX SPRADDR6+1

  STA SPRADDR0
  CLC
  ADC #3
  STA SPRADDR3
  ADC #3
  STA SPRADDR6
  
  LDY #0
  LAX (MAPADDR),Y    ; get first height
  LDY SPRCOL0,X   ; get column1 sprite pos based on height
  LDA #%01010101    ; pattern
  STA (SPRADDR0),Y
  LDA #%11111111    ; pattern
  STA (SPRADDR3),Y
  LDA #%10101010    ; pattern
  STA (SPRADDR3),Y

  LDY #1
  LAX (MAPADDR),Y    ; get first height
  LDY SPRCOL1,X   ; get column1 sprite pos based on height
  LDA #%01010101    ; pattern
  STA (SPRADDR0),Y
  LDA #%11111111    ; pattern
  STA (SPRADDR3),Y
  LDA #%10101010    ; pattern
  STA (SPRADDR3),Y

  LDY #2
  LAX (MAPADDR),Y    ; get first height
  LDY SPRCOL2,X   ; get column1 sprite pos based on height
  LDA #%01010101    ; pattern
  STA (SPRADDR0),Y
  LDA #%11111111    ; pattern
  STA (SPRADDR3),Y
  LDA #%10101010    ; pattern
  STA (SPRADDR3),Y

 RTS


CLEAR_LANDSCAPE_SPRITE2:

  STX MAPADDR
  STY MAPADDR+1
  STA SPRADDR0
  
  LDY #0
  LAX (MAPADDR),Y    ; get first height
  LDY SPRCOL0,X   ; get column1 sprite pos based on height
  LDA #0    ; pattern
  STA (SPRADDR0),Y

  LDY #1
  LAX (MAPADDR),Y    ; get first height
  LDY SPRCOL1,X   ; get column1 sprite pos based on height
  LDA #0    ; pattern
  STA (SPRADDR0),Y

  LDY #2
  LAX (MAPADDR),Y    ; get first height
  LDY SPRCOL2,X   ; get column1 sprite pos based on height
  LDA #0    ; pattern
  STA (SPRADDR0),Y

 RTS

CLEAR_LANDSCAPE_SPRITE:

  STX MAPADDR
  STY MAPADDR+1

 LDX SPRADDR0+1
 STX SPRADDR3+1
 STX SPRADDR6+1

  STA SPRADDR0
  CLC
  ADC #3
  STA SPRADDR3
  ADC #3
  STA SPRADDR6
  
  LDY #0
  LAX (MAPADDR),Y    ; get first height
  LDY SPRCOL0,X   ; get column1 sprite pos based on height
  LDA #0    ; pattern
  STA (SPRADDR0),Y
  STA (SPRADDR3),Y
  STA (SPRADDR6),Y

  LDY #1
  LAX (MAPADDR),Y    ; get first height
  LDY SPRCOL1,X   ; get column1 sprite pos based on height
  LDA #0    ; pattern
  STA (SPRADDR0),Y
  STA (SPRADDR3),Y
  STA (SPRADDR6),Y

  LDY #2
  LAX (MAPADDR),Y    ; get first height
  LDY SPRCOL2,X   ; get column1 sprite pos based on height
  LDA #0    ; pattern
  STA (SPRADDR0),Y
  STA (SPRADDR3),Y
  STA (SPRADDR6),Y

 RTS

DRAW_LANDSCAPE_SPRITE1:

  STX MAPADDR
  STY MAPADDR+1
  STA SPRADDR0
  
  LDY #0
  LAX (MAPADDR),Y    ; get first height
  LDY SPRCOL0,X   ; get column1 sprite pos based on height
  LDA #%01010000    ; pattern
  STA (SPRADDR0),Y

  LDY #1
  LAX (MAPADDR),Y    ; get second height
  LDY SPRCOL0,X   ; get column1 sprite pos based on height
  LDA #%00000101
  STA (SPRADDR0),Y

  LDY #2
  LAX (MAPADDR),Y    ; get first height
  LDY SPRCOL1,X   ; get column1 sprite pos based on height
  LDA #%01010000    ; pattern
  STA (SPRADDR0),Y

  LDY #3
  LAX (MAPADDR),Y    ; get second height
  LDY SPRCOL1,X   ; get column1 sprite pos based on height
  LDA #%00000101
  STA (SPRADDR0),Y

  LDY #4
  LAX (MAPADDR),Y    ; get first height
  LDY SPRCOL2,X   ; get column1 sprite pos based on height
  LDA #%01010000    ; pattern
  STA (SPRADDR0),Y

  LDY #5
  LAX (MAPADDR),Y    ; get second height
  LDY SPRCOL2,X   ; get column1 sprite pos based on height
  LDA #%00000101
  STA (SPRADDR0),Y

 RTS

CLEAR_LANDSCAPE_SPRITE1:

  STX MAPADDR
  STY MAPADDR+1
  STA SPRADDR0
  
  LDY #0
  LAX (MAPADDR),Y    ; get first height
  LDY SPRCOL0,X   ; get column1 sprite pos based on height
  LDA #0    ; pattern
  STA (SPRADDR0),Y

  LDY #1
  LAX (MAPADDR),Y    ; get second height
  LDY SPRCOL0,X   ; get column1 sprite pos based on height
  LDA #0
  STA (SPRADDR0),Y

  LDY #2
  LAX (MAPADDR),Y    ; get first height
  LDY SPRCOL1,X   ; get column1 sprite pos based on height
  LDA #0    ; pattern
  STA (SPRADDR0),Y

  LDY #3
  LAX (MAPADDR),Y    ; get second height
  LDY SPRCOL1,X   ; get column1 sprite pos based on height
  LDA #0
  STA (SPRADDR0),Y

  LDY #4
  LAX (MAPADDR),Y    ; get first height
  LDY SPRCOL2,X   ; get column1 sprite pos based on height
  LDA #0    ; pattern
  STA (SPRADDR0),Y

  LDY #5
  LAX (MAPADDR),Y    ; get second height
  LDY SPRCOL2,X   ; get column1 sprite pos based on height
  LDA #0
  STA (SPRADDR0),Y

 RTS
