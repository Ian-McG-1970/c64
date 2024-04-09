; map of 32x32 tiles converted to 128x128 chars
; eah tiles is either wall (neg) or floor (pos)
; each floor tiles has a 4 bit point pointing to which direction objects can move in on this tile? (4 bits for up/down/left/right)

; next is to convert 32x32 tiles into 128x128 chars

; screen = 18k to 19k
; charset = 16k to 18k
; sprites = 19k to 32k

*= 2049
!byte $0c,$08,$0a,$00,$9e   ; Line 10 SYS
!tx "2070"            ; Address for sys start in text 4096+11

SCR = 2
MEM_FROM = SCR +2
MEM_TO = MEM_FROM +2

MINI_MAP_LO = MEM_FROM
MINI_MAP_HI = MEM_FROM +1

EXPAND_MAP_LO = MEM_TO
EXPAND_MAP_HI = MEM_TO +1

REGA = MEM_TO +2
REGX = REGA +1
REGY = REGX +1
MAP_H_START_POS_FIRST_LINE = REGY +1
MAP_H_START_POS_SECOND_LINE = MAP_H_START_POS_FIRST_LINE +1
MAP_V = MAP_H_START_POS_SECOND_LINE +1
PIXEL_V = MAP_V +1
MAP_H = PIXEL_V +1
PIXEL_H = MAP_H +1

PLAYER_V_HI = PIXEL_H +1
PLAYER_V_LO = PLAYER_V_HI +1
PLAYER_H_HI = PLAYER_V_LO +1
PLAYER_H_LO = PLAYER_H_HI +1

SPR2_V_LO = PLAYER_H_LO +1 
SPR2_V_HI = SPR2_V_LO +1
SPR2_H_LO = SPR2_V_HI +1
SPR2_H_HI = SPR2_H_LO +1

SPR3_V_LO = SPR2_H_HI +1
SPR3_V_HI = SPR3_V_LO +1
SPR3_H_LO = SPR3_V_HI +1
SPR3_H_HI = SPR3_H_LO +1

SPR4_V_LO = SPR3_H_HI +1
SPR4_V_HI = SPR4_V_LO +1
SPR4_H_LO = SPR4_V_HI +1
SPR4_H_HI = SPR4_H_LO +1

SPR5_V_LO = SPR4_H_HI +1
SPR5_V_HI = SPR5_V_LO +1
SPR5_H_LO = SPR5_V_HI +1
SPR5_H_HI = SPR5_H_LO +1

SPR6_V_LO = SPR5_H_HI +1
SPR6_V_HI = SPR6_V_LO +1
SPR6_H_LO = SPR6_V_HI +1
SPR6_H_HI = SPR6_H_LO +1

SPR7_V_LO = SPR6_H_HI +1
SPR7_V_HI = SPR7_V_LO +1
SPR7_H_LO = SPR7_V_HI +1
SPR7_H_HI = SPR7_H_LO +1

SPR2V = SPR7_H_HI +1
SPR2H = SPR2V +1
SPR2S = SPR2H +1 ; shape
SPR2C = SPR2S +1 ; colour

SPR3V = SPR2C +1
SPR3H = SPR3V +1
SPR3S = SPR3H +1
SPR3C = SPR3S +1

SPR4V = SPR3C +1
SPR4H = SPR4V +1
SPR4S = SPR4H +1
SPR4C = SPR4S +1

SPR5V = SPR4C +1
SPR5H = SPR5V +1
SPR5S = SPR5H +1
SPR5C = SPR5S +1

SPR6V = SPR5C +1
SPR6H = SPR6V +1
SPR6S = SPR6H +1
SPR6C = SPR6S +1

SPR7V = SPR6C +1
SPR7H = SPR7V +1
SPR7S = SPR7H +1
SPR7C = SPR7S +1

SCR_LFT_LO = SPR7C +1
SCR_LFT_HI = SCR_LFT_LO +1
SCR_RGT_LO = SCR_LFT_HI +1
SCR_RGT_HI = SCR_RGT_LO +1
SCR_TOP_LO = SCR_RGT_HI +1
SCR_TOP_HI = SCR_TOP_LO +1
SCR_BOT_LO = SCR_TOP_HI +1
SCR_BOT_HI = SCR_BOT_LO +1

MAP_VALUE = SCR_BOT_HI +1
MAP_OFFSET = MAP_VALUE +1

MAP_00_LO = MAP_OFFSET +1
MAP_00 = MAP_00_LO
MAP_00_HI = MAP_00_LO +1

MAP_01_LO = MAP_00_HI +1
MAP_01 = MAP_01_LO
MAP_01_HI = MAP_01_LO +1

MAP_02_LO = MAP_01_HI +1
MAP_02 = MAP_02_LO
MAP_02_HI = MAP_02_LO +1

MAP_03_LO = MAP_02_HI +1
MAP_03 = MAP_03_LO
MAP_03_HI = MAP_03_LO +1

;TEST_HI = SCR_BOT_HI +1
;TEST_LO = TEST_HI+1
;TEST_CHAR = TEST_LO+1
;TEST_PIXEL = TEST_CHAR+1
 
STACK = 255

BDR = $D020
SCR0 = $D021
SCR1 = $D022
SCR2 = $D023
SCR3 = $D024
SPC1 = $D025
SPC2 = $D026

MULCOLSPR = $D01C

SPRENBL = 53248+21
SPRXPX = 53248+29 
SPRXPY = 53248+23

S0X = 53248+0
S0Y = 53248+1
S0C = $D027
S0P = VIC_SCN+$03f8
HW_SPRITE_0 = (512/64)+0

S1X = 53248+2
S1Y = 53248+3
S1C = $D028
S1P = VIC_SCN+$03f9
HW_SPRITE_1 = (512/64)+1

S2X = 53248+4
S2Y = 53248+5
S2C = $D029
S2P = VIC_SCN+$03fa
HW_SPRITE_2 = (512/64)+2

S3X = 53248+6
S3Y = 53248+7
S3C = $D02A
S3P = VIC_SCN+$03fb
HW_SPRITE_3 = (512/64)+3

S4X = 53248+8
S4Y = 53248+9
S4C = $D02B
S4P = VIC_SCN+$03fc
HW_SPRITE_4 = (512/64)+4

S5X = 53248+10
S5Y = 53248+11
S5C = $D02C
S5P = VIC_SCN+$03fd
HW_SPRITE_5 = (512/64)+5

S6X = 53248+12
S6Y = 53248+13
S6C = $D02D
S6P = VIC_SCN+$03fe
HW_SPRITE_6 = (512/64)+6

S7X = 53248+14
S7Y = 53248+15
S7C = $D02E
S7P = VIC_SCN+$03ff
HW_SPRITE_7 = (512/64)+7

SPRXMSB = 53248+16

MP_RASTER_POS = 246-12
IRQ_042 = 84
IRQ_042 = 140

VIC_BANK = 16384
VIC_CHAR = VIC_BANK
VIC_SCN = VIC_CHAR +2048

MAP_ADR = 32768 ; 49152
MAP_LEN = 128

VIC_BNK = %00000010 ; 16384

RASTER_088 = 88+1
RASTER_130 = 130+1
RASTER_172 = 172+1
RASTER_214 = 214+1
RASTER_242 = 242+1

IRQ_088_VPOS = 92 
IRQ_130_VPOS = 134 
IRQ_172_VPOS = 176 
IRQ_214_VPOS = 218 
IRQ_242_VPOS = 50 

