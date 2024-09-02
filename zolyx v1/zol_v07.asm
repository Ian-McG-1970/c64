*= $1000 


; todo movement - 
; if prev point moved to was 'empty'
;  if no direction selected
;    direction is previous direction
; endif
   
SCR_LO = 2 ; BANK_LO_HI+1
SCR_HI = SCR_LO+1
SCR = SCR_LO

REGA_BUF = SCR_HI +1
REGX_BUF = REGA_BUF+1
REGY_BUF = REGX_BUF+1
REGA_INT = REGY_BUF+1
REGX_INT = REGA_INT+1
REGY_INT = REGX_INT+1

SPD = REGY_INT +1 ; game speed
SPDCNT = SPD +1 ; current game speed counter
JOYX = SPDCNT +1
JOYY = JOYX +1
JOYF = JOYY +1
XPOS = JOYF +1
YPOS = XPOS +1
POS = YPOS +1
VAL = POS +1
PNTCNT = VAL +1
PRVX = PNTCNT +1
PRVY = PRVX +1
NXTX = PRVY +1
NXTY = NXTX +1
PNTIN = NXTY +1
PNTOUT = PNTIN +1

FILL_ST_1_X =PNTOUT +1
FILL_ST_1_Y =FILL_ST_1_X +1
FILL_ST_2_X =FILL_ST_1_Y +1
FILL_ST_2_Y =FILL_ST_2_X +1
WALL_CHK_1_X =FILL_ST_2_Y +1
WALL_CHK_1_Y =WALL_CHK_1_X +1
WALL_CHK_2_X =WALL_CHK_1_Y +1
WALL_CHK_2_Y =WALL_CHK_2_X +1
WALL_CHK_3_X =WALL_CHK_2_Y +1
WALL_CHK_3_Y =WALL_CHK_3_X +1
EMPTY_CHK_X =WALL_CHK_3_Y +1
EMPTY_CHK_Y =EMPTY_CHK_X +1

JPX = EMPTY_CHK_Y +1
JPY = JPX +1

BUF_HEAD_X = JPY+1
BUF_HEAD_X_LO = BUF_HEAD_X
BUF_HEAD_X_HI = BUF_HEAD_X_LO +1

BUF_HEAD_Y = BUF_HEAD_X_HI+1
BUF_HEAD_Y_LO = BUF_HEAD_Y
BUF_HEAD_Y_HI = BUF_HEAD_Y_LO +1

BUF_TAIL_X = BUF_HEAD_Y_HI+1
BUF_TAIL_X_LO = BUF_TAIL_X
BUF_TAIL_X_HI = BUF_TAIL_X_LO +1

BUF_TAIL_Y = BUF_TAIL_X_HI+1
BUF_TAIL_Y_LO = BUF_TAIL_Y
BUF_TAIL_Y_HI = BUF_TAIL_Y_LO+1

SCRN0 = $4000 ; $8000
SCRNBANK = $02 ; $01
BANK = $80

PLOT_SPACE = PLOT00
PLOT_ENEMY = PLOT01
PLOT_PLAYER = PLOT10
PLOT_WALL = PLOT11

SPACE = 0
ENEMY = 1
PLAYER = 2
WALL = 3

TOP = 1
LEFT = 1
BOTTOM = 198
RIGHT = 158

BUF_X = $8000
BUF_Y = $9000

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

 LDA #$FA   ; this is how to tell at which rasterline we want the irq to be triggered
 STA $D012

 LDA #$1B   ; as there are more than 256 rasterlines, the topmost bit of $d011 serves as
 STA $D011  ; the 9th bit for the rasterline we want our irq to be triggered. here we simply set up a character screen, leaving the topmost bit 0.

 LDA #$35   ; we turn off the BASIC and KERNAL rom here
 STA $01    ; the cpu now sees RAM everywhere except at $d000-$e000, where still the registers of SID/VICII/etc are visible

 lDA #<BM_IRQ  ; this is how we set up
 STA $FFFE     ; the address of our interrupt code
 LDA #>BM_IRQ
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
 LDA #$03 ; $05 ; $00
 STA $D021
 LDA #$0B ; $00
 STA $D022
 LDA #$0F ; $00
 STA $D023

 LDA #$3B ; 3B ; bitmap mode? - finding 0011=3 1011=b
 STA $D011    ;VIC Control Register 1

