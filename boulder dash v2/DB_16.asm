﻿*= $1000 

;!MACRO BRA .v {
;    !byte $12, (.v - 2) - *
;}


; todo - collect diamonds if player moves over 1
; todo - push boulder and diamonds
; todo - boulder and diamond dropping onto players causes explosion
; todo - firefly can overwrite player
; todo - butterfly can overwrite player
; todo - amoeba can kill butterfly or firefly on contact and turns into diamonds?


; 0000 - 0
; 0001 - 1
; 0010 - 2
; 0011 - 3
; 0100 - 4
; 0101 - 5
; 0110 - 6
; 0111 - 7
; 1000 - 8
; 1001 - 9
; 1010 - A
; 1011 - B
; 1100 - C
; 1101 - D
; 1110 - E
; 1111 - F


PLAYER_COUNT = 12
ROCK_COUNT = 13
DIAMOND_COUNT = 14
AMOEBA_COUNT = 15
BUTTERFLY_TIMER = 16
FIREFLY_TIMER = 17

SCR_LO = 2 ; BANK_LO_HI+1
SCR_HI = SCR_LO+1
SCR = SCR_LO
REGA_BUF = SCR_HI +1
REGX_BUF = REGA_BUF+1
REGY_BUF = REGX_BUF+1
REGA_INT = REGY_BUF+1
REGX_INT = REGA_INT+1
REGY_INT = REGX_INT+1

XPLAYER = REGY_INT +1
YPLAYER = XPLAYER +1

PLAYER_COUNTER = YPLAYER +1
ROCK_COUNTER = PLAYER_COUNTER +1
DIAMOND_COUNTER = ROCK_COUNTER +1
AMOEBA_COUNTER = DIAMOND_COUNTER +1
BUTTERFLY_COUNTER = AMOEBA_COUNTER +1
FIREFLY_COUNTER = BUTTERFLY_COUNTER +1

XJOY = FIREFLY_COUNTER +1
YJOY = XJOY +1
JOYF = YJOY +1
XPOS = JOYF +1
YPOS = XPOS +1
SCR_BELOW_LO = YPOS +1
SCR_BELOW_HI = SCR_BELOW_LO +1
SCR_BELOW = SCR_BELOW_LO

EXPLOSION_LO = SCR_BELOW_HI +1
EXPLOSION_HI = EXPLOSION_LO +1
EXPLOSION = EXPLOSION_LO

EXPLOSION_BELOW_LO = EXPLOSION_HI +1
EXPLOSION_BELOW_HI = EXPLOSION_BELOW_LO +1
EXPLOSION_BELOW = EXPLOSION_BELOW_LO

SCR_ABOVE_LO = EXPLOSION_BELOW_HI +1
SCR_ABOVE_HI = SCR_ABOVE_LO +1
SCR_ABOVE = SCR_ABOVE_LO

SCR_TEMP_LO = SCR_ABOVE_HI +1
SCR_TEMP_HI = SCR_TEMP_LO +1
SCR_TEMP = SCR_TEMP_LO
VAL = SCR_TEMP_HI +1
AMOEBA_FOUND = VAL +1
AMOEBA_LIST_COUNT = AMOEBA_FOUND +1
FIREFLY_COUNT = AMOEBA_LIST_COUNT +1
BUTTERFLY_COUNT = FIREFLY_COUNT +1

CHRNO = 49152 +8192
SCRN0 = CHRNO+2048
SCRFRAC = SCRN0+1024

SCRNBANK = $00 ; $01 ; bank3: $c000-$ffff
BANK = %10101000 ; $D018 = %xxxx100x -> charmem is at $2000 (49152+8192) / $D018 = %1010xxxx -> screenmem is at $2800 (49152+8192+2048)

ROCK = 0 ; can move
DIAMOND = ROCK +1 ; can move
AMOEBA = DIAMOND +1 ; can move

WALL = 128 ; cant move
TITANIUM = WALL +1 ; cant move
BUTTERFLY = TITANIUM +1 ; can move
FIREFLY = BUTTERFLY +1 ; can move

SPACE = FIREFLY +1 ; cant move
GROUND = SPACE +1 ; cant move
EXIT = GROUND +1 ; cant move

PLAYER = EXIT +1 ; can move

PLAYER_MAX = 17

SRC_LO = SCR_LO
SRC_HI = SCR_HI
DST_LO = SCR_BELOW_LO
DST_HI = SCR_BELOW_HI

ZERO  = 32
ONE   = ZERO +1
TWO   = ONE +1
THREE = TWO +1
FOUR  = THREE +1
FIVE  = FOUR +1
SIX   = FIVE +1
SEVEN = SIX +1
EIGHT = SEVEN +1
NINE  = EIGHT +1

A = ZERO +32
B = A +1
C = B +1
D = C +1
E = D +1
F = E +1
G = F +1
H = G +1
I = H +1
J = I +1
K = J +1
L = K +1
M = L +1
N = M +1
O = N +1
P = O +1
Q = P +1
R = Q +1
S = R +1
T = S +1
U = T +1
V = U +1
W = V +1
X = W +1
Y = X +1
Z = Y +1

AMOEBA_MAX = 100

STOP = 0
UP = STOP +1
RIGHT = UP +1
DOWN = RIGHT +1
LEFT = DOWN +1

UP_DIR = 0
RIGHT_DIR = 1
DOWN_DIR = 2
LEFT_DIR = 3

