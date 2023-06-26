﻿*= 2049
!byte $0c,$08,$0a,$00,$9e   ; Line 10 SYS
!tx "2070"            ; Address for sys start in text

SPRITES =2
REGA = 3
REGX = 4
REGY = 5
SPRITES_LEFT =7
SPRITE_NEXT_POS = 8
TEMPY = 9 ;7?

Multiplex_counterx1 = 10
Multiplex_counterx2 = 11

Multiplex_countery1 = 12
Multiplex_countery2 = 13

Multiplex_xdif  = 14
Multiplex_ydif  = 15

Multiplex_xspeed  = 16
Multiplex_yspeed  = 17

Multiplex_xoffset = 18
Multiplex_yoffset = 19


SORTED =31 ;63 to 94
SPRITE_YPOS =63 ;31 to 62
SPRITE_RASTER = 95 ;95 to 127
SPRITE_XPOS =127 ;127 to 158
SPRITE_COL =159 ;159 to 190
SPRITE_PTR =191 ;191 to 222
SPRITE_XMSB =223 ;223 to 254

STACK = 255

BDR = $D020

SPRENBL = 53248+21
SPRXPX = 53248+29 
SPRXPY = 53248+23

S0X = 53248+0
S0Y = 53248+1
S0C = $D027
S0P = 2040

S1X = 53248+2
S1Y = 53248+3
S1C = $D028
S1P = 2041

S2X = 53248+4
S2Y = 53248+5
S2C = $D029
S2P = 2042

S3X = 53248+6
S3Y = 53248+7
S3C = $D02A
S3P = 2043

S4X = 53248+8
S4Y = 53248+9
S4C = $D02B
S4P = 2044

S5X = 53248+10
S5Y = 53248+11
S5C = $D02C
S5P = 2045

S6X = 53248+12
S6Y = 53248+13
S6C = $D02D
S6P = 2046

S7X = 53248+14
S7Y = 53248+15
S7C = $D02E
S7P = 2047

SPRXMSB = 53248+16

MP_RASTER_POS = 255

*= 2070

  SEI        ; disable maskable IRQs
  LDX   #$FF   ; reset stack
  TXS
 
  LDA   #$7F
  STA   $DC0D  ; disable timer interrupts which can be generated by the two CIA chips
  STA   $DD0D  ; the kernal uses such an interrupt to flash the cursor and scan the keyboard, so we better stop it.

  LDA   $DC0D  ; by reading this two registers we negate any pending CIA irqs.
  LDA   $DD0D  ; if we don't do this, a pending CIA irq might occur after we finish setting up our irq. we don't want that to happen.

  LDA   #$01   ; this is how to tell the VICII to generate a raster interrupt
  STA   $D01A

  LDA   #$1B   ; as there are more than 256 rasterlines, the topmost bit of $d011 serves as
  STA   $D011  ; the 9th bit for the rasterline we want our irq to be triggered. here we simply set up a character screen, leaving the topmost bit 0.

  LDA   #$35   ; we turn off the BASIC and KERNAL rom here
  STA   $01    ; the cpu now sees RAM everywhere except at $d000-$e000, where still the registers of SID/VICII/etc are visible

  LDA   #<MP_IRQ  ; this is how we set up
  STA   $FFFE     ; the address of our interrupt code
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

  JSR SETUP_MOVE
  JSR SETUP_DATA
  JSR SETUP_SCN
 
  CLI ; enable maskable interrupts again

MLOOP:  JMP   MLOOP ; we better don't RTS, the ROMS are now switched off, there's no way back to the system

!ZONE SPRITE_USED
!MACRO SPRITE_USED R1 {
                    LDY   SPRITE_YPOS+R1   ; Y= SPRITE YPOS

.SPRITE_USED_LOOP:    LDA   SPRITE_YUSED,Y    ; USED POS
                      BMI   .SPRITE_Y_UNUSED  ; TOP BIT SET SO UNUSED
                        INY
                        BNE   .SPRITE_USED_LOOP ; next position - replaces JMP IDENTIFY_LOOP_2

.SPRITE_Y_UNUSED: LDA   #R1             ; NO - MOVE SPRITE VALUE TO A
                  STA   SPRITE_YUSED,Y  ; STORE SPRITE VALUE IN YUSED
}

!ZONE SORT_USED_SPRITES
!MACRO SORT_USED_SPRITES POS {
    LDA   SPRITE_YUSED+POS   ; IS SPRITE AT THIS POSITION USED
    BMI   .SPRITE_POS_UNUSED                  ; TOP BIT SET SO NO
        STA   SORTED,Y            ; YES - STORE IN SORTED LIST
        STX   SPRITE_YUSED+POS  ; CLEAR USED
        INY                     ; INC SORTED COUNT
.SPRITE_POS_UNUSED
}

!MACRO RASTERSET R1 {
    LDY   SORTED+R1     ; get sprite
    LDA   SPRITE_YPOS,Y
    ADC   #21 ;23 ; #22 ; #23 ; #22 ; +1 as SEC is set
    STA   SPRITE_RASTER+R1 ; store at sprite raster pos
}