SCREEN_EDGE = (12*8) +24
SCREEN_EDGE_OFFSET = 106

MINI_MAP = 512 ; uncompressed map 32x32 

!ZONE SET_SPRITE_POS
!MACRO SET_SPRITE_POS {
   LDA  SPR2V
   STA  S2Y
   LDA  SPR2H
   STA  S2X
   LDA  SPR2S
   STA  S2P
   LDA  SPR2C
   STA  S2C

   LDA  SPR3V
   STA  S3Y
   LDA  SPR3H
   STA  S3X
   LDA  SPR3S
   STA  S3P
   LDA  SPR3C
   STA  S3C

   LDA  SPR4V
   STA  S4Y
   LDA  SPR4H
   STA  S4X
   LDA  SPR4S
   STA  S4P
   LDA  SPR4C
   STA  S4C

   LDA  SPR5V
   STA  S5Y
   LDA  SPR5H
   STA  S5X
   LDA  SPR5S
   STA  S5P
   LDA  SPR5C
   STA  S5C

   LDA  SPR6V
   STA  S6Y
   LDA  SPR6H
   STA  S6X
   LDA  SPR6S
   STA  S6P
   LDA  SPR6C
   STA  S6C

   LDA  SPR7V
   STA  S7Y
   LDA  SPR7H
   STA  S7X
   LDA  SPR7S
   STA  S7P
   LDA  SPR7C
   STA  S7C
}

!ZONE CALC_SCROLL
!MACRO CALC_SCROLL HI, LO, CHAR, PIXEL {
  LAX   LO      ; 3 
  EOR   #$FF    ; 2
  AND   #$07    ; 2
  ORA   #$10    ; 2
  STA   PIXEL   ; 3
  TXA ;2 
  LSR ;2
  LSR ;2
  LSR ;2 ; LO >>3
  STA CHAR ;3
  LDA HI ;3
  ASL ;2
  ASL ;2
  ASL ;2
  ASL ;2
  ASL ;2 ; HI <<5
  ORA CHAR ;3
  STA CHAR ;3
}

!ZONE CALC_SCROLL_BK
!MACRO CALC_SCROLL_BK HI, LO, CHAR, PIXEL {
  LAX   LO      ; 3 
  EOR   #$FF
  AND   #$07    ; 2
  ORA   #$10    ; 2
  STA   PIXEL   ; 3
  TXA
  AND #%11111000
  STA CHAR
  LDA HI
  AND #%00000111
  ORA CHAR
  TAX
  ROR
  TXA
  ROR
  ROR
  ROR
;  ROR
  STA CHAR
}

;!ZONE CALC_SCROLL_H 
;!MACRO CALC_SCROLL_H HI, LO, CHAR, PIXEL {
;  LAX   LO      ; 3 
;  EOR   #$FF
;  AND   #$07    ; 2
;  ORA   #$10    ; 2
;  STA   PIXEL   ; 3
;  LDA   HI      ; 3
;  LSR           ; 2
;  STA   CHAR    ; 3 temp
;  TXA           ; 2
;  ROR           ; 2
;  LSR   CHAR    ; 5 temp
;  ROR           ; 2
;  LSR   CHAR    ; 2
;;  STA   CHAR    ; 3
;}

;!ZONE CALC_SCROLL_V 
;!MACRO CALC_SCROLL_V HI, LO, CHAR, PIXEL {
;  LAX   LO      ; 3 
;  EOR   #$FF
;  AND   #$07    ; 2
;  ORA   #$10    ; 2
;  STA   PIXEL   ; 3
;  LDA   HI      ; 3
;  LSR           ; 2
;  STA   CHAR    ; 3 temp
;  TXA           ; 2
;  ROR           ; 2
;  LSR   CHAR    ; 5 temp
;  ROR           ; 2
;  LSR   CHAR    ; 2
;;  STA   CHAR    ; 3
;}

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

  LDA   #$35   ; we turn off the BASIC and KERNAL rom here
  STA   $01    ; the cpu now sees RAM everywhere except at $d000-$e000, where still the registers of SID/VICII/etc are visible

  LDA #<IRQ_242  ; this is how we set up
  STA $FFFE     ; the address of our interrupt code
  LDA #>IRQ_242
  STA $FFFF
  LDA #RASTER_242 ; this is how to tell at which rasterline we want the irq to be triggered
  STA $D012

;  LDA   #<MP_IRQ  ; this is how we set up
;  STA   $FFFE     ; the address of our interrupt code
;  LDA   #>MP_IRQ
;  STA   $FFFF
;  LDA   #MP_RASTER_POS   ; this is how to tell at which rasterline we want the irq to be triggered
;  STA   $D012
  
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

  LDA #VIC_BNK
  STA $DD00

  LDA #%00100000 ; charset at 16*1024 / screen at 18*1024
  STA $D018

  LDA #0
  STA BDR

  LDA #1
  STA SCR0
  LDA #2
  STA SCR1
  LDA #3
  STA SCR2

  LDA #4
  STA SPC1
  LDA #5
  STA SPC2

  LDA #255
  STA SPRENBL
  STA MULCOLSPR
  LDA #0
  STA SPRXPX
  STA SPRXPY

  LDA #100
  STA S0X
  STA S0Y
 
  LDA #80
  STA S1X
  STA S1Y
  
  LDA #10
  STA S0C
  LDA #11
  STA S1C
  
  LDA #HW_SPRITE_0
  STA S0P
  LDA #HW_SPRITE_1
  STA S1P
  
  LDA #50
  STA MAP_V
  LDA #50
  STA MAP_H

  LDA #$01
  LDX #<$D800
  LDY #>$D800
  STX SCR+0
  STY SCR+1
  LDX #>1000 
  LDY #<1000
  JSR MEMSET

  LDX #<800
  LDY #>800
  STX MEM_FROM+0
  STY MEM_FROM+1
  LDX #<VIC_SCN
  LDY #>VIC_SCN
  STX MEM_TO+0
  STY MEM_TO+1
  LDY #<1024
  LDX #>1024
  JSR MEMCPY

  LDX #<800
  LDY #>800
  STX MEM_FROM+0
  STY MEM_FROM+1
  LDX #<VIC_CHAR
  LDY #>VIC_CHAR
  STX MEM_TO+0
  STY MEM_TO+1
  LDY #<2048
  LDX #>2048
  JSR MEMCPY

 ldx #<512
 ldy #>512
 stx PLAYER_H_LO
 stx PLAYER_V_LO
 sty PLAYER_H_HI
 sty PLAYER_V_HI

 ldx #<512
 ldy #>512
 stx SPR2_H_LO
 stx SPR2_V_LO
 sty SPR2_H_HI
 sty SPR2_V_HI

 ldx #<612
 ldy #>612
 stx SPR3_H_LO
 stx SPR3_V_LO
 sty SPR3_H_HI
 sty SPR3_V_HI

 ldx #<712
 ldy #>712
 stx SPR4_H_LO
 stx SPR4_V_LO
 sty SPR4_H_HI
 sty SPR4_V_HI

 ldx #<812
 ldy #>812
 stx SPR5_H_LO
 stx SPR5_V_LO
 sty SPR5_H_HI
 sty SPR5_V_HI

 ldx #<912
 ldy #>912
 stx SPR6_H_LO
 stx SPR6_V_LO
 sty SPR6_H_HI
 sty SPR6_V_HI

 ldx #<1012
 ldy #>1012
 stx SPR7_H_LO
 stx SPR7_V_LO
 sty SPR7_H_HI
 sty SPR7_V_HI