!MACRO GET_MACRO {
     LDA   VER_LO,X ; get point from screen
     STA   .SCR+1
     LDA   VER_HI,X
     STA   .SCR+2
.SCR LDA   $ABCD,Y
}

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

 LDA #$FA-8   ; this is how to tell at which rasterline we want the irq to be triggered
 STA $D012

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
    
 LDA #$00     ; screen and border colours
 STA $D020
 LDA #$00 ; $00
 STA $D021
 LDA #$0C ; $00
 STA $D022
 LDA #$0F ; $00 
 STA $D023

 LDA #%00011011 ;$1B ; multicolour text mode 128=RST 64=ECM 32=CH/BM 16=VIS 8=24/25 4=SCRL 2=SCRL 1=SCRL
 STA $D011    ;VIC Control Register 1

 LDA #%00011000 ; 0-2=SCRL 3=40/38 4=MCM 5-7=UNUSED
 STA $D016    ;VIC Control Register 2

 LDA #%00001001 ; $01 ; bit 3 is set so multicolour colour 11 = white 
 LDX #<$D800
 LDY #>$D800
 STX SCR+0
 STY SCR+1
 LDX #>1000 
 LDY #<1000
 JSR MEMSET



LDA #12
STA BUTTERFLY_LIST_H
LDA #16
STA BUTTERFLY_LIST_V
LDA #0
STA BUTTERFLY_DIR
LDA #0
STA BUTTERFLY_COUNT


LDA #17
STA FIREFLY_LIST_H
LDA #16
STA FIREFLY_LIST_V
LDA #3
STA FIREFLY_DIR
LDA #0
STA FIREFLY_COUNT




 JSR GAME_SETUP
 JSR SCREEN_SETUP

CLI ; enable maskable interrupts again

MLOOP: JMP  MLOOP


!ZONE MOVE_PLAYER
MOVE_PLAYER LDA PLAYER_COUNTER
            BNE .EXIT

            LDX XPLAYER
            STX REGX_BUF
            LDY YPLAYER
            STY REGY_BUF
            JSR JOYSTICK2
            
            +GET_MACRO
            CMP #ROCK
            ; beq collect
            CMP #FIREFLY
            ; beq dead
            CMP #BUTTERFLY
            ; beq dead
                        
            CMP #TITANIUM+1 ; cant move into these
            BCC .EXIT
            
              STX XPLAYER
              STY YPLAYER

              LDX REGX_BUF
              LDY REGY_BUF
              LDA #SPACE
              JSR PLOT

              LDX XPLAYER
              LDY YPLAYER
              LDA #PLAYER
              JSR PLOT
            
.EXIT
RTS

; x = v
; y = h
!ALIGN 255,0
GAP_UP    DEX
RTS
 
GAP_DOWN  INX
RTS

GAP_LEFT  DEY
RTS

GAP_RIGHT INY
RTS

GAP_DIRECTION  !BYTE <GAP_UP, <GAP_RIGHT, <GAP_DOWN, <GAP_LEFT
NEXT_DIRECTION !BYTE LEFT_DIR, UP_DIR, RIGHT_DIR, DOWN_DIR, LEFT_DIR, UP_DIR
TURN_LEFT = NEXT_DIRECTION
FORWARD = NEXT_DIRECTION +1
TURN_RIGHT = NEXT_DIRECTION +2

!ZONE MOVE_BUTTERFLY

.LATEST_DIR = REGA_BUF
.XPOS_NEW = SCR_BELOW_LO
.YPOS_NEW = SCR_BELOW_HI
.NEXT_POS = VAL

.QUIT RTS
MOVE_BUTTERFLY  LDA BUTTERFLY_COUNTER
                BNE .QUIT
                
                LDX BUTTERFLY_COUNT
                BMI .QUIT

.LOOP             STX .NEXT_POS ; temp array pos

                  LDY BUTTERFLY_DIR,X   ; get direction
                  LDA TURN_LEFT,Y       ; get left of that direction
                  STA .LATEST_DIR       ; left direction
                  TAY

                  LDA GAP_DIRECTION,Y   ; get code to jump to 
                  STA .LEFT +1

                  LDY BUTTERFLY_LIST_H,X
                  LDA BUTTERFLY_LIST_V,X
                  TAX
                  
.LEFT             JSR GAP_UP ; self modified low byte of jsr

                  STX .XPOS_NEW ; backup new
                  STY .YPOS_NEW
                 
                  LDA VER_HI,X
                  STA SCR_HI
                  LDA VER_LO,X 
                  STA SCR_LO

                  LDX .NEXT_POS

                  LDA (SCR),Y
                  CMP #SPACE ; is it a space
                  BEQ .UPDATE
 

                  LDY BUTTERFLY_DIR,X   ; get direction
                  STY .LATEST_DIR      ; forward direction

                  LDA GAP_DIRECTION,Y   ; get code to jump to 
                  STA .FORWARD +1

                  LDY BUTTERFLY_LIST_H,X
                  LDA BUTTERFLY_LIST_V,X
                  TAX
                  
.FORWARD          JSR GAP_UP ; self modified low byte of jsr

                  STX .XPOS_NEW ; backup new
                  STY .YPOS_NEW
                 
                  LDA VER_HI,X
                  STA SCR_HI
                  LDA VER_LO,X 
                  STA SCR_LO

                  LDX .NEXT_POS

                  LDA (SCR),Y
                  CMP #SPACE ; is it a space
                  BEQ .UPDATE

                  
                  LDY BUTTERFLY_DIR,X   ; get direction
                  LDA TURN_RIGHT,Y      ; get right of that direction
                  STA BUTTERFLY_DIR,X

                  JMP .NEXT
 
.UPDATE LDA #BUTTERFLY
        STA (SCR),Y ; update new pos with butterfly

        LDY BUTTERFLY_LIST_V,X
        LDA VER_HI,Y
        STA SCR_HI
        LDA VER_LO,Y 
        STA SCR_LO
        LDY BUTTERFLY_LIST_H,X
        LDA #SPACE
        STA (SCR),Y ; clear old pos   

        LDA .XPOS_NEW ; backup new
        STA BUTTERFLY_LIST_V,X
        LDA .YPOS_NEW ; backup new
        STA BUTTERFLY_LIST_H,X
        LDA .LATEST_DIR   ; left direction
        STA BUTTERFLY_DIR,X

.NEXT DEX
      BMI .EXIT 
      JMP .LOOP