!ALIGN 255,0
  
SP01:   LDA   SPRITE_XPOS,X
        STA   S0X
        LDA   SPRITE_COL,X
        STA   S0C
        LDA   SPRITE_PTR,X
        STA   S0P
        LDA   SPRITE_YPOS,X
        STA   S0Y
        LDA   SPRITE_XMSB,X
        BEQ   SP01MSB
          LDA   #$01
          JMP   SRR_JMP_MSB
SP01MSB LDA   #$FF-$01
        JMP   SRR_JMP_LSB

SP11:   LDA   SPRITE_XPOS,X
        STA   S1X
        LDA   SPRITE_COL,X
        STA   S1C
        LDA   SPRITE_PTR,X
        STA   S1P
        LDA   SPRITE_YPOS,X
        STA   S1Y
        LDA   SPRITE_XMSB,X
        BEQ   SP11MSB
          LDA   #$02
          JMP   SRR_JMP_MSB
SP11MSB LDA   #$FF-$02
        JMP   SRR_JMP_LSB

SP21:   LDA   SPRITE_XPOS,X
        STA   S2X
        LDA   SPRITE_COL,X
        STA   S2C
        LDA   SPRITE_PTR,X
        STA   S2P
        LDA   SPRITE_YPOS,X
        STA   S2Y
        LDA   SPRITE_XMSB,X
        BEQ   SP21MSB
          LDA   #$04
          JMP   SRR_JMP_MSB
SP21MSB LDA   #$FF-$04
        JMP   SRR_JMP_LSB

SP31:   LDA   SPRITE_XPOS,X
        STA   S3X
        LDA   SPRITE_COL,X
        STA   S3C
        LDA   SPRITE_PTR,X
        STA   S3P
        LDA   SPRITE_YPOS,X
        STA   S3Y
        LDA   SPRITE_XMSB,X
        BEQ   SP31MSB
          LDA   #$08
          JMP   SRR_JMP_MSB
SP31MSB LDA   #$FF-$08
        JMP   SRR_JMP_LSB

SP41:   LDA   SPRITE_XPOS,X
        STA   S4X
        LDA   SPRITE_COL,X
        STA   S4C
        LDA   SPRITE_PTR,X
        STA   S4P
        LDA   SPRITE_YPOS,X
        STA   S4Y
        LDA   SPRITE_XMSB,X
        BEQ   SP41MSB
          LDA   #$10
          JMP   SRR_JMP_MSB
SP41MSB LDA   #$FF-$10
        JMP   SRR_JMP_LSB

SP51:   LDA   SPRITE_XPOS,X
        STA   S5X
        LDA   SPRITE_COL,X
        STA   S5C
        LDA   SPRITE_PTR,X
        STA   S5P
        LDA   SPRITE_YPOS,X
        STA   S5Y
        LDA   SPRITE_XMSB,X
        BEQ   SP51MSB
          LDA   #$20
          JMP   SRR_JMP_MSB
SP51MSB LDA   #$FF-$20
        JMP   SRR_JMP_LSB

SP61:   LDA   SPRITE_XPOS,X
        STA   S6X
        LDA   SPRITE_COL,X
        STA   S6C
        LDA   SPRITE_PTR,X
        STA   S6P
        LDA   SPRITE_YPOS,X
        STA   S6Y
        LDA   SPRITE_XMSB,X
        BEQ   SP61MSB
          LDA   #$40
          JMP   SRR_JMP_MSB
SP61MSB LDA   #$FF-$40
        JMP   SRR_JMP_LSB
   
SP71:   LDA   SPRITE_XPOS,X
        STA   S7X
        LDA   SPRITE_COL,X
        STA   S7C
        LDA   SPRITE_PTR,X
        STA   S7P
        LDA   SPRITE_YPOS,X
        STA   S7Y
        LDA   SPRITE_XMSB,X
        BEQ   SP71MSB
          LDA   #$80
          JMP   SRR_JMP_MSB
SP71MSB LDA   #$FF-$80
        JMP   SRR_JMP_LSB   

SETUP_SPR:  LDA   #0 ; left as none
            STA   S0Y
            STA   S1Y
            STA   S2Y
            STA   S3Y
            STA   S4Y
            STA   S5Y
            STA   S6Y
            STA   S7Y

            TSX
            STX   STACK
  
            LDX   SPRITES ; number of sprites to draw

            LDA   SPRTABLO2,X
            STA   SPR_JMP_2+1
            LDA   #0 ; clear msb
SPR_JMP_2:  JMP   SP74 ; draw first sprites
  
!ALIGN 255,0
SP04:   TXS                 ; STX   TEMPY
        LDY   SORTED,X
        LDX   SPRITE_XPOS,Y
        STX   S0X
        LDX   SPRITE_YPOS,Y
        STX   S0Y
        LDX   SPRITE_COL,Y
        STX   S0C
        LDX   SPRITE_PTR,Y
        STX   S0P
        LDX   SPRITE_XMSB,Y
        BEQ   SP04MSB
            ORA   #$01
SP04MSB TSX                 ; LDX   TEMPY
        DEx

