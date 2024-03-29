*= $1000 

  
; get sprite no from table
; get sprite table lohi from table
; get x
; get

; ldx andhi
; ldy andlo

; get xpos (0-127)
; get xpos char (0-31)
; subtract xpos-char from andlo
; if carry dec andhi

; background screen 192*320 - done
; buffer screen 192*320 - needed

; get sprite
; get size
; get position
; copy background to buffer - new
; draw sprites into buffer if overlap - new
; copy buffer to screen - new


; to draw moving sprite
; - 1 copy background to temp background (33*40 - straight copy)
; - 2 draw sprite and/or to temp bckground (32*40)
; - 3 draw temp background to (straight copy)

; next 
; - setup background (32*192) temp buffer - done
; - build background table
; - test - create background
; - copy background to screen - using 1 + 3

; copy background to temp buffer 
;- pass in x and y
; - dec x
; - calc x background address
; - calc y byte
; - copy 5 bytes from x+0 to x+33 to temp inner buffer

; copy temp buffer to screen
; - pass in x and y
; - dec x
; - calc x screen address
; - calc y byte
; - copy 5 bytes from from temp inner buffer to x+0 to x+33

; lda (
; sta (4) or sta (4) / sta (4)


; sprite
; - get temp buffer ,x
; - and $abcd      ,y (4) / and (scn1),y (5)
; - or $abcd      ,y  (4) / or (scn2),y (5)
; - put temp buffer,x
; iny

; across
;  7 across
;  1 across visible to clear previous frame
;  7 across visible
;  15 total across
; down
;  7 chars down *8 = 56 = same line =1
;  1 line down to clear previous frame
;  7 chars down *8 = 56
;  1 line spare at end
;  59 total down
; total bytes = 15 * 59 = 798

SCR = 2

AND_LO_LO = TY +11
AND_LO_HI = AND_LO_LO +1
AND_HI_LO = AND_LO_HI +1
AND_HI_HI = AND_HI_LO +1
ORA_LO_LO = AND_HI_HI +1
ORA_LO_HI = ORA_LO_LO +1
ORA_HI_LO = ORA_LO_HI +1
ORA_HI_HI = ORA_HI_LO +1

SPR_AND = SCR +2
SPR_ORA = SPR_AND +2

TX = SPR_ORA +2
TY = TX +1

SPR_CNT = SCR

 SEI        ; disable maskable IRQs

 LDA #$7F
 STA $DC0D  ; disable timer interrupts which can be generated by the two CIA chips
 STA $DD0D  ; the kernal uses such an interrupt to flash the cursor and scan the keyboard, so we better stop it.

 LDA $DC0D  ; by reading this two registers we negate any pending CIA irqs.
 LDA $DD0D  ; if we don't do this, a pending CIA irq might occur after we finish setting up our irq. we don't want that to happen.

 LDA #$01   ; this is how to tell the VICII to generate a raster interrupt
 STA $D01A
 LDA #$FB   ; this is how to tell at which rasterline we want the irq to be triggered
 STA $D012

 LDA #%00110000 ; 00111011 ; 76543210 - 7=MSBRST 6=ECM 5=BM 4=VIS 3=25/24 0-2=SCRL
 STA $D011    ;VIC Control Register 1

 LDA #%00011000 ; 0-2=SCRL 3=40/38 4=MCM 5-7=UNUSED
 STA $D016    ;VIC Control Register 2

 LDA #$35   ; we turn off the BASIC and KERNAL rom here
 STA $01    ; the cpu now sees RAM everywhere except at $d000-$e000, where still the registers of SID/VICII/etc are visible

 ldA #<BM_IRQ  ; this is how we set up
 STA $FFFE     ; the address of our interrupt code
 LDA #>BM_IRQ
 STA $FFFF
  
 LDA #<NMI_NOP ; lsb
 STA $FFFA ; Create a nop, irq handler for NMI that gets called whenever RESTORE is pressed or similar.
 LDA #>NMI_NOP ; msb
 STA $FFFB ; We're putting our irq handler directly in the vector that usually points to the kernal's NMI handler since we have kernal banked out.

 LDA #$00  ; Force an NMI by setting up a timer. This will cause an NMI, that won't be acked. Any subsequent NMI's from RESTORE will be essentially disabled.
 STA $DD0E       ; Stop timer A
 STA $DD04       ; Set timer A to 0, NMI will occure immediately after start
 STA $DD0E

 LDA #$81
 STA $DD0D       ; Set timer A as source for NMI

 LDA #$01
 STA $DD0E       ; Start timer A -> NMI

 LDA #$02
 STA $DD00 ; bank
    
 LDA #$80
 STA $D018    ;VIC Memory Control Register - screen at bank 0 - colour at bank 8

 LDA #$00
 STA $D021

 LDA #$01 ; colour 01 (0000????) and colour 10 (????0000) - bank 1
 LDX #<$4000
 LDY #>$4000 
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

 LDA #$BC ; colour 01 (0000????) and colour 10 (????0000) - bank 1
 LDX #<($4000+$2000)
 LDY #>($4000+$2000) 
 STX SCR+0
 STY SCR+1
 LDX #>1000 
 LDY #<1000
 JSR MEMSET
 
 JSR SB_FILL
 
;CLI ; enable maskable interrupts again

 LDA #32
 STA TX
 STA TY

MLOOP:
 JSR V_WAIT
 JSR JOYSTICK

 LDX TX
 LDY TY
 LDA #1
 JSR SCNB_TMPB_1
  
 LDA TX
 AND #3
 TAY
 LDA SPR00_AND_LO,Y
 STA SPR_AND
 LDA SPR00_AND_HI,Y
 STA SPR_AND +1
 LDA SPR00_ORA_LO,Y
 STA SPR_ORA
 LDA SPR00_ORA_HI,Y
 STA SPR_ORA +1

 LDX TX
 LDY TY
 LDA #16 ; todo - needs to be *rows (8) - done
 JSR SPRN_SCRN_1

 LDX TX
 LDY TY
 LDA #1
 JSR TMPB_SCNB_1

JMP MLOOP ; we better don't RTS, the ROMS are now switched off, there's no way back to the system


FIRE !BYTE 0

!ZONE JOYSTICK
JOYSTICK:
 LDA $DC00
 LSR
 BCS .LEFT
  DEC TY
.LEFT
 LSR
 BCS .RIGHT
  INC TY
.RIGHT
 LSR
 BCS .UP
  DEC TX
.UP
 LSR
 BCS .DOWN
  INC TX
.DOWN
 AND #1
 STA FIRE
RTS


!ZONE V_WAIT
V_WAIT
 LDA #248
.LOOP
 CMP $D012
 BNE .LOOP
 INC $D020
 DEC $D020
RTS

BM_IRQ:
 INC $D019    ;VIC Interrupt Request Register (IRR)
 PHA
 TXA 
 PHA
 TYA 
 PHA 

 PLA 
 TAY
 PLA 
 TAX
 PLA
NMI_NOP:
RTI ; This is the irq handler for the NMI. Just returns without acknowledge. This prevents subsequent NMI's from interfering.

!ZONE SB_FILL
SB_FILL:
 LDX #31

.LOOP_X
 LDY #24
 
.LOOP_Y

  JSR CHAR_SB_2
  DEY
  BPL .LOOP_Y

 DEX
 BPL .LOOP_X
  
RTS 
  
TEST !BYTE 1,1

CHAR_SB_2
 
 TYA
 PHA

 STA TEST

 ASL ; *2
 ASL ; *4
 ASL ; *8
 TAY
 LDA SC_LO,Y
 STA SCR 
 LDA SB_HI,Y 
 STA SCR+1 

 TXA
 PHA

 STA TEST+1

 ASL ; *2
 ASL ; *4
 ASL ; *8
 TAY
 
 LDA TEST
 CLC
 ADC TEST+1
 AND #15
 TAX
 LDA PATTERN,X
 
 STA (SCR),Y
 INY
 STA (SCR),Y
 INY
 STA (SCR),Y
 INY
 STA (SCR),Y
 INY
 STA (SCR),Y
 INY
 STA (SCR),Y
 INY
 STA (SCR),Y
 INY
 STA (SCR),Y

 PLA
 TAX
 PLA
 TAY
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

!MACRO BUF_TMP_99 SRC, DST, VAL { ; buffer to temp
 LDA SC_LO+VAL,Y
 STA SRC+1
 STA DST+1
 LDA SB_HI+VAL,Y 
 STA SRC+2
 LDA TB_HI+VAL,Y 
 STA DST+2
}

!MACRO TMP_SCR_99 SRC, DST, VAL { ; temp to screen
 LDA SC_LO+VAL,Y
 STA SRC+1
 STA DST+1
 LDA TB_HI+VAL,Y 
 STA SRC+2
 LDA SC_HI+VAL,Y 
 STA DST+2
}

!MACRO SPR_SCR_99 SRC, DST, VAL {  ; sprite to temp
 LDA SC_LO+VAL,Y
 STA SRC+1
 STA DST+1
 LDA TB_HI+VAL,Y 
 STA SRC+2
 STA DST+2
}
!MACRO INCXY {
 INX
 BNE .CONT
  INY
.CONT
}

!ZONE SPRN_SCRN_1 ; copy sprite to temp buffer
SPRN_SCRN_1
 INC $D020
 
 STA SPR_CNT

STX BKX
STY BKY

 LDX SPR_AND
 LDY SPR_AND +1
 STX .SPA01 +1
 STY .SPA01 +2
 
 +INCXY 
 STX .SPA02 +1
 STY .SPA02 +2

 +INCXY 
 STX .SPA03 +1
 STY .SPA03 +2
 
 +INCXY 
 STX .SPA04 +1
 STY .SPA04 +2

 +INCXY 
 STX .SPA05 +1
 STY .SPA05 +2
 
 +INCXY 
 STX .SPA06 +1
 STY .SPA06 +2

 +INCXY 
 STX .SPA07 +1
 STY .SPA07 +2

 +INCXY 
 STX .SPA08 +1
 STY .SPA08 +2

 LDX SPR_ORA
 LDY SPR_ORA +1
 STX .SPO01 +1
 STY .SPO01 +2

 +INCXY 
 STX .SPO02 +1
 STY .SPO02 +2

 +INCXY 
 STX .SPO03 +1
 STY .SPO03 +2
 
 +INCXY 
 STX .SPO04 +1
 STY .SPO04 +2

 +INCXY 
 STX .SPO05 +1
 STY .SPO05 +2
 
 +INCXY 
 STX .SPO06 +1
 STY .SPO06 +2

 +INCXY 
 STX .SPO07 +1
 STY .SPO07 +2

 +INCXY 
 STX .SPO08 +1
 STY .SPO08 +2

LDX BKX
LDY BKY

  +SPR_SCR_99 .SCS08, .SCD08, 7
  +SPR_SCR_99 .SCS07, .SCD07, 6
  +SPR_SCR_99 .SCS06, .SCD06, 5
  +SPR_SCR_99 .SCS05, .SCD05, 4
  +SPR_SCR_99 .SCS04, .SCD04, 3
  +SPR_SCR_99 .SCS03, .SCD03, 2
  +SPR_SCR_99 .SCS02, .SCD02, 1
  +SPR_SCR_99 .SCS01, .SCD01, 0
  
 LDY SCR_TAB3,X
 LDX SPR_CNT ; 24 16 8 0 (needs to be colums*rows)
 SEC ; todo - needs to be SEC - done

.LOOP
.SCS01 LDA $ABCD,Y
.SPA01 AND $ABCD,X ; todo - needs to be x - done
.SPO01 ORA $ABCD,X ; todo - needs to be x - done
.SCD01 STA $ABCD,Y

.SCS02 LDA $ABCD,Y
.SPA02 AND $ABCD,X ; todo - needs to be x - done
.SPO02 ORA $ABCD,X ; todo - needs to be x - done
.SCD02 STA $ABCD,Y
     
.SCS03 LDA $ABCD,Y
.SPA03 AND $ABCD,X ; todo - needs to be x - done
.SPO03 ORA $ABCD,X ; todo - needs to be x - done
.SCD03 STA $ABCD,Y

.SCS04 LDA $ABCD,Y
.SPA04 AND $ABCD,X ; todo - needs to be x - done
.SPO04 ORA $ABCD,X ; todo - needs to be x - done
.SCD04 STA $ABCD,Y

.SCS05 LDA $ABCD,Y
.SPA05 AND $ABCD,X ; todo - needs to be x - done
.SPO05 ORA $ABCD,X ; todo - needs to be x - done
.SCD05 STA $ABCD,Y

.SCS06 LDA $ABCD,Y
.SPA06 AND $ABCD,X ; todo - needs to be x - done
.SPO06 ORA $ABCD,X ; todo - needs to be x - done
.SCD06 STA $ABCD,Y

.SCS07 LDA $ABCD,Y
.SPA07 AND $ABCD,X ; todo - needs to be x - done
.SPO07 ORA $ABCD,X ; todo - needs to be x - done
.SCD07 STA $ABCD,Y

.SCS08 LDA $ABCD,Y
.SPA08 AND $ABCD,X ; todo - needs to be x - done
.SPO08 ORA $ABCD,X ; todo - needs to be x - done
.SCD08 STA $ABCD,Y

  TYA
  ADC #8-1
  TAY

  TXA
  SBC #8-1 ; todo needs to be decrement all rows - done
  TAX

  BNE .LOOP ; todo - should be BNE

 DEC $D020

RTS

!ZONE SCNB_TMPB_1
SCNB_TMPB_1 ; copy from temp buffer to screen - size 1
 INC $D020

 STA SPR_CNT

 +BUF_TMP_99 .SRC09, .DST09, 8
 
 +BUF_TMP_99 .SRC08, .DST08, 7
 +BUF_TMP_99 .SRC07, .DST07, 6
 +BUF_TMP_99 .SRC06, .DST06, 5
 +BUF_TMP_99 .SRC05, .DST05, 4
 +BUF_TMP_99 .SRC04, .DST04, 3
 +BUF_TMP_99 .SRC03, .DST03, 2
 +BUF_TMP_99 .SRC02, .DST02, 1
 +BUF_TMP_99 .SRC01, .DST01, 0

 +BUF_TMP_99 .SRCTP, .DSTTP, -1

 LDY SCR_TAB3-4,X
 LDX SPR_CNT
 INX
 CLC 
 
.LOOP

.SRC09  LDA $ABCD,Y
.DST09  STA $ABCD,Y

.SRC08  LDA $ABCD,Y
.DST08  STA $ABCD,Y
.SRC07  LDA $ABCD,Y
.DST07  STA $ABCD,Y
.SRC06  LDA $ABCD,Y
.DST06  STA $ABCD,Y
.SRC05  LDA $ABCD,Y
.DST05  STA $ABCD,Y
.SRC04  LDA $ABCD,Y
.DST04  STA $ABCD,Y
.SRC03  LDA $ABCD,Y
.DST03  STA $ABCD,Y
.SRC02  LDA $ABCD,Y
.DST02  STA $ABCD,Y
.SRC01  LDA $ABCD,Y
.DST01  STA $ABCD,Y
.SRCTP  LDA $ABCD,Y
.DSTTP  STA $ABCD,Y

  TYA      ;
  ADC #8   ; replace with LAX possibly?
  TAY      ;

  DEX
  BPL .LOOP

 DEC $D020
RTS

!ZONE TMPB_SCNB_1
TMPB_SCNB_1 ; copy from screen buffer to temp buffer - size 1
 INC $D020

 STA SPR_CNT

 +TMP_SCR_99 .SRC09, .DST09, 8
 
 +TMP_SCR_99 .SRC08, .DST08, 7
 +TMP_SCR_99 .SRC07, .DST07, 6
 +TMP_SCR_99 .SRC06, .DST06, 5
 +TMP_SCR_99 .SRC05, .DST05, 4
 +TMP_SCR_99 .SRC04, .DST04, 3
 +TMP_SCR_99 .SRC03, .DST03, 2
 +TMP_SCR_99 .SRC02, .DST02, 1
 +TMP_SCR_99 .SRC01, .DST01, 0

 +TMP_SCR_99 .SRCTP, .DSTTP, -1

 LDY SCR_TAB3-4,X
 LDX SPR_CNT
 INX
 CLC 
 
.LOOP

.SRC09  LDA $ABCD,Y
.DST09  STA $ABCD,Y

.SRC08  LDA $ABCD,Y
.DST08  STA $ABCD,Y
.SRC07  LDA $ABCD,Y
.DST07  STA $ABCD,Y
.SRC06  LDA $ABCD,Y
.DST06  STA $ABCD,Y
.SRC05  LDA $ABCD,Y
.DST05  STA $ABCD,Y
.SRC04  LDA $ABCD,Y
.DST04  STA $ABCD,Y
.SRC03  LDA $ABCD,Y
.DST03  STA $ABCD,Y
.SRC02  LDA $ABCD,Y
.DST02  STA $ABCD,Y
.SRC01  LDA $ABCD,Y
.DST01  STA $ABCD,Y
.SRCTP  LDA $ABCD,Y
.DSTTP  STA $ABCD,Y

  TYA
  ADC #8
  TAY

  DEX
  BPL .LOOP

 DEC $D020
RTS

BKX !BYTE 0
BKY !BYTE 0

PATTERN
; !BYTE %00000000,%00010001,%00100010,%00110011,%01000100,%01010101,%01100110,%01110111,%10001000,%10011001,%10101010,%10111011,%11001100,%11011101,%11101110,%11111111
 
 !BYTE %00000000,%01010101,%10101010,%11111111
 !BYTE %00000000,%01010101,%10101010,%11111111
 !BYTE %00000000,%01010101,%10101010,%11111111
 !BYTE %00000000,%01010101,%10101010,%11111111


SCR_TAB3:
!BYTE $00,$00,$00,$00,$08,$08,$08,$08,$10,$10,$10,$10,$18,$18,$18,$18
!BYTE $20,$20,$20,$20,$28,$28,$28,$28,$30,$30,$30,$30,$38,$38,$38,$38
!BYTE $40,$40,$40,$40,$48,$48,$48,$48,$50,$50,$50,$50,$58,$58,$58,$58
!BYTE $60,$60,$60,$60,$68,$68,$68,$68,$70,$70,$70,$70,$78,$78,$78,$78
!BYTE $80,$80,$80,$80,$88,$88,$88,$88,$90,$90,$90,$90,$98,$98,$98,$98
!BYTE $A0,$A0,$A0,$A0,$A8,$A8,$A8,$A8,$B0,$B0,$B0,$B0,$B8,$B8,$B8,$B8
!BYTE $C0,$C0,$C0,$C0,$C8,$C8,$C8,$C8,$D0,$D0,$D0,$D0,$D8,$D8,$D8,$D8
!BYTE $E0,$E0,$E0,$E0,$E8,$E8,$E8,$E8,$F0,$F0,$F0,$F0,$F8,$F8,$F8,$F8

SCR_AND_TAB:
!BYTE $3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC
!BYTE $3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC
!BYTE $3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC
!BYTE $3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC
!BYTE $3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC
!BYTE $3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC
!BYTE $3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC
!BYTE $3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC

SCR_OR_TAB:
!BYTE $C0,$30,$0C,$03,$C0,$30,$0C,$03,$C0,$30,$0C,$03,$C0,$30,$0C,$03
!BYTE $C0,$30,$0C,$03,$C0,$30,$0C,$03,$C0,$30,$0C,$03,$C0,$30,$0C,$03
!BYTE $C0,$30,$0C,$03,$C0,$30,$0C,$03,$C0,$30,$0C,$03,$C0,$30,$0C,$03
!BYTE $C0,$30,$0C,$03,$C0,$30,$0C,$03,$C0,$30,$0C,$03,$C0,$30,$0C,$03
!BYTE $C0,$30,$0C,$03,$C0,$30,$0C,$03,$C0,$30,$0C,$03,$C0,$30,$0C,$03
!BYTE $C0,$30,$0C,$03,$C0,$30,$0C,$03,$C0,$30,$0C,$03,$C0,$30,$0C,$03
!BYTE $C0,$30,$0C,$03,$C0,$30,$0C,$03,$C0,$30,$0C,$03,$C0,$30,$0C,$03
!BYTE $C0,$30,$0C,$03,$C0,$30,$0C,$03,$C0,$30,$0C,$03,$C0,$30,$0C,$03

SC_HI:
!BYTE >($4000+(00*320)+0),>($4000+(00*320)+1),>($4000+(00*320)+2),>($4000+(00*320)+3),>($4000+(00*320)+4),>($4000+(00*320)+5),>($4000+(00*320)+6),>($4000+(00*320)+7)
!BYTE >($4000+(01*320)+0),>($4000+(01*320)+1),>($4000+(01*320)+2),>($4000+(01*320)+3),>($4000+(01*320)+4),>($4000+(01*320)+5),>($4000+(01*320)+6),>($4000+(01*320)+7)
!BYTE >($4000+(02*320)+0),>($4000+(02*320)+1),>($4000+(02*320)+2),>($4000+(02*320)+3),>($4000+(02*320)+4),>($4000+(02*320)+5),>($4000+(02*320)+6),>($4000+(02*320)+7)
!BYTE >($4000+(03*320)+0),>($4000+(03*320)+1),>($4000+(03*320)+2),>($4000+(03*320)+3),>($4000+(03*320)+4),>($4000+(03*320)+5),>($4000+(03*320)+6),>($4000+(03*320)+7)
!BYTE >($4000+(04*320)+0),>($4000+(04*320)+1),>($4000+(04*320)+2),>($4000+(04*320)+3),>($4000+(04*320)+4),>($4000+(04*320)+5),>($4000+(04*320)+6),>($4000+(04*320)+7)
!BYTE >($4000+(05*320)+0),>($4000+(05*320)+1),>($4000+(05*320)+2),>($4000+(05*320)+3),>($4000+(05*320)+4),>($4000+(05*320)+5),>($4000+(05*320)+6),>($4000+(05*320)+7)
!BYTE >($4000+(06*320)+0),>($4000+(06*320)+1),>($4000+(06*320)+2),>($4000+(06*320)+3),>($4000+(06*320)+4),>($4000+(06*320)+5),>($4000+(06*320)+6),>($4000+(06*320)+7)
!BYTE >($4000+(07*320)+0),>($4000+(07*320)+1),>($4000+(07*320)+2),>($4000+(07*320)+3),>($4000+(07*320)+4),>($4000+(07*320)+5),>($4000+(07*320)+6),>($4000+(07*320)+7)
!BYTE >($4000+(08*320)+0),>($4000+(08*320)+1),>($4000+(08*320)+2),>($4000+(08*320)+3),>($4000+(08*320)+4),>($4000+(08*320)+5),>($4000+(08*320)+6),>($4000+(08*320)+7)
!BYTE >($4000+(09*320)+0),>($4000+(09*320)+1),>($4000+(09*320)+2),>($4000+(09*320)+3),>($4000+(09*320)+4),>($4000+(09*320)+5),>($4000+(09*320)+6),>($4000+(09*320)+7)
!BYTE >($4000+(10*320)+0),>($4000+(10*320)+1),>($4000+(10*320)+2),>($4000+(10*320)+3),>($4000+(10*320)+4),>($4000+(10*320)+5),>($4000+(10*320)+6),>($4000+(10*320)+7)
!BYTE >($4000+(11*320)+0),>($4000+(11*320)+1),>($4000+(11*320)+2),>($4000+(11*320)+3),>($4000+(11*320)+4),>($4000+(11*320)+5),>($4000+(11*320)+6),>($4000+(11*320)+7)
!BYTE >($4000+(12*320)+0),>($4000+(12*320)+1),>($4000+(12*320)+2),>($4000+(12*320)+3),>($4000+(12*320)+4),>($4000+(12*320)+5),>($4000+(12*320)+6),>($4000+(12*320)+7)
!BYTE >($4000+(13*320)+0),>($4000+(13*320)+1),>($4000+(13*320)+2),>($4000+(13*320)+3),>($4000+(13*320)+4),>($4000+(13*320)+5),>($4000+(13*320)+6),>($4000+(13*320)+7)
!BYTE >($4000+(14*320)+0),>($4000+(14*320)+1),>($4000+(14*320)+2),>($4000+(14*320)+3),>($4000+(14*320)+4),>($4000+(14*320)+5),>($4000+(14*320)+6),>($4000+(14*320)+7)
!BYTE >($4000+(15*320)+0),>($4000+(15*320)+1),>($4000+(15*320)+2),>($4000+(15*320)+3),>($4000+(15*320)+4),>($4000+(15*320)+5),>($4000+(15*320)+6),>($4000+(15*320)+7)
!BYTE >($4000+(16*320)+0),>($4000+(16*320)+1),>($4000+(16*320)+2),>($4000+(16*320)+3),>($4000+(16*320)+4),>($4000+(16*320)+5),>($4000+(16*320)+6),>($4000+(16*320)+7)
!BYTE >($4000+(17*320)+0),>($4000+(17*320)+1),>($4000+(17*320)+2),>($4000+(17*320)+3),>($4000+(17*320)+4),>($4000+(17*320)+5),>($4000+(17*320)+6),>($4000+(17*320)+7)
!BYTE >($4000+(18*320)+0),>($4000+(18*320)+1),>($4000+(18*320)+2),>($4000+(18*320)+3),>($4000+(18*320)+4),>($4000+(18*320)+5),>($4000+(18*320)+6),>($4000+(18*320)+7)
!BYTE >($4000+(19*320)+0),>($4000+(19*320)+1),>($4000+(19*320)+2),>($4000+(19*320)+3),>($4000+(19*320)+4),>($4000+(19*320)+5),>($4000+(19*320)+6),>($4000+(19*320)+7)
!BYTE >($4000+(20*320)+0),>($4000+(20*320)+1),>($4000+(20*320)+2),>($4000+(20*320)+3),>($4000+(20*320)+4),>($4000+(20*320)+5),>($4000+(20*320)+6),>($4000+(20*320)+7)
!BYTE >($4000+(21*320)+0),>($4000+(21*320)+1),>($4000+(21*320)+2),>($4000+(21*320)+3),>($4000+(21*320)+4),>($4000+(21*320)+5),>($4000+(21*320)+6),>($4000+(21*320)+7)
!BYTE >($4000+(22*320)+0),>($4000+(22*320)+1),>($4000+(22*320)+2),>($4000+(22*320)+3),>($4000+(22*320)+4),>($4000+(22*320)+5),>($4000+(22*320)+6),>($4000+(22*320)+7)
!BYTE >($4000+(23*320)+0),>($4000+(23*320)+1),>($4000+(23*320)+2),>($4000+(23*320)+3),>($4000+(23*320)+4),>($4000+(23*320)+5),>($4000+(23*320)+6),>($4000+(23*320)+7)
!BYTE >($4000+(24*320)+0),>($4000+(24*320)+1),>($4000+(24*320)+2),>($4000+(24*320)+3),>($4000+(24*320)+4),>($4000+(24*320)+5),>($4000+(24*320)+6),>($4000+(24*320)+7)

SC_LO:
!BYTE <($4000+(00*320)+0),<($4000+(00*320)+1),<($4000+(00*320)+2),<($4000+(00*320)+3),<($4000+(00*320)+4),<($4000+(00*320)+5),<($4000+(00*320)+6),<($4000+(00*320)+7)
!BYTE <($4000+(01*320)+0),<($4000+(01*320)+1),<($4000+(01*320)+2),<($4000+(01*320)+3),<($4000+(01*320)+4),<($4000+(01*320)+5),<($4000+(01*320)+6),<($4000+(01*320)+7)
!BYTE <($4000+(02*320)+0),<($4000+(02*320)+1),<($4000+(02*320)+2),<($4000+(02*320)+3),<($4000+(02*320)+4),<($4000+(02*320)+5),<($4000+(02*320)+6),<($4000+(02*320)+7)
!BYTE <($4000+(03*320)+0),<($4000+(03*320)+1),<($4000+(03*320)+2),<($4000+(03*320)+3),<($4000+(03*320)+4),<($4000+(03*320)+5),<($4000+(03*320)+6),<($4000+(03*320)+7)
!BYTE <($4000+(04*320)+0),<($4000+(04*320)+1),<($4000+(04*320)+2),<($4000+(04*320)+3),<($4000+(04*320)+4),<($4000+(04*320)+5),<($4000+(04*320)+6),<($4000+(04*320)+7)
!BYTE <($4000+(05*320)+0),<($4000+(05*320)+1),<($4000+(05*320)+2),<($4000+(05*320)+3),<($4000+(05*320)+4),<($4000+(05*320)+5),<($4000+(05*320)+6),<($4000+(05*320)+7)
!BYTE <($4000+(06*320)+0),<($4000+(06*320)+1),<($4000+(06*320)+2),<($4000+(06*320)+3),<($4000+(06*320)+4),<($4000+(06*320)+5),<($4000+(06*320)+6),<($4000+(06*320)+7)
!BYTE <($4000+(07*320)+0),<($4000+(07*320)+1),<($4000+(07*320)+2),<($4000+(07*320)+3),<($4000+(07*320)+4),<($4000+(07*320)+5),<($4000+(07*320)+6),<($4000+(07*320)+7)
!BYTE <($4000+(08*320)+0),<($4000+(08*320)+1),<($4000+(08*320)+2),<($4000+(08*320)+3),<($4000+(08*320)+4),<($4000+(08*320)+5),<($4000+(08*320)+6),<($4000+(08*320)+7)
!BYTE <($4000+(09*320)+0),<($4000+(09*320)+1),<($4000+(09*320)+2),<($4000+(09*320)+3),<($4000+(09*320)+4),<($4000+(09*320)+5),<($4000+(09*320)+6),<($4000+(09*320)+7)
!BYTE <($4000+(10*320)+0),<($4000+(10*320)+1),<($4000+(10*320)+2),<($4000+(10*320)+3),<($4000+(10*320)+4),<($4000+(10*320)+5),<($4000+(10*320)+6),<($4000+(10*320)+7)
!BYTE <($4000+(11*320)+0),<($4000+(11*320)+1),<($4000+(11*320)+2),<($4000+(11*320)+3),<($4000+(11*320)+4),<($4000+(11*320)+5),<($4000+(11*320)+6),<($4000+(11*320)+7)
!BYTE <($4000+(12*320)+0),<($4000+(12*320)+1),<($4000+(12*320)+2),<($4000+(12*320)+3),<($4000+(12*320)+4),<($4000+(12*320)+5),<($4000+(12*320)+6),<($4000+(12*320)+7)
!BYTE <($4000+(13*320)+0),<($4000+(13*320)+1),<($4000+(13*320)+2),<($4000+(13*320)+3),<($4000+(13*320)+4),<($4000+(13*320)+5),<($4000+(13*320)+6),<($4000+(13*320)+7)
!BYTE <($4000+(14*320)+0),<($4000+(14*320)+1),<($4000+(14*320)+2),<($4000+(14*320)+3),<($4000+(14*320)+4),<($4000+(14*320)+5),<($4000+(14*320)+6),<($4000+(14*320)+7)
!BYTE <($4000+(15*320)+0),<($4000+(15*320)+1),<($4000+(15*320)+2),<($4000+(15*320)+3),<($4000+(15*320)+4),<($4000+(15*320)+5),<($4000+(15*320)+6),<($4000+(15*320)+7)
!BYTE <($4000+(16*320)+0),<($4000+(16*320)+1),<($4000+(16*320)+2),<($4000+(16*320)+3),<($4000+(16*320)+4),<($4000+(16*320)+5),<($4000+(16*320)+6),<($4000+(16*320)+7)
!BYTE <($4000+(17*320)+0),<($4000+(17*320)+1),<($4000+(17*320)+2),<($4000+(17*320)+3),<($4000+(17*320)+4),<($4000+(17*320)+5),<($4000+(17*320)+6),<($4000+(17*320)+7)
!BYTE <($4000+(18*320)+0),<($4000+(18*320)+1),<($4000+(18*320)+2),<($4000+(18*320)+3),<($4000+(18*320)+4),<($4000+(18*320)+5),<($4000+(18*320)+6),<($4000+(18*320)+7)
!BYTE <($4000+(19*320)+0),<($4000+(19*320)+1),<($4000+(19*320)+2),<($4000+(19*320)+3),<($4000+(19*320)+4),<($4000+(19*320)+5),<($4000+(19*320)+6),<($4000+(19*320)+7)
!BYTE <($4000+(20*320)+0),<($4000+(20*320)+1),<($4000+(20*320)+2),<($4000+(20*320)+3),<($4000+(20*320)+4),<($4000+(20*320)+5),<($4000+(20*320)+6),<($4000+(20*320)+7)
!BYTE <($4000+(21*320)+0),<($4000+(21*320)+1),<($4000+(21*320)+2),<($4000+(21*320)+3),<($4000+(21*320)+4),<($4000+(21*320)+5),<($4000+(21*320)+6),<($4000+(21*320)+7)
!BYTE <($4000+(22*320)+0),<($4000+(22*320)+1),<($4000+(22*320)+2),<($4000+(22*320)+3),<($4000+(22*320)+4),<($4000+(22*320)+5),<($4000+(22*320)+6),<($4000+(22*320)+7)
!BYTE <($4000+(23*320)+0),<($4000+(23*320)+1),<($4000+(23*320)+2),<($4000+(23*320)+3),<($4000+(23*320)+4),<($4000+(23*320)+5),<($4000+(23*320)+6),<($4000+(23*320)+7)
!BYTE <($4000+(24*320)+0),<($4000+(24*320)+1),<($4000+(24*320)+2),<($4000+(24*320)+3),<($4000+(24*320)+4),<($4000+(24*320)+5),<($4000+(24*320)+6),<($4000+(24*320)+7)

SB_HI:
!BYTE >(SCN_BUF+(00*320)+0),>(SCN_BUF+(00*320)+1),>(SCN_BUF+(00*320)+2),>(SCN_BUF+(00*320)+3),>(SCN_BUF+(00*320)+4),>(SCN_BUF+(00*320)+5),>(SCN_BUF+(00*320)+6),>(SCN_BUF+(00*320)+7)
!BYTE >(SCN_BUF+(01*320)+0),>(SCN_BUF+(01*320)+1),>(SCN_BUF+(01*320)+2),>(SCN_BUF+(01*320)+3),>(SCN_BUF+(01*320)+4),>(SCN_BUF+(01*320)+5),>(SCN_BUF+(01*320)+6),>(SCN_BUF+(01*320)+7)
!BYTE >(SCN_BUF+(02*320)+0),>(SCN_BUF+(02*320)+1),>(SCN_BUF+(02*320)+2),>(SCN_BUF+(02*320)+3),>(SCN_BUF+(02*320)+4),>(SCN_BUF+(02*320)+5),>(SCN_BUF+(02*320)+6),>(SCN_BUF+(02*320)+7)
!BYTE >(SCN_BUF+(03*320)+0),>(SCN_BUF+(03*320)+1),>(SCN_BUF+(03*320)+2),>(SCN_BUF+(03*320)+3),>(SCN_BUF+(03*320)+4),>(SCN_BUF+(03*320)+5),>(SCN_BUF+(03*320)+6),>(SCN_BUF+(03*320)+7)
!BYTE >(SCN_BUF+(04*320)+0),>(SCN_BUF+(04*320)+1),>(SCN_BUF+(04*320)+2),>(SCN_BUF+(04*320)+3),>(SCN_BUF+(04*320)+4),>(SCN_BUF+(04*320)+5),>(SCN_BUF+(04*320)+6),>(SCN_BUF+(04*320)+7)
!BYTE >(SCN_BUF+(05*320)+0),>(SCN_BUF+(05*320)+1),>(SCN_BUF+(05*320)+2),>(SCN_BUF+(05*320)+3),>(SCN_BUF+(05*320)+4),>(SCN_BUF+(05*320)+5),>(SCN_BUF+(05*320)+6),>(SCN_BUF+(05*320)+7)
!BYTE >(SCN_BUF+(06*320)+0),>(SCN_BUF+(06*320)+1),>(SCN_BUF+(06*320)+2),>(SCN_BUF+(06*320)+3),>(SCN_BUF+(06*320)+4),>(SCN_BUF+(06*320)+5),>(SCN_BUF+(06*320)+6),>(SCN_BUF+(06*320)+7)
!BYTE >(SCN_BUF+(07*320)+0),>(SCN_BUF+(07*320)+1),>(SCN_BUF+(07*320)+2),>(SCN_BUF+(07*320)+3),>(SCN_BUF+(07*320)+4),>(SCN_BUF+(07*320)+5),>(SCN_BUF+(07*320)+6),>(SCN_BUF+(07*320)+7)
!BYTE >(SCN_BUF+(08*320)+0),>(SCN_BUF+(08*320)+1),>(SCN_BUF+(08*320)+2),>(SCN_BUF+(08*320)+3),>(SCN_BUF+(08*320)+4),>(SCN_BUF+(08*320)+5),>(SCN_BUF+(08*320)+6),>(SCN_BUF+(08*320)+7)
!BYTE >(SCN_BUF+(09*320)+0),>(SCN_BUF+(09*320)+1),>(SCN_BUF+(09*320)+2),>(SCN_BUF+(09*320)+3),>(SCN_BUF+(09*320)+4),>(SCN_BUF+(09*320)+5),>(SCN_BUF+(09*320)+6),>(SCN_BUF+(09*320)+7)
!BYTE >(SCN_BUF+(10*320)+0),>(SCN_BUF+(10*320)+1),>(SCN_BUF+(10*320)+2),>(SCN_BUF+(10*320)+3),>(SCN_BUF+(10*320)+4),>(SCN_BUF+(10*320)+5),>(SCN_BUF+(10*320)+6),>(SCN_BUF+(10*320)+7)
!BYTE >(SCN_BUF+(11*320)+0),>(SCN_BUF+(11*320)+1),>(SCN_BUF+(11*320)+2),>(SCN_BUF+(11*320)+3),>(SCN_BUF+(11*320)+4),>(SCN_BUF+(11*320)+5),>(SCN_BUF+(11*320)+6),>(SCN_BUF+(11*320)+7)
!BYTE >(SCN_BUF+(12*320)+0),>(SCN_BUF+(12*320)+1),>(SCN_BUF+(12*320)+2),>(SCN_BUF+(12*320)+3),>(SCN_BUF+(12*320)+4),>(SCN_BUF+(12*320)+5),>(SCN_BUF+(12*320)+6),>(SCN_BUF+(12*320)+7)
!BYTE >(SCN_BUF+(13*320)+0),>(SCN_BUF+(13*320)+1),>(SCN_BUF+(13*320)+2),>(SCN_BUF+(13*320)+3),>(SCN_BUF+(13*320)+4),>(SCN_BUF+(13*320)+5),>(SCN_BUF+(13*320)+6),>(SCN_BUF+(13*320)+7)
!BYTE >(SCN_BUF+(14*320)+0),>(SCN_BUF+(14*320)+1),>(SCN_BUF+(14*320)+2),>(SCN_BUF+(14*320)+3),>(SCN_BUF+(14*320)+4),>(SCN_BUF+(14*320)+5),>(SCN_BUF+(14*320)+6),>(SCN_BUF+(14*320)+7)
!BYTE >(SCN_BUF+(15*320)+0),>(SCN_BUF+(15*320)+1),>(SCN_BUF+(15*320)+2),>(SCN_BUF+(15*320)+3),>(SCN_BUF+(15*320)+4),>(SCN_BUF+(15*320)+5),>(SCN_BUF+(15*320)+6),>(SCN_BUF+(15*320)+7)
!BYTE >(SCN_BUF+(16*320)+0),>(SCN_BUF+(16*320)+1),>(SCN_BUF+(16*320)+2),>(SCN_BUF+(16*320)+3),>(SCN_BUF+(16*320)+4),>(SCN_BUF+(16*320)+5),>(SCN_BUF+(16*320)+6),>(SCN_BUF+(16*320)+7)
!BYTE >(SCN_BUF+(17*320)+0),>(SCN_BUF+(17*320)+1),>(SCN_BUF+(17*320)+2),>(SCN_BUF+(17*320)+3),>(SCN_BUF+(17*320)+4),>(SCN_BUF+(17*320)+5),>(SCN_BUF+(17*320)+6),>(SCN_BUF+(17*320)+7)
!BYTE >(SCN_BUF+(18*320)+0),>(SCN_BUF+(18*320)+1),>(SCN_BUF+(18*320)+2),>(SCN_BUF+(18*320)+3),>(SCN_BUF+(18*320)+4),>(SCN_BUF+(18*320)+5),>(SCN_BUF+(18*320)+6),>(SCN_BUF+(18*320)+7)
!BYTE >(SCN_BUF+(19*320)+0),>(SCN_BUF+(19*320)+1),>(SCN_BUF+(19*320)+2),>(SCN_BUF+(19*320)+3),>(SCN_BUF+(19*320)+4),>(SCN_BUF+(19*320)+5),>(SCN_BUF+(19*320)+6),>(SCN_BUF+(19*320)+7)
!BYTE >(SCN_BUF+(20*320)+0),>(SCN_BUF+(20*320)+1),>(SCN_BUF+(20*320)+2),>(SCN_BUF+(20*320)+3),>(SCN_BUF+(20*320)+4),>(SCN_BUF+(20*320)+5),>(SCN_BUF+(20*320)+6),>(SCN_BUF+(20*320)+7)
!BYTE >(SCN_BUF+(21*320)+0),>(SCN_BUF+(21*320)+1),>(SCN_BUF+(21*320)+2),>(SCN_BUF+(21*320)+3),>(SCN_BUF+(21*320)+4),>(SCN_BUF+(21*320)+5),>(SCN_BUF+(21*320)+6),>(SCN_BUF+(21*320)+7)
!BYTE >(SCN_BUF+(22*320)+0),>(SCN_BUF+(22*320)+1),>(SCN_BUF+(22*320)+2),>(SCN_BUF+(22*320)+3),>(SCN_BUF+(22*320)+4),>(SCN_BUF+(22*320)+5),>(SCN_BUF+(22*320)+6),>(SCN_BUF+(22*320)+7)
!BYTE >(SCN_BUF+(23*320)+0),>(SCN_BUF+(23*320)+1),>(SCN_BUF+(23*320)+2),>(SCN_BUF+(23*320)+3),>(SCN_BUF+(23*320)+4),>(SCN_BUF+(23*320)+5),>(SCN_BUF+(23*320)+6),>(SCN_BUF+(23*320)+7)
!BYTE >(SCN_BUF+(24*320)+0),>(SCN_BUF+(24*320)+1),>(SCN_BUF+(24*320)+2),>(SCN_BUF+(24*320)+3),>(SCN_BUF+(24*320)+4),>(SCN_BUF+(24*320)+5),>(SCN_BUF+(24*320)+6),>(SCN_BUF+(24*320)+7)

TB_HI:
!BYTE >(TMP_BUF+(00*320)+0),>(TMP_BUF+(00*320)+1),>(TMP_BUF+(00*320)+2),>(TMP_BUF+(00*320)+3),>(TMP_BUF+(00*320)+4),>(TMP_BUF+(00*320)+5),>(TMP_BUF+(00*320)+6),>(TMP_BUF+(00*320)+7)
!BYTE >(TMP_BUF+(01*320)+0),>(TMP_BUF+(01*320)+1),>(TMP_BUF+(01*320)+2),>(TMP_BUF+(01*320)+3),>(TMP_BUF+(01*320)+4),>(TMP_BUF+(01*320)+5),>(TMP_BUF+(01*320)+6),>(TMP_BUF+(01*320)+7)
!BYTE >(TMP_BUF+(02*320)+0),>(TMP_BUF+(02*320)+1),>(TMP_BUF+(02*320)+2),>(TMP_BUF+(02*320)+3),>(TMP_BUF+(02*320)+4),>(TMP_BUF+(02*320)+5),>(TMP_BUF+(02*320)+6),>(TMP_BUF+(02*320)+7)
!BYTE >(TMP_BUF+(03*320)+0),>(TMP_BUF+(03*320)+1),>(TMP_BUF+(03*320)+2),>(TMP_BUF+(03*320)+3),>(TMP_BUF+(03*320)+4),>(TMP_BUF+(03*320)+5),>(TMP_BUF+(03*320)+6),>(TMP_BUF+(03*320)+7)
!BYTE >(TMP_BUF+(04*320)+0),>(TMP_BUF+(04*320)+1),>(TMP_BUF+(04*320)+2),>(TMP_BUF+(04*320)+3),>(TMP_BUF+(04*320)+4),>(TMP_BUF+(04*320)+5),>(TMP_BUF+(04*320)+6),>(TMP_BUF+(04*320)+7)
!BYTE >(TMP_BUF+(05*320)+0),>(TMP_BUF+(05*320)+1),>(TMP_BUF+(05*320)+2),>(TMP_BUF+(05*320)+3),>(TMP_BUF+(05*320)+4),>(TMP_BUF+(05*320)+5),>(TMP_BUF+(05*320)+6),>(TMP_BUF+(05*320)+7)
!BYTE >(TMP_BUF+(06*320)+0),>(TMP_BUF+(06*320)+1),>(TMP_BUF+(06*320)+2),>(TMP_BUF+(06*320)+3),>(TMP_BUF+(06*320)+4),>(TMP_BUF+(06*320)+5),>(TMP_BUF+(06*320)+6),>(TMP_BUF+(06*320)+7)
!BYTE >(TMP_BUF+(07*320)+0),>(TMP_BUF+(07*320)+1),>(TMP_BUF+(07*320)+2),>(TMP_BUF+(07*320)+3),>(TMP_BUF+(07*320)+4),>(TMP_BUF+(07*320)+5),>(TMP_BUF+(07*320)+6),>(TMP_BUF+(07*320)+7)
!BYTE >(TMP_BUF+(08*320)+0),>(TMP_BUF+(08*320)+1),>(TMP_BUF+(08*320)+2),>(TMP_BUF+(08*320)+3),>(TMP_BUF+(08*320)+4),>(TMP_BUF+(08*320)+5),>(TMP_BUF+(08*320)+6),>(TMP_BUF+(08*320)+7)
!BYTE >(TMP_BUF+(09*320)+0),>(TMP_BUF+(09*320)+1),>(TMP_BUF+(09*320)+2),>(TMP_BUF+(09*320)+3),>(TMP_BUF+(09*320)+4),>(TMP_BUF+(09*320)+5),>(TMP_BUF+(09*320)+6),>(TMP_BUF+(09*320)+7)
!BYTE >(TMP_BUF+(10*320)+0),>(TMP_BUF+(10*320)+1),>(TMP_BUF+(10*320)+2),>(TMP_BUF+(10*320)+3),>(TMP_BUF+(10*320)+4),>(TMP_BUF+(10*320)+5),>(TMP_BUF+(10*320)+6),>(TMP_BUF+(10*320)+7)
!BYTE >(TMP_BUF+(11*320)+0),>(TMP_BUF+(11*320)+1),>(TMP_BUF+(11*320)+2),>(TMP_BUF+(11*320)+3),>(TMP_BUF+(11*320)+4),>(TMP_BUF+(11*320)+5),>(TMP_BUF+(11*320)+6),>(TMP_BUF+(11*320)+7)
!BYTE >(TMP_BUF+(12*320)+0),>(TMP_BUF+(12*320)+1),>(TMP_BUF+(12*320)+2),>(TMP_BUF+(12*320)+3),>(TMP_BUF+(12*320)+4),>(TMP_BUF+(12*320)+5),>(TMP_BUF+(12*320)+6),>(TMP_BUF+(12*320)+7)
!BYTE >(TMP_BUF+(13*320)+0),>(TMP_BUF+(13*320)+1),>(TMP_BUF+(13*320)+2),>(TMP_BUF+(13*320)+3),>(TMP_BUF+(13*320)+4),>(TMP_BUF+(13*320)+5),>(TMP_BUF+(13*320)+6),>(TMP_BUF+(13*320)+7)
!BYTE >(TMP_BUF+(14*320)+0),>(TMP_BUF+(14*320)+1),>(TMP_BUF+(14*320)+2),>(TMP_BUF+(14*320)+3),>(TMP_BUF+(14*320)+4),>(TMP_BUF+(14*320)+5),>(TMP_BUF+(14*320)+6),>(TMP_BUF+(14*320)+7)
!BYTE >(TMP_BUF+(15*320)+0),>(TMP_BUF+(15*320)+1),>(TMP_BUF+(15*320)+2),>(TMP_BUF+(15*320)+3),>(TMP_BUF+(15*320)+4),>(TMP_BUF+(15*320)+5),>(TMP_BUF+(15*320)+6),>(TMP_BUF+(15*320)+7)
!BYTE >(TMP_BUF+(16*320)+0),>(TMP_BUF+(16*320)+1),>(TMP_BUF+(16*320)+2),>(TMP_BUF+(16*320)+3),>(TMP_BUF+(16*320)+4),>(TMP_BUF+(16*320)+5),>(TMP_BUF+(16*320)+6),>(TMP_BUF+(16*320)+7)
!BYTE >(TMP_BUF+(17*320)+0),>(TMP_BUF+(17*320)+1),>(TMP_BUF+(17*320)+2),>(TMP_BUF+(17*320)+3),>(TMP_BUF+(17*320)+4),>(TMP_BUF+(17*320)+5),>(TMP_BUF+(17*320)+6),>(TMP_BUF+(17*320)+7)
!BYTE >(TMP_BUF+(18*320)+0),>(TMP_BUF+(18*320)+1),>(TMP_BUF+(18*320)+2),>(TMP_BUF+(18*320)+3),>(TMP_BUF+(18*320)+4),>(TMP_BUF+(18*320)+5),>(TMP_BUF+(18*320)+6),>(TMP_BUF+(18*320)+7)
!BYTE >(TMP_BUF+(19*320)+0),>(TMP_BUF+(19*320)+1),>(TMP_BUF+(19*320)+2),>(TMP_BUF+(19*320)+3),>(TMP_BUF+(19*320)+4),>(TMP_BUF+(19*320)+5),>(TMP_BUF+(19*320)+6),>(TMP_BUF+(19*320)+7)
!BYTE >(TMP_BUF+(20*320)+0),>(TMP_BUF+(20*320)+1),>(TMP_BUF+(20*320)+2),>(TMP_BUF+(20*320)+3),>(TMP_BUF+(20*320)+4),>(TMP_BUF+(20*320)+5),>(TMP_BUF+(20*320)+6),>(TMP_BUF+(20*320)+7)
!BYTE >(TMP_BUF+(21*320)+0),>(TMP_BUF+(21*320)+1),>(TMP_BUF+(21*320)+2),>(TMP_BUF+(21*320)+3),>(TMP_BUF+(21*320)+4),>(TMP_BUF+(21*320)+5),>(TMP_BUF+(21*320)+6),>(TMP_BUF+(21*320)+7)
!BYTE >(TMP_BUF+(22*320)+0),>(TMP_BUF+(22*320)+1),>(TMP_BUF+(22*320)+2),>(TMP_BUF+(22*320)+3),>(TMP_BUF+(22*320)+4),>(TMP_BUF+(22*320)+5),>(TMP_BUF+(22*320)+6),>(TMP_BUF+(22*320)+7)
!BYTE >(TMP_BUF+(23*320)+0),>(TMP_BUF+(23*320)+1),>(TMP_BUF+(23*320)+2),>(TMP_BUF+(23*320)+3),>(TMP_BUF+(23*320)+4),>(TMP_BUF+(23*320)+5),>(TMP_BUF+(23*320)+6),>(TMP_BUF+(23*320)+7)
!BYTE >(TMP_BUF+(24*320)+0),>(TMP_BUF+(24*320)+1),>(TMP_BUF+(24*320)+2),>(TMP_BUF+(24*320)+3),>(TMP_BUF+(24*320)+4),>(TMP_BUF+(24*320)+5),>(TMP_BUF+(24*320)+6),>(TMP_BUF+(24*320)+7)

; SPR_SIZE !BYTE
;SPR_SIZE_TAB_LO !BYTE <SB_TB_1 ;,<SB_TB_2,<SB_TB_3,<SB_TB_4,<SB_TB_5
;SPR_SIZE_TAB_HI !BYTE >SB_TB_1 ;,>SB_TB_2,>SB_TB_3,>SB_TB_4,>SB_TB_5

SPR00_AND_LO !BYTE <(SPR00_AND_0-8),<(SPR00_AND_1-8),<(SPR00_AND_2-8),<(SPR00_AND_3-8) ; todo - needs to be -8 - done
SPR00_AND_HI !BYTE >(SPR00_AND_0-8),>(SPR00_AND_2-8),>(SPR00_AND_2-8),>(SPR00_AND_3-8) ; todo - needs to be -8 - done
SPR00_ORA_LO !BYTE <(SPR00_ORA_0-8),<(SPR00_ORA_1-8),<(SPR00_ORA_2-8),<(SPR00_ORA_3-8) ; todo - needs to be -8 - done
SPR00_ORA_HI !BYTE >(SPR00_ORA_0-8),>(SPR00_ORA_2-8),>(SPR00_ORA_2-8),>(SPR00_ORA_3-8) ; todo - needs to be -8 - done

SPR00_AND_0
 !BYTE %11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111 ; todo - needs to be last first - done
 !BYTE %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; todo - needs to be last first - done
SPR00_AND_1
 !BYTE %00111111,%00111111,%00111111,%00111111,%00111111,%00111111,%00111111,%00111111 ; todo - needs to be last first - done
 !BYTE %11000000,%11000000,%11000000,%11000000,%11000000,%11000000,%11000000,%11000000 ; todo - needs to be last first - done
SPR00_AND_2
 !BYTE %00001111,%00001111,%00001111,%00001111,%00001111,%00001111,%00001111,%00001111 ; todo - needs to be last first - done
 !BYTE %11110000,%11110000,%11110000,%11110000,%11110000,%11110000,%11110000,%11110000 ; todo - needs to be last first - done
SPR00_AND_3
 !BYTE %00000011,%00000011,%00000011,%00000011,%00000011,%00000011,%00000011,%00000011 ; todo - needs to be last first - done
 !BYTE %11111100,%11111100,%11111100,%11111100,%11111100,%11111100,%11111100,%11111100 ; todo - needs to be last first - done

SPR00_ORA_0
 !BYTE %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; todo - needs to be last first - done
 !BYTE %11111111,%11011011,%11100111,%11011011,%11100111,%11011011,%11100111,%11111111 ; todo - needs to be last first - done
SPR00_ORA_1
 !BYTE %11000000,%11000000,%11000000,%11000000,%11000000,%11000000,%11000000,%11000000 ; todo - needs to be last first - done
 !BYTE %00111111,%00110110,%00111001,%00110110,%00111001,%00110110,%00111001,%00111111 ; todo - needs to be last first - done
SPR00_ORA_2
 !BYTE %11110000,%10110000,%01110000,%10110000,%01110000,%10110000,%01110000,%11110000 ; todo - needs to be last first - done
 !BYTE %00001111,%00001101,%00001110,%00001101,%00001110,%00001101,%00001110,%00001111 ; todo - needs to be last first - done
SPR00_ORA_3
 !BYTE %11111100,%01101100,%10011100,%01101100,%10011100,%01101100,%10011100,%11111100 ; todo - needs to be last first - done
 !BYTE %00000011,%00000011,%00000011,%00000011,%00000011,%00000011,%00000011,%00000011 ; todo - needs to be last first - done
 
SCN_BUF = 41984 ; 41 *1024
;!FILL 200*32,$A5

TMP_BUF = 57344 ; $e000 ; 57344