.EXIT RTS



!ZONE MOVE_FIREFLY

.LATEST_DIR = REGA_BUF
.XPOS_NEW = SCR_BELOW_LO
.YPOS_NEW = SCR_BELOW_HI
.NEXT_POS = VAL

.QUIT RTS
MOVE_FIREFLY  LDA FIREFLY_COUNTER
              BNE .QUIT
                
              LDX FIREFLY_COUNT
              BMI .QUIT

.LOOP         STX .NEXT_POS ; temp array pos

              LDY FIREFLY_DIR,X
              LDA TURN_RIGHT,Y
              STA .LATEST_DIR
              TAY

              LDA GAP_DIRECTION,Y   ; get code to jump to 
              STA .LEFT +1

              LDY FIREFLY_LIST_H,X
              LDA FIREFLY_LIST_V,X
              TAX
                  
.LEFT         JSR GAP_UP ; self modified low byte of jsr

              STX .XPOS_NEW ; backup new
              STY .YPOS_NEW
                 
              LDA VER_HI,X
              STA SCR_HI
              LDA VER_LO,X 
              STA SCR_LO

              LDX .NEXT_POS

              LDA (SCR),Y
              CMP #SPACE ; is it a space
              BEQ .UPDATE
 
              LDY FIREFLY_DIR,X   ; get direction
              STY .LATEST_DIR      ; forward direction

              LDA GAP_DIRECTION,Y   ; get code to jump to 
              STA .FORWARD +1

              LDY FIREFLY_LIST_H,X
              LDA FIREFLY_LIST_V,X
              TAX
                  
.FORWARD      JSR GAP_UP ; self modified low byte of jsr

              STX .XPOS_NEW ; backup new
              STY .YPOS_NEW
                 
              LDA VER_HI,X
              STA SCR_HI
              LDA VER_LO,X 
              STA SCR_LO

              LDX .NEXT_POS

              LDA (SCR),Y
              CMP #SPACE ; is it a space
              BEQ .UPDATE

                  
              LDY FIREFLY_DIR,X
              LDA TURN_LEFT,Y
              STA FIREFLY_DIR,X

              JMP .NEXT
 
.UPDATE LDA #FIREFLY
        STA (SCR),Y ; update new pos with butterfly

        LDY FIREFLY_LIST_V,X
        LDA VER_HI,Y
        STA SCR_HI
        LDA VER_LO,Y 
        STA SCR_LO
        LDY FIREFLY_LIST_H,X
        LDA #SPACE
        STA (SCR),Y ; clear old pos   

        LDA .XPOS_NEW ; backup new
        STA FIREFLY_LIST_V,X
        LDA .YPOS_NEW ; backup new
        STA FIREFLY_LIST_H,X
        LDA .LATEST_DIR   ; left direction
        STA FIREFLY_DIR,X
                    
.NEXT DEX
      BMI .EXIT 
      JMP .LOOP

.EXIT RTS


RANDOM  LDA #123
        BEQ   DO_EOR
          ASL
          BEQ NO_EOR ;if the input was $80, skip the EOR
          BCC NO_EOR
DO_EOR      EOR #$1D
NO_EOR  STA RANDOM+1
RTS

!ZONE MOVE_ROCKS_DIAMONDS_AMEOBAS

.AMOEBAS_TO_DIAMONDS  STA .ATD_DIAMOND_ROCK +1 ; either rocks or diamonds
                      LDX #20 ;

.ATD_XLOOP            LDA VER_HI,X
                      STA SCR_HI
                      LDA VER_LO,X
                      STA SCR_LO       

                      LDY #38
  
.ATD_YLOOP              LDA (SCR),Y       ; get value 
                        CMP #AMOEBA       ; is it 
                        BNE .ATD_YNEXT

.ATD_DIAMOND_ROCK         LDA #DIAMOND 
                          STA (SCR),Y

.ATD_YNEXT              DEY
                        BNE .ATD_YLOOP

                      DEX
                      BNE .ATD_XLOOP
RTS

.AMOEBA_CHECK   LDY AMOEBA_FOUND       ; get number of amoebas found
                BEQ .AMOEBA_CHECK_EXIT ; if no amoebas then exit
        
                LDA #DIAMOND              ; fill amoebas as diamonds
                LDX AMOEBA_LIST_COUNT     ; if amoeba count is 0 but there are amoebas found
                BEQ .AMOEBAS_TO_DIAMONDS  ; then make all amoebas diamonds and exit
        
                LDA #ROCK                 ; fill amoebas as rocks
                CPY #AMOEBA_MAX           ; if over 200 amoebas found
                BCS .AMOEBAS_TO_DIAMONDS
  
.RANDOM         JSR RANDOM
                CMP AMOEBA_LIST_COUNT
                BCS .RANDOM               ; get random point to grow into

                TAY
                LDX AMOEBA_LIST_V,Y
                LDA AMOEBA_LIST_H,Y
                TAY
        
                LDA VER_HI,X
                STA SCR_TEMP_HI
                LDA VER_LO,X 
                STA SCR_TEMP_LO
        
                LDA (SCR_TEMP),Y          ; get point from screen
                CMP #GROUND               ; if its ground 
                BEQ .AMEOBA_GROW          ; grown into it 
                  CMP #SPACE              ; if its space
                  BNE .AMOEBA_CHECK_EXIT  ; grow into it

.AMEOBA_GROW    LDA #AMOEBA               ; grow amoeba
                STA (SCR_TEMP),Y          
        
.AMOEBA_CHECK_EXIT  RTS


MOVE_ROCKS_DIAMONDS_AMOEBAS
  LDA #0
  STA AMOEBA_FOUND
  STA AMOEBA_LIST_COUNT
  
  LDX #20