SP14:   TXS
        LDy   SORTED,x
        LDx   SPRITE_XPOS,y
        STx   S1X
        LDx   SPRITE_YPOS,y
        STx   S1Y
        LDx   SPRITE_COL,y
        STx   S1C
        LDx   SPRITE_PTR,y
        STx   S1P
        LDx   SPRITE_XMSB,y
        BEQ   SP14MSB
            ORA   #$02
SP14MSB TSX
        DEx

SP24:   TXS
        LDy   SORTED,x
        LDx   SPRITE_XPOS,y
        STx   S2X
        LDx   SPRITE_YPOS,y
        STx   S2Y
        LDx   SPRITE_COL,y
        STx   S2C
        LDx   SPRITE_PTR,y
        STx   S2P
        LDx   SPRITE_XMSB,y
        BEQ   SP24MSB
            ORA   #$04
SP24MSB TSX
        DEx

SP34:   TXS
        LDy   SORTED,x
        LDx   SPRITE_XPOS,y
        STx   S3X
        LDx   SPRITE_YPOS,y
        STx   S3Y
        LDx   SPRITE_COL,y
        STx   S3C
        LDx   SPRITE_PTR,y
        STx   S3P
        LDx   SPRITE_XMSB,y
        BEQ   SP34MSB
            ORA   #$08
SP34MSB TSX
        DEx
        
SP44:   TXS
        LDy   SORTED,x
        LDx   SPRITE_XPOS,y
        STx   S4X
        LDx   SPRITE_YPOS,y
        STx   S4Y
        LDx   SPRITE_COL,y
        STx   S4C
        LDx   SPRITE_PTR,y
        STx   S4P
        LDx   SPRITE_XMSB,y
        BEQ   SP44MSB
            ORA   #$10
SP44MSB TSX
        DEx
        
SP54:   TXS ; STx   TEMPY
        LDy   SORTED,x
        LDx   SPRITE_XPOS,y
        STx   S5X
        LDx   SPRITE_YPOS,y
        STx   S5Y
        LDx   SPRITE_COL,y
        STx   S5C
        LDx   SPRITE_PTR,y
        STx   S5P
        LDx   SPRITE_XMSB,y
        BEQ   SP54MSB
            ORA  #$20
SP54MSB TSX
        DEx

SP64:   TXS
        LDy   SORTED,x
        LDx   SPRITE_XPOS,y
        STx   S6X
        LDx   SPRITE_YPOS,y
        STx   S6Y
        LDx   SPRITE_COL,y
        STx   S6C
        LDx   SPRITE_PTR,y
        STx   S6P
        LDx   SPRITE_XMSB,y
        BEQ   SP64MSB
            ORA   #$40
SP64MSB TSX
        DEx

SP74:   TXS
        LDy   SORTED,x
        LDx   SPRITE_XPOS,y
        STx   S7X
        LDx   SPRITE_YPOS,y
        STx   S7Y
        LDx   SPRITE_COL,y
        STx   S7C
        LDx   SPRITE_PTR,y
        STx   S7P
        LDx   SPRITE_XMSB,y
        BEQ   SP74MSB
            ORA   #$80
SP74MSB STA   SPRXMSB ; set msb
 
                TSX
                DEx
                BPL   SETUP_SPR_CONT ; more sprites to draw
  
                LDX   STACK
                TXS
                RTS  ; no

SETUP_SPR_CONT  STx   SPRITES_LEFT ; store sprites left
 
                LDX   STACK
                TXS

                LDA   #0
                STA   SPRITE_NEXT_POS ; set next as 0
  
                LDA   #<SP_IRQ ; raster interrupt setup
                STA   $FFFE
                LDA   #>SP_IRQ
                STA   $FFFF
  
                CLC   ; was SEC ?

  +RASTERSET 31
  +RASTERSET 30
  +RASTERSET 29
  +RASTERSET 28
  +RASTERSET 27
  +RASTERSET 26
  +RASTERSET 25
  +RASTERSET 24
  +RASTERSET 23
  +RASTERSET 22
  +RASTERSET 21

  +RASTERSET 20
  +RASTERSET 19
  +RASTERSET 18
  +RASTERSET 17
  +RASTERSET 16
  +RASTERSET 15
  +RASTERSET 14
  +RASTERSET 13
  +RASTERSET 12
  +RASTERSET 11
  
  +RASTERSET 10
  +RASTERSET 09
  +RASTERSET 08

 +RASTERSET 07
; +RASTERSET 06
; +RASTERSET 05
; +RASTERSET 04
; +RASTERSET 03
; +RASTERSET 02
; +RASTERSET 01
; +RASTERSET 00
  
      LDX   SPRITES         ; get first sprite
      LDA   SPRITE_RASTER,X ; get first sprite raster pos
      STA   $D012           ; next raster
RTS

SP_IRQ:             INC   $D019  ; VIC Interrupt Request Register (IRR)
                    STA   REGA
                    STX   REGX
                    STY   REGY