; LDA #$18
 LDA #%00011000 ; 0-2=SCRL 3=40/38 4=MCM 5-7=UNUSED
 STA $D016    ;VIC Control Register 2

 LDA #$01 ; $01 ; colour 11 
 LDX #<$D800
 LDY #>$D800
 STX SCR+0
 STY SCR+1
 LDX #>1000 
 LDY #<1000
 JSR MEMSET

 LDA #$BC ;$65 ; colour 01 (0000????) and colour 10 (????0000) - bank 1
 LDX #<(SCRN0+$2000)
 LDY #>(SCRN0+$2000)
 STX SCR+0
 STY SCR+1
 LDX #>1000 
 LDY #<1000
 JSR MEMSET

LDA #0
STA XPOS
STA YPOS

LDA #0
STA SPDCNT
LDA #0
STA SPD
 
LDX #3
LDY #40
LDA #145
JSR HORLINE

LDA #175
LDX #10
LDY #4
JSR VERLINE

LDX #0
LDY #100
LDA #100
JSR PUT
LDX #1
LDY #102
LDA #100
JSR PUT
LDX #2
LDY #100
LDA #102
JSR PUT
LDX #3
LDY #102
LDA #102
JSR PUT

JSR SCREEN_SETUP

;LDY #5
;LDX #6
;JSR PLOT10


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

!ZONE GET
GET     BMI   .GET1
.GET0   LDA   VER_TAB_0_LO,Y ; get point from screen
        STA   SCR_LO
        LDA   VER_TAB_0_HI,Y
        STA   SCR_HI
        LDY   HOR_TAB,X
        LDA   (SCR),Y
        AND   OR_11_TAB,X
        TAX
        LDA   GET_TAB,X
        RTS
.GET1   LDA   VER_TAB_0_LO,Y ; get point from screen
        STA   SCR_LO
        LDA   VER_TAB_1_HI,Y
        STA   SCR_HI
        LDY   HOR_TAB,X
        LDA   (SCR),Y
        AND   OR_11_TAB,X
        TAX
        LDA   GET_TAB,X
        RTS

!ALIGN 255,0
!ZONE PUT
PUT     BMI   .PLOT1
.PLOT0  STA   .TEMP0+1
        LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_0_HI,Y 
        STA   SCR_HI

        LDA   PUT_LO_TAB,X  ; put colour address
        STA   .JUMP0+1
.TEMP0  LDX   #0        ; restore HOR   

        LDY   HOR_TAB,X
        LDA   (SCR),Y
      
.JUMP0  JMP   PLOTDBL00

.PLOT1  STA   .TEMP1+1
        LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_1_HI,Y 
        STA   SCR_HI

        LDA   PUT_LO_TAB,X  ; put colour address
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

!ZONE VERLINE
VERLINE   STA   REGA_BUF
          STX   REGX_BUF
          STY   REGY_BUF

.LOOP       LDY   REGY_BUF
            LDX   REGX_BUF
            JSR   PLOT_WALL
        
            INC   REGY_BUF
            DEC   REGA_BUF
            BNE   .LOOP
                 
          RTS

!ZONE HORLINE
HORLINE   STA   REGA_BUF
          STX   REGX_BUF
          STY   REGY_BUF

.LOOP       LDY   REGY_BUF
            LDX   REGX_BUF
            JSR   PLOT_WALL
        
            INC   REGX_BUF
            DEC   REGA_BUF
            BNE   .LOOP
                 
          RTS

!ZONE PLOT01
PLOT01  BMI   .PLOT1
.PLOT0  LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_0_HI,Y 
        STA   SCR_HI 
        LDY   HOR_TAB,X
        LDA   (SCR),Y
        AND   AND_00_TAB,X
        ORA   OR_01_TAB,X
        STA   (SCR),Y 
        RTS
.PLOT1  LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_1_HI,Y 
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
        LDA   VER_TAB_0_HI,Y 
        STA   SCR_HI 
        LDY   HOR_TAB,X
        LDA   (SCR),Y
        ORA   OR_11_TAB,X
        STA   (SCR),Y 
        RTS
.PLOT1  LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_1_HI,Y 
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
        LDA   VER_TAB_0_HI,Y 
        STA   SCR_HI 
        LDY   HOR_TAB,X
        LDA   (SCR),Y
        AND   AND_00_TAB,X
        STA   (SCR),Y 
        RTS