.XLOOP  STX XPOS

        LDA VER_HI,X
        STA .SCR_ADDR+2
        STA SCR_HI
        LDA VER_LO,X ; get point from screen
        STA .SCR_ADDR+1
        STA SCR_LO
        
        LDA VER_HI+1,X
        STA SCR_BELOW_HI
        LDA VER_LO+1,X ; get point below 
        STA SCR_BELOW_LO

        LDA VER_HI+2,X
        STA EXPLOSION_HI
        LDA VER_LO+2,X ; get point below 
        STA EXPLOSION_LO

        LDA VER_HI+2,X
        STA EXPLOSION_BELOW_HI
        LDA VER_LO+2,X ; get point below 
        STA EXPLOSION_BELOW_LO

        LDA VER_HI-1,X
        STA SCR_ABOVE_HI
        LDA VER_LO-1,X ; get point below 
        STA SCR_ABOVE_LO

        LDY #38
  
.YLOOP    STY YPOS
.SCR_ADDR LDA $ABCD,Y       ; get value 
          BMI .YNEXT        ; its not a boulder or firefly or amoeba
          BNE .AMBA_CHK

.ROCK     LDA ROCK_COUNTER  ; its zero so its a rock
          BNE .YNEXT        ; rocks cant move yet
          BEQ .ROCK_DIAMOND_MOVE ; rocks can move

.AMBA_CHK CMP #AMOEBA    ; is it an amoeba
          BNE .DIAMOND      ; no it must be a diamond

.AMOEBA   LDA AMOEBA_COUNTER ; can amoeba move
          BNE .YNEXT        ; no

          JMP .AMOEBA_MOVE

.DIAMOND  LDA DIAMOND_COUNTER 
          BEQ .ROCK_DIAMOND_MOVE ; diamond can move yet
          
.GETYNEXT LDY YPOS
.YNEXT    DEY
          BNE .YLOOP

        LDX XPOS
        DEX
        BNE .XLOOP
        
        LDA AMOEBA_FOUND 
        BEQ .EXIT

         JMP .AMOEBA_CHECK

.EXIT        
RTS

.ROCK_DIAMOND_MOVE  LDA (SCR_BELOW),Y ; get point below        
                    CMP #SPACE        ; is it space
                    BNE .LFT_RGT      ; no

                    LDA (SCR),Y       ; yes
                    STA (SCR_BELOW),Y ; so move current
                    LDA #SPACE        ; to below
                    STA (SCR),Y       ; and put space in current

                    JSR CHECK_EXPLOSION
            
                    jmp .GETYNEXT     ; could use beq instead?

.LFT_RGT ;          LDA (SCR_BELOW),Y
                    CMP #DIAMOND      ; is below a diamond
                    BEQ .LEFT_CHK     ; diamond underneath
                    CMP #ROCK         ; or a rock
                    BEQ .LEFT_CHK     ; rock underneath
                    CMP #TITANIUM     ; or a titanium wall
                    BEQ .LEFT_CHK     ; rock underneath
                    CMP #WALL         ; or a wall
                    BNE .YNEXT        ; not any of these so continue
            
.LEFT_CHK   DEY               ; move to left
            LDA (SCR_BELOW),Y ; check if bottom left
            CMP #SPACE        ; is space
            BNE .RIGHT_CHK    ; no
            LDA (SCR),Y       ; check if left
            CMP #SPACE        ; is space
            BNE .RIGHT_CHK    ; no

            INY               ; back to start
            LDA (SCR),Y       ; get current - replace with lax?
            TAX               ; in x
            LDA #SPACE        ; put space
            STA (SCR),Y       ; in current
            
            DEY               ; move to left
            TXA               ; put current
            STA (SCR),Y       ; in left
            DEC YPOS          ; needed to prevent item being reprocessed again this frame
            JMP .GETYNEXT     ; could use beq instead?

.RIGHT_CHK  INY               ; back to start
            INY               ; move to right
            LDA (SCR_BELOW),Y ; check if right right
            CMP #SPACE        ; is space
            BNE .GETYNEXT     ; no
            LDA (SCR),Y       ; check if right
            CMP #SPACE        ; is space
            BNE .GETYNEXT     ; no

            DEY               ; back to start
            LDA (SCR),Y       ; get current - replace with lax?
            TAX               ; in x
            LDA #SPACE        ; put space
            STA (SCR),Y       ; in current
            
            INY               ; move to right
            TXA               ; put current
            STA (SCR),Y       ; in right
            JMP .GETYNEXT     ; could use beq instead?

.AMOEBA_MOVE  INC AMOEBA_FOUND ; increment amuont found count

              LDX XPOS

              LDA (SCR_ABOVE),Y   ; get point above        
              CMP #SPACE          ; is it space or ground
              BEQ .AMOEBA_UP_ADD
              CMP #GROUND
              BEQ .AMOEBA_UP_ADD
 
              LDA (SCR_BELOW),Y    ; get point below        
              CMP #SPACE           ; is it space or ground
              BEQ .AMOEBA_DOWN_ADD
              CMP #GROUND
              BEQ .AMOEBA_DOWN_ADD

              INY
              LDA (SCR),Y          ; get point right        
              CMP #SPACE           ; is it space or ground
              BEQ .AMOEBA_RIGHT_ADD
              CMP #GROUND
              BEQ .AMOEBA_RIGHT_ADD

              DEY
              DEY
              LDA (SCR),Y          ; get point left        
              CMP #SPACE           ; is it space or ground
              BEQ .AMOEBA_LEFT_ADD
              CMP #GROUND
              BEQ .AMOEBA_LEFT_ADD

              JMP .GETYNEXT

.AMOEBA_UP_ADD    DEX
                  JMP .AMOEBA_ADD ; could be replaced with 2 dexs instead?
  
.AMOEBA_DOWN_ADD  INX
.AMOEBA_RIGHT_ADD
.AMOEBA_LEFT_ADD