SPRITES_LEFT_LOOP:  INC BDR  ; border

                    LDY   SPRITE_NEXT_POS ; get next sprite
                    LDA   SPRTABLO,Y
                    STA   SPR_JMP+1
                    INY
                    STY   SPRITE_NEXT_POS ; inc next sprite

                    LDY   SPRITES_LEFT
                    LDX   SORTED,Y ; get next sprite to draw
SPR_JMP:            JMP   SP01 ; draw sprite
 
SRR_JMP_MSB:
 ORA SPRXMSB
 STA SPRXMSB
 DEY
 BPL SETUP_SPR_NEXT ; setup next sprite to draw

  DEC BDR ; border

  LDA #<MP_IRQ ; mp irq address
  STA $FFFE
  LDA #>MP_IRQ
  STA $FFFF
  LDA #MP_RASTER_POS  ; irq line
  STA $D012

  LDA REGA
  LDX REGX 
  LDY REGY
  RTI

SRR_JMP_LSB:
 AND SPRXMSB
 STA SPRXMSB
 DEY
 BPL SETUP_SPR_NEXT ; setup next sprite to draw

  DEC BDR  ; border

  LDA #<MP_IRQ  ; mp irq address
  STA $FFFE
  LDA #>MP_IRQ
  STA $FFFF
  LDA #MP_RASTER_POS   ;  irq line
  STA $D012

  LDA REGA
  LDX REGX 
  LDY REGY
  RTI

SETUP_SPR_NEXT: DEC   BDR  ; border

                STY   SPRITES_LEFT

                LAX   SPRITE_RASTER+8,Y ; get sprite 8 behind current 
                SEC
                SBC   #2    ; #2
                cmp   $D012
                BCC   SPRITES_LEFT_LOOP

                STX $D012 ; next raster
 
                LDA REGA
                LDX REGX 
                LDY REGY
                RTI

SU_NONE         RTS

MULTIPLEXOR:  INC   BDR    ; border

              LDX   SPRITES ; NUMBERS OF SPRITES-1
              BMI   SU_NONE  ; NONE TO DRAW

              LDA   SPRUSEDTABLO,X
              STA   SPR_JMP_3+1
              LDA   SPRUSEDTABHI,X
              STA   SPR_JMP_3+2
SPR_JMP_3:    JMP   SU31 ; draw first sprites
  
SU31: SPRITE_USED 31
SU30: SPRITE_USED 30
SU29: SPRITE_USED 29
SU28: SPRITE_USED 28
SU27: SPRITE_USED 27
SU26: SPRITE_USED 26
SU25: SPRITE_USED 25
SU24: SPRITE_USED 24
SU23: SPRITE_USED 23
SU22: SPRITE_USED 22
SU21: SPRITE_USED 21
SU20: SPRITE_USED 20
SU19: SPRITE_USED 19
SU18: SPRITE_USED 18
SU17: SPRITE_USED 17
SU16: SPRITE_USED 16
SU15: SPRITE_USED 15
SU14: SPRITE_USED 14
SU13: SPRITE_USED 13
SU12: SPRITE_USED 12
SU11: SPRITE_USED 11
SU10: SPRITE_USED 10
SU09: SPRITE_USED 9
SU08: SPRITE_USED 8
SU07: SPRITE_USED 7
SU06: SPRITE_USED 6
SU05: SPRITE_USED 5
SU04: SPRITE_USED 4
SU03: SPRITE_USED 3
SU02: SPRITE_USED 2
SU01: SPRITE_USED 1
SU00: SPRITE_USED 0
    
 INC BDR    ; border

SORT_USED:  LDY   #0    ; RESET USED COUNT
            LDX   #255 ; SLOTS TO CHECK 244 to 28