.PLOT1  LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_1_HI,Y 
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
        LDA   VER_TAB_0_HI,Y 
        STA   SCR_HI 
        LDY   HOR_TAB,X
        LDA   (SCR),Y
        AND   AND_00_TAB,X
        ORA   OR_10_TAB,X
        STA   (SCR),Y 
        RTS
.PLOT1  LDA   VER_TAB_0_LO,Y
        STA   SCR_LO 
        LDA   VER_TAB_1_HI,Y 
        STA   SCR_HI 
        LDY   HOR_TAB,X
        LDA   (SCR),Y
        AND   AND_00_TAB,X
        ORA   OR_10_TAB,X
        STA   (SCR),Y 
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

!ZONE BM_IRQ
BM_IRQ:
  INC $D019    ;VIC Interrupt Request Register (IRR)

  DEC SPDCNT
  BPL IRQ_EXIT

    INC $d020
    STA REGA_INT
    STX REGX_INT
    STY REGY_INT

    LDA SPD
    STA SPDCNT

    LDX POS ; get curret pos
; CPX #SPACE
    BEQ .CONT

      LDY YPOS ; replace old pos if needed
      LDA XPOS
      JSR PUT

.CONT 

JSR MOVE_PLR

 INC $d020

LDY YPOS ; get new pos
LDX XPOS
JSR GET 
STA POS

  DEC $d020

;LDX VAL
;LDY YPOS
;LDA XPOS
;JSR PUT

LDY YPOS ; put new pos
LDX XPOS
JSR PLOT_PLAYER

JSR MOVE_IN
JSR MOVE_OUT

;JSR INC_HEAD
;JSR DEC_TAIL

  LDA REGA_INT
  LDX REGX_INT
  LDY REGY_INT
  DEC $d020

IRQ_EXIT: 
NMI_NOP:
RTI ; This is the irq handler for the NMI. Just returns without acknowledge. This prevents subsequent NMI's from interfering.


;RANDOMDIR JSR  RANDOM
;          AND  #1
;          TAX
;          LDA  DIR,X
;          RTS
          
SCREEN_SETUP
; STX  PNT_IN
; STY  PNT_OUT
 
 LDA #$00 ;$65 ; colour 01 (0000????) and colour 10 (????0000) - bank 1
 LDX #<(SCRN0)
 LDY #>(SCRN0)
 STX SCR+0
 STY SCR+1
 LDX #>8000 
 LDY #<8000
 JSR MEMSET
 
 LDX #1
 LDY #1
 LDA #158
 JSR HORLINE
 LDX #1
 LDY #2
 LDA #158
 JSR HORLINE

 LDX #1
 LDY #197
 LDA #158
 JSR HORLINE
 LDX #1
 LDY #198
 LDA #158
 JSR HORLINE

 LDX #1
 LDY #3
 LDA #194
 JSR VERLINE
 LDX #2
 LDY #3
 LDA #194
 JSR VERLINE

 LDX #157
 LDY #3
 LDA #194
 JSR VERLINE
 LDX #158
 LDY #3
 LDA #194
 JSR VERLINE

 LDA #31
 STA PNTIN
 LDA #2
 STA PNTOUT
 
 LDY YPOS ; get pos
 LDX XPOS
 JSR GET
 STA POS

 RTS

;JPX !BYTE 0
;JPY !BYTE 0 
 
!ZONE MOVE_PLR
MOVE_PLR  
          LDX   JOYX  ; backup previous joystick pos
          STX   JPX
          LDY   JOYY
          STY   JPY

          JSR JOYSTICK2
; x and y already contain x and y joy pos?
          
          LDA   POS  ; if current pos is space
;          CMP   #SPACE
          BNE  .CONT
            LDA   JOYX  ; and joystick xdir is 0
            BNE   .CONT
              LDA   JOYY  ; and joystick ydir is 0
              BNE   .CONT
                LDX   JPX   ; joystick is previous joystick
                STX   JOYX
                LDY   JPY
                STY   JOYY                          

.CONT          
; x and y already contain x and y joy pos?

          LDA   JOYX
          BEQ   .UP_DOWN
          BMI   .LFT