.AMOEBA_ADD       TXA
                  LDX AMOEBA_LIST_COUNT
                  CPX #255             ; list already full
                  BEQ .AMOEBA_EXIT     ; yes
                    STA AMOEBA_LIST_V,X
                    TYA
                    STA AMOEBA_LIST_H,X
                    INC AMOEBA_LIST_COUNT

.AMOEBA_EXIT      JMP .GETYNEXT

; get point below and if its a player or firefly or ameoba or butterfly then explode - into something depending on what type it is
!ZONE CHECK_EXPLOSION
CHECK_EXPLOSION STA .EXPLODE+1 ; object type dropping
                LDA VER_HI+2,X
                STA SCR_TEMP_HI
                LDA VER_LO+2,X ; get point below 
                STA SCR_TEMP_LO

                LDA (SCR_TEMP),Y
                CMP #PLAYER
                BEQ .EXPLODE
                CMP #AMOEBA
                BEQ .EXPLODE
                CMP #FIREFLY
                BEQ .EXPLODE
                CMP #BUTTERFLY
                BNE .EXIT
                
.EXPLODE          LDA #0
                  STA (SCR_TEMP),Y
.EXIT
RTS

!ZONE JOYSTICK
JOYSTICK1 LDA $DC01     ; PORT 1
          JMP .JOYSTICK
JOYSTICK2 LDA $DC00     ; PORT 2
.JOYSTICK
.UP       LSR
          BCS   .DOWN
            DEX
            RTS
.DOWN     LSR
          BCS   .LEFT
            INX
            RTS
.LEFT     LSR
          BCS   .RIGHT
            DEY
            RTS
.RIGHT    LSR
          BCS   .EXIT
            INY
            RTS
;.FIRE     EOR   #255
;          AND   #1
;          STA   JOYF
;          STX   XJOY
;          STY   YJOY
;          LSR
.EXIT      RTS

!ZONE GET
GET
+GET_MACRO
;GET     LDA   VER_LO,X ; get point from screen
;        STA   .SCR+1
;        LDA   VER_HI,X
;        STA   .SCR+2
;.SCR    LDA   $ABCD,Y
        RTS

!ZONE PUT
PLOT    STA   VAL
PUT     LDA   VER_LO,X ; get point from screen
        STA   .SCR+1
        LDA   VER_HI,X
        STA   .SCR+2
        LDA   VAL
.SCR    STA   $ABCD,Y
        RTS

!ZONE VERLINE
VERLINE   STA   REGA_BUF
          STX   REGX_BUF
          STY   REGY_BUF

.LOOP       LDX   REGX_BUF
            LDY   REGY_BUF
            JSR   PUT
        
            INC   REGX_BUF
            DEC   REGA_BUF
            BNE   .LOOP
                 
          RTS

!ZONE HORLINE
HORLINE   STA   REGA_BUF
          STX   REGX_BUF
          STY   REGY_BUF

.LOOP       LDX   REGX_BUF
            LDY   REGY_BUF
            JSR   PUT
        
            INC   REGY_BUF
            DEC   REGA_BUF
            BNE   .LOOP
                 
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

!ZONE MEM_CPY
MEM_CPY   LDA SRC_LO
          STA .SRC+1
          LDA SRC_HI
          STA .SRC+2
          LDA DST_LO
          STA .DST+1
          LDA DST_HI
          STA .DST+2
      
.SRC        LDA $ABCD
.DST        STA $ABCD
            LDA .SRC+1
            CLC
            ADC #1
            STA .SRC+1
            BCC .SRCNXT
              INC .SRC+2

.SRCNXT     LDA .DST+1
            CLC
            ADC #1
            STA .DST+1
            BCC .DSTNXT
              INC .DST+2        

.DSTNXT     DEX
            BNE .SRC
          DEY
          BPL .SRC
        RTS

!ZONE UPDATE_COUNTERS
UPDATE_COUNTERS DEC PLAYER_COUNTER
                BPL .CONT1
                  LDA #PLAYER_COUNT ; if minus set to start
                  STA PLAYER_COUNTER

.CONT1          DEC ROCK_COUNTER
                BPL .CONT2
                  LDA #ROCK_COUNT ; if minus set to start
                  STA ROCK_COUNTER

.CONT2          DEC DIAMOND_COUNTER
                BPL .CONT3
                  LDA #DIAMOND_COUNT ; if minus set to start
                  STA DIAMOND_COUNTER

.CONT3          DEC AMOEBA_COUNTER
                BPL .CONT4
                  LDA #AMOEBA_COUNT ; if minus set to start
                  STA AMOEBA_COUNTER

.CONT4          DEC BUTTERFLY_COUNTER
                BPL .CONT5
                  LDA #BUTTERFLY_TIMER ; if minus set to start
                  STA BUTTERFLY_COUNTER

.CONT5          DEC FIREFLY_COUNTER
                BPL .CONT6
                  LDA #FIREFLY_TIMER ; if minus set to start
                  STA FIREFLY_COUNTER

.CONT6
          RTS
                

!ZONE BM_IRQ
BM_IRQ:
  INC $D019    ;VIC Interrupt Request Register (IRR)

    INC $d020
    STA REGA_INT
    STX REGX_INT
    STY REGY_INT

  JSR UPDATE_COUNTERS
  JSR MOVE_PLAYER
;  JSR MOVE_BUTTERFLY
;  JSR MOVE_FIREFLY
  JSR MOVE_ROCKS_DIAMONDS_AMOEBAS
  
  JSR MOVE_BUTTERFLY
  JSR MOVE_FIREFLY
  

;JSR MOVE_PLR

  LDA REGA_INT
  LDX REGX_INT
  LDY REGY_INT
  DEC $d020

;  INC $D019    ;VIC Interrupt Request Register (IRR)

NMI_NOP:  
RTI ; This is the irq handler for the NMI. Just returns without acknowledge. This prevents subsequent NMI's from interfering.