; sprite is off top of screen at line 33 and starts appearing at top at line 34
; sprite ends appearing at bottom at line 245 and is offscreen at line 246
 
; LDA  #54
; STA  SPR2V
; LDA  #100
; STA  SPR2H
 LDA  #51
 STA  SPR2S
 LDA  #2
 STA  SPR2C

; LDA #34 ; #33 ; #54 ; #53
; STA SPR3V
; LDA #150
; STA SPR3H
 LDA #51
 STA SPR3S
 LDA #3
 STA SPR3C

; LDA #245 ; #33 ; #54 ; #53
; STA SPR4V
; LDA #100
; STA SPR4H
 LDA #51
 STA SPR4S
 LDA #4
 STA SPR4C

; sprite is off left of screen at line 7 and starts to appear at left at line 8
; sprite ends appearing at right bottom at line 219 and is offscreen at line 220

; LDA  #100
; STA  SPR5V
; LDA  #7
; STA  SPR5H
 LDA  #51
 STA  SPR5S
 LDA  #5
 STA  SPR5C

; LDA #150 ; #33 ; #54 ; #53
; STA SPR6V
; LDA #31
; STA SPR6H
 LDA #51
 STA SPR6S
 LDA #6
 STA SPR6C

; LDA #140 ; #33 ; #54 ; #53
; STA SPR7V
; LDA #220
; STA SPR7H
 LDA #51
 STA SPR7S
 LDA #7
 STA SPR7C

 ldy #0
 jsr EXPAND_RLE_MAP
 jsr EXPAND_MINI_MAP
  CLI

MLOOP:  JMP   MLOOP ; we better don't RTS, the ROMS are now switched off, there's no way back to the system

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

!align 255, 0
!ZONE IRQ_088
IRQ_088 INC   $D019    ;VIC Interrupt Request Register (IRR)
        STA   .REG_A+1
 DEC BDR

        LDA   #IRQ_088_VPOS
        STA   S0Y
        STA   S1Y

        LDA   #1      ; expand single sprites
        STA   SPRXPY

        LDA   #SP008
        STA   S0P
        LDA   #SP009
        STA   S1P

        LDA   #<IRQ_130 ; 128  ; setup next raster interrupt for 42 lines down the screen?     
        STA   $FFFE
        LDA   #RASTER_130 ; 128
        STA   $D012

 INC BDR
.REG_A  LDA   #0
        RTI

!ZONE IRQ_130
IRQ_130 INC   $D019
        STA   .REG_A+1
 DEC BDR

        LDA   #IRQ_130_VPOS  ; ver pos
        STA   S0Y
        LDA   #139 ; 129 ; 136
        STA   S1Y

        LDA   #1      ; expand single sprites
        STA   SPRXPX

        LDA   #0      ; reset sprite msb
        STA   SPRXMSB

        LDA   #113 ; (24+96-10) ; main sprite hor pos
        STA   S1X

        LDA   #SP001
        STA   S0P
        LDA   #SP000
        STA   S1P
 
        LDA   #<IRQ_172  ; setup next raster interrupt for 42 lines down the screen     
        STA   $FFFE
        LDA   #RASTER_172
        STA   $D012

 INC BDR
.REG_A  LDA   #0
        RTI

!ZONE IRQ_172
IRQ_172 INC   $D019
        STA   .REG_A+1
 DEC BDR

        LDA   #IRQ_172_VPOS  ; ver pos
        STA   S0Y
        STA   S1Y

        LDA   #3    ; expand both sprites
        STA   SPRXPX
        LDA   #1
        STA   SPRXPY

        LDA     #12    ; reset hor pos
        STA     S1X

        LDA     #2    ; set msb
        STA     SPRXMSB

        LDA   #SP003
        STA   S0P
        LDA   #SP002
        STA   S1P
  
        LDA     #<IRQ_214  ; setup next raster interrupt for 42 lines down the screen?     
        STA     $FFFE
        LDA     #RASTER_214
        STA     $D012

        STX     .REG_X+1
        STY     .REG_Y+1

 INC BDR
    JSR     JOYSTICK2
    JSR     MOVE_PLAYER
    JSR     CALC_SCREEN_EDGE
    JSR     SETUP_SPRITES

 DEC BDR

 INC BDR
.REG_A  LDA     #0
.REG_X  LDX     #0
.REG_Y  LDY     #0
        RTI

!ZONE IRQ_214
IRQ_214 INC   $D019
        STA     .REG_A+1
 DEC BDR

        LDA     #IRQ_214_VPOS  ; ver pos
        STA     S0Y
        STA     S1Y

        LDA   #SP005
        STA   S0P
        LDA   #SP004
        STA   S1P

        LDA     #<IRQ_242  ; setup next raster interrupt for 42 lines down the screen?     
        STA     $FFFE
        LDA     #RASTER_242
        STA     $D012

 INC BDR
.REG_A  LDA     #0
        RTI
        
!ZONE IRQ_242
IRQ_242 INC     $D019
        STA     .REG_A+1
 DEC BDR

        STX     .REG_X+1
        STY     .REG_Y+1

        JSR     CALC_MAP_POS

    LDX   PIXEL_H
    LDY   PIXEL_V
    STX   $D016
    STY   $D011

 INC BDR
    
        LDA     #IRQ_242_VPOS   ; ver pos
        STA     S0Y
        STA     S1Y

        LDA     #220  ; hor pos
        STA     S0X

        LDA   #SP007
        STA   S0P
        LDA   #SP006
        STA   S1P

        LDA     #<IRQ_088  ; setup next raster interrupt for 42 lines down the screen?     
        STA     $FFFE
        LDA     #RASTER_088
        STA     $D012
  
.REG_A  LDA     #0
.REG_X  LDX     #0
.REG_Y  LDY     #0
NMI_NOP: RTI ; This is the irq handler for the NMI. Just returns without acknowledge. This prevents subsequent NMI's from interfering.

SP000 = 48
SP001 = 49
SP002 = 50
SP003 = 51
SP004 = 52
SP005 = 53
SP006 = 54
SP007 = 55
SP008 = 56
SP009 = 57
SP010 = 58
SP011 = 59
SP012 = 60

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
.RIGHT INC   PLAYER_H_LO
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

!ZONE MAP_POS
CALC_MAP_POS
 INC BDR
 INC BDR
 INC BDR
  +CALC_SCROLL PLAYER_H_HI, PLAYER_H_LO, MAP_H, PIXEL_H
  +CALC_SCROLL PLAYER_V_HI, PLAYER_V_LO, MAP_V, PIXEL_V
 INC BDR
 INC BDR
 INC BDR
 DEC BDR
 DEC BDR
 DEC BDR
  +SET_SPRITE_POS
 DEC BDR
 DEC BDR
 DEC BDR

MAP
  LDY MAP_H         ; GET MAP CHAR POS H
  LAX MAP_V         ; GET MAP CHAR POS V
  LSR             ; MOVE MSB INTO CARRY
  LDA NUMBERS-12,Y      ; GET LEFT (-12) - BETWEEN 0 AND 127  
  LDY NUMBERS-12,X      ; GET TOP (-12) - BETWEEN 0 AND 127 
  LDX MAP_HI,Y        ; GET MAP V START POS

  BCS MAP_EVEN_LINE     ; POPULATE MAP STARTING FROM EVEN LINE (12*2 EVEN LINES THEN 1 ODD LINE)