; +SORT_USED_SPRITES 255
; +SORT_USED_SPRITES 254
; +SORT_USED_SPRITES 253
; +SORT_USED_SPRITES 252
; +SORT_USED_SPRITES 251
; +SORT_USED_SPRITES 250
; +SORT_USED_SPRITES 249
; +SORT_USED_SPRITES 248
; +SORT_USED_SPRITES 247
; +SORT_USED_SPRITES 246 
; +SORT_USED_SPRITES 245
  
  +SORT_USED_SPRITES 244
  +SORT_USED_SPRITES 243
  +SORT_USED_SPRITES 242
  +SORT_USED_SPRITES 241
  +SORT_USED_SPRITES 240
  
  +SORT_USED_SPRITES 239
  +SORT_USED_SPRITES 238
  +SORT_USED_SPRITES 237
  +SORT_USED_SPRITES 236
  +SORT_USED_SPRITES 235
  +SORT_USED_SPRITES 234
  +SORT_USED_SPRITES 233
  +SORT_USED_SPRITES 232
  +SORT_USED_SPRITES 231
  +SORT_USED_SPRITES 230
  
  +SORT_USED_SPRITES 229
  +SORT_USED_SPRITES 228
  +SORT_USED_SPRITES 227
  +SORT_USED_SPRITES 226
  +SORT_USED_SPRITES 225
  +SORT_USED_SPRITES 224
  +SORT_USED_SPRITES 223
  +SORT_USED_SPRITES 222
  +SORT_USED_SPRITES 221
  +SORT_USED_SPRITES 220

  +SORT_USED_SPRITES 219
  +SORT_USED_SPRITES 218
  +SORT_USED_SPRITES 217
  +SORT_USED_SPRITES 216
  +SORT_USED_SPRITES 215
  +SORT_USED_SPRITES 214
  +SORT_USED_SPRITES 213
  +SORT_USED_SPRITES 212
  +SORT_USED_SPRITES 211
  +SORT_USED_SPRITES 210

  +SORT_USED_SPRITES 209
  +SORT_USED_SPRITES 208
  +SORT_USED_SPRITES 207
  +SORT_USED_SPRITES 206
  +SORT_USED_SPRITES 205
  +SORT_USED_SPRITES 204
  +SORT_USED_SPRITES 203
  +SORT_USED_SPRITES 202
  +SORT_USED_SPRITES 201
  +SORT_USED_SPRITES 200

  +SORT_USED_SPRITES 199
  +SORT_USED_SPRITES 198
  +SORT_USED_SPRITES 197
  +SORT_USED_SPRITES 196
  +SORT_USED_SPRITES 195
  +SORT_USED_SPRITES 194
  +SORT_USED_SPRITES 193
  +SORT_USED_SPRITES 192
  +SORT_USED_SPRITES 191
  +SORT_USED_SPRITES 190

  +SORT_USED_SPRITES 189
  +SORT_USED_SPRITES 188
  +SORT_USED_SPRITES 187
  +SORT_USED_SPRITES 186
  +SORT_USED_SPRITES 185
  +SORT_USED_SPRITES 184
  +SORT_USED_SPRITES 183
  +SORT_USED_SPRITES 182
  +SORT_USED_SPRITES 181
  +SORT_USED_SPRITES 180
  
  +SORT_USED_SPRITES 179
  +SORT_USED_SPRITES 178
  +SORT_USED_SPRITES 177
  +SORT_USED_SPRITES 176
  +SORT_USED_SPRITES 175
  +SORT_USED_SPRITES 174
  +SORT_USED_SPRITES 173
  +SORT_USED_SPRITES 172
  +SORT_USED_SPRITES 171
  +SORT_USED_SPRITES 170

  +SORT_USED_SPRITES 169
  +SORT_USED_SPRITES 168
  +SORT_USED_SPRITES 167
  +SORT_USED_SPRITES 166
  +SORT_USED_SPRITES 165
  +SORT_USED_SPRITES 164
  +SORT_USED_SPRITES 163
  +SORT_USED_SPRITES 162
  +SORT_USED_SPRITES 161
  +SORT_USED_SPRITES 160

  +SORT_USED_SPRITES 159
  +SORT_USED_SPRITES 158
  +SORT_USED_SPRITES 157
  +SORT_USED_SPRITES 156
  +SORT_USED_SPRITES 155
  +SORT_USED_SPRITES 154
  +SORT_USED_SPRITES 153
  +SORT_USED_SPRITES 152
  +SORT_USED_SPRITES 151
  +SORT_USED_SPRITES 150

  +SORT_USED_SPRITES 149
  +SORT_USED_SPRITES 148
  +SORT_USED_SPRITES 147
  +SORT_USED_SPRITES 146
  +SORT_USED_SPRITES 145
  +SORT_USED_SPRITES 144
  +SORT_USED_SPRITES 143
  +SORT_USED_SPRITES 142
  +SORT_USED_SPRITES 141
  +SORT_USED_SPRITES 140

  +SORT_USED_SPRITES 139
  +SORT_USED_SPRITES 138
  +SORT_USED_SPRITES 137
  +SORT_USED_SPRITES 136
  +SORT_USED_SPRITES 135
  +SORT_USED_SPRITES 134
  +SORT_USED_SPRITES 133
  +SORT_USED_SPRITES 132
  +SORT_USED_SPRITES 131
  +SORT_USED_SPRITES 130

  +SORT_USED_SPRITES 129
  +SORT_USED_SPRITES 128
  +SORT_USED_SPRITES 127
  +SORT_USED_SPRITES 126
  +SORT_USED_SPRITES 125
  +SORT_USED_SPRITES 124
  +SORT_USED_SPRITES 123
  +SORT_USED_SPRITES 122
  +SORT_USED_SPRITES 121
  +SORT_USED_SPRITES 120

  +SORT_USED_SPRITES 119
  +SORT_USED_SPRITES 118
  +SORT_USED_SPRITES 117
  +SORT_USED_SPRITES 116
  +SORT_USED_SPRITES 115
  +SORT_USED_SPRITES 114
  +SORT_USED_SPRITES 113
  +SORT_USED_SPRITES 112
  +SORT_USED_SPRITES 111
  +SORT_USED_SPRITES 110

  +SORT_USED_SPRITES 109
  +SORT_USED_SPRITES 108
  +SORT_USED_SPRITES 107
  +SORT_USED_SPRITES 106
  +SORT_USED_SPRITES 105
  +SORT_USED_SPRITES 104
  +SORT_USED_SPRITES 103
  +SORT_USED_SPRITES 102
  +SORT_USED_SPRITES 101
  +SORT_USED_SPRITES 100

  +SORT_USED_SPRITES 99
  +SORT_USED_SPRITES 98
  +SORT_USED_SPRITES 97
  +SORT_USED_SPRITES 96
  +SORT_USED_SPRITES 95
  +SORT_USED_SPRITES 94
  +SORT_USED_SPRITES 93
  +SORT_USED_SPRITES 92
  +SORT_USED_SPRITES 91
  +SORT_USED_SPRITES 90
 
  +SORT_USED_SPRITES 89
  +SORT_USED_SPRITES 88
  +SORT_USED_SPRITES 87
  +SORT_USED_SPRITES 86
  +SORT_USED_SPRITES 85
  +SORT_USED_SPRITES 84
  +SORT_USED_SPRITES 83
  +SORT_USED_SPRITES 82
  +SORT_USED_SPRITES 81
  +SORT_USED_SPRITES 80
 
  +SORT_USED_SPRITES 79
  +SORT_USED_SPRITES 78
  +SORT_USED_SPRITES 77
  +SORT_USED_SPRITES 76
  +SORT_USED_SPRITES 75
  +SORT_USED_SPRITES 74
  +SORT_USED_SPRITES 73
  +SORT_USED_SPRITES 72
  +SORT_USED_SPRITES 71
  +SORT_USED_SPRITES 70
 
  +SORT_USED_SPRITES 69
  +SORT_USED_SPRITES 68
  +SORT_USED_SPRITES 67
  +SORT_USED_SPRITES 66
  +SORT_USED_SPRITES 65
  +SORT_USED_SPRITES 64
  +SORT_USED_SPRITES 63
  +SORT_USED_SPRITES 62
  +SORT_USED_SPRITES 61
  +SORT_USED_SPRITES 60

  +SORT_USED_SPRITES 59
  +SORT_USED_SPRITES 58
  +SORT_USED_SPRITES 57
  +SORT_USED_SPRITES 56
  +SORT_USED_SPRITES 55
  +SORT_USED_SPRITES 54
  +SORT_USED_SPRITES 53
  +SORT_USED_SPRITES 52
  +SORT_USED_SPRITES 51
  +SORT_USED_SPRITES 50

  +SORT_USED_SPRITES 49
  +SORT_USED_SPRITES 48
  +SORT_USED_SPRITES 47
  +SORT_USED_SPRITES 46
  +SORT_USED_SPRITES 45
  +SORT_USED_SPRITES 44
  +SORT_USED_SPRITES 43
  +SORT_USED_SPRITES 42
  +SORT_USED_SPRITES 41
  +SORT_USED_SPRITES 40

  +SORT_USED_SPRITES 39
  +SORT_USED_SPRITES 38
  +SORT_USED_SPRITES 37
  +SORT_USED_SPRITES 36
  +SORT_USED_SPRITES 35
  +SORT_USED_SPRITES 34
  +SORT_USED_SPRITES 33
  +SORT_USED_SPRITES 32
  +SORT_USED_SPRITES 31
  +SORT_USED_SPRITES 30

  +SORT_USED_SPRITES 29
  +SORT_USED_SPRITES 28