!ZONE GAME_SETUP
GAME_SETUP  LDX #46
.LOOP         STX REGX_BUF
              LDA CHAR_SETUP_LO,X
              STA REGA_BUF
              LDY CHAR_SETUP_HI,X
              LDA CHAR_SETUP_CHAR,X
              LDX REGA_BUF
              JSR SET_CHAR
              LDX REGX_BUF
              DEX
              BPL .LOOP
RTS

SCREEN_SETUP
 
 LDA #20
 STA XPLAYER
 STA YPLAYER

 LDA #SPACE ; BC ;$65 ; colour 01 (0000????) and colour 10 (????0000) - bank 1
 LDX #<SCRN0
 LDY #>SCRN0
 STX SCR+0
 STY SCR+1
 LDX #>1000 
 LDY #<1000
 JSR MEMSET
 
 LDA #A
 LDX #22
 LDY #0
 JSR PLOT
 LDA #B
 LDX #22
 LDY #1
 JSR PLOT
 LDA #C
 LDX #22
 LDY #2
 JSR PLOT
 LDA #D
 LDX #22
 LDY #3
 JSR PLOT
 LDA #E
 LDX #22
 LDY #4
 JSR PLOT
 LDA #F
 LDX #22
 LDY #5
 JSR PLOT
 LDA #G
 LDX #22
 LDY #6
 JSR PLOT
 LDA #H
 LDX #22
 LDY #7
 JSR PLOT
 LDA #I
 LDX #22
 LDY #8
 JSR PLOT
 LDA #J
 LDX #22
 LDY #9
 JSR PLOT
 LDA #K
 LDX #22
 LDY #10
 JSR PLOT
 LDA #L
 LDX #22
 LDY #11
 JSR PLOT
 LDA #M
 LDX #22
 LDY #12
 JSR PLOT
 LDA #N
 LDX #22
 LDY #13
 JSR PLOT
 LDA #O
 LDX #22
 LDY #14
 JSR PLOT
 LDA #P
 LDX #22
 LDY #15
 JSR PLOT
 LDA #Q
 LDX #22
 LDY #16
 JSR PLOT
 LDA #R
 LDX #22
 LDY #17
 JSR PLOT
 LDA #S
 LDX #22
 LDY #18
 JSR PLOT
 LDA #T
 LDX #22
 LDY #19
 JSR PLOT
 LDA #U
 LDX #22
 LDY #20
 JSR PLOT
 LDA #V
 LDX #22
 LDY #21
 JSR PLOT
 LDA #W
 LDX #22
 LDY #22
 JSR PLOT
 LDA #X
 LDX #22
 LDY #23
 JSR PLOT
 LDA #Y
 LDX #22
 LDY #24
 JSR PLOT
 LDA #Z
 LDX #22
 LDY #25
 JSR PLOT

 LDA #ZERO
 LDX #22
 LDY #26
 JSR PLOT
 LDA #ONE
 LDX #22
 LDY #27
 JSR PLOT
 LDA #TWO
 LDX #22
 LDY #28
 JSR PLOT
 LDA #THREE
 LDX #22
 LDY #29
 JSR PLOT
 LDA #FOUR
 LDX #22
 LDY #30
 JSR PLOT
 LDA #FIVE
 LDX #22
 LDY #31
 JSR PLOT
 LDA #SIX
 LDX #22
 LDY #32
 JSR PLOT
 LDA #SEVEN
 LDX #22
 LDY #33
 JSR PLOT
 LDA #EIGHT
 LDX #22
 LDY #34
 JSR PLOT
 LDA #NINE
 LDX #22
 LDY #35
 JSR PLOT

LDX #<MAP1
LDY #>MAP1
STX SRC_LO
STY SRC_HI
LDX #<SCRN0
LDY #>SCRN0
STX DST_LO
STY DST_HI
LDX #<880
LDY #>880
JSR MEM_CPY
  
RTS
 
!ZONE SET_CHAR          
SET_CHAR  STX .LOOP +1
          STY .LOOP +2

          LDY #0
          STY .CHR +2
                    
          ASL 
          ROL .CHR +2
          ASL 
          ROL .CHR +2
          ASL 
          ROL .CHR +2

          STA .CHR +1

          CLC
          LDA #>(CHRNO)
          ADC .CHR +2
          STA .CHR +2

          LDY #7
.LOOP       LDA !ABCD,Y
.CHR        STA !ABCD,Y
            DEY
            BPL .LOOP

          RTS

VER_HI
!for LOOP = 0 TO 24
!BYTE >(SCRN0+(LOOP*40))
!end

VER_LO
!for LOOP = 0 TO 24
!BYTE <(SCRN0+(LOOP*40))
!end