MAP_ODD_LINE          ; POPULATE MAP STARTING FROM ODD LINE (1 ODD LINE THEN 12*23 EVEN LINES)
;  LDA NUMBERS-12,Y      ; GET LEFT (-12) - BETWEEN 0 AND 127 
  STA MAP_H_START_POS_FIRST_LINE  ; BACKUP HOR START POS (H POS + 0)
  EOR #128
  STA MAP_H_START_POS_SECOND_LINE ; BACKUP HOR START POS FOR NEXT LINE

;  LDY NUMBERS-12,X      ; GET TOP (-12) - BETWEEN 0 AND 127 
;  LDX MAP_HI,Y        ; GET MAP V START POS

    STX MAP_SCN_01+2
    STX MAP_SCN_02+2
  INX
    STX MAP_SCN_03+2
    STX MAP_SCN_04+2
  INX
    STX MAP_SCN_05+2
    STX MAP_SCN_06+2
  INX
    STX MAP_SCN_07+2
    STX MAP_SCN_08+2
  INX
    STX MAP_SCN_09+2
    STX MAP_SCN_10+2
  INX
    STX MAP_SCN_11+2
    STX MAP_SCN_12+2
  INX
    STX MAP_SCN_13+2
    STX MAP_SCN_14+2
  INX
    STX MAP_SCN_15+2
    STX MAP_SCN_16+2
  INX
    STX MAP_SCN_17+2
    STX MAP_SCN_18+2
  INX
    STX MAP_SCN_19+2
    STX MAP_SCN_20+2
  INX
    STX MAP_SCN_21+2
    STX MAP_SCN_22+2
  INX
    STX MAP_SCN_23+2
    STX MAP_SCN_24+2
  INX
    STX MAP_SCN_25+2
  JMP CONT ; BVC CONT ; JMP

MAP_EVEN_LINE         ; POPULATE MAP STARTING FROM EVEN LINE (12*2 EVEN LINES THEN 1 ODD LINE)
;  LDA NUMBERS-12,Y      ; GET LEFT (-12) - BETWEEN 0 AND 127
  STA MAP_H_START_POS_SECOND_LINE  ; BACKUP HOR START POS (128+H POS)
  EOR #128
  STA MAP_H_START_POS_FIRST_LINE ; BACKUP HOR START POS FOR NEXT LINE
  
;  LDY NUMBERS-12,X      ; GET TOP (-12) - BETWEEN 0 AND 127 
;  LDX MAP_HI,Y        ; GET MAP V START POS

    STX MAP_SCN_01+2
  INX
    STX MAP_SCN_02+2
    STX MAP_SCN_03+2
  INX
    STX MAP_SCN_04+2
    STX MAP_SCN_05+2
  INX
    STX MAP_SCN_06+2
    STX MAP_SCN_07+2
  INX
    STX MAP_SCN_08+2
    STX MAP_SCN_09+2
  INX
    STX MAP_SCN_10+2
    STX MAP_SCN_11+2
  INX
    STX MAP_SCN_12+2
    STX MAP_SCN_13+2
  INX
    STX MAP_SCN_14+2
    STX MAP_SCN_15+2
  INX
    STX MAP_SCN_16+2
    STX MAP_SCN_17+2
  INX
    STX MAP_SCN_18+2
    STX MAP_SCN_19+2
  INX
    STX MAP_SCN_20+2
    STX MAP_SCN_21+2
  INX
    STX MAP_SCN_22+2
    STX MAP_SCN_23+2
  INX
    STX MAP_SCN_24+2
    STX MAP_SCN_25+2

CONT
  LDX MAP_H_START_POS_FIRST_LINE
  LDY MAP_H_START_POS_SECOND_LINE

    STX MAP_SCN_01+1
    STY MAP_SCN_02+1
    STX MAP_SCN_03+1
    STY MAP_SCN_04+1
    STX MAP_SCN_05+1
    STY MAP_SCN_06+1
    STX MAP_SCN_07+1
    STY MAP_SCN_08+1
    STX MAP_SCN_09+1
    STY MAP_SCN_10+1
    STX MAP_SCN_11+1
    STY MAP_SCN_12+1
    STX MAP_SCN_13+1
    STY MAP_SCN_14+1
    STX MAP_SCN_15+1
    STY MAP_SCN_16+1
    STX MAP_SCN_17+1
    STY MAP_SCN_18+1
    STX MAP_SCN_19+1
    STY MAP_SCN_20+1
    STX MAP_SCN_21+1
    STY MAP_SCN_22+1
    STX MAP_SCN_23+1
    STY MAP_SCN_24+1
    STX MAP_SCN_25+1
          
    DEC BDR
    
          LDY #24 ; 31 ; 24
.LOOP
MAP_SCN_01  LDA  $1111,Y
            STA  VIC_SCN+(40*00),Y
MAP_SCN_02  LDA  $2222,Y
            STA  VIC_SCN+(40*01),Y
MAP_SCN_03  LDA  $3333,Y
            STA  VIC_SCN+(40*02),Y
MAP_SCN_04  LDA  $4444,Y
            STA  VIC_SCN+(40*03),Y
MAP_SCN_05  LDA  $5555,Y
            STA  VIC_SCN+(40*04),Y
MAP_SCN_06  LDA  $6666,Y
            STA  VIC_SCN+(40*05),Y
MAP_SCN_07  LDA  $7777,Y
            STA  VIC_SCN+(40*06),Y
MAP_SCN_08  LDA  $8888,Y
            STA  VIC_SCN+(40*07),Y
MAP_SCN_09  LDA  $9999,Y
            STA  VIC_SCN+(40*08),Y
MAP_SCN_10  LDA  $AAAA,Y
            STA  VIC_SCN+(40*09),Y
MAP_SCN_11  LDA  $BBBB,Y
            STA  VIC_SCN+(40*10),Y
MAP_SCN_12  LDA  $CCCC,Y
            STA  VIC_SCN+(40*11),Y
MAP_SCN_13  LDA  $DDDD,Y
            STA  VIC_SCN+(40*12),Y
MAP_SCN_14  LDA  $EEEE,Y
            STA  VIC_SCN+(40*13),Y
MAP_SCN_15  LDA  $1111,Y
            STA  VIC_SCN+(40*14),Y
MAP_SCN_16  LDA  $2222,Y
            STA  VIC_SCN+(40*15),Y
MAP_SCN_17  LDA  $3333,Y
            STA  VIC_SCN+(40*16),Y
MAP_SCN_18  LDA  $4444,Y
            STA  VIC_SCN+(40*17),Y
MAP_SCN_19  LDA  $5555,Y
            STA  VIC_SCN+(40*18),Y
MAP_SCN_20  LDA  $6666,Y
            STA  VIC_SCN+(40*19),Y
MAP_SCN_21  LDA  $7777,Y
            STA  VIC_SCN+(40*20),Y
MAP_SCN_22  LDA  $8888,Y
            STA  VIC_SCN+(40*21),Y
MAP_SCN_23  LDA  $9999,Y
            STA  VIC_SCN+(40*22),Y
MAP_SCN_24  LDA  $AAAA,Y
            STA  VIC_SCN+(40*23),Y
MAP_SCN_25  LDA  $BBBB,Y
            STA  VIC_SCN+(40*24),Y
          DEY
          BMI .EXIT ; SHOULD THIS BE BMI ?  
         JMP .LOOP
.EXIT
    INC BDR

  RTS