.RGT      LDX   XPOS
          CPX   #RIGHT
          BEQ   .RGT_OFF
            INX
            STX   XPOS
            
            LDX   XPOS
            LDY   YPOS
            STX   EMPTY_CHK_X
            STY   EMPTY_CHK_Y

            INX   ; h+1
            STX   WALL_CHK_1_X
            STY   WALL_CHK_1_Y

            LDX   XPOS
            LDY   YPOS
            DEY   ; v-1
            STX   WALL_CHK_2_X
            STY   WALL_CHK_2_Y

            LDX   XPOS
            LDY   YPOS
            INY   ; v+1
            STX   WALL_CHK_3_X
            STY   WALL_CHK_3_Y
          
            LDX   XPOS
            LDY   YPOS
            DEX   ; h-1
            DEY   ; v-1
            STX   FILL_ST_1_X
            STY   FILL_ST_1_Y

            LDX   XPOS
            LDY   YPOS
            DEX   ; h-1
            INY   ; v+1
            STX   FILL_ST_2_X
            STY   FILL_ST_2_Y

            JSR   FILL_CHECK
            ; if x,y = space
            ;  and either x,y+1 = space or x-1,y = space or x+1,y = space
            ;   do fill
            
            ; F W 0
            ; S D W
            ; F W 0
            
            ; if x+1,y or x,y-1 or x,y+1
.RGT_OFF  RTS

.LFT      LDX   XPOS
          CPX   #LEFT
          BEQ   .LFT_OFF
            DEX
            STX   XPOS
.LFT_OFF  RTS

.UP_DOWN  LDA   JOYY
          BEQ   .TOP_OFF
          BMI   .TOP
.BTM      LDY   YPOS
          CPY   #BOTTOM
          BEQ   .BTM_OFF
            INY
            STY   YPOS
.BTM_OFF  RTS

.TOP      LDY   YPOS
          CPY   #TOP
          BEQ   .TOP_OFF
            DEY
            STY   YPOS
.TOP_OFF  RTS

;          LDA XPOS
;          CLC
;          ADC JOYX
;          BEQ .dontmove
          
;          STA XPOS
;          LDA YPOS
;          CLC
;          ADC JOYY
;          STA YPOS
;          LDA VAL
;          CLC
;          ADC JOYF
;          AND #3
;          STA VAL
          RTS
 
FILL_CHECK ; x across y down
          LDY   EMPTY_CHK_Y
          LDX   EMPTY_CHK_X
          JSR   GET
          ; if not empty exit
          
            LDY   WALL_CHK_1_Y          
            LDX   WALL_CHK_1_X
            JSR   GET
            ; if wall
            ; do fill
          LDY   WALL_CHK_2_Y          
          LDX   WALL_CHK_2_X
          JSR   GET
          ; if wall
          ; do fill
          LDY   WALL_CHK_3_Y          
          LDX   WALL_CHK_3_X
          JSR   GET
          ; if wall
          ; do fill
          
          RTS
          
FILL      ; do fill
          RTS
          
!ZONE MOVE_OUT
MOVE_OUT 
  rts
  LDA  PNTOUT
         STA  PNTCNT
.MV_LP   LDX  PNTCNT
  
         LDA  POY,X
         STA  PRVY
         CLC
         ADC  MOY,X
         STA  POY,X
         STA  NXTY
         TAY

         LDA  POX,X
         STA  PRVX
         CLC
         ADC  MOX,X
         STA  POX,X
         STA  NXTX
         TAX

         JSR  GET
         CMP  #WALL
         BNE  .MV_COLLIDE 
           LDY  NXTY
           LDX  NXTX
           JSR  PLOT_ENEMY  ; set new pos             
           LDY  PRVY
           LDX  PRVX
           JSR  PLOT_WALL  ; clear old pos
             
         DEC  PNTCNT
         BNE  .MV_LP
       RTS

.MV_COLLIDE  LDX  PNTCNT
             LDA  PRVY
             STA  POY,X
             LDA  PRVX
             STA  POX,X
             
.MV_VER      LDY  NXTY
             LDX  PRVX
             JSR  GET
             CMP  #WALL
             BEQ  .MV_HOR
               LDX  PNTCNT
               LDY  MOY,X
               LDA  NEGATE,Y
               STA  MOY,X
             
.MV_HOR      LDY  PRVY
             LDX  NXTX
             JSR  GET
             CMP  #WALL
             BEQ  .MV_EXIT
               LDX  PNTCNT
               LDY  MOX,X
               LDA  NEGATE,Y
               STA  MOX,X
 
.MV_EXIT     DEC  PNTCNT
             BNE  .MV_LP
           RTS