CHAR_SPACE
!BYTE %00000000
!BYTE %00000000
!BYTE %00000000
!BYTE %00000000
!BYTE %00000000
!BYTE %00000000
!BYTE %00000000
!BYTE %00000000
CHAR_A
!BYTE %11111100
!BYTE %11001100
!BYTE %11001100
!BYTE %11111100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %00000000
CHAR_B
!BYTE %11111100
!BYTE %11001100
!BYTE %11001100
!BYTE %11110000
!BYTE %11001100
!BYTE %11001100
!BYTE %11111100
!BYTE %00000000
CHAR_C
!BYTE %11111100
!BYTE %11000000
!BYTE %11000000
!BYTE %11000000
!BYTE %11000000
!BYTE %11000000
!BYTE %11111100
!BYTE %00000000
CHAR_D
!BYTE %11110000
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11110000
!BYTE %00000000
CHAR_E
!BYTE %11111100
!BYTE %11000000
!BYTE %11000000
!BYTE %11111100
!BYTE %11000000
!BYTE %11000000
!BYTE %11111100
!BYTE %00000000
CHAR_F
!BYTE %11111100
!BYTE %11000000
!BYTE %11000000
!BYTE %11111100
!BYTE %11000000
!BYTE %11000000
!BYTE %11000000
!BYTE %00000000
CHAR_G
!BYTE %11111100
!BYTE %11000000
!BYTE %11000000
!BYTE %11000000
!BYTE %11001100
!BYTE %11001100
!BYTE %11111100
!BYTE %00000000
CHAR_H
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11111100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %00000000
CHAR_I
!BYTE %11111100
!BYTE %00110000
!BYTE %00110000
!BYTE %00110000
!BYTE %00110000
!BYTE %00110000
!BYTE %11111100
!BYTE %00000000
CHAR_J
!BYTE %00111100
!BYTE %00001100
!BYTE %00001100
!BYTE %00001100
!BYTE %00001100
!BYTE %11001100
!BYTE %11111100
!BYTE %00000000
CHAR_K
!BYTE %11000000
!BYTE %11001100
!BYTE %11001100
!BYTE %11110000
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %00000000
CHAR_L
!BYTE %11000000
!BYTE %11000000
!BYTE %11000000
!BYTE %11000000
!BYTE %11000000
!BYTE %11000000
!BYTE %11111100
!BYTE %00000000
CHAR_M
!BYTE %11001100
!BYTE %11111100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %00000000
CHAR_N
!BYTE %11111100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %00000000
CHAR_O
!BYTE %11111100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11111100
!BYTE %00000000
CHAR_P
!BYTE %11111100
!BYTE %11001100
!BYTE %11001100
!BYTE %11111100
!BYTE %11000000
!BYTE %11000000
!BYTE %11000000
!BYTE %00000000
CHAR_Q
!BYTE %11111100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11111100
!BYTE %00001100
!BYTE %00000000
CHAR_R
!BYTE %11111100
!BYTE %11001100
!BYTE %11001100
!BYTE %11110000
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %00000000
CHAR_S
!BYTE %11111100
!BYTE %11000000
!BYTE %11000000
!BYTE %11111100
!BYTE %00001100
!BYTE %00001100
!BYTE %11111100
!BYTE %00000000
CHAR_T
!BYTE %11111100
!BYTE %00110000
!BYTE %00110000
!BYTE %00110000
!BYTE %00110000
!BYTE %00110000
!BYTE %00110000
!BYTE %00000000
CHAR_U
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11111100
!BYTE %00000000
CHAR_V
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %00110000
!BYTE %00000000
CHAR_W
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11111100
!BYTE %11001100
!BYTE %00000000
CHAR_X
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %00110000
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %00000000
CHAR_Y
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11111100
!BYTE %00001100
!BYTE %00001100
!BYTE %00001100
!BYTE %00000000
CHAR_Z
!BYTE %11111100
!BYTE %00001100
!BYTE %00001100
!BYTE %00110000
!BYTE %11000000
!BYTE %11000000
!BYTE %11111100
!BYTE %00000000

CHAR_0
!BYTE %11111100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11111100
!BYTE %00000000
CHAR_1
!BYTE %00110000
!BYTE %11110000
!BYTE %00110000
!BYTE %00110000
!BYTE %00110000
!BYTE %00110000
!BYTE %11111100
!BYTE %00000000
CHAR_2
!BYTE %11111100
!BYTE %00001100
!BYTE %00001100
!BYTE %11111100
!BYTE %11000000
!BYTE %11000000
!BYTE %11111100
!BYTE %00000000
CHAR_3
!BYTE %11111100
!BYTE %00001100
!BYTE %00001100
!BYTE %11111100
!BYTE %00001100
!BYTE %00001100
!BYTE %11111100
!BYTE %00000000
CHAR_4
!BYTE %11001100
!BYTE %11001100
!BYTE %11001100
!BYTE %11111100
!BYTE %00001100
!BYTE %00001100
!BYTE %00001100
!BYTE %00000000
CHAR_5
!BYTE %11111100
!BYTE %11000000
!BYTE %11000000
!BYTE %11111100
!BYTE %00001100
!BYTE %00001100
!BYTE %11111100
!BYTE %00000000
CHAR_6
!BYTE %11111100
!BYTE %11000000
!BYTE %11000000
!BYTE %11111100
!BYTE %11001100
!BYTE %11001100
!BYTE %11111100
!BYTE %00000000
CHAR_7
!BYTE %11111100
!BYTE %00001100
!BYTE %00001100
!BYTE %00001100
!BYTE %00001100
!BYTE %00001100
!BYTE %00001100
!BYTE %00000000
CHAR_8
!BYTE %11111100
!BYTE %11001100
!BYTE %11001100
!BYTE %11111100
!BYTE %11001100
!BYTE %11001100
!BYTE %11111100
!BYTE %00000000
CHAR_9
!BYTE %11111100
!BYTE %11001100
!BYTE %11001100
!BYTE %11111100
!BYTE %00001100
!BYTE %00001100
!BYTE %00001100
!BYTE %00000000

CHAR_DIAMOND
!BYTE %00010100
!BYTE %00101000
!BYTE %11111111
!BYTE %01010101
!BYTE %10101010
!BYTE %11111111
!BYTE %00010100
!BYTE %00101000

CHAR_TITANIUM
!BYTE %10101010
!BYTE %10101010
!BYTE %10101010
!BYTE %10101010
!BYTE %10101010
!BYTE %10101010
!BYTE %10101010
!BYTE %10101010

CHAR_WALL
!BYTE %11111111
!BYTE %11111111
!BYTE %11111111
!BYTE %11111111
!BYTE %11111111
!BYTE %11111111
!BYTE %11111111
!BYTE %11111111

CHAR_GROUND
!BYTE %00010001
!BYTE %01000100
!BYTE %00010001
!BYTE %01000100
!BYTE %00010001
!BYTE %01000100
!BYTE %00010001
!BYTE %01000100

CHAR_ROCK
!BYTE %00111100
!BYTE %00111100
!BYTE %11010111
!BYTE %11010111
!BYTE %11010111
!BYTE %11010111
!BYTE %00111100
!BYTE %00111100