!ZONE CALC_SCREEN_EDGE
CALC_SCREEN_EDGE

  LDY PLAYER_V_HI
  LDA PLAYER_V_LO
  SEC
  SBC #SCREEN_EDGE_OFFSET+33
  BCS .CONT_V
    DEY
.CONT_V
  STY SCR_TOP_HI
  STA SCR_TOP_LO

  LDY PLAYER_H_HI
  LDA PLAYER_H_LO
  SEC
  SBC #SCREEN_EDGE_OFFSET+7
  BCS .CONT_H
    DEY
.CONT_H
  STY SCR_LFT_HI
  STA SCR_LFT_LO

  RTS

!ZONE SETUP_SPRITE
!MACRO SETUP_SPRITE V_LO, V_HI, H_LO, H_HI, V_RES, H_RES {

  LDA V_LO
  SEC
  SBC SCR_TOP_LO
  TAX
  LDA V_HI
  SBC SCR_TOP_HI
  BNE .OFFSCR
  CPX #(SCREEN_EDGE_OFFSET*2)+35
  BCS .OFFSCR

  LDA H_LO
  SEC
  SBC SCR_LFT_LO
  TAY
  LDA H_HI
  SBC SCR_LFT_HI
  BNE .OFFSCR
  CPY #(SCREEN_EDGE_OFFSET*2)+9
  BCC .ONSCR

.OFFSCR LDX #0

.ONSCR  STX V_RES
    STY H_RES
}

!ZONE SETUP_SPRITES
SETUP_SPRITES

  +SETUP_SPRITE SPR2_V_LO, SPR2_V_HI, SPR2_H_LO, SPR2_H_HI, SPR2V, SPR2H
  +SETUP_SPRITE SPR3_V_LO, SPR3_V_HI, SPR3_H_LO, SPR3_H_HI, SPR3V, SPR3H
  +SETUP_SPRITE SPR4_V_LO, SPR4_V_HI, SPR4_H_LO, SPR4_H_HI, SPR4V, SPR4H
  +SETUP_SPRITE SPR5_V_LO, SPR5_V_HI, SPR5_H_LO, SPR5_H_HI, SPR5V, SPR5H
  +SETUP_SPRITE SPR6_V_LO, SPR6_V_HI, SPR6_H_LO, SPR6_H_HI, SPR6V, SPR6H
  +SETUP_SPRITE SPR7_V_LO, SPR7_V_HI, SPR7_H_LO, SPR7_H_HI, SPR7V, SPR7H

 RTS

!ZONE EXPAND_RLE_MAP
EXPAND_RLE_MAP  LDA #<MINI_MAP
        STA MINI_MAP_LO
        LDA #>MINI_MAP
        STA MINI_MAP_HI

        LDA COMPRESSED_MAP_LO,Y
        STA EXPAND_MAP_LO
        LDX COMPRESSED_MAP_HI,Y
        STX EXPAND_MAP_HI
            
        LDY #0

.LOOP:  STY   REGY
    LAX   (EXPAND_MAP_LO),Y  ; get rle byte
        BEQ   .EXIT     ; 0=exit

        ROL         ; shift msb into carry
        LDA   #0
        ADC   #0    ; ROL ? ; acc now holds either 0 or 1
        STA   MAP_VALUE

        TXA         ; get rle byte
        ASL         ; AND #127 ; move msb out
        LSR         ; AND #127 ; shift back to keep 000-127
        TAX         ; fill count
        STA     MAP_OFFSET
        LDA     MAP_VALUE

    LDY   #0
.FILL_LOOP  STA   (MINI_MAP_LO),Y  ; store at map,x
      INY
      DEX
      BNE   .FILL_LOOP    ; end-for

        LDA   MINI_MAP_LO
        CLC
        ADC   MAP_OFFSET
        STA   MINI_MAP_LO
        BCC   .CONT2
      INC   MINI_MAP_HI
.CONT2:
    LDY   REGY
        INY
        BNE   .LOOP
      INC   EXPAND_MAP_HI
        JMP   .LOOP
.EXIT:    RTS

!ZONE EXPAND_MINI_MAP
EXPAND_MINI_MAP:  LDX   #31
    
.vloop            STX   REGX

            LDA   MINI_MAP_ADR_LO,X
            STA   .mini_map+1
            LDA   MINI_MAP_ADR_HI,X
            STA   .mini_map+2

            TXA
            ASL
            ASL   ; v*4
            TAX
            LDA   MAP_LO,X
            STA   MAP_00_LO
            LDA   MAP_LO+1,X
            STA   MAP_01_LO
            LDA   MAP_LO+2,X
            STA   MAP_02_LO
            LDA   MAP_LO+3,X
            STA   MAP_03_LO
            LDA   MAP_HI,X
            STA   MAP_00_HI
            LDA   MAP_HI+1,X
            STA   MAP_01_HI
            LDA   MAP_HI+2,X
            STA   MAP_02_HI
            LDA   MAP_HI+3,X
            STA   MAP_03_HI
      
            LDY   #127
            LDX   #31

.hloop            STX   REGY
.mini_map           LDA   $ABCD,X
              TAX

              LDA   MAP03,X
              STA   (MAP_00),Y
              LDA   MAP13,X
              STA   (MAP_01),Y
              LDA   MAP23,X
              STA   (MAP_02),Y
              LDA   MAP33,X
              STA   (MAP_03),Y
              DEY

              LDA   MAP02,X
              STA   (MAP_00),Y
              LDA   MAP12,X
              STA   (MAP_01),Y
              LDA   MAP22,X
              STA   (MAP_02),Y
              LDA   MAP32,X
              STA   (MAP_03),Y
              DEY

              LDA   MAP01,X
              STA   (MAP_00),Y
              LDA   MAP11,X
              STA   (MAP_01),Y
              LDA   MAP21,X
              STA   (MAP_02),Y
              LDA   MAP31,X
              STA   (MAP_03),Y
              DEY

              LDA   MAP00,X
              STA   (MAP_00),Y
              LDA   MAP10,X
              STA   (MAP_01),Y
              LDA   MAP20,X
              STA   (MAP_02),Y
              LDA   MAP30,X
              STA   (MAP_03),Y
              DEY

              LDX   REGY
              DEX
              BPL   .hloop
      
            LDX   REGX
            DEX
            BMI   .exit
            JMP   .vloop

.exit:        RTS

;for v eq 0 to 31 ; down
; get maplo[v]
; get maphi[v]
; for h eq 0 to 31 ; across
;  i = minimap[v,h]
;  lda map00[i]
;  sta map[(v*4),(h*4)]
;  lda map01[i]
;  sta map[(v*4),(h*4)+1]
;  lda map02[i]
;  sta map[(v*4),(h*4)+2]
;  lda map03[i]
;  sta map[(v*4),(h*4)+3]
;
;  lda map10[i]
;  sta map[(v*4)+1,(h*4)]
;  lda map11[i]
;  sta map[(v*4)+1,(h*4)+1]
;  lda map12[i]
;  sta map[(v*4)+1,(h*4)+2]
;  lda map13[i]
;  sta map[(v*4)+1,(h*4)+3]
;
;  lda map20[i]
;  sta map[(v*4)+2,(h*4)]
;  lda map21[i]
;  sta map[(v*4)+2,(h*4)+1]
;  lda map22[i]
;  sta map[(v*4)+2,(h*4)+2]
;  lda map23[i]
;  sta map[(v*4)+2,(h*4)+3]
;
;  lda map30[i]
;  sta map[(v*4)+3,(h*4)]
;  lda map31[i]
;  sta map[(v*4)+3,(h*4)+1]
;  lda map32[i]
;  sta map[(v*4)+3,(h*4)+2]
;  lda map33[i]
;  sta map[(v*4)+3,(h*4)+3]
; next
;next