; +SORT_USED_SPRITES 27
; +SORT_USED_SPRITES 26
; +SORT_USED_SPRITES 25
; +SORT_USED_SPRITES 24
; +SORT_USED_SPRITES 23
; +SORT_USED_SPRITES 22
; +SORT_USED_SPRITES 21
; +SORT_USED_SPRITES 20
; +SORT_USED_SPRITES 19
; +SORT_USED_SPRITES 19
; +SORT_USED_SPRITES 17
; +SORT_USED_SPRITES 16
; +SORT_USED_SPRITES 15
; +SORT_USED_SPRITES 14
; +SORT_USED_SPRITES 13
; +SORT_USED_SPRITES 12
; +SORT_USED_SPRITES 11
; +SORT_USED_SPRITES 10
; +SORT_USED_SPRITES 9
; +SORT_USED_SPRITES 8
; +SORT_USED_SPRITES 7
; +SORT_USED_SPRITES 6
; +SORT_USED_SPRITES 5
; +SORT_USED_SPRITES 4
; +SORT_USED_SPRITES 3
; +SORT_USED_SPRITES 2
; +SORT_USED_SPRITES 1
; +SORT_USED_SPRITES 0

  
  ;  +SORT_USED_SPRITES_2 27,V8_27  
  
 DEC   BDR    ; border

  JSR   SETUP_SPR
 DEC BDR    ; border
RTS
  
MP_IRQ:   INC   $D019    ;VIC Interrupt Request Register (IRR)
          STA   REGA
          STX   REGX 
          STY   REGY

          JSR   MULTIPLEXOR
 
          JSR   MOVE

          LDA   REGA
          LDX   REGX 
          LDY   REGY
NMI_NOP:  RTI ; This is the irq handler for the NMI. Just returns without acknowledge. This prevents subsequent NMI's from interfering.

SETUP_DATA:       LDX   #31; 31; //31 ; sprite-1
                  STX   SPRITES
 