!ALIGN 255,0
!ZONE MOVE_IN
MOVE_IN LDA   PNTIN
        STA   PNTCNT

.LOOP   LDX   PNTCNT
  
      LDA   PIY,X
      STA   PRVY
      CLC
      ADC   MIY,X
      STA   PIY,X
      STA   NXTY
      TAY

      LDA   PIX,X
      STA   PRVX
      CLC
      ADC   MIX,X
      STA   PIX,X
      STA   NXTX
      TAX

      JSR   GET
;           CMP   #SPACE
      BEQ   .SPACE
        JSR   GET_PIXEL_VALUE
      
.SPACE    TAX
      LDA   MOVE_IN_LO_TAB,X
      STA   .JUMP+1
      
.JUMP   JSR   MOVE_IN_SPACE

      DEC   PNTCNT
      BNE   .LOOP
    RTS

     ;  front is not floor         

MOVE_IN_SPACE LDY   PRVY
        LDX   PRVX
        JSR   PLOT_SPACE  ; clear old pos
        LDY   NXTY
        LDX   NXTX
        JSR   PLOT_ENEMY  ; set new pos                 
        RTS

MOVE_IN_PLAYER  LDY   PRVY
        LDX   PRVX
        JSR   PLOT_SPACE  ; clear old pos
        LDY   NXTY
        LDX   NXTX
        JSR   PLOT_ENEMY  ; set new pos             
        RTS

MOVE_IN_ENEMY LDX   PNTCNT
        LDA   PRVY
        STA   PIY,X
        LDA   PRVX
        STA   PIX,X
        
        LDX   PNTCNT    ; negate
        LDY   MIY,X
        LDA   NEGATE,Y
        STA   MIY,X

        RTS

MOVE_IN_WALL  LDX   PNTCNT
        LDA   PRVY
        STA   PIY,X
        LDA   PRVX
        STA   PIX,X
             
.VER        LDY   NXTY
        LDX   PRVX
        JSR   GET
;             CMP   #SPACE
        BEQ   .HOR
          LDX   PNTCNT
          LDY   MIY,X
          LDA   NEGATE,Y
          STA   MIY,X
             
.HOR          LDY   PRVY
        LDX   NXTX
        JSR   GET
;             CMP   #SPACE
        BEQ   .EXIT
          LDX   PNTCNT
          LDY   MIX,X
          LDA   NEGATE,Y
          STA   MIX,X

.EXIT       RTS

!ZONE CHECK_ENEMY
CHECK_ENEMY       TAY       ; backup previous GET
                  AND   #3
                  CMP   #ENEMY
                  BEQ   .FND
                  TYA
                  LSR
                  LSR
                  TAY
                  AND   #3
                  CMP   #ENEMY
                  BEQ   .FND
                  TYA
                  LSR
                  LSR
                  TAY
                  AND   #3
                  CMP   #ENEMY
                  BEQ   .FND
                  TYA
                  LSR
                  LSR
                  TAY
                  AND   #3
                  CMP   #ENEMY
                  BEQ   .FND
            RTS

.FND  LDA   #SPACE  ; set to space
        RTS           ; exit with zero flag set

!ZONE CHECK_ENEMY_2
CHECK_ENEMY_2       TAY       ; backup previous GET
                  LDX   #3  ; loop count

.CHECK_ENEMY_LOOP AND   #3
                  CMP   #ENEMY
                  BEQ   .FOUND
                  TYA       ; restore GET shift previous 2 bits out
                  LSR       ; shift prev 2 bits out
                  LSR
                  TAY
                  DEX
                  BPL   .CHECK_ENEMY_LOOP
            RTS ; exit with minus flag set

.FOUND  LDA   #SPACE  ; set to space
        RTS           ; exit with zero flag set

; convert get to pixel value 
; for x eq 1 to 4
; if acc and #3 ne 0 return acc and #3
; lsr twice to get rid of these bits

!ZONE GET_PIXEL_VALUE
GET_PIXEL_VALUE TAY       ; backup original GET
                LDX   #3  ; loop count 4 times

.LOOP         AND   #3    ; check next 2 bits
          BNE   .FOUND  ; not zero so exit
          TYA         ; restore GET
          LSR         ; shift the 2 bits checked out
          LSR
          TAY       ; backup GET
          DEX
          BPL   .LOOP
.FOUND          RTS         ; exit with acc containing pixel value and zero set