; .macro SUB16IMM
; sec
; lda my16bit_lsb
; sbc #96
; sta my16bit_lsb
;   bcc .exit             
;        dec my16bit_msb
; .exit
; .endm

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
    !BYTE >(MAP_ADR+(MAP_LEN*120)),>(MAP_ADR+(MAP_LEN*121)),>(MAP_ADR+(MAP_LEN*122)),>(MAP_ADR+(MAP_LEN*123)),>(MAP_ADR+(MAP_LEN*124)),>(MAP_ADR+(MAP_LEN*125)),>(MAP_ADR+(MAP_LEN*126)),>(MAP_ADR+(MAP_LEN*127)),>(MAP_ADR+(MAP_LEN*128)),>(MAP_ADR+(MAP_LEN*129))

MAP_LO  !BYTE <(MAP_ADR+(MAP_LEN*000)),<(MAP_ADR+(MAP_LEN*001)),<(MAP_ADR+(MAP_LEN*002)),<(MAP_ADR+(MAP_LEN*003)),<(MAP_ADR+(MAP_LEN*004)),<(MAP_ADR+(MAP_LEN*005)),<(MAP_ADR+(MAP_LEN*006)),<(MAP_ADR+(MAP_LEN*007)),<(MAP_ADR+(MAP_LEN*008)),<(MAP_ADR+(MAP_LEN*009))
    !BYTE <(MAP_ADR+(MAP_LEN*010)),<(MAP_ADR+(MAP_LEN*011)),<(MAP_ADR+(MAP_LEN*012)),<(MAP_ADR+(MAP_LEN*013)),<(MAP_ADR+(MAP_LEN*014)),<(MAP_ADR+(MAP_LEN*015)),<(MAP_ADR+(MAP_LEN*016)),<(MAP_ADR+(MAP_LEN*017)),<(MAP_ADR+(MAP_LEN*018)),<(MAP_ADR+(MAP_LEN*019))
    !BYTE <(MAP_ADR+(MAP_LEN*020)),<(MAP_ADR+(MAP_LEN*021)),<(MAP_ADR+(MAP_LEN*022)),<(MAP_ADR+(MAP_LEN*023)),<(MAP_ADR+(MAP_LEN*024)),<(MAP_ADR+(MAP_LEN*025)),<(MAP_ADR+(MAP_LEN*026)),<(MAP_ADR+(MAP_LEN*027)),<(MAP_ADR+(MAP_LEN*028)),<(MAP_ADR+(MAP_LEN*029))
    !BYTE <(MAP_ADR+(MAP_LEN*030)),<(MAP_ADR+(MAP_LEN*031)),<(MAP_ADR+(MAP_LEN*032)),<(MAP_ADR+(MAP_LEN*033)),<(MAP_ADR+(MAP_LEN*034)),<(MAP_ADR+(MAP_LEN*035)),<(MAP_ADR+(MAP_LEN*036)),<(MAP_ADR+(MAP_LEN*037)),<(MAP_ADR+(MAP_LEN*038)),<(MAP_ADR+(MAP_LEN*039))
    !BYTE <(MAP_ADR+(MAP_LEN*040)),<(MAP_ADR+(MAP_LEN*041)),<(MAP_ADR+(MAP_LEN*042)),<(MAP_ADR+(MAP_LEN*043)),<(MAP_ADR+(MAP_LEN*044)),<(MAP_ADR+(MAP_LEN*045)),<(MAP_ADR+(MAP_LEN*046)),<(MAP_ADR+(MAP_LEN*047)),<(MAP_ADR+(MAP_LEN*048)),<(MAP_ADR+(MAP_LEN*049))
    !BYTE <(MAP_ADR+(MAP_LEN*050)),<(MAP_ADR+(MAP_LEN*051)),<(MAP_ADR+(MAP_LEN*052)),<(MAP_ADR+(MAP_LEN*053)),<(MAP_ADR+(MAP_LEN*054)),<(MAP_ADR+(MAP_LEN*055)),<(MAP_ADR+(MAP_LEN*056)),<(MAP_ADR+(MAP_LEN*057)),<(MAP_ADR+(MAP_LEN*058)),<(MAP_ADR+(MAP_LEN*059))
    !BYTE <(MAP_ADR+(MAP_LEN*060)),<(MAP_ADR+(MAP_LEN*061)),<(MAP_ADR+(MAP_LEN*062)),<(MAP_ADR+(MAP_LEN*063)),<(MAP_ADR+(MAP_LEN*064)),<(MAP_ADR+(MAP_LEN*065)),<(MAP_ADR+(MAP_LEN*066)),<(MAP_ADR+(MAP_LEN*067)),<(MAP_ADR+(MAP_LEN*068)),<(MAP_ADR+(MAP_LEN*069))
    !BYTE <(MAP_ADR+(MAP_LEN*070)),<(MAP_ADR+(MAP_LEN*071)),<(MAP_ADR+(MAP_LEN*072)),<(MAP_ADR+(MAP_LEN*073)),<(MAP_ADR+(MAP_LEN*074)),<(MAP_ADR+(MAP_LEN*075)),<(MAP_ADR+(MAP_LEN*076)),<(MAP_ADR+(MAP_LEN*077)),<(MAP_ADR+(MAP_LEN*078)),<(MAP_ADR+(MAP_LEN*079))
    !BYTE <(MAP_ADR+(MAP_LEN*080)),<(MAP_ADR+(MAP_LEN*081)),<(MAP_ADR+(MAP_LEN*082)),<(MAP_ADR+(MAP_LEN*083)),<(MAP_ADR+(MAP_LEN*084)),<(MAP_ADR+(MAP_LEN*085)),<(MAP_ADR+(MAP_LEN*086)),<(MAP_ADR+(MAP_LEN*087)),<(MAP_ADR+(MAP_LEN*088)),<(MAP_ADR+(MAP_LEN*089))
    !BYTE <(MAP_ADR+(MAP_LEN*090)),<(MAP_ADR+(MAP_LEN*091)),<(MAP_ADR+(MAP_LEN*092)),<(MAP_ADR+(MAP_LEN*093)),<(MAP_ADR+(MAP_LEN*094)),<(MAP_ADR+(MAP_LEN*095)),<(MAP_ADR+(MAP_LEN*096)),<(MAP_ADR+(MAP_LEN*097)),<(MAP_ADR+(MAP_LEN*098)),<(MAP_ADR+(MAP_LEN*099))
    !BYTE <(MAP_ADR+(MAP_LEN*100)),<(MAP_ADR+(MAP_LEN*101)),<(MAP_ADR+(MAP_LEN*102)),<(MAP_ADR+(MAP_LEN*103)),<(MAP_ADR+(MAP_LEN*104)),<(MAP_ADR+(MAP_LEN*105)),<(MAP_ADR+(MAP_LEN*106)),<(MAP_ADR+(MAP_LEN*107)),<(MAP_ADR+(MAP_LEN*108)),<(MAP_ADR+(MAP_LEN*109))
    !BYTE <(MAP_ADR+(MAP_LEN*110)),<(MAP_ADR+(MAP_LEN*111)),<(MAP_ADR+(MAP_LEN*112)),<(MAP_ADR+(MAP_LEN*113)),<(MAP_ADR+(MAP_LEN*114)),<(MAP_ADR+(MAP_LEN*115)),<(MAP_ADR+(MAP_LEN*116)),<(MAP_ADR+(MAP_LEN*117)),<(MAP_ADR+(MAP_LEN*118)),<(MAP_ADR+(MAP_LEN*119))
    !BYTE <(MAP_ADR+(MAP_LEN*120)),<(MAP_ADR+(MAP_LEN*121)),<(MAP_ADR+(MAP_LEN*122)),<(MAP_ADR+(MAP_LEN*123)),<(MAP_ADR+(MAP_LEN*124)),<(MAP_ADR+(MAP_LEN*125)),<(MAP_ADR+(MAP_LEN*126)),<(MAP_ADR+(MAP_LEN*127)),<(MAP_ADR+(MAP_LEN*128)),<(MAP_ADR+(MAP_LEN*129))