SETUP_DATA_LOOP:    LDA SPR_YPOS,X
                    STA SPRITE_YPOS,X
                    LDA SPR_XPOS,X
                    STA SPRITE_XPOS,X
                    LDA SPR_COL,X
                    STA SPRITE_COL,X
                    LDA SPR_XMSB,X
                    STA SPRITE_XMSB,X
                    LDA SPR_PTR,X
                    STA   SPRITE_PTR,X
                    DEX 
                    BPL   SETUP_DATA_LOOP:
                  RTS

SETUP_SCN:

  LDA #255
  STA SPRENBL
  LDA #0
  STA SPRXPX
  STA SPRXPY
  LDA #255
  STA SPRENBL
 
RTS 

;!align 255, 0
;--------------------------------------
!zn {
MOVE  
  ldy SPRITES
;  dey
  bmi .exit

.1  lda Multiplex_counterx2
  clc
  adc Multiplex_xdif
  sta Multiplex_counterx2
  clc
  adc Multiplex_counterx1
  tax
  lda sinx,x
  sta SPRITE_XPOS,y
  lda sinxhi,x
  sta SPRITE_XMSB,y

  lda Multiplex_countery2
  clc
  adc Multiplex_ydif
  sta Multiplex_countery2
  clc
  adc Multiplex_countery1
  tax
  lda siny,x
  sta SPRITE_YPOS,y

  dey
  bpl .1

.exit
  lda Multiplex_xoffset
  sta Multiplex_counterx2
  lda Multiplex_yoffset
  sta Multiplex_countery2

  lda Multiplex_counterx1
  clc
  adc Multiplex_xspeed
  sta Multiplex_counterx1

  lda Multiplex_countery1
  clc
  adc Multiplex_yspeed
  sta Multiplex_countery1

  rts
}

SETUP_MOVE
  lda #$40
  sta Multiplex_xoffset

  lda #$00
  sta Multiplex_yoffset

  lda #$ff
  sta Multiplex_xspeed

  lda #$01
  sta Multiplex_yspeed

  lda #$0a
  sta Multiplex_xdif
  lda #$10
  sta Multiplex_ydif
RTS
  

SPRTABLO: !BYTE <SP01,<SP11,<SP21,<SP31,<SP41,<SP51,<SP61,<SP71,<SP01,<SP11,<SP21,<SP31,<SP41,<SP51,<SP61,<SP71,<SP01,<SP11,<SP21,<SP31,<SP41,<SP51,<SP61,<SP71,<SP01,<SP11,<SP21,<SP31,<SP41,<SP51,<SP61,<SP71
SPR_XPOS: !BYTE 11,55,99,143,187,231,275-255,319-255,22,66,110,154,198,242,286-255,330-255,33,77,121,165,209,253,297-255,341-255,44,88,132,176,220,264-255,308-255,352-255
SPR_XMSB: !BYTE 0, 0, 0, 0,  0,  0,  1,      1,      0, 0, 0,  0,  0,  0,  1,      1,      0, 0, 0,  0,  0,  0,  1,      1,      0, 0, 0,  0,  0,  1,      1,       1

;SPR_YPOS: !BYTE 32,50,55,60,65,70,75,80,90,95,100,105,110,115,120,130,135,140,145,150,155,160,170,175,180,185,190,195,200,205,215,225
SPR_YPOS: !BYTE 32,50,55,60,65,70,75,80,110,110,110,110,110,110,110,130,135,140,145,150,155,160,170,175,180,185,190,195,200,205,215,225
;SPR_XPOS: !BYTE 40,70,100,130,160,190,220,250,75,105,135,165,195,225,255,70,100,130,160,190,220,250,70,100,130,160,190,220,250,70,100,40
SPR_COL: !BYTE 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,1,2
SPR_PTR: !BYTE 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32

SPRTABLO2: !BYTE <SP74,<SP64,<SP54,<SP44,<SP34,<SP24,<SP14,<SP04
           !BYTE <SP04,<SP04,<SP04,<SP04,<SP04,<SP04,<SP04,<SP04
           !BYTE <SP04,<SP04,<SP04,<SP04,<SP04,<SP04,<SP04,<SP04
           !BYTE <SP04,<SP04,<SP04,<SP04,<SP04,<SP04,<SP04,<SP04
           
SPRUSEDTABLO  !BYTE <SU00,<SU01,<SU02,<SU03,<SU04,<SU05,<SU06,<SU07,<SU08,<SU09,<SU10,<SU11,<SU12,<SU13,<SU14,<SU15
              !BYTE <SU16,<SU17,<SU18,<SU19,<SU20,<SU21,<SU22,<SU23,<SU24,<SU25,<SU26,<SU27,<SU28,<SU29,<SU30,<SU31
SPRUSEDTABHI  !BYTE >SU00,>SU01,>SU02,>SU03,>SU04,>SU05,>SU06,>SU07,>SU08,>SU09,>SU10,>SU11,>SU12,>SU13,>SU14,>SU15
              !BYTE >SU16,>SU17,>SU18,>SU19,>SU20,>SU21,>SU22,>SU23,>SU24,>SU25,>SU26,>SU27,>SU28,>SU29,>SU30,>SU31

SPRITE_YUSED: !FILL 255,255