!ZONE RANDOM
RANDOM  LDA   EORN+1
        BEQ   EORY
        ASL
        BEQ   EORN ;if the input was $80, skip the EOR
        BCC   EORN
EORY      EOR   #$1D
EORN    STA   EORN+1
        RTS

PIX !BYTE 00,140,20,30,40,50,60,70,80,90,100,110,120,130,140,150,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,10,20,30
PIY !BYTE 00,140,10,10,10,10,10,10,10,10,10, 10, 10, 10, 10, 10, 20,20,20,20,20,20,20,20,20, 20, 20, 20, 20, 20, 20,30,30,30
MIX !BYTE 00,-1, 1,-1,-1, 1,-1, 1,-1, 1, -1,  1, -1,  1, -1,  1,-1,-1, 1,-1,-1, 1,-1, 1,-1,  1, -1,  1, -1,  1, -1,  1, -1,  1
MIY !BYTE 00, 1,-1, 1,-1,-1,-1, 1,-1,-1,  1, -1,  1, -1, -1, -1, 1, 1,-1, 1,-1,-1,-1, 1,-1, -1,  1, -1,  1, -1, -1, -1,  1, -1

POX !BYTE 0,1,20,30,40
POY !BYTE 0,10,2,30,40
MOX !BYTE 0,-1,1,-1,1
MOY !BYTE 0, 1,-1,1,-1