MINI_MAP_LEN = 32

MINI_MAP_ADR_LO 
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*00))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*01))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*02))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*03))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*04))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*05))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*06))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*07))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*08))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*09))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*10))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*11))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*12))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*13))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*14))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*15))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*16))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*17))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*18))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*19))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*20))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*21))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*22))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*23))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*24))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*25))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*26))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*27))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*28))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*29))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*30))
 !BYTE <(MINI_MAP+(MINI_MAP_LEN*31))

MINI_MAP_ADR_HI 
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*00))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*01))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*02))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*03))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*04))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*05))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*06))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*07))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*08))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*09))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*10))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*11))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*12))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*13))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*14))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*15))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*16))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*17))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*18))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*19))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*20))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*21))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*22))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*23))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*24))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*25))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*26))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*27))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*28))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*29))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*30))
 !BYTE >(MINI_MAP+(MINI_MAP_LEN*31))

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
  
*= 19*1024
sprites
;48
!byte %11111111,%11111111,%11111111
!for I = 0 TO 18
!byte %01010101,%10101010,%01010101
!end
!byte %11111111,%11111111,%11111111
!byte 0
;49
!for I = 0 TO 20
!byte %10101010,%01010101,%10101010
!end
!byte 0
;50
!for I = 0 TO 20
!byte %01010101,%01010101,%01010101
!end
!byte 0
;51
!for I = 0 TO 20
!byte %11111111,%10101010,%01010101
!end
!byte 0
;52
!for I = 0 TO 20
!byte %01010101,%11111111,%10101010
!end
!byte 0
;53
!for I = 0 TO 20
!byte %10101010,%01010101,%11111111
!end
!byte 0
;54
!for I = 0 TO 20
!byte %11111111,%01010101,%11111111
!end
!byte 0
;55
!for I = 0 TO 20
!byte %11111111,%10101010,%11111111
!end
!byte 0
;56
!for I = 0 TO 20
!byte %01010101,%11111111,%10101010
!end
!byte 0
;57
!for I = 0 TO 20
!byte %11011101,%01110111,%11101110
!end
!byte 0
;58
!for I = 0 TO 20
!byte %10101010,%10101010,%11111111
!end
!byte 0
;59
!for I = 0 TO 20
!byte %11111111,%01010101,%01010101
!end
!byte 0
;60
!for I = 0 TO 20
!byte %10111110,%11111111,%10111110
!end
!byte 0

; .macro LDASTA16
; LDA \1
; STA \2
; LDA \1 +1
; STA \2 +1
; .endm

; .macro LDASTA16IMM
; LDA \#1
; STA \#2
; LDA \1 +1
; STA \2 +1
; .endm

; .macro LDXY16
; LDX \1
; LDY \1 +1
; .endm

; .macro LDXY16IMM
; LDX \#1
; LDY \#1 +1
; .endm

; .macro STXY16
; STX \1
; STY \1 +1
; .endm

; .macro SUB16IMM
; sec
; lda my16bit_lsb
; sbc #96
; sta my16bit_lsb
;   bcc .exit             
;        dec my16bit_msb
; .exit
; .endm

; .macro ADD16IMM
; clc
; lda my16bit_lsb
; adc #96
; sta my16bit_lsb
;   bcc .exit
;        inc my16bit_msb
; .exit
; .endm
  
;********************************************
;*  BEQ16                                   *
;*  16bit beq                               *
;*  \1  a       16-bit                      *
;*  \2  b       16 bit                      *
;*  \3  Destination a = b                   *
;*  destroys    a                           *
;********************************************
; .macro BEQ16
;        lda \1 + 1
;        cmp \2 + 1
;        bne .exit
;        lda \1
;        cmp \2
;        beq \3
; .exit
; .endm

;********************************************
;*  BNE16                                   *
;*  16bit beq                               *
;*  \1  a       16-bit                      *
;*  \2  b       16 bit                      *
;*  \3  Destination a != b                  *
;*  destroys    a                           *
;********************************************
; .macro BNE16
;        lda \1 + 1
;        cmp \2 + 1
;        bne \3
;        lda \1
;        cmp \2
;        bne \3
; .endm

;********************************************
;*  BLT16                                   *
;*  16bit bcc                               *
;*  \1  a       16-bit                      *
;*  \2  b       16 bit                      *
;*  \3  Destination a < b                   *
;*  destroys    a                           *
;********************************************
; .macro BLT16
;        lda \1 + 1
;        cmp \2 + 1
;        bcc \3
;        bne .exit
;        lda \1
;        cmp \2
;        bcc \3
; .exit
; .endm

;********************************************
;*  BLE16                                   *
;*  16bit branch less than or equal         *
;*  \1  a       16-bit                      *
;*  \2  b       16 bit                      *
;*  \3  Destination a <= b                  *
;*  destroys    a                           *
;********************************************
; .macro BLE16
;        lda \1 + 1
;        cmp \2 + 1
;        bcc \3
;        bne .exit
;        lda \1
;        cmp \2
;        bcc \3
;        beq \3
; .exit
; .endm 

COMPRESSED_MAP_LO !BYTE <COMPRESSED_MAP_01
COMPRESSED_MAP_HI !BYTE >COMPRESSED_MAP_01