!align 255, 0
sinx
 !by $af,$b2,$b6,$b9,$bd,$c1,$c4,$c8,$cb,$cf,$d2,$d6,$d9,$dd,$e0,$e3
 !by $e7,$ea,$ed,$f1,$f4,$f7,$fa,$fd,$00,$03,$06,$09,$0b,$0e,$11,$13
 !by $16,$18,$1b,$1d,$1f,$21,$24,$26,$28,$2a,$2b,$2d,$2f,$30,$32,$33
 !by $35,$36,$37,$38,$39,$3a,$3b,$3c,$3c,$3d,$3d,$3e,$3e,$3e,$3e,$3e
 !by $3e,$3e,$3e,$3e,$3d,$3d,$3c,$3c,$3b,$3a,$39,$38,$37,$36,$35,$33
 !by $32,$30,$2f,$2d,$2b,$2a,$28,$26,$24,$21,$1f,$1d,$1b,$18,$16,$13
 !by $11,$0e,$0b,$09,$06,$03,$00,$fd,$fa,$f7,$f4,$f1,$ed,$ea,$e7,$e3
 !by $e0,$dd,$d9,$d6,$d2,$cf,$cb,$c8,$c4,$c1,$bd,$b9,$b6,$b2,$af,$ab
 !by $a7,$a4,$a0,$9d,$99,$95,$92,$8e,$8b,$87,$84,$80,$7d,$79,$76,$73
 !by $6f,$6c,$69,$65,$62,$5f,$5c,$59,$56,$53,$50,$4d,$4b,$48,$45,$43
 !by $40,$3e,$3b,$39,$37,$35,$32,$30,$2e,$2c,$2b,$29,$27,$26,$24,$23
 !by $21,$20,$1f,$1e,$1d,$1c,$1b,$1a,$1a,$19,$19,$18,$18,$18,$18,$18
 !by $18,$18,$18,$18,$19,$19,$1a,$1a,$1b,$1c,$1d,$1e,$1f,$20,$21,$23
 !by $24,$26,$27,$29,$2b,$2c,$2e,$30,$32,$35,$37,$39,$3b,$3e,$40,$43
 !by $45,$48,$4b,$4d,$50,$53,$56,$59,$5c,$5f,$62,$65,$69,$6c,$6f,$73
 !by $76,$79,$7d,$80,$84,$87,$8b,$8e,$92,$95,$99,$9d,$a0,$a4,$a7,$ab

sinxhi
 !by $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 !by $00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01
 !by $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
 !by $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
 !by $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
 !by $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
 !by $01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00
 !by $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 !by $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 !by $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 !by $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 !by $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 !by $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 !by $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 !by $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 !by $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

siny
 !by $8d,$8f,$92,$94,$96,$98,$9a,$9c,$9f,$a1,$a3,$a5,$a7,$a9,$ab,$ad
 !by $af,$b1,$b3,$b5,$b7,$b9,$bb,$bc,$be,$c0,$c2,$c3,$c5,$c7,$c8,$ca
 !by $cb,$cd,$ce,$d0,$d1,$d2,$d4,$d5,$d6,$d7,$d8,$d9,$da,$db,$dc,$dd
 !by $de,$df,$e0,$e0,$e1,$e1,$e2,$e2,$e3,$e3,$e3,$e4,$e4,$e4,$e4,$e4
 !by $e4,$e4,$e4,$e4,$e3,$e3,$e3,$e2,$e2,$e1,$e1,$e0,$e0,$df,$de,$dd
 !by $dc,$db,$da,$d9,$d8,$d7,$d6,$d5,$d4,$d2,$d1,$d0,$ce,$cd,$cb,$ca
 !by $c8,$c7,$c5,$c3,$c2,$c0,$be,$bc,$bb,$b9,$b7,$b5,$b3,$b1,$af,$ad
 !by $ab,$a9,$a7,$a5,$a3,$a1,$9f,$9c,$9a,$98,$96,$94,$92,$8f,$8d,$8b
 !by $89,$87,$84,$82,$80,$7e,$7c,$7a,$77,$75,$73,$71,$6f,$6d,$6b,$69
 !by $67,$65,$63,$61,$5f,$5d,$5b,$5a,$58,$56,$54,$53,$51,$4f,$4e,$4c
 !by $4b,$49,$48,$46,$45,$44,$42,$41,$40,$3f,$3e,$3d,$3c,$3b,$3a,$39
 !by $38,$37,$36,$36,$35,$35,$34,$34,$33,$33,$33,$32,$32,$32,$32,$32
 !by $32,$32,$32,$32,$33,$33,$33,$34,$34,$35,$35,$36,$36,$37,$38,$39
 !by $3a,$3b,$3c,$3d,$3e,$3f,$40,$41,$42,$44,$45,$46,$48,$49,$4b,$4c
 !by $4e,$4f,$51,$53,$54,$56,$58,$5a,$5b,$5d,$5f,$61,$63,$65,$67,$69
 !by $6b,$6d,$6f,$71,$73,$75,$77,$7a,$7c,$7e,$80,$82,$84,$87,$89,$8b
 !by $ff
 