; random number generator
; move routine
; get px/py
; add mx/my
; get point
; if point( ne expected
;  if point(ver) ne expected
;   swap ver
;  if point(hor) ne expected
;   swap hor
 
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

VER_TAB_0_HI
!for I = 0 TO 24
!BYTE >(SCRN0+(I*320)+0),>(SCRN0+(I*320)+1),>(SCRN0+(I*320)+2),>(SCRN0+(I*320)+3),>(SCRN0+(I*320)+4),>(SCRN0+(I*320)+5),>(SCRN0+(I*320)+6),>(SCRN0+(I*320)+7)
!end

VER_TAB_1_HI
!for I = 0 TO 24
!BYTE >((SCRN0+256)+(I*320)+0),>((SCRN0+256)+(I*320)+1),>((SCRN0+256)+(I*320)+2),>((SCRN0+256)+(I*320)+3),>((SCRN0+256)+(I*320)+4),>((SCRN0+256)+(I*320)+5),>((SCRN0+256)+(I*320)+6),>((SCRN0+256)+(I*320)+7)
!end

VER_TAB_0_LO
!for I = 0 TO 24
!BYTE <(SCRN0+(I*320)+0),<(SCRN0+(I*320)+1),<(SCRN0+(I*320)+2),<(SCRN0+(I*320)+3),<(SCRN0+(I*320)+4),<(SCRN0+(I*320)+5),<(SCRN0+(I*320)+6),<(SCRN0+(I*320)+7)
!end

NEGATE !BYTE 0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
GET_TAB
!BYTE  00, 01, 02, 03, 01,$05,$06,$07, 02,$09,$0A,$0B, 03,$0D,$0E,$0F ; $04=01 ; $08=02 ; $0C=03
!BYTE  01
PUT_LO_TAB 		!BYTE <PLOTDBL00,<PLOTDBL01,<PLOTDBL10,<PLOTDBL11
MOVE_IN_LO_TAB  !BYTE <MOVE_IN_SPACE,<MOVE_IN_ENEMY,<MOVE_IN_PLAYER,<MOVE_IN_WALL
;!BYTE $15,$16,$17,$18 - ignore
!BYTE $19,$1A,$1B,$1C,$1D,$1E,$1F ; $10=01
!BYTE  02,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F ; $20=02
!BYTE  03,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F ; $30=03
!BYTE  01,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F ; $40=01
!BYTE $50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$5B,$5C,$5D,$5E,$5F
!BYTE $60,$61,$62,$63,$64,$65,$66,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$6F
!BYTE $70,$71,$72,$73,$74,$75,$76,$77,$78,$79,$7A,$7B,$7C,$7D,$7E,$7F
!BYTE  02,$81,$82,$83,$84,$85,$86,$87,$88,$89,$8A,$8B,$8C,$8D,$8E,$8F ; $80=02
!BYTE $90,$91,$92,$93,$94,$95,$96,$97,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F
!BYTE $A0,$A1,$A2,$A3,$A4,$A5,$A6,$A7,$A8,$A9,$AA,$AB,$AC,$AD,$AE,$AF
!BYTE $B0,$B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8,$B9,$BA,$BB,$BC,$BD,$BE,$BF
!BYTE  03,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF ; $C0=03
!BYTE $D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9,$DA,$DB,$DC,$DD,$DE,$DF
!BYTE 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
!BYTE $E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9,$EA,$EB,$EC,$ED,$EE,$EF
!BYTE $F0,$F1,$F2,$F3,$F4,$F5,$F6,$F7,$F8,$F9,$FA,$FB,$FC,$FD,$FE,$FF
MOVE_IN_LO_TAB  !BYTE <MOVE_IN_SPACE,<MOVE_IN_ENEMY,<MOVE_IN_PLAYER,<MOVE_IN_WALL

; 00000000 - 00 = 00
; 00000001 - 01 = 01
; 00000010 - 02 = 02
; 00000011 - 03 = 03

; 00000000 - 00 = 00
; 00000100 - 04 = 01
; 00001000 - 08 = 02
; 00001100 - 0C = 03

; 00000000 - 00 = 00
; 00010000 - 10 = 01
; 00100000 - 20 = 02
; 00110000 - 30 = 03

; 00000000 - 00 = 00
; 01000000 - 40 = 01
; 10000000 - 80 = 02
; 11000000 - C0 = 03

; increment x
; increment y
; decrement x
; decrement y



;4k x table
;4k y table
;2k = 4096 = 265*16
;2k = 
;buffer_stt_x_lo
;buffer_stt_x_hi
;buffer_stt_y_lo
;buffer_stt_y_hi
;buffer_end_x_lo
;buffer_end_x_hi
;buffer_end_y_lo
;buffer_end_y_hi

; ldx buffer_stt_x_lo
; inx
; stx buffer_stt_x_lo
; stx buffer_stt_y_lo
; bne .cont
;   lda buffer_stt_x_hi
;   clc
;   adc #1
;   and #3
;   tay
;   adc #buffer_stt_pos_x_hi
;   sta buffer_stt_x_hi
;   tya
;   adc #buffer_stt_pos_y_hi
;   sta buffer_stt_y_hi

; x = lo
; y = hi
!ZONE INC_BUFFER
INC_BUFFER  INX         ; inc lo
            BNE   .EXIT ; hasnt wrapped around
              INY       ; inc hi
              TYA
              AND   #15
              TAY              
.EXIT       RTS

; x = lo
; y = hi
!ZONE DEC_BUFFER
DEC_BUFFER  BNE   .EXIT
              DEY       ; dec hi
              TYA
              AND   #15
              TAY              
.EXIT       DEX         ; dec lo
            RTS
  
!ZONE INC_HEAD
INC_HEAD  LDA   BUF_HEAD_X_HI
          SEC
          SBC   #>BUF_X
          TAY
          LDX   BUF_HEAD_X_LO
          JSR   INC_BUFFER
          STX   BUF_HEAD_X_LO
          STX   BUF_HEAD_Y_LO
          TYA
          CLC
          ADC   #>BUF_X
          STA   BUF_HEAD_X_HI
          TYA
          CLC
          ADC   #>BUF_Y
          STA   BUF_HEAD_Y_HI
          RTS

!ZONE DEC_HEAD
DEC_HEAD  LDA   BUF_HEAD_X_HI
          SEC
          SBC   #>BUF_X
          TAY
          LDX   BUF_HEAD_X_LO
          JSR   DEC_BUFFER
          STX   BUF_HEAD_X_LO
          STX   BUF_HEAD_Y_LO
          TYA
          CLC
          ADC   #>BUF_X
          STA   BUF_HEAD_X_HI
          TYA
          CLC
          ADC   #>BUF_Y
          STA   BUF_HEAD_Y_HI
          RTS

!ZONE INC_TAIL
INC_TAIL  LDA   BUF_TAIL_X_HI
          SEC
          SBC   #>BUF_X
          TAY
          LDX   BUF_TAIL_X_LO
          JSR   INC_BUFFER
          STX   BUF_TAIL_X_LO
          STX   BUF_TAIL_Y_LO
          TYA
          CLC
          ADC   #>BUF_X
          STA   BUF_TAIL_X_HI
          TYA
          CLC
          ADC   #>BUF_Y
          STA   BUF_TAIL_Y_HI
          RTS

!ZONE DEC_TAIL
DEC_TAIL  LDA   BUF_TAIL_X_HI
          SEC
          SBC   #>BUF_X
          TAY
          LDX   BUF_TAIL_X_LO
          JSR   DEC_BUFFER
          STX   BUF_TAIL_X_LO
          STX   BUF_TAIL_Y_LO
          TYA
          CLC
          ADC   #>BUF_X
          STA   BUF_TAIL_X_HI
          TYA
          CLC
          ADC   #>BUF_Y
          STA   BUF_TAIL_Y_HI
          RTS

!ZONE CMP_HEAD_TAIL
CMP_HEAD_TAIL   LDA   BUF_HEAD_X_LO
                CMP   BUF_TAIL_X_LO
                BNE   .EXIT
                  LDA   BUF_HEAD_X_HI
                  CMP   BUF_TAIL_X_HI
                  BNE   .EXIT
                  SEC
                  RTS
.EXIT           CLC
                RTS

!ZONE GET_HEAD
GET_HEAD  LDY   #0  ; RETURN XY FROM HEAD POS
          LDA   (BUF_HEAD_X),Y
          TAX
          LDA   (BUF_HEAD_Y),Y
          TAY
          TXA   ; TO SET FLAGS
          RTS

!ZONE GET_TAIL
GET_TAIL  LDY   #0  ; RETURN XY FROM HEAD POS
          LDA   (BUF_TAIL_X),Y
          TAX
          LDA   (BUF_TAIL_X),Y
          TAY
          TXA   ; TO SET FLAGS
          RTS

!ZONE GET_HEAD_VAL  
GET_HEAD_VAL  JSR   GET_HEAD  ; GET HEAD XY POS
              JSR   GET       ; GET VALUE AT XY
              RTS

!ZONE GET_TAIL_VAL  
GET_TAIL_VAL  JSR   GET_TAIL  ; GET HEAD XY POS
              JSR   GET       ; GET VALUE AT XY
              RTS

; speed test #1          
;      STA SRC1    ;4
;      STA DST1    ;4 =8
;SRC1  LDA $ABCD,Y ;4
;DST1  STA $ABCD,Y ;5 =9
;                  *2 =18
; speed test #2

;      STA SCR     ;3 =3
;SRC3  LDA (SCR),Y ;5
;DST3  STA (SCR),Y ;6 =11
;                  *2 =22


; RESET HEAD AND TAIL
; ADD XY POINT TO HEAD
; INC HEAD

; START
;   GET TAIL - RETURNS XY
;   GET (XY)
;   CMP #EMPTY
;   BNE EXIT
;    LDA #PLAYER
;    PUT (XY)
;    ADD X+1Y TO HEAD
;    ADD X-1Y TO HEAD
;    ADD XY+1 TO HEAD
;    ADD XY-1 TO HEAD
; .EXIT
;   INC TAIL
;   IF TAIL NE HEAD
;    GOTO START

; 16x16 sprite copied to 24x21 sprite

; ldy #sprite     ; get sprite address pointer

; lda src_addr_lo,y   ; get sprite address (16x16x2=64 bytes)
; sta src_ptr_01 +1
; sta src_ptr_02 +1
; ..
; sta src_ptr_31 +1
; sta src_ptr_32 +1

; lda src_addr_hi,y
; sta src_ptr_01 +2
; sta src_ptr_02 +2
; ..
; sta src_ptr_31 +2
; sta src_ptr_32 +2

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

; until stack_size eq 0
;   x = remove_x_from_stack(stack_size)
;   y = remove_y_from_stack(stack_size)
;   stack_size--
;   if get(x,y) = space
;     put(x,y) = wall
;     add_x_to_stack(x-1,stack_size)
;     add_y_to_stack(y,stack_size)
;     stack_size++
;     add_x_to_stack(x+1,stack_size)
;     add_y_to_stack(y,stack_size)
;     stack_size++
;     add_x_to_stack(x,stack_size)
;     add_y_to_stack(y-1,stack_size)
;     stack_size++
;     add_x_to_stack(x,stack_size)
;     add_y_to_stack(y+1,stack_size)
;     stack_size++

; Flood-fill (node):
;  1. If node is not Inside return.
;  2. Set the node
;  3. Perform Flood-fill one step to the south of node.
;  4. Perform Flood-fill one step to the north of node
;  5. Perform Flood-fill one step to the west of node
;  6. Perform Flood-fill one step to the east of node
;  7. Return.