;COMPRESSED_MAP_01:
 !byte (  0 *128) +  34
 !byte (  1 *128) +   6
 !byte (  0 *128) +  26
 !byte (  1 *128) +   1
 !byte (  0 *128) +   4
 !byte (  1 *128) +   5
 !byte (  0 *128) +  22
 !byte (  1 *128) +   1
 !byte (  0 *128) +   4
 !byte (  1 *128) +   1
 !byte (  0 *128) +   3
 !byte (  1 *128) +   9
 !byte (  0 *128) +  14
 !byte (  1 *128) +   1
 !byte (  0 *128) +  16
 !byte (  1 *128) +   1
 !byte (  0 *128) +  14
 !byte (  1 *128) +   1
 !byte (  0 *128) +   3
 !byte (  1 *128) +   2
 !byte (  0 *128) +   3
 !byte (  1 *128) +   1
 !byte (  0 *128) +   7
 !byte (  1 *128) +   8
 !byte (  0 *128) +   7
 !byte (  1 *128) +   1
 !byte (  0 *128) +   3
 !byte (  1 *128) +   1
 !byte (  0 *128) +   4
 !byte (  1 *128) +   7
 !byte (  0 *128) +   8
 !byte (  1 *128) +   4
 !byte (  0 *128) +   4
 !byte (  1 *128) +   1
 !byte (  0 *128) +   2
 !byte (  1 *128) +   2
 !byte (  0 *128) +   4
 !byte (  1 *128) +   1
 !byte (  0 *128) +   5
 !byte (  1 *128) +   8
 !byte (  0 *128) +   4
 !byte (  1 *128) +   1
 !byte (  0 *128) +   4
 !byte (  1 *128) +   1
 !byte (  0 *128) +   2
 !byte (  1 *128) +   1
 !byte (  0 *128) +  13
 !byte (  1 *128) +   1
 !byte (  0 *128) +   6
 !byte (  1 *128) +   4
 !byte (  0 *128) +   4
 !byte (  1 *128) +   1
 !byte (  0 *128) +   1
 !byte (  1 *128) +   1
 !byte (  0 *128) +   2
 !byte (  1 *128) +  13
 !byte (  0 *128) +   1
 !byte (  1 *128) +   6
 !byte (  0 *128) +   7
 !byte (  1 *128) +   1
 !byte (  0 *128) +   1
 !byte (  1 *128) +   1
 !byte (  0 *128) +   6
 !byte (  1 *128) +   1
 !byte (  0 *128) +   9
 !byte (  1 *128) +   1
 !byte (  0 *128) +  12
 !byte (  1 *128) +   1
 !byte (  0 *128) +   1
 !byte (  1 *128) +   4
 !byte (  0 *128) +   3
 !byte (  1 *128) +  11
 !byte (  0 *128) +  12
 !byte (  1 *128) +   1
 !byte (  0 *128) +   4
 !byte (  1 *128) +   5
 !byte (  0 *128) +  22
 !byte (  1 *128) +   6
 !byte (  0 *128) + 127
 !byte (  0 *128) +  27
 !byte (  1 *128) +   6
 !byte (  0 *128) +  26
 !byte (  1 *128) +   1
 !byte (  0 *128) +   4
 !byte (  1 *128) +   5
 !byte (  0 *128) +  22
 !byte (  1 *128) +   1
 !byte (  0 *128) +   4
 !byte (  1 *128) +   1
 !byte (  0 *128) +   3
 !byte (  1 *128) +   9
 !byte (  0 *128) +  14
 !byte (  1 *128) +   1
 !byte (  0 *128) +  16
 !byte (  1 *128) +   8
 !byte (  0 *128) +   7
 !byte (  1 *128) +   1
 !byte (  0 *128) +   3
 !byte (  1 *128) +   2
 !byte (  0 *128) +   3
 !byte (  1 *128) +   1
 !byte (  0 *128) +  14
 !byte (  1 *128) +   1
 !byte (  0 *128) +   7
 !byte (  1 *128) +   1
 !byte (  0 *128) +   3
 !byte (  1 *128) +   1
 !byte (  0 *128) +   4
 !byte (  1 *128) +   7
 !byte (  0 *128) +   8
 !byte (  1 *128) +   4
 !byte (  0 *128) +   4
 !byte (  1 *128) +   1
 !byte (  0 *128) +   2
 !byte (  1 *128) +   2
 !byte (  0 *128) +   4
 !byte (  1 *128) +   1
 !byte (  0 *128) +   5
 !byte (  1 *128) +   4
 !byte (  0 *128) +   8
 !byte (  1 *128) +   1
 !byte (  0 *128) +   4
 !byte (  1 *128) +   1
 !byte (  0 *128) +   2
 !byte (  1 *128) +   1
 !byte (  0 *128) +  13
 !byte (  1 *128) +   1
 !byte (  0 *128) +   6
 !byte (  1 *128) +   4
 !byte (  0 *128) +   4
 !byte (  1 *128) +   1
 !byte (  0 *128) +   1
 !byte (  1 *128) +   1
 !byte (  0 *128) +   2
 !byte (  1 *128) +  13
 !byte (  0 *128) +   1
 !byte (  1 *128) +   6
 !byte (  0 *128) +   7
 !byte (  1 *128) +   1
 !byte (  0 *128) +   1
 !byte (  1 *128) +   1
 !byte (  0 *128) +   6
 !byte (  1 *128) +   1
 !byte (  0 *128) +   9
 !byte (  1 *128) +   1
 !byte (  0 *128) +  12
 !byte (  1 *128) +   1
 !byte (  0 *128) +   1
 !byte (  1 *128) +   4
 !byte (  0 *128) +   3
 !byte (  1 *128) +  11
 !byte (  0 *128) +  12
 !byte (  1 *128) +   1
 !byte (  0 *128) +   4
 !byte (  1 *128) +   5
 !byte (  0 *128) +  22
 !byte (  1 *128) +   6
 !byte (  0 *128) +  55
 !byte 0

COMPRESSED_MAP_01:
 !byte (  1 *128) +  33
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte (  1 *128) +   2
 !byte (  0 *128) +  30
 !byte 0

;for v eq 0 to 31 ; down
; get maplo[v]
; get maphi[v]
; for h eq 0 to 31 ; across
;  i = minimap[v,h]
;  lda map00[i]
;  sta map[(v*4),(h*4)]
;  lda map01[i]
;  sta map[(v*4),(h*4)+1]
;  lda map02[i]
;  sta map[(v*4),(h*4)+2]
;  lda map03[i]
;  sta map[(v*4),(h*4)+3]
;
;  lda map10[i]
;  sta map[(v*4)+1,(h*4)]
;  lda map11[i]
;  sta map[(v*4)+1,(h*4)+1]
;  lda map12[i]
;  sta map[(v*4)+1,(h*4)+2]
;  lda map13[i]
;  sta map[(v*4)+1,(h*4)+3]
;
;  lda map20[i]
;  sta map[(v*4)+2,(h*4)]
;  lda map21[i]
;  sta map[(v*4)+2,(h*4)+1]
;  lda map22[i]
;  sta map[(v*4)+2,(h*4)+2]
;  lda map23[i]
;  sta map[(v*4)+2,(h*4)+3]
;
;  lda map30[i]
;  sta map[(v*4)+3,(h*4)]
;  lda map31[i]
;  sta map[(v*4)+3,(h*4)+1]
;  lda map32[i]
;  sta map[(v*4)+3,(h*4)+2]
;  lda map33[i]
;  sta map[(v*4)+3,(h*4)+3]
; next
;next

MAP00: !byte  0,1
MAP01: !byte  0,1
MAP02: !byte  0,1
MAP03: !byte  0,1
MAP10: !byte  0,1
MAP11: !byte  0,1
MAP12: !byte  0,1
MAP13: !byte  0,1
MAP20: !byte  0,1
MAP21: !byte  0,1
MAP22: !byte  0,1
MAP23: !byte  0,1
MAP30: !byte  0,1
MAP31: !byte  0,1
MAP32: !byte  0,1
MAP33: !byte  0,1

CHARS
!byte $fc,$cc,$cc,$cc,$cc,$cc,$fc,$00
!byte $30,$f0,$30,$30,$30,$30,$fc,$00
!byte $fc,$0c,$0c,$fc,$c0,$c0,$fc,$00
!byte $fc,$0c,$0c,$fc,$0c,$0c,$fc,$00
!byte $cc,$cc,$cc,$fc,$0c,$0c,$0c,$00
!byte $fc,$c0,$c0,$fc,$0c,$0c,$fc,$00
!byte $fc,$c0,$c0,$fc,$cc,$cc,$fc,$00
!byte $fc,$0c,$0c,$0c,$0c,$0c,$0c,$00
!byte $fc,$cc,$cc,$fc,$cc,$cc,$fc,$00