CHAR_SETUP_LO 
!BYTE <CHAR_SPACE,<CHAR_WALL,<CHAR_GROUND,<CHAR_P,<CHAR_B,<CHAR_F,<CHAR_A,<CHAR_E,<CHAR_ROCK,<CHAR_TITANIUM,<CHAR_DIAMOND
!BYTE <CHAR_0,<CHAR_1,<CHAR_2,<CHAR_3,<CHAR_4,<CHAR_5,<CHAR_6,<CHAR_7,<CHAR_8,<CHAR_9
!BYTE <CHAR_A,<CHAR_B,<CHAR_C,<CHAR_D,<CHAR_E,<CHAR_F,<CHAR_G,<CHAR_H,<CHAR_I,<CHAR_J,<CHAR_K,<CHAR_L,<CHAR_M,<CHAR_N,<CHAR_O,<CHAR_P,<CHAR_Q,<CHAR_R,<CHAR_S,<CHAR_T,<CHAR_U,<CHAR_V,<CHAR_W,<CHAR_X,<CHAR_Y,<CHAR_Z

CHAR_SETUP_HI
!BYTE >CHAR_SPACE,>CHAR_WALL,>CHAR_GROUND,>CHAR_P,>CHAR_B,>CHAR_F,>CHAR_A,>CHAR_E,>CHAR_ROCK,>CHAR_TITANIUM,>CHAR_DIAMOND
!BYTE >CHAR_0,>CHAR_1,>CHAR_2,>CHAR_3,>CHAR_4,>CHAR_5,>CHAR_6,>CHAR_7,>CHAR_8,>CHAR_9
!BYTE >CHAR_A,>CHAR_B,>CHAR_C,>CHAR_D,>CHAR_E,>CHAR_F,>CHAR_G,>CHAR_H,>CHAR_I,>CHAR_J,>CHAR_K,>CHAR_L,>CHAR_M,>CHAR_N,>CHAR_O,>CHAR_P,>CHAR_Q,>CHAR_R,>CHAR_S,>CHAR_T,>CHAR_U,>CHAR_V,>CHAR_W,>CHAR_X,>CHAR_Y,>CHAR_Z

CHAR_SETUP_CHAR
!BYTE SPACE,WALL,GROUND,PLAYER,BUTTERFLY,FIREFLY,AMOEBA,EXIT,ROCK,TITANIUM,DIAMOND
!BYTE ZERO,ONE,TWO,THREE,FOUR,FIVE,SIX,SEVEN,EIGHT,NINE
!BYTE A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z

SP = SPACE
WL = WALL
GR = GROUND
PL = PLAYER
BF = BUTTERFLY
FF = FIREFLY
AM = AMOEBA
RK = ROCK
TT = TITANIUM
DD = DIAMOND

!ALIGN 255,0
MAP1
!BYTE TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT ; 1
!BYTE TT,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,TT ; 2
!BYTE TT,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,TT ; 3
!BYTE TT,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,WL,WL,WL,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,TT ; 4
!BYTE TT,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,TT ; 5
!BYTE TT,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,DD,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,TT ; 6
!BYTE TT,GR,SP,SP,SP,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,DD,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,TT ; 7
!BYTE TT,GR,SP,SP,SP,GR,GR,GR,GR,RK,RK,DD,DD,RK,RK,DD,DD,RK,GR,GR,RK,GR,DD,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,TT ; 8
!BYTE TT,GR,SP,SP,SP,GR,GR,GR,GR,DD,RK,DD,RK,DD,DD,RK,RK,DD,GR,GR,GR,RK,GR,DD,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,RK,RK,RK,RK,RK,TT ; 9
!BYTE TT,GR,SP,SP,SP,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,RK,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,RK,GR,GR,AM,RK,TT ; 10
!BYTE TT,GR,GR,SP,GR,GR,GR,GR,SP,SP,SP,SP,SP,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,RK,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,RK,GR,GR,GR,RK,TT ; 11
!BYTE TT,GR,GR,SP,GR,GR,GR,GR,SP,SP,SP,SP,SP,GR,SP,SP,SP,SP,SP,GR,GR,GR,RK,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,RK,GR,GR,GR,RK,TT ; 12
!BYTE TT,GR,GR,SP,GR,GR,SP,SP,SP,SP,SP,SP,SP,GR,SP,SP,SP,SP,SP,GR,GR,GR,GR,RK,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,RK,GR,GR,GR,RK,TT ; 13
!BYTE TT,GR,GR,SP,SP,SP,SP,SP,SP,SP,SP,SP,SP,GR,SP,SP,SP,SP,SP,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,RK,RK,RK,RK,RK,TT ; 14
!BYTE TT,GR,GR,GR,GR,GR,SP,SP,SP,SP,SP,SP,SP,GR,SP,SP,SP,SP,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,TT ; 15
!BYTE TT,GR,GR,GR,GR,GR,SP,SP,SP,SP,SP,SP,SP,GR,SP,SP,SP,SP,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,RK,RK,RK,RK,RK,RK,GR,TT ; 16
!BYTE TT,GR,GR,GR,GR,GR,SP,SP,SP,SP,SP,SP,SP,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,RK,GR,GR,GR,GR,RK,GR,TT ; 17
!BYTE TT,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,RK,GR,GR,AM,GR,RK,GR,TT ; 18
!BYTE TT,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,RK,GR,GR,GR,GR,RK,GR,TT ; 19
!BYTE TT,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,RK,RK,RK,RK,RK,RK,GR,TT ; 20
!BYTE TT,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,GR,TT ; 21
!BYTE TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT,TT ; 22

AMOEBA_LIST_H !FILL 256
AMOEBA_LIST_V !FILL 256

FIREFLY_LIST_H !FILL 128 ;7
FIREFLY_LIST_V !FILL 128 ;13
FIREFLY_DIR !FILL 128 ;0

BUTTERFLY_LIST_H !FILL 128
BUTTERFLY_LIST_V !FILL 128
BUTTERFLY_DIR !FILL 128

