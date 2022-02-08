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

; background screen 192*256 - done
; buffer screen 192*256 - needed

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

SRCTP = SCR +2
SRCBT = SRCTP +2

SRC01 = SRCBT +2
SRC02 = SRC01 +2
SRC03 = SRC02 +2
SRC04 = SRC03 +2
SRC05 = SRC04 +2
SRC06 = SRC05 +2
SRC07 = SRC06 +2
SRC08 = SRC07 +2
SRC09 = SRC08 +2
SRC10 = SRC09 +2
SRC11 = SRC10 +2
SRC12 = SRC11 +2
SRC13 = SRC12 +2

SRC14 = SRC13 +2
SRC15 = SRC14 +2
SRC16 = SRC15 +2
SRC17 = SRC16 +2
SRC18 = SRC17 +2
SRC19 = SRC18 +2
SRC20 = SRC19 +2
SRC21 = SRC20 +2
SRC22 = SRC21 +2
SRC23 = SRC22 +2

SRC24 = SRC23 +2
SRC25 = SRC24 +2
SRC26 = SRC25 +2
SRC27 = SRC26 +2
SRC28 = SRC27 +2
SRC29 = SRC28 +2
SRC30 = SRC29 +2
SRC31 = SRC30 +2
SRC32 = SRC31 +2
SRC33 = SRC32 +2
SRC34 = SRC33 +2
SRC35 = SRC34 +2
SRC36 = SRC35 +2
SRC37 = SRC36 +2
SRC38 = SRC37 +2
SRC39 = SRC38 +2
SRC40 = SRC39 +2

DSTTP = SRC40 +2
DSTBT = DSTTP +2

DST01 = DSTBT +2
DST02 = DST01 +2
DST03 = DST02 +2
DST04 = DST03 +2
DST05 = DST04 +2
DST06 = DST05 +2
DST07 = DST06 +2
DST08 = DST07 +2
DST09 = DST08 +2
DST10 = DST09 +2
DST11 = DST10 +2
DST12 = DST11 +2
DST13 = DST12 +2

DST14 = DST13 +2
DST15 = DST14 +2
DST16 = DST15 +2
DST17 = DST16 +2
DST18 = DST17 +2
DST19 = DST18 +2
DST20 = DST19 +2
DST21 = DST20 +2
DST22 = DST21 +2
DST23 = DST22 +2

DST24 = DST23 +2
DST25 = DST24 +2
DST26 = DST25 +2
DST27 = DST26 +2
DST28 = DST27 +2
DST29 = DST28 +2
DST30 = DST29 +2
DST31 = DST30 +2
DST32 = DST31 +2
DST33 = DST32 +2
DST34 = DST33 +2
DST35 = DST34 +2
DST36 = DST35 +2
DST37 = DST36 +2
DST38 = DST37 +2
DST39 = DST38 +2
DST40 = DST39 +2

SPA01 = DST40 +2
SPA02 = SPA01 +2
SPA03 = SPA02 +2
SPA04 = SPA03 +2
SPA05 = SPA04 +2
SPA06 = SPA05 +2
SPA07 = SPA06 +2
SPA08 = SPA07 +2
SPA09 = SPA08 +2
SPA10 = SPA09 +2
SPA11 = SPA10 +2
SPA12 = SPA11 +2
SPA13 = SPA12 +2
SPA14 = SPA13 +2
SPA15 = SPA14 +2
SPA16 = SPA15 +2
SPA17 = SPA16 +2
SPA18 = SPA17 +2
SPA19 = SPA18 +2
SPA20 = SPA19 +2
SPA21 = SPA20 +2
SPA22 = SPA21 +2
SPA23 = SPA22 +2
SPA24 = SPA23 +2
SPA25 = SPA24 +2
SPA26 = SPA25 +2
SPA27 = SPA26 +2
SPA28 = SPA27 +2
SPA29 = SPA28 +2
SPA30 = SPA29 +2
SPA31 = SPA30 +2
SPA32 = SPA31 +2
SPA33 = SPA32 +2
SPA34 = SPA33 +2
SPA35 = SPA34 +2
SPA36 = SPA35 +2
SPA37 = SPA36 +2
SPA38 = SPA37 +2
SPA39 = SPA38 +2
SPA40 = SPA39 +2

SPO01 = DST01
SPO02 = SPO01 +2
SPO03 = SPO02 +2
SPO04 = SPO03 +2
SPO05 = SPO04 +2
SPO06 = SPO05 +2
SPO07 = SPO06 +2
SPO08 = SPO07 +2
SPO09 = SPO08 +2
SPO10 = SPO09 +2
SPO11 = SPO10 +2
SPO12 = SPO11 +2
SPO13 = SPO12 +2
SPO14 = SPO13 +2
SPO15 = SPO14 +2
SPO16 = SPO15 +2
SPO17 = SPO16 +2
SPO18 = SPO17 +2
SPO19 = SPO18 +2
SPO20 = SPO19 +2
SPO21 = SPO20 +2
SPO22 = SPO21 +2
SPO23 = SPO22 +2
SPO24 = SPO23 +2
SPO25 = SPO24 +2
SPO26 = SPO25 +2
SPO27 = SPO26 +2
SPO28 = SPO27 +2
SPO29 = SPO28 +2
SPO30 = SPO29 +2
SPO31 = SPO30 +2
SPO32 = SPO31 +2
SPO33 = SPO32 +2
SPO34 = SPO33 +2
SPO35 = SPO34 +2
SPO36 = SPO35 +2
SPO37 = SPO36 +2
SPO38 = SPO37 +2
SPO39 = SPO38 +2
SPO40 = SPO39 +2

AND_LO_LO = SRCTP
AND_LO_HI = AND_LO_LO +1
AND_HI_LO = SRCBT
AND_HI_HI = AND_HI_LO +1
ORA_LO_LO = DSTTP
ORA_LO_HI = ORA_LO_LO +1
ORA_HI_LO = DSTBT
ORA_HI_HI = ORA_HI_LO +1

SPR_AND = SRCTP
SPR_ORA = SRCBT

TX = SPA40 +2
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
 JSR SB_TB_1
  
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
 LDA SPR_AND
 SEC
 SBC SCR_TAB3,X
 BCS .T1
  DEC SPR_AND +1
.T1
 STA SPR_AND
 LDA SPR_ORA
 SEC
 SBC SCR_TAB3,X
 BCS .T2
  DEC SPR_ORA +1
.T2
 STA SPR_ORA

 ; +SHIFT_AND_OR SPR_AND, SPR_AND +1, 
 
 LDX TX
 LDY TY
 LDA #1
 JSR SP_SN_1

 LDX TX
 LDY TY
 LDA #1
 JSR TB_SN_1 ; TB_SN_16 ; TB_SN_24 ; TB_SN_32

 LDX TX
 LDY TY 
; JSR BLINK

 LDA TX
 CLC
 ADC #3
 TAX
 LDY TY 
; JSR BLINK

 LDX TX
 LDA TY
 CLC
 ADC #7
 TAY
; JSR BLINK

 LDA TX
 CLC
 ADC #3
 TAX
 LDA TY
 CLC
 ADC #7
 TAY
; JSR BLINK

 LDA TX
 CLC
 ADC #2
 TAX
 LDA TY
 CLC
 ADC #3
 TAY
; JSR BLINK
 
JMP MLOOP ; we better don't RTS, the ROMS are now switched off, there's no way back to the system

;PX !BYTE 32
;PY !BYTE 32
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
                      ;

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

PLOT:
 LDA SC_LO,Y
 STA SCR 
 LDA SC_HI,Y 
 STA SCR+1 
 LDY SCR_TAB3,X
 LDA (SCR),Y
 AND SCR_AND_TAB,X
 ORA SCR_OR_TAB,X
 STA (SCR),Y 
RTS

BLINK:
 INC BLINK_CNT+1
BLINK_CNT:
 LDA #0
 LSR
 BCC PLOT11 

PLOT00:
 LDA SC_LO,Y
 STA SCR 
 LDA SC_HI,Y 
 STA SCR+1 
 LDY SCR_TAB3,X
 LDA (SCR),Y
 AND SCR_AND_TAB,X
 STA (SCR),Y 
RTS

PLOT11:
 LDA SC_LO,Y
 STA SCR 
 LDA SC_HI,Y 
 STA SCR+1 
 LDY SCR_TAB3,X
 LDA (SCR),Y
 ORA SCR_OR_TAB,X
 STA (SCR),Y 
RTS


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
 LDA SB_LO,Y
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


!MACRO BUF_TMP SRC, DST, VAL {
 LDA SB_LO+VAL,Y
 STA SRC
 LDA SB_HI+VAL,Y 
 STA SRC+1
 LDA TB_LO+VAL,Y
 STA DST
 LDA TB_HI+VAL,Y 
 STA DST+1
}



!MACRO TMP_SCR SRC, DST, VAL {
 LDA TB_LO+VAL,Y
 STA SRC
 LDA TB_HI+VAL,Y 
 STA SRC+1
 LDA SC_LO+VAL,Y
 STA DST
 LDA SC_HI+VAL,Y 
 STA DST+1
}


!ZONE SRC_DST_5
SRC_DST_5:

.LOOP

  LDA (SRCBT),Y
  STA (DSTBT),Y
  
  LDA (SRC40),Y
  STA (DST40),Y
  LDA (SRC39),Y
  STA (DST39),Y
  LDA (SRC38),Y
  STA (DST38),Y
  LDA (SRC37),Y
  STA (DST37),Y
  LDA (SRC36),Y
  STA (DST36),Y
  LDA (SRC35),Y
  STA (DST35),Y
  LDA (SRC34),Y
  STA (DST34),Y

;TMP_SCR_4:
  LDA (SRC33),Y 
  STA (DST33),Y

  LDA (SRC32),Y 
  STA (DST32),Y
  LDA (SRC31),Y 
  STA (DST31),Y
  LDA (SRC30),Y 
  STA (DST30),Y
  LDA (SRC29),Y 
  STA (DST29),Y
  LDA (SRC28),Y 
  STA (DST28),Y
  LDA (SRC27),Y 
  STA (DST27),Y
  LDA (SRC26),Y 
  STA (DST26),Y
  
;TMP_SCR_3:
  LDA (SRC25),Y
  STA (DST25),Y

  LDA (SRC24),Y 
  STA (DST24),Y
  LDA (SRC23),Y 
  STA (DST23),Y
  LDA (SRC22),Y 
  STA (DST22),Y
  LDA (SRC21),Y 
  STA (DST21),Y
  LDA (SRC20),Y 
  STA (DST20),Y
  LDA (SRC19),Y 
  STA (DST19),Y
  LDA (SRC18),Y 
  STA (DST18),Y
  
;TMP_SCR_2:
  LDA (SRC17),Y
  STA (DST17),Y

  LDA (SRC16),Y
  STA (DST16),Y
  LDA (SRC15),Y
  STA (DST15),Y
  LDA (SRC14),Y
  STA (DST14),Y
  LDA (SRC13),Y
  STA (DST13),Y
  LDA (SRC12),Y
  STA (DST12),Y
  LDA (SRC11),Y
  STA (DST11),Y
  LDA (SRC10),Y
  STA (DST10),Y
  
;TMP_SCR_1:
  LDA (SRC09),Y
  STA (DST09),Y

  LDA (SRC08),Y
  STA (DST08),Y
  LDA (SRC07),Y
  STA (DST07),Y
  LDA (SRC06),Y
  STA (DST06),Y
  LDA (SRC05),Y
  STA (DST05),Y
  LDA (SRC04),Y
  STA (DST04),Y
  LDA (SRC03),Y
  STA (DST03),Y
  LDA (SRC02),Y
  STA (DST02),Y
  LDA (SRC01),Y
  STA (DST01),Y

  LDA (SRCTP),Y 
  STA (DSTTP),Y
 
 DEX
 BMI .EXIT
  
 TYA
 ADC #8
 TAY

 JMP .LOOP

.EXIT
 DEC $D020
RTS

!ZONE SRC_DST_4
SRC_DST_4:

.LOOP

  LDA (SRC33),Y 
  STA (DST33),Y

  LDA (SRC32),Y 
  STA (DST32),Y
  LDA (SRC31),Y 
  STA (DST31),Y
  LDA (SRC30),Y 
  STA (DST30),Y
  LDA (SRC29),Y 
  STA (DST29),Y
  LDA (SRC28),Y 
  STA (DST28),Y
  LDA (SRC27),Y 
  STA (DST27),Y
  LDA (SRC26),Y 
  STA (DST26),Y
  
;TMP_SCR_3:
  LDA (SRC25),Y
  STA (DST25),Y

  LDA (SRC24),Y 
  STA (DST24),Y
  LDA (SRC23),Y 
  STA (DST23),Y
  LDA (SRC22),Y 
  STA (DST22),Y
  LDA (SRC21),Y 
  STA (DST21),Y
  LDA (SRC20),Y 
  STA (DST20),Y
  LDA (SRC19),Y 
  STA (DST19),Y
  LDA (SRC18),Y 
  STA (DST18),Y
  
;TMP_SCR_2:
  LDA (SRC17),Y
  STA (DST17),Y

  LDA (SRC16),Y
  STA (DST16),Y
  LDA (SRC15),Y
  STA (DST15),Y
  LDA (SRC14),Y
  STA (DST14),Y
  LDA (SRC13),Y
  STA (DST13),Y
  LDA (SRC12),Y
  STA (DST12),Y
  LDA (SRC11),Y
  STA (DST11),Y
  LDA (SRC10),Y
  STA (DST10),Y
  
;TMP_SCR_1:
  LDA (SRC09),Y
  STA (DST09),Y

  LDA (SRC08),Y
  STA (DST08),Y
  LDA (SRC07),Y
  STA (DST07),Y
  LDA (SRC06),Y
  STA (DST06),Y
  LDA (SRC05),Y
  STA (DST05),Y
  LDA (SRC04),Y
  STA (DST04),Y
  LDA (SRC03),Y
  STA (DST03),Y
  LDA (SRC02),Y
  STA (DST02),Y
  LDA (SRC01),Y
  STA (DST01),Y

  LDA (SRCTP),Y 
  STA (DSTTP),Y
 
 DEX
 BMI .EXIT
  
 TYA
 ADC #8
 TAY

 JMP .LOOP

.EXIT
 DEC $D020
RTS
  
!ZONE SRC_DST_3
SRC_DST_3:

.LOOP

  LDA (SRC25),Y
  STA (DST25),Y

  LDA (SRC24),Y 
  STA (DST24),Y
  LDA (SRC23),Y 
  STA (DST23),Y
  LDA (SRC22),Y 
  STA (DST22),Y
  LDA (SRC21),Y 
  STA (DST21),Y
  LDA (SRC20),Y 
  STA (DST20),Y
  LDA (SRC19),Y 
  STA (DST19),Y
  LDA (SRC18),Y 
  STA (DST18),Y
  
;TMP_SCR_2:
  LDA (SRC17),Y
  STA (DST17),Y

  LDA (SRC16),Y
  STA (DST16),Y
  LDA (SRC15),Y
  STA (DST15),Y
  LDA (SRC14),Y
  STA (DST14),Y
  LDA (SRC13),Y
  STA (DST13),Y
  LDA (SRC12),Y
  STA (DST12),Y
  LDA (SRC11),Y
  STA (DST11),Y
  LDA (SRC10),Y
  STA (DST10),Y
  
;TMP_SCR_1:
  LDA (SRC09),Y
  STA (DST09),Y

  LDA (SRC08),Y
  STA (DST08),Y
  LDA (SRC07),Y
  STA (DST07),Y
  LDA (SRC06),Y
  STA (DST06),Y
  LDA (SRC05),Y
  STA (DST05),Y
  LDA (SRC04),Y
  STA (DST04),Y
  LDA (SRC03),Y
  STA (DST03),Y
  LDA (SRC02),Y
  STA (DST02),Y
  LDA (SRC01),Y
  STA (DST01),Y

  LDA (SRCTP),Y 
  STA (DSTTP),Y
 
 TYA
 ADC #8
 TAY

 DEX
 BPL .LOOP

 DEC $D020
RTS
  
!ZONE SRC_DST_2
SRC_DST_2:

.LOOP

  LDA (SRC17),Y
  STA (DST17),Y

  LDA (SRC16),Y
  STA (DST16),Y
  LDA (SRC15),Y
  STA (DST15),Y
  LDA (SRC14),Y
  STA (DST14),Y
  LDA (SRC13),Y
  STA (DST13),Y
  LDA (SRC12),Y
  STA (DST12),Y
  LDA (SRC11),Y
  STA (DST11),Y
  LDA (SRC10),Y
  STA (DST10),Y
  
;TMP_SCR_1:
  LDA (SRC09),Y
  STA (DST09),Y

  LDA (SRC08),Y
  STA (DST08),Y
  LDA (SRC07),Y
  STA (DST07),Y
  LDA (SRC06),Y
  STA (DST06),Y
  LDA (SRC05),Y
  STA (DST05),Y
  LDA (SRC04),Y
  STA (DST04),Y
  LDA (SRC03),Y
  STA (DST03),Y
  LDA (SRC02),Y
  STA (DST02),Y
  LDA (SRC01),Y
  STA (DST01),Y

  LDA (SRCTP),Y 
  STA (DSTTP),Y
 
 TYA
 ADC #8
 TAY

 DEX
 BPL .LOOP

 DEC $D020
RTS
  
!ZONE SRC_DST_1
SRC_DST_1:

.LOOP

  LDA (SRC09),Y
  STA (DST09),Y

  LDA (SRC08),Y
  STA (DST08),Y
  LDA (SRC07),Y
  STA (DST07),Y
  LDA (SRC06),Y
  STA (DST06),Y
  LDA (SRC05),Y
  STA (DST05),Y
  LDA (SRC04),Y
  STA (DST04),Y
  LDA (SRC03),Y
  STA (DST03),Y
  LDA (SRC02),Y
  STA (DST02),Y
  LDA (SRC01),Y
  STA (DST01),Y

  LDA (SRCTP),Y 
  STA (DSTTP),Y
 
 TYA
 ADC #8
 TAY

 DEX
 BPL .LOOP

 DEC $D020
RTS


TB_SN_1
 INC $D020

 STA SPR_CNT
 
 LDA #<SRC_DST_1
 STA TMP_SCR_EXIT+1
 LDA #>SRC_DST_1
 STA TMP_SCR_EXIT+2
 JMP TMP_SCR_1

SB_TB_1
 INC $D020

 STA SPR_CNT
 
 LDA #<SRC_DST_1
 STA BUF_TMP_EXIT+1
 LDA #>SRC_DST_1
 STA BUF_TMP_EXIT+2
 JMP BUF_TMP_1
 
TB_SN_2
 INC $D020

 STA SPR_CNT
 
 LDA #<SRC_DST_2
 STA TMP_SCR_EXIT+1
 LDA #>SRC_DST_2
 STA TMP_SCR_EXIT+2
 JMP TMP_SCR_2

SB_TB_2
 INC $D020

 STA SPR_CNT
 
 LDA #<SRC_DST_2
 STA BUF_TMP_EXIT+1
 LDA #>SRC_DST_2
 STA BUF_TMP_EXIT+2
 JMP BUF_TMP_2

TB_SN_3
 INC $D020

 STA SPR_CNT
 
 LDA #<SRC_DST_3
 STA TMP_SCR_EXIT+1
 LDA #>SRC_DST_3
 STA TMP_SCR_EXIT+2
 JMP TMP_SCR_3

SB_TB_3
 INC $D020

 STA SPR_CNT
 
 LDA #<SRC_DST_3
 STA BUF_TMP_EXIT+1
 LDA #>SRC_DST_3
 STA BUF_TMP_EXIT+2
 JMP BUF_TMP_3

TB_SN_4
 INC $D020

 STA SPR_CNT
 
 LDA #<SRC_DST_4
 STA TMP_SCR_EXIT+1
 LDA #>SRC_DST_4
 STA TMP_SCR_EXIT+2
 JMP TMP_SCR_4

SB_TB_4
 INC $D020

 STA SPR_CNT
 
 LDA #<SRC_DST_4
 STA BUF_TMP_EXIT+1
 LDA #>SRC_DST_4
 STA BUF_TMP_EXIT+2
 JMP BUF_TMP_4
 
TB_SN_5
 INC $D020

 STA SPR_CNT
 
 LDA #<SRC_DST_5
 STA TMP_SCR_EXIT+1
 LDA #>SRC_DST_5
 STA TMP_SCR_EXIT+2
; JMP TMP_SCR_5

TMP_SCR_5:
  +TMP_SCR SRCBT, DSTBT, 40
  
  +TMP_SCR SRC40, DST40, 39
  +TMP_SCR SRC39, DST39, 38
  +TMP_SCR SRC38, DST38, 37
  +TMP_SCR SRC37, DST37, 36
  +TMP_SCR SRC36, DST36, 35
  +TMP_SCR SRC35, DST35, 34
  +TMP_SCR SRC34, DST34, 33

TMP_SCR_4:
  +TMP_SCR SRC33, DST33, 32

  +TMP_SCR SRC32, DST32, 31
  +TMP_SCR SRC31, DST31, 30
  +TMP_SCR SRC30, DST30, 29
  +TMP_SCR SRC29, DST29, 28
  +TMP_SCR SRC28, DST28, 27
  +TMP_SCR SRC27, DST27, 26
  +TMP_SCR SRC26, DST26, 25
  
TMP_SCR_3:
  +TMP_SCR SRC25, DST25, 24

  +TMP_SCR SRC24, DST24, 23
  +TMP_SCR SRC23, DST23, 22
  +TMP_SCR SRC22, DST22, 21
  +TMP_SCR SRC21, DST21, 20
  +TMP_SCR SRC20, DST20, 19
  +TMP_SCR SRC19, DST19, 18
  +TMP_SCR SRC18, DST18, 17
  
TMP_SCR_2:
  +TMP_SCR SRC17, DST17, 16

  +TMP_SCR SRC16, DST16, 15
  +TMP_SCR SRC15, DST15, 14
  +TMP_SCR SRC14, DST14, 13
  +TMP_SCR SRC13, DST13, 12
  +TMP_SCR SRC12, DST12, 11
  +TMP_SCR SRC11, DST11, 10
  +TMP_SCR SRC10, DST10, 9
  
TMP_SCR_1:
  +TMP_SCR SRC09, DST09, 8

  +TMP_SCR SRC08, DST08, 7
  +TMP_SCR SRC07, DST07, 6
  +TMP_SCR SRC06, DST06, 5
  +TMP_SCR SRC05, DST05, 4
  +TMP_SCR SRC04, DST04, 3
  +TMP_SCR SRC03, DST03, 2
  +TMP_SCR SRC02, DST02, 1
  +TMP_SCR SRC01, DST01, 0

  +TMP_SCR SRCTP, DSTTP, -1

 LDY SCR_TAB3-4,X
 LDX SPR_CNT
 INX
 CLC

TMP_SCR_EXIT:
  JMP $ABCD

SB_TB_5
 INC $D020

 STA SPR_CNT
 
 LDA #<SRC_DST_5
 STA BUF_TMP_EXIT+1
 LDA #>SRC_DST_5
 STA BUF_TMP_EXIT+2
; JMP BUF_TMP_5

BUF_TMP_5:
  +BUF_TMP SRCBT, DSTBT, 40
  
  +BUF_TMP SRC40, DST40, 39
  +BUF_TMP SRC39, DST39, 38
  +BUF_TMP SRC38, DST38, 37
  +BUF_TMP SRC37, DST37, 36
  +BUF_TMP SRC36, DST36, 35
  +BUF_TMP SRC35, DST35, 34
  +BUF_TMP SRC34, DST34, 33

BUF_TMP_4:
  +BUF_TMP SRC33, DST33, 32

  +BUF_TMP SRC32, DST32, 31
  +BUF_TMP SRC31, DST31, 30
  +BUF_TMP SRC30, DST30, 29
  +BUF_TMP SRC29, DST29, 28
  +BUF_TMP SRC28, DST28, 27
  +BUF_TMP SRC27, DST27, 26
  +BUF_TMP SRC26, DST26, 25
  
BUF_TMP_3:
  +BUF_TMP SRC25, DST25, 24

  +BUF_TMP SRC24, DST24, 23
  +BUF_TMP SRC23, DST23, 22
  +BUF_TMP SRC22, DST22, 21
  +BUF_TMP SRC21, DST21, 20
  +BUF_TMP SRC20, DST20, 19
  +BUF_TMP SRC19, DST19, 18
  +BUF_TMP SRC18, DST18, 17
  
BUF_TMP_2:
  +BUF_TMP SRC17, DST17, 16

  +BUF_TMP SRC16, DST16, 15
  +BUF_TMP SRC15, DST15, 14
  +BUF_TMP SRC14, DST14, 13
  +BUF_TMP SRC13, DST13, 12
  +BUF_TMP SRC12, DST12, 11
  +BUF_TMP SRC11, DST11, 10
  +BUF_TMP SRC10, DST10, 9
  
BUF_TMP_1:
  +BUF_TMP SRC09, DST09, 8

  +BUF_TMP SRC08, DST08, 7
  +BUF_TMP SRC07, DST07, 6
  +BUF_TMP SRC06, DST06, 5
  +BUF_TMP SRC05, DST05, 4
  +BUF_TMP SRC04, DST04, 3
  +BUF_TMP SRC03, DST03, 2
  +BUF_TMP SRC02, DST02, 1
  +BUF_TMP SRC01, DST01, 0

  +BUF_TMP SRCTP, DSTTP, -1

 LDY SCR_TAB3-4,X
 LDX SPR_CNT
 INX
 CLC

BUF_TMP_EXIT:
  JMP $ABCD

!MACRO SPR_SCR SRC_DST, VAL {
 LDA TB_LO+VAL,Y
 STA SRC_DST
 LDA TB_HI+VAL,Y 
 STA SRC_DST+1
}

SP_SN_1
 INC $D020
 
 STA SPR_CNT

 LDA #<SPR_1
 STA SPR_SCR_EXIT+1
 LDA #>SPR_1
 STA SPR_SCR_EXIT+2
 
 JMP SPR_SCR_1

SPR_SCR_5:
  +SPR_SCR SRC40, 39
  +SPR_SCR SRC39, 38
  +SPR_SCR SRC38, 37
  +SPR_SCR SRC37, 36
  +SPR_SCR SRC36, 35
  +SPR_SCR SRC35, 34
  +SPR_SCR SRC34, 33
  +SPR_SCR SRC33, 32
  
SPR_SCR_4:
  +SPR_SCR SRC32, 31
  +SPR_SCR SRC31, 30
  +SPR_SCR SRC30, 29
  +SPR_SCR SRC29, 28
  +SPR_SCR SRC28, 27
  +SPR_SCR SRC27, 26
  +SPR_SCR SRC26, 25
  +SPR_SCR SRC25, 24
  
SPR_SCR_3:
  +SPR_SCR SRC24, 23
  +SPR_SCR SRC23, 22
  +SPR_SCR SRC22, 21
  +SPR_SCR SRC21, 20
  +SPR_SCR SRC20, 19
  +SPR_SCR SRC19, 18
  +SPR_SCR SRC18, 17
  +SPR_SCR SRC17, 16
  
SPR_SCR_2:
  +SPR_SCR SRC16, 15
  +SPR_SCR SRC15, 14
  +SPR_SCR SRC14, 13
  +SPR_SCR SRC13, 12
  +SPR_SCR SRC12, 11
  +SPR_SCR SRC11, 10
  +SPR_SCR SRC10, 9
  +SPR_SCR SRC09, 8

!ZONE SPR_SCR_1
SPR_SCR_1:
; need to set and and or 

STX BKX
STY BKY

 LDX SPR_AND
 LDY SPR_AND +1
 STX SPA01
 STY SPA01 +1
 
 INX
 BNE .A1
  INY
.A1
 STX SPA02
 STY SPA02 +1

 INX
 BNE .A2
  INY
.A2
 STX SPA03
 STY SPA03 +1
 
 INX
 BNE .A3
  INY
.A3
 STX SPA04
 STY SPA04 +1

 INX
 BNE .A4
  INY
.A4
 STX SPA05
 STY SPA05 +1
 
 INX
 BNE .A5
  INY
.A5
 STX SPA06
 STY SPA06 +1

 INX
 BNE .A6
  INY
.A6
 STX SPA07
 STY SPA07 +1

 INX
 BNE .A7
  INY
.A7
 STX SPA08
 STY SPA08 +1

LDX BKX
LDY BKY

 LDX SPR_ORA
 LDY SPR_ORA +1
 STX SPO01
 STY SPO01 +1
 
 INX
 BNE .O1
  INY
.O1
 STX SPO02
 STY SPO02 +1

 INX
 BNE .O2
  INY
.O2
 STX SPO03
 STY SPO03 +1
 
 INX
 BNE .O3
  INY
.O3
 STX SPO04
 STY SPO04 +1

 INX
 BNE .O4
  INY
.O4
 STX SPO05
 STY SPO05 +1
 
 INX
 BNE .O5
  INY
.O5
 STX SPO06
 STY SPO06 +1

 INX
 BNE .O6
  INY
.O6
 STX SPO07
 STY SPO07 +1

 INX
 BNE .O7
  INY
.O7
 STX SPO08
 STY SPO08 +1

LDX BKX
LDY BKY


  +SPR_SCR SRC08, 7
  +SPR_SCR SRC07, 6
  +SPR_SCR SRC06, 5
  +SPR_SCR SRC05, 4
  +SPR_SCR SRC04, 3
  +SPR_SCR SRC03, 2
  +SPR_SCR SRC02, 1
  +SPR_SCR SRC01, 0
  
SPR_SCR_EXIT:
  JMP $ABCD

BKX !BYTE 0
BKY !BYTE 0
  
!ZONE SPR_1
SPR_1
  
 LDY SCR_TAB3,X
 LDX SPR_CNT
 CLC

.LOOP
;      LDA (SPA01),Y
;      LDA (SPA02),Y
;      LDA (SPA03),Y
;      LDA (SPA04),Y
;      LDA (SPA05),Y
;      LDA (SPA06),Y
;      LDA (SPA07),Y
;      LDA (SPA08),Y

;      LDA (SPO01),Y ;;?
;      LDA (SPO02),Y
;      LDA (SPO03),Y
;      LDA (SPO04),Y
;      LDA (SPO05),Y
;      LDA (SPO06),Y
;      LDA (SPO07),Y
;      LDA (SPO08),Y

      LDA (SRC01),Y
      AND (SPA01),Y
      ORA (SPO01),Y
      STA (SRC01),Y

      LDA (SRC02),Y
      AND (SPA02),Y
      ORA (SPO02),Y
      STA (SRC02),Y
     
      LDA (SRC03),Y
      AND (SPA03),Y
      ORA (SPO03),Y
      STA (SRC03),Y

      LDA (SRC04),Y
      AND (SPA04),Y
      ORA (SPO04),Y
      STA (SRC04),Y

      LDA (SRC05),Y
      AND (SPA05),Y
      ORA (SPO05),Y
      STA (SRC05),Y

      LDA (SRC06),Y
      AND (SPA06),Y
      ORA (SPO06),Y
      STA (SRC06),Y

      LDA (SRC07),Y
      AND (SPA07),Y
      ORA (SPO07),Y
      STA (SRC07),Y

      LDA (SRC08),Y
      AND (SPA08),Y
      ORA (SPO08),Y
      STA (SRC08),Y

; lda $ff
; STA (SRC01),Y
; STA (SRC02),Y
; STA (SRC03),Y
; STA (SRC04),Y
; STA (SRC05),Y
; STA (SRC06),Y
; STA (SRC07),Y
; STA (SRC08),Y

 TYA
 ADC #8
 TAY

 DEX
 BPL .LOOP

 DEC $D020

RTS

!ZONE SPR_2
SPR_2
  
 LDY SCR_TAB3-4,X
 LDX SPR_CNT
 INX
 CLC

.LOOP
      LDA (SRC01),Y
      AND (SPA01),Y
      ORA (SPO01),Y
      STA (SRC01),Y

      LDA (SRC02),Y
      AND (SPA02),Y
      ORA (SPO02),Y
      STA (SRC02),Y
     
      LDA (SRC03),Y
      AND (SPA03),Y
      ORA (SPO03),Y
      STA (SRC03),Y

      LDA (SRC04),Y
      AND (SPA04),Y
      ORA (SPO04),Y
      STA (SRC04),Y

      LDA (SRC05),Y
      AND (SPA05),Y
      ORA (SPO05),Y
      STA (SRC05),Y

      LDA (SRC06),Y
      AND (SPA06),Y
      ORA (SPO06),Y
      STA (SRC06),Y

      LDA (SRC07),Y
      AND (SPA07),Y
      ORA (SPO07),Y
      STA (SRC07),Y

      LDA (SRC08),Y
      AND (SPA08),Y
      ORA (SPO08),Y
      STA (SRC08),Y
  
      LDA (SRC09),Y
      AND (SPA09),Y
      ORA (SPO09),Y
      STA (SRC09),Y

      LDA (SRC10),Y
      AND (SPA10),Y
      ORA (SPO10),Y
      STA (SRC10),Y
     
      LDA (SRC11),Y
      AND (SPA11),Y
      ORA (SPO11),Y
      STA (SRC11),Y

      LDA (SRC12),Y
      AND (SPA12),Y
      ORA (SPO12),Y
      STA (SRC12),Y

      LDA (SRC13),Y
      AND (SPA13),Y
      ORA (SPO13),Y
      STA (SRC13),Y

      LDA (SRC14),Y
      AND (SPA14),Y
      ORA (SPO14),Y
      STA (SRC14),Y

      LDA (SRC15),Y
      AND (SPA15),Y
      ORA (SPO15),Y
      STA (SRC15),Y

      LDA (SRC16),Y
      AND (SPA16),Y
      ORA (SPO16),Y
      STA (SRC16),Y
  
 DEX
 BMI .EXIT

 TYA
 ADC #4
 TAY

 JMP .LOOP
.EXIT:
 INC $D020

RTS

!ZONE SPR_3
SPR_3
  
 LDY SCR_TAB3-4,X
 LDX SPR_CNT
 INX
 CLC

.LOOP
      LDA (SRC01),Y
      AND (SPA01),Y
      ORA (SPO01),Y
      STA (SRC01),Y

      LDA (SRC02),Y
      AND (SPA02),Y
      ORA (SPO02),Y
      STA (SRC02),Y
     
      LDA (SRC03),Y
      AND (SPA03),Y
      ORA (SPO03),Y
      STA (SRC03),Y

      LDA (SRC04),Y
      AND (SPA04),Y
      ORA (SPO04),Y
      STA (SRC04),Y

      LDA (SRC05),Y
      AND (SPA05),Y
      ORA (SPO05),Y
      STA (SRC05),Y

      LDA (SRC06),Y
      AND (SPA06),Y
      ORA (SPO06),Y
      STA (SRC06),Y

      LDA (SRC07),Y
      AND (SPA07),Y
      ORA (SPO07),Y
      STA (SRC07),Y

      LDA (SRC08),Y
      AND (SPA08),Y
      ORA (SPO08),Y
      STA (SRC08),Y
  
      LDA (SRC09),Y
      AND (SPA09),Y
      ORA (SPO09),Y
      STA (SRC09),Y

      LDA (SRC10),Y
      AND (SPA10),Y
      ORA (SPO10),Y
      STA (SRC10),Y
     
      LDA (SRC11),Y
      AND (SPA11),Y
      ORA (SPO11),Y
      STA (SRC11),Y

      LDA (SRC12),Y
      AND (SPA12),Y
      ORA (SPO12),Y
      STA (SRC12),Y

      LDA (SRC13),Y
      AND (SPA13),Y
      ORA (SPO13),Y
      STA (SRC13),Y

      LDA (SRC14),Y
      AND (SPA14),Y
      ORA (SPO14),Y
      STA (SRC14),Y

      LDA (SRC15),Y
      AND (SPA15),Y
      ORA (SPO15),Y
      STA (SRC15),Y

      LDA (SRC16),Y
      AND (SPA16),Y
      ORA (SPO16),Y
      STA (SRC16),Y

      LDA (SRC17),Y
      AND (SPA17),Y
      ORA (SPO17),Y
      STA (SRC17),Y

      LDA (SRC18),Y
      AND (SPA18),Y
      ORA (SPO18),Y
      STA (SRC18),Y

      LDA (SRC19),Y
      AND (SPA19),Y
      ORA (SPO19),Y
      STA (SRC19),Y

      LDA (SRC20),Y
      AND (SPA20),Y
      ORA (SPO20),Y
      STA (SRC20),Y

      LDA (SRC21),Y
      AND (SPA21),Y
      ORA (SPO21),Y
      STA (SRC21),Y

      LDA (SRC22),Y
      AND (SPA22),Y
      ORA (SPO22),Y
      STA (SRC22),Y

      LDA (SRC23),Y
      AND (SPA23),Y
      ORA (SPO23),Y
      STA (SRC23),Y

      LDA (SRC24),Y
      AND (SPA24),Y
      ORA (SPO24),Y
      STA (SRC24),Y
  
 DEX
 BMI .EXIT

 TYA
 ADC #4
 TAY

 JMP .LOOP
.EXIT:
 INC $D020

RTS

!ZONE SPR_4
SPR_4
  
 LDY SCR_TAB3-4,X
 LDX SPR_CNT
 INX
 CLC

.LOOP
      LDA (SRC01),Y
      AND (SPA01),Y
      ORA (SPO01),Y
      STA (SRC01),Y

      LDA (SRC02),Y
      AND (SPA02),Y
      ORA (SPO02),Y
      STA (SRC02),Y
     
      LDA (SRC03),Y
      AND (SPA03),Y
      ORA (SPO03),Y
      STA (SRC03),Y

      LDA (SRC04),Y
      AND (SPA04),Y
      ORA (SPO04),Y
      STA (SRC04),Y

      LDA (SRC05),Y
      AND (SPA05),Y
      ORA (SPO05),Y
      STA (SRC05),Y

      LDA (SRC06),Y
      AND (SPA06),Y
      ORA (SPO06),Y
      STA (SRC06),Y

      LDA (SRC07),Y
      AND (SPA07),Y
      ORA (SPO07),Y
      STA (SRC07),Y

      LDA (SRC08),Y
      AND (SPA08),Y
      ORA (SPO08),Y
      STA (SRC08),Y
  
      LDA (SRC09),Y
      AND (SPA09),Y
      ORA (SPO09),Y
      STA (SRC09),Y

      LDA (SRC10),Y
      AND (SPA10),Y
      ORA (SPO10),Y
      STA (SRC10),Y
     
      LDA (SRC11),Y
      AND (SPA11),Y
      ORA (SPO11),Y
      STA (SRC11),Y

      LDA (SRC12),Y
      AND (SPA12),Y
      ORA (SPO12),Y
      STA (SRC12),Y

      LDA (SRC13),Y
      AND (SPA13),Y
      ORA (SPO13),Y
      STA (SRC13),Y

      LDA (SRC14),Y
      AND (SPA14),Y
      ORA (SPO14),Y
      STA (SRC14),Y

      LDA (SRC15),Y
      AND (SPA15),Y
      ORA (SPO15),Y
      STA (SRC15),Y

      LDA (SRC16),Y
      AND (SPA16),Y
      ORA (SPO16),Y
      STA (SRC16),Y

      LDA (SRC17),Y
      AND (SPA17),Y
      ORA (SPO17),Y
      STA (SRC17),Y

      LDA (SRC18),Y
      AND (SPA18),Y
      ORA (SPO18),Y
      STA (SRC18),Y

      LDA (SRC19),Y
      AND (SPA19),Y
      ORA (SPO19),Y
      STA (SRC19),Y

      LDA (SRC20),Y
      AND (SPA20),Y
      ORA (SPO20),Y
      STA (SRC20),Y

      LDA (SRC21),Y
      AND (SPA21),Y
      ORA (SPO21),Y
      STA (SRC21),Y

      LDA (SRC22),Y
      AND (SPA22),Y
      ORA (SPO22),Y
      STA (SRC22),Y

      LDA (SRC23),Y
      AND (SPA23),Y
      ORA (SPO23),Y
      STA (SRC23),Y

      LDA (SRC24),Y
      AND (SPA24),Y
      ORA (SPO24),Y
      STA (SRC24),Y

      LDA (SRC25),Y
      AND (SPA25),Y
      ORA (SPO25),Y
      STA (SRC25),Y

      LDA (SRC26),Y
      AND (SPA26),Y
      ORA (SPO26),Y
      STA (SRC26),Y

      LDA (SRC27),Y
      AND (SPA27),Y
      ORA (SPO27),Y
      STA (SRC27),Y

      LDA (SRC28),Y
      AND (SPA28),Y
      ORA (SPO28),Y
      STA (SRC28),Y

      LDA (SRC29),Y
      AND (SPA29),Y
      ORA (SPO29),Y
      STA (SRC29),Y

      LDA (SRC30),Y
      AND (SPA30),Y
      ORA (SPO30),Y
      STA (SRC30),Y

      LDA (SRC31),Y
      AND (SPA31),Y
      ORA (SPO13),Y
      STA (SRC31),Y

      LDA (SRC32),Y
      AND (SPA32),Y
      ORA (SPO32),Y
      STA (SRC32),Y    
      
 DEX
 BMI .EXIT

 TYA
 ADC #4
 TAY

 JMP .LOOP
.EXIT:
 INC $D020

RTS

!ZONE SPR_5
SPR_5
  
 LDY SCR_TAB3-4,X
 LDX SPR_CNT
 INX
 CLC

.LOOP
      LDA (SRC01),Y
      AND (SPA01),Y
      ORA (SPO01),Y
      STA (SRC01),Y

      LDA (SRC02),Y
      AND (SPA02),Y
      ORA (SPO02),Y
      STA (SRC02),Y
     
      LDA (SRC03),Y
      AND (SPA03),Y
      ORA (SPO03),Y
      STA (SRC03),Y

      LDA (SRC04),Y
      AND (SPA04),Y
      ORA (SPO04),Y
      STA (SRC04),Y

      LDA (SRC05),Y
      AND (SPA05),Y
      ORA (SPO05),Y
      STA (SRC05),Y

      LDA (SRC06),Y
      AND (SPA06),Y
      ORA (SPO06),Y
      STA (SRC06),Y

      LDA (SRC07),Y
      AND (SPA07),Y
      ORA (SPO07),Y
      STA (SRC07),Y

      LDA (SRC08),Y
      AND (SPA08),Y
      ORA (SPO08),Y
      STA (SRC08),Y
  
      LDA (SRC09),Y
      AND (SPA09),Y
      ORA (SPO09),Y
      STA (SRC09),Y

      LDA (SRC10),Y
      AND (SPA10),Y
      ORA (SPO10),Y
      STA (SRC10),Y
     
      LDA (SRC11),Y
      AND (SPA11),Y
      ORA (SPO11),Y
      STA (SRC11),Y

      LDA (SRC12),Y
      AND (SPA12),Y
      ORA (SPO12),Y
      STA (SRC12),Y

      LDA (SRC13),Y
      AND (SPA13),Y
      ORA (SPO13),Y
      STA (SRC13),Y

      LDA (SRC14),Y
      AND (SPA14),Y
      ORA (SPO14),Y
      STA (SRC14),Y

      LDA (SRC15),Y
      AND (SPA15),Y
      ORA (SPO15),Y
      STA (SRC15),Y

      LDA (SRC16),Y
      AND (SPA16),Y
      ORA (SPO16),Y
      STA (SRC16),Y

      LDA (SRC17),Y
      AND (SPA17),Y
      ORA (SPO17),Y
      STA (SRC17),Y

      LDA (SRC18),Y
      AND (SPA18),Y
      ORA (SPO18),Y
      STA (SRC18),Y

      LDA (SRC19),Y
      AND (SPA19),Y
      ORA (SPO19),Y
      STA (SRC19),Y

      LDA (SRC20),Y
      AND (SPA20),Y
      ORA (SPO20),Y
      STA (SRC20),Y

      LDA (SRC21),Y
      AND (SPA21),Y
      ORA (SPO21),Y
      STA (SRC21),Y

      LDA (SRC22),Y
      AND (SPA22),Y
      ORA (SPO22),Y
      STA (SRC22),Y

      LDA (SRC23),Y
      AND (SPA23),Y
      ORA (SPO23),Y
      STA (SRC23),Y

      LDA (SRC24),Y
      AND (SPA24),Y
      ORA (SPO24),Y
      STA (SRC24),Y

      LDA (SRC25),Y
      AND (SPA25),Y
      ORA (SPO25),Y
      STA (SRC25),Y

      LDA (SRC26),Y
      AND (SPA26),Y
      ORA (SPO26),Y
      STA (SRC26),Y

      LDA (SRC27),Y
      AND (SPA27),Y
      ORA (SPO27),Y
      STA (SRC27),Y

      LDA (SRC28),Y
      AND (SPA28),Y
      ORA (SPO28),Y
      STA (SRC28),Y

      LDA (SRC29),Y
      AND (SPA29),Y
      ORA (SPO29),Y
      STA (SRC29),Y

      LDA (SRC30),Y
      AND (SPA30),Y
      ORA (SPO30),Y
      STA (SRC30),Y

      LDA (SRC31),Y
      AND (SPA31),Y
      ORA (SPO13),Y
      STA (SRC31),Y

      LDA (SRC32),Y
      AND (SPA32),Y
      ORA (SPO32),Y
      STA (SRC32),Y    

      LDA (SRC33),Y
      AND (SPA33),Y
      ORA (SPO33),Y
      STA (SRC33),Y

      LDA (SRC34),Y
      AND (SPA34),Y
      ORA (SPO34),Y
      STA (SRC34),Y

      LDA (SRC35),Y
      AND (SPA35),Y
      ORA (SPO35),Y
      STA (SRC35),Y

      LDA (SRC36),Y
      AND (SPA36),Y
      ORA (SPO36),Y
      STA (SRC36),Y

      LDA (SRC37),Y
      AND (SPA37),Y
      ORA (SPO37),Y
      STA (SRC37),Y

      LDA (SRC38),Y
      AND (SPA38),Y
      ORA (SPO38),Y
      STA (SRC38),Y

      LDA (SRC39),Y
      AND (SPA39),Y
      ORA (SPO39),Y
      STA (SRC39),Y

      LDA (SRC40),Y
      AND (SPA40),Y
      ORA (SPO40),Y
      STA (SRC40),Y
      
 DEX
 BMI .EXIT

 TYA
 ADC #4
 TAY

 JMP .LOOP
.EXIT:
 INC $D020

RTS

PATTERN
; !BYTE %00000000,%00010001,%00100010,%00110011,%01000100,%01010101,%01100110,%01110111,%10001000,%10011001,%10101010,%10111011,%11001100,%11011101,%11101110,%11111111
 
 !BYTE %00000000,%01010101,%10101010,%11111111
 !BYTE %00000000,%01010101,%10101010,%11111111
 !BYTE %00000000,%01010101,%10101010,%11111111
 !BYTE %00000000,%01010101,%10101010,%11111111
 
 
SPRITE_ORA 
 !BYTE $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0 
 !BYTE 255,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,255
 !BYTE 255,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,255
 !BYTE 255,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,255
 !BYTE $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F 

SPRITE_AND
 !BYTE 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
 !BYTE 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
 !BYTE 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
 !BYTE 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
 !BYTE 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255

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
!BYTE >(SCN_BUF+(00*256)+0),>(SCN_BUF+(00*256)+1),>(SCN_BUF+(00*256)+2),>(SCN_BUF+(00*256)+3),>(SCN_BUF+(00*256)+4),>(SCN_BUF+(00*256)+5),>(SCN_BUF+(00*256)+6),>(SCN_BUF+(00*256)+7)
!BYTE >(SCN_BUF+(01*256)+0),>(SCN_BUF+(01*256)+1),>(SCN_BUF+(01*256)+2),>(SCN_BUF+(01*256)+3),>(SCN_BUF+(01*256)+4),>(SCN_BUF+(01*256)+5),>(SCN_BUF+(01*256)+6),>(SCN_BUF+(01*256)+7)
!BYTE >(SCN_BUF+(02*256)+0),>(SCN_BUF+(02*256)+1),>(SCN_BUF+(02*256)+2),>(SCN_BUF+(02*256)+3),>(SCN_BUF+(02*256)+4),>(SCN_BUF+(02*256)+5),>(SCN_BUF+(02*256)+6),>(SCN_BUF+(02*256)+7)
!BYTE >(SCN_BUF+(03*256)+0),>(SCN_BUF+(03*256)+1),>(SCN_BUF+(03*256)+2),>(SCN_BUF+(03*256)+3),>(SCN_BUF+(03*256)+4),>(SCN_BUF+(03*256)+5),>(SCN_BUF+(03*256)+6),>(SCN_BUF+(03*256)+7)
!BYTE >(SCN_BUF+(04*256)+0),>(SCN_BUF+(04*256)+1),>(SCN_BUF+(04*256)+2),>(SCN_BUF+(04*256)+3),>(SCN_BUF+(04*256)+4),>(SCN_BUF+(04*256)+5),>(SCN_BUF+(04*256)+6),>(SCN_BUF+(04*256)+7)
!BYTE >(SCN_BUF+(05*256)+0),>(SCN_BUF+(05*256)+1),>(SCN_BUF+(05*256)+2),>(SCN_BUF+(05*256)+3),>(SCN_BUF+(05*256)+4),>(SCN_BUF+(05*256)+5),>(SCN_BUF+(05*256)+6),>(SCN_BUF+(05*256)+7)
!BYTE >(SCN_BUF+(06*256)+0),>(SCN_BUF+(06*256)+1),>(SCN_BUF+(06*256)+2),>(SCN_BUF+(06*256)+3),>(SCN_BUF+(06*256)+4),>(SCN_BUF+(06*256)+5),>(SCN_BUF+(06*256)+6),>(SCN_BUF+(06*256)+7)
!BYTE >(SCN_BUF+(07*256)+0),>(SCN_BUF+(07*256)+1),>(SCN_BUF+(07*256)+2),>(SCN_BUF+(07*256)+3),>(SCN_BUF+(07*256)+4),>(SCN_BUF+(07*256)+5),>(SCN_BUF+(07*256)+6),>(SCN_BUF+(07*256)+7)
!BYTE >(SCN_BUF+(08*256)+0),>(SCN_BUF+(08*256)+1),>(SCN_BUF+(08*256)+2),>(SCN_BUF+(08*256)+3),>(SCN_BUF+(08*256)+4),>(SCN_BUF+(08*256)+5),>(SCN_BUF+(08*256)+6),>(SCN_BUF+(08*256)+7)
!BYTE >(SCN_BUF+(09*256)+0),>(SCN_BUF+(09*256)+1),>(SCN_BUF+(09*256)+2),>(SCN_BUF+(09*256)+3),>(SCN_BUF+(09*256)+4),>(SCN_BUF+(09*256)+5),>(SCN_BUF+(09*256)+6),>(SCN_BUF+(09*256)+7)
!BYTE >(SCN_BUF+(10*256)+0),>(SCN_BUF+(10*256)+1),>(SCN_BUF+(10*256)+2),>(SCN_BUF+(10*256)+3),>(SCN_BUF+(10*256)+4),>(SCN_BUF+(10*256)+5),>(SCN_BUF+(10*256)+6),>(SCN_BUF+(10*256)+7)
!BYTE >(SCN_BUF+(11*256)+0),>(SCN_BUF+(11*256)+1),>(SCN_BUF+(11*256)+2),>(SCN_BUF+(11*256)+3),>(SCN_BUF+(11*256)+4),>(SCN_BUF+(11*256)+5),>(SCN_BUF+(11*256)+6),>(SCN_BUF+(11*256)+7)
!BYTE >(SCN_BUF+(12*256)+0),>(SCN_BUF+(12*256)+1),>(SCN_BUF+(12*256)+2),>(SCN_BUF+(12*256)+3),>(SCN_BUF+(12*256)+4),>(SCN_BUF+(12*256)+5),>(SCN_BUF+(12*256)+6),>(SCN_BUF+(12*256)+7)
!BYTE >(SCN_BUF+(13*256)+0),>(SCN_BUF+(13*256)+1),>(SCN_BUF+(13*256)+2),>(SCN_BUF+(13*256)+3),>(SCN_BUF+(13*256)+4),>(SCN_BUF+(13*256)+5),>(SCN_BUF+(13*256)+6),>(SCN_BUF+(13*256)+7)
!BYTE >(SCN_BUF+(14*256)+0),>(SCN_BUF+(14*256)+1),>(SCN_BUF+(14*256)+2),>(SCN_BUF+(14*256)+3),>(SCN_BUF+(14*256)+4),>(SCN_BUF+(14*256)+5),>(SCN_BUF+(14*256)+6),>(SCN_BUF+(14*256)+7)
!BYTE >(SCN_BUF+(15*256)+0),>(SCN_BUF+(15*256)+1),>(SCN_BUF+(15*256)+2),>(SCN_BUF+(15*256)+3),>(SCN_BUF+(15*256)+4),>(SCN_BUF+(15*256)+5),>(SCN_BUF+(15*256)+6),>(SCN_BUF+(15*256)+7)
!BYTE >(SCN_BUF+(16*256)+0),>(SCN_BUF+(16*256)+1),>(SCN_BUF+(16*256)+2),>(SCN_BUF+(16*256)+3),>(SCN_BUF+(16*256)+4),>(SCN_BUF+(16*256)+5),>(SCN_BUF+(16*256)+6),>(SCN_BUF+(16*256)+7)
!BYTE >(SCN_BUF+(17*256)+0),>(SCN_BUF+(17*256)+1),>(SCN_BUF+(17*256)+2),>(SCN_BUF+(17*256)+3),>(SCN_BUF+(17*256)+4),>(SCN_BUF+(17*256)+5),>(SCN_BUF+(17*256)+6),>(SCN_BUF+(17*256)+7)
!BYTE >(SCN_BUF+(18*256)+0),>(SCN_BUF+(18*256)+1),>(SCN_BUF+(18*256)+2),>(SCN_BUF+(18*256)+3),>(SCN_BUF+(18*256)+4),>(SCN_BUF+(18*256)+5),>(SCN_BUF+(18*256)+6),>(SCN_BUF+(18*256)+7)
!BYTE >(SCN_BUF+(19*256)+0),>(SCN_BUF+(19*256)+1),>(SCN_BUF+(19*256)+2),>(SCN_BUF+(19*256)+3),>(SCN_BUF+(19*256)+4),>(SCN_BUF+(19*256)+5),>(SCN_BUF+(19*256)+6),>(SCN_BUF+(19*256)+7)
!BYTE >(SCN_BUF+(20*256)+0),>(SCN_BUF+(20*256)+1),>(SCN_BUF+(20*256)+2),>(SCN_BUF+(20*256)+3),>(SCN_BUF+(20*256)+4),>(SCN_BUF+(20*256)+5),>(SCN_BUF+(20*256)+6),>(SCN_BUF+(20*256)+7)
!BYTE >(SCN_BUF+(21*256)+0),>(SCN_BUF+(21*256)+1),>(SCN_BUF+(21*256)+2),>(SCN_BUF+(21*256)+3),>(SCN_BUF+(21*256)+4),>(SCN_BUF+(21*256)+5),>(SCN_BUF+(21*256)+6),>(SCN_BUF+(21*256)+7)
!BYTE >(SCN_BUF+(22*256)+0),>(SCN_BUF+(22*256)+1),>(SCN_BUF+(22*256)+2),>(SCN_BUF+(22*256)+3),>(SCN_BUF+(22*256)+4),>(SCN_BUF+(22*256)+5),>(SCN_BUF+(22*256)+6),>(SCN_BUF+(22*256)+7)
!BYTE >(SCN_BUF+(23*256)+0),>(SCN_BUF+(23*256)+1),>(SCN_BUF+(23*256)+2),>(SCN_BUF+(23*256)+3),>(SCN_BUF+(23*256)+4),>(SCN_BUF+(23*256)+5),>(SCN_BUF+(23*256)+6),>(SCN_BUF+(23*256)+7)
!BYTE >(SCN_BUF+(24*256)+0),>(SCN_BUF+(24*256)+1),>(SCN_BUF+(24*256)+2),>(SCN_BUF+(24*256)+3),>(SCN_BUF+(24*256)+4),>(SCN_BUF+(24*256)+5),>(SCN_BUF+(24*256)+6),>(SCN_BUF+(24*256)+7)

SB_LO:
!BYTE <(SCN_BUF+(00*256)+0),<(SCN_BUF+(00*256)+1),<(SCN_BUF+(00*256)+2),<(SCN_BUF+(00*256)+3),<(SCN_BUF+(00*256)+4),<(SCN_BUF+(00*256)+5),<(SCN_BUF+(00*256)+6),<(SCN_BUF+(00*256)+7)
!BYTE <(SCN_BUF+(01*256)+0),<(SCN_BUF+(01*256)+1),<(SCN_BUF+(01*256)+2),<(SCN_BUF+(01*256)+3),<(SCN_BUF+(01*256)+4),<(SCN_BUF+(01*256)+5),<(SCN_BUF+(01*256)+6),<(SCN_BUF+(01*256)+7)
!BYTE <(SCN_BUF+(02*256)+0),<(SCN_BUF+(02*256)+1),<(SCN_BUF+(02*256)+2),<(SCN_BUF+(02*256)+3),<(SCN_BUF+(02*256)+4),<(SCN_BUF+(02*256)+5),<(SCN_BUF+(02*256)+6),<(SCN_BUF+(02*256)+7)
!BYTE <(SCN_BUF+(03*256)+0),<(SCN_BUF+(03*256)+1),<(SCN_BUF+(03*256)+2),<(SCN_BUF+(03*256)+3),<(SCN_BUF+(03*256)+4),<(SCN_BUF+(03*256)+5),<(SCN_BUF+(03*256)+6),<(SCN_BUF+(03*256)+7)
!BYTE <(SCN_BUF+(04*256)+0),<(SCN_BUF+(04*256)+1),<(SCN_BUF+(04*256)+2),<(SCN_BUF+(04*256)+3),<(SCN_BUF+(04*256)+4),<(SCN_BUF+(04*256)+5),<(SCN_BUF+(04*256)+6),<(SCN_BUF+(04*256)+7)
!BYTE <(SCN_BUF+(05*256)+0),<(SCN_BUF+(05*256)+1),<(SCN_BUF+(05*256)+2),<(SCN_BUF+(05*256)+3),<(SCN_BUF+(05*256)+4),<(SCN_BUF+(05*256)+5),<(SCN_BUF+(05*256)+6),<(SCN_BUF+(05*256)+7)
!BYTE <(SCN_BUF+(06*256)+0),<(SCN_BUF+(06*256)+1),<(SCN_BUF+(06*256)+2),<(SCN_BUF+(06*256)+3),<(SCN_BUF+(06*256)+4),<(SCN_BUF+(06*256)+5),<(SCN_BUF+(06*256)+6),<(SCN_BUF+(06*256)+7)
!BYTE <(SCN_BUF+(07*256)+0),<(SCN_BUF+(07*256)+1),<(SCN_BUF+(07*256)+2),<(SCN_BUF+(07*256)+3),<(SCN_BUF+(07*256)+4),<(SCN_BUF+(07*256)+5),<(SCN_BUF+(07*256)+6),<(SCN_BUF+(07*256)+7)
!BYTE <(SCN_BUF+(08*256)+0),<(SCN_BUF+(08*256)+1),<(SCN_BUF+(08*256)+2),<(SCN_BUF+(08*256)+3),<(SCN_BUF+(08*256)+4),<(SCN_BUF+(08*256)+5),<(SCN_BUF+(08*256)+6),<(SCN_BUF+(08*256)+7)
!BYTE <(SCN_BUF+(09*256)+0),<(SCN_BUF+(09*256)+1),<(SCN_BUF+(09*256)+2),<(SCN_BUF+(09*256)+3),<(SCN_BUF+(09*256)+4),<(SCN_BUF+(09*256)+5),<(SCN_BUF+(09*256)+6),<(SCN_BUF+(09*256)+7)
!BYTE <(SCN_BUF+(10*256)+0),<(SCN_BUF+(10*256)+1),<(SCN_BUF+(10*256)+2),<(SCN_BUF+(10*256)+3),<(SCN_BUF+(10*256)+4),<(SCN_BUF+(10*256)+5),<(SCN_BUF+(10*256)+6),<(SCN_BUF+(10*256)+7)
!BYTE <(SCN_BUF+(11*256)+0),<(SCN_BUF+(11*256)+1),<(SCN_BUF+(11*256)+2),<(SCN_BUF+(11*256)+3),<(SCN_BUF+(11*256)+4),<(SCN_BUF+(11*256)+5),<(SCN_BUF+(11*256)+6),<(SCN_BUF+(11*256)+7)
!BYTE <(SCN_BUF+(12*256)+0),<(SCN_BUF+(12*256)+1),<(SCN_BUF+(12*256)+2),<(SCN_BUF+(12*256)+3),<(SCN_BUF+(12*256)+4),<(SCN_BUF+(12*256)+5),<(SCN_BUF+(12*256)+6),<(SCN_BUF+(12*256)+7)
!BYTE <(SCN_BUF+(13*256)+0),<(SCN_BUF+(13*256)+1),<(SCN_BUF+(13*256)+2),<(SCN_BUF+(13*256)+3),<(SCN_BUF+(13*256)+4),<(SCN_BUF+(13*256)+5),<(SCN_BUF+(13*256)+6),<(SCN_BUF+(13*256)+7)
!BYTE <(SCN_BUF+(14*256)+0),<(SCN_BUF+(14*256)+1),<(SCN_BUF+(14*256)+2),<(SCN_BUF+(14*256)+3),<(SCN_BUF+(14*256)+4),<(SCN_BUF+(14*256)+5),<(SCN_BUF+(14*256)+6),<(SCN_BUF+(14*256)+7)
!BYTE <(SCN_BUF+(15*256)+0),<(SCN_BUF+(15*256)+1),<(SCN_BUF+(15*256)+2),<(SCN_BUF+(15*256)+3),<(SCN_BUF+(15*256)+4),<(SCN_BUF+(15*256)+5),<(SCN_BUF+(15*256)+6),<(SCN_BUF+(15*256)+7)
!BYTE <(SCN_BUF+(16*256)+0),<(SCN_BUF+(16*256)+1),<(SCN_BUF+(16*256)+2),<(SCN_BUF+(16*256)+3),<(SCN_BUF+(16*256)+4),<(SCN_BUF+(16*256)+5),<(SCN_BUF+(16*256)+6),<(SCN_BUF+(16*256)+7)
!BYTE <(SCN_BUF+(17*256)+0),<(SCN_BUF+(17*256)+1),<(SCN_BUF+(17*256)+2),<(SCN_BUF+(17*256)+3),<(SCN_BUF+(17*256)+4),<(SCN_BUF+(17*256)+5),<(SCN_BUF+(17*256)+6),<(SCN_BUF+(17*256)+7)
!BYTE <(SCN_BUF+(18*256)+0),<(SCN_BUF+(18*256)+1),<(SCN_BUF+(18*256)+2),<(SCN_BUF+(18*256)+3),<(SCN_BUF+(18*256)+4),<(SCN_BUF+(18*256)+5),<(SCN_BUF+(18*256)+6),<(SCN_BUF+(18*256)+7)
!BYTE <(SCN_BUF+(19*256)+0),<(SCN_BUF+(19*256)+1),<(SCN_BUF+(19*256)+2),<(SCN_BUF+(19*256)+3),<(SCN_BUF+(19*256)+4),<(SCN_BUF+(19*256)+5),<(SCN_BUF+(19*256)+6),<(SCN_BUF+(19*256)+7)
!BYTE <(SCN_BUF+(20*256)+0),<(SCN_BUF+(20*256)+1),<(SCN_BUF+(20*256)+2),<(SCN_BUF+(20*256)+3),<(SCN_BUF+(20*256)+4),<(SCN_BUF+(20*256)+5),<(SCN_BUF+(20*256)+6),<(SCN_BUF+(20*256)+7)
!BYTE <(SCN_BUF+(21*256)+0),<(SCN_BUF+(21*256)+1),<(SCN_BUF+(21*256)+2),<(SCN_BUF+(21*256)+3),<(SCN_BUF+(21*256)+4),<(SCN_BUF+(21*256)+5),<(SCN_BUF+(21*256)+6),<(SCN_BUF+(21*256)+7)
!BYTE <(SCN_BUF+(22*256)+0),<(SCN_BUF+(22*256)+1),<(SCN_BUF+(22*256)+2),<(SCN_BUF+(22*256)+3),<(SCN_BUF+(22*256)+4),<(SCN_BUF+(22*256)+5),<(SCN_BUF+(22*256)+6),<(SCN_BUF+(22*256)+7)
!BYTE <(SCN_BUF+(23*256)+0),<(SCN_BUF+(23*256)+1),<(SCN_BUF+(23*256)+2),<(SCN_BUF+(23*256)+3),<(SCN_BUF+(23*256)+4),<(SCN_BUF+(23*256)+5),<(SCN_BUF+(23*256)+6),<(SCN_BUF+(23*256)+7)
!BYTE <(SCN_BUF+(24*256)+0),<(SCN_BUF+(24*256)+1),<(SCN_BUF+(24*256)+2),<(SCN_BUF+(24*256)+3),<(SCN_BUF+(24*256)+4),<(SCN_BUF+(24*256)+5),<(SCN_BUF+(24*256)+6),<(SCN_BUF+(24*256)+7)

TB_HI:
!BYTE >(TMP_BUF+(00*256)+0),>(TMP_BUF+(00*256)+1),>(TMP_BUF+(00*256)+2),>(TMP_BUF+(00*256)+3),>(TMP_BUF+(00*256)+4),>(TMP_BUF+(00*256)+5),>(TMP_BUF+(00*256)+6),>(TMP_BUF+(00*256)+7)
!BYTE >(TMP_BUF+(01*256)+0),>(TMP_BUF+(01*256)+1),>(TMP_BUF+(01*256)+2),>(TMP_BUF+(01*256)+3),>(TMP_BUF+(01*256)+4),>(TMP_BUF+(01*256)+5),>(TMP_BUF+(01*256)+6),>(TMP_BUF+(01*256)+7)
!BYTE >(TMP_BUF+(02*256)+0),>(TMP_BUF+(02*256)+1),>(TMP_BUF+(02*256)+2),>(TMP_BUF+(02*256)+3),>(TMP_BUF+(02*256)+4),>(TMP_BUF+(02*256)+5),>(TMP_BUF+(02*256)+6),>(TMP_BUF+(02*256)+7)
!BYTE >(TMP_BUF+(03*256)+0),>(TMP_BUF+(03*256)+1),>(TMP_BUF+(03*256)+2),>(TMP_BUF+(03*256)+3),>(TMP_BUF+(03*256)+4),>(TMP_BUF+(03*256)+5),>(TMP_BUF+(03*256)+6),>(TMP_BUF+(03*256)+7)
!BYTE >(TMP_BUF+(04*256)+0),>(TMP_BUF+(04*256)+1),>(TMP_BUF+(04*256)+2),>(TMP_BUF+(04*256)+3),>(TMP_BUF+(04*256)+4),>(TMP_BUF+(04*256)+5),>(TMP_BUF+(04*256)+6),>(TMP_BUF+(04*256)+7)
!BYTE >(TMP_BUF+(05*256)+0),>(TMP_BUF+(05*256)+1),>(TMP_BUF+(05*256)+2),>(TMP_BUF+(05*256)+3),>(TMP_BUF+(05*256)+4),>(TMP_BUF+(05*256)+5),>(TMP_BUF+(05*256)+6),>(TMP_BUF+(05*256)+7)
!BYTE >(TMP_BUF+(06*256)+0),>(TMP_BUF+(06*256)+1),>(TMP_BUF+(06*256)+2),>(TMP_BUF+(06*256)+3),>(TMP_BUF+(06*256)+4),>(TMP_BUF+(06*256)+5),>(TMP_BUF+(06*256)+6),>(TMP_BUF+(06*256)+7)
!BYTE >(TMP_BUF+(07*256)+0),>(TMP_BUF+(07*256)+1),>(TMP_BUF+(07*256)+2),>(TMP_BUF+(07*256)+3),>(TMP_BUF+(07*256)+4),>(TMP_BUF+(07*256)+5),>(TMP_BUF+(07*256)+6),>(TMP_BUF+(07*256)+7)
!BYTE >(TMP_BUF+(08*256)+0),>(TMP_BUF+(08*256)+1),>(TMP_BUF+(08*256)+2),>(TMP_BUF+(08*256)+3),>(TMP_BUF+(08*256)+4),>(TMP_BUF+(08*256)+5),>(TMP_BUF+(08*256)+6),>(TMP_BUF+(08*256)+7)
!BYTE >(TMP_BUF+(09*256)+0),>(TMP_BUF+(09*256)+1),>(TMP_BUF+(09*256)+2),>(TMP_BUF+(09*256)+3),>(TMP_BUF+(09*256)+4),>(TMP_BUF+(09*256)+5),>(TMP_BUF+(09*256)+6),>(TMP_BUF+(09*256)+7)
!BYTE >(TMP_BUF+(10*256)+0),>(TMP_BUF+(10*256)+1),>(TMP_BUF+(10*256)+2),>(TMP_BUF+(10*256)+3),>(TMP_BUF+(10*256)+4),>(TMP_BUF+(10*256)+5),>(TMP_BUF+(10*256)+6),>(TMP_BUF+(10*256)+7)
!BYTE >(TMP_BUF+(11*256)+0),>(TMP_BUF+(11*256)+1),>(TMP_BUF+(11*256)+2),>(TMP_BUF+(11*256)+3),>(TMP_BUF+(11*256)+4),>(TMP_BUF+(11*256)+5),>(TMP_BUF+(11*256)+6),>(TMP_BUF+(11*256)+7)
!BYTE >(TMP_BUF+(12*256)+0),>(TMP_BUF+(12*256)+1),>(TMP_BUF+(12*256)+2),>(TMP_BUF+(12*256)+3),>(TMP_BUF+(12*256)+4),>(TMP_BUF+(12*256)+5),>(TMP_BUF+(12*256)+6),>(TMP_BUF+(12*256)+7)
!BYTE >(TMP_BUF+(13*256)+0),>(TMP_BUF+(13*256)+1),>(TMP_BUF+(13*256)+2),>(TMP_BUF+(13*256)+3),>(TMP_BUF+(13*256)+4),>(TMP_BUF+(13*256)+5),>(TMP_BUF+(13*256)+6),>(TMP_BUF+(13*256)+7)
!BYTE >(TMP_BUF+(14*256)+0),>(TMP_BUF+(14*256)+1),>(TMP_BUF+(14*256)+2),>(TMP_BUF+(14*256)+3),>(TMP_BUF+(14*256)+4),>(TMP_BUF+(14*256)+5),>(TMP_BUF+(14*256)+6),>(TMP_BUF+(14*256)+7)
!BYTE >(TMP_BUF+(15*256)+0),>(TMP_BUF+(15*256)+1),>(TMP_BUF+(15*256)+2),>(TMP_BUF+(15*256)+3),>(TMP_BUF+(15*256)+4),>(TMP_BUF+(15*256)+5),>(TMP_BUF+(15*256)+6),>(TMP_BUF+(15*256)+7)
!BYTE >(TMP_BUF+(16*256)+0),>(TMP_BUF+(16*256)+1),>(TMP_BUF+(16*256)+2),>(TMP_BUF+(16*256)+3),>(TMP_BUF+(16*256)+4),>(TMP_BUF+(16*256)+5),>(TMP_BUF+(16*256)+6),>(TMP_BUF+(16*256)+7)
!BYTE >(TMP_BUF+(17*256)+0),>(TMP_BUF+(17*256)+1),>(TMP_BUF+(17*256)+2),>(TMP_BUF+(17*256)+3),>(TMP_BUF+(17*256)+4),>(TMP_BUF+(17*256)+5),>(TMP_BUF+(17*256)+6),>(TMP_BUF+(17*256)+7)
!BYTE >(TMP_BUF+(18*256)+0),>(TMP_BUF+(18*256)+1),>(TMP_BUF+(18*256)+2),>(TMP_BUF+(18*256)+3),>(TMP_BUF+(18*256)+4),>(TMP_BUF+(18*256)+5),>(TMP_BUF+(18*256)+6),>(TMP_BUF+(18*256)+7)
!BYTE >(TMP_BUF+(19*256)+0),>(TMP_BUF+(19*256)+1),>(TMP_BUF+(19*256)+2),>(TMP_BUF+(19*256)+3),>(TMP_BUF+(19*256)+4),>(TMP_BUF+(19*256)+5),>(TMP_BUF+(19*256)+6),>(TMP_BUF+(19*256)+7)
!BYTE >(TMP_BUF+(20*256)+0),>(TMP_BUF+(20*256)+1),>(TMP_BUF+(20*256)+2),>(TMP_BUF+(20*256)+3),>(TMP_BUF+(20*256)+4),>(TMP_BUF+(20*256)+5),>(TMP_BUF+(20*256)+6),>(TMP_BUF+(20*256)+7)
!BYTE >(TMP_BUF+(21*256)+0),>(TMP_BUF+(21*256)+1),>(TMP_BUF+(21*256)+2),>(TMP_BUF+(21*256)+3),>(TMP_BUF+(21*256)+4),>(TMP_BUF+(21*256)+5),>(TMP_BUF+(21*256)+6),>(TMP_BUF+(21*256)+7)
!BYTE >(TMP_BUF+(22*256)+0),>(TMP_BUF+(22*256)+1),>(TMP_BUF+(22*256)+2),>(TMP_BUF+(22*256)+3),>(TMP_BUF+(22*256)+4),>(TMP_BUF+(22*256)+5),>(TMP_BUF+(22*256)+6),>(TMP_BUF+(22*256)+7)
!BYTE >(TMP_BUF+(23*256)+0),>(TMP_BUF+(23*256)+1),>(TMP_BUF+(23*256)+2),>(TMP_BUF+(23*256)+3),>(TMP_BUF+(23*256)+4),>(TMP_BUF+(23*256)+5),>(TMP_BUF+(23*256)+6),>(TMP_BUF+(23*256)+7)
!BYTE >(TMP_BUF+(24*256)+0),>(TMP_BUF+(24*256)+1),>(TMP_BUF+(24*256)+2),>(TMP_BUF+(24*256)+3),>(TMP_BUF+(24*256)+4),>(TMP_BUF+(24*256)+5),>(TMP_BUF+(24*256)+6),>(TMP_BUF+(24*256)+7)

TB_LO:
!BYTE <(TMP_BUF+(00*256)+0),<(TMP_BUF+(00*256)+1),<(TMP_BUF+(00*256)+2),<(TMP_BUF+(00*256)+3),<(TMP_BUF+(00*256)+4),<(TMP_BUF+(00*256)+5),<(TMP_BUF+(00*256)+6),<(TMP_BUF+(00*256)+7)
!BYTE <(TMP_BUF+(01*256)+0),<(TMP_BUF+(01*256)+1),<(TMP_BUF+(01*256)+2),<(TMP_BUF+(01*256)+3),<(TMP_BUF+(01*256)+4),<(TMP_BUF+(01*256)+5),<(TMP_BUF+(01*256)+6),<(TMP_BUF+(01*256)+7)
!BYTE <(TMP_BUF+(02*256)+0),<(TMP_BUF+(02*256)+1),<(TMP_BUF+(02*256)+2),<(TMP_BUF+(02*256)+3),<(TMP_BUF+(02*256)+4),<(TMP_BUF+(02*256)+5),<(TMP_BUF+(02*256)+6),<(TMP_BUF+(02*256)+7)
!BYTE <(TMP_BUF+(03*256)+0),<(TMP_BUF+(03*256)+1),<(TMP_BUF+(03*256)+2),<(TMP_BUF+(03*256)+3),<(TMP_BUF+(03*256)+4),<(TMP_BUF+(03*256)+5),<(TMP_BUF+(03*256)+6),<(TMP_BUF+(03*256)+7)
!BYTE <(TMP_BUF+(04*256)+0),<(TMP_BUF+(04*256)+1),<(TMP_BUF+(04*256)+2),<(TMP_BUF+(04*256)+3),<(TMP_BUF+(04*256)+4),<(TMP_BUF+(04*256)+5),<(TMP_BUF+(04*256)+6),<(TMP_BUF+(04*256)+7)
!BYTE <(TMP_BUF+(05*256)+0),<(TMP_BUF+(05*256)+1),<(TMP_BUF+(05*256)+2),<(TMP_BUF+(05*256)+3),<(TMP_BUF+(05*256)+4),<(TMP_BUF+(05*256)+5),<(TMP_BUF+(05*256)+6),<(TMP_BUF+(05*256)+7)
!BYTE <(TMP_BUF+(06*256)+0),<(TMP_BUF+(06*256)+1),<(TMP_BUF+(06*256)+2),<(TMP_BUF+(06*256)+3),<(TMP_BUF+(06*256)+4),<(TMP_BUF+(06*256)+5),<(TMP_BUF+(06*256)+6),<(TMP_BUF+(06*256)+7)
!BYTE <(TMP_BUF+(07*256)+0),<(TMP_BUF+(07*256)+1),<(TMP_BUF+(07*256)+2),<(TMP_BUF+(07*256)+3),<(TMP_BUF+(07*256)+4),<(TMP_BUF+(07*256)+5),<(TMP_BUF+(07*256)+6),<(TMP_BUF+(07*256)+7)
!BYTE <(TMP_BUF+(08*256)+0),<(TMP_BUF+(08*256)+1),<(TMP_BUF+(08*256)+2),<(TMP_BUF+(08*256)+3),<(TMP_BUF+(08*256)+4),<(TMP_BUF+(08*256)+5),<(TMP_BUF+(08*256)+6),<(TMP_BUF+(08*256)+7)
!BYTE <(TMP_BUF+(09*256)+0),<(TMP_BUF+(09*256)+1),<(TMP_BUF+(09*256)+2),<(TMP_BUF+(09*256)+3),<(TMP_BUF+(09*256)+4),<(TMP_BUF+(09*256)+5),<(TMP_BUF+(09*256)+6),<(TMP_BUF+(09*256)+7)
!BYTE <(TMP_BUF+(10*256)+0),<(TMP_BUF+(10*256)+1),<(TMP_BUF+(10*256)+2),<(TMP_BUF+(10*256)+3),<(TMP_BUF+(10*256)+4),<(TMP_BUF+(10*256)+5),<(TMP_BUF+(10*256)+6),<(TMP_BUF+(10*256)+7)
!BYTE <(TMP_BUF+(11*256)+0),<(TMP_BUF+(11*256)+1),<(TMP_BUF+(11*256)+2),<(TMP_BUF+(11*256)+3),<(TMP_BUF+(11*256)+4),<(TMP_BUF+(11*256)+5),<(TMP_BUF+(11*256)+6),<(TMP_BUF+(11*256)+7)
!BYTE <(TMP_BUF+(12*256)+0),<(TMP_BUF+(12*256)+1),<(TMP_BUF+(12*256)+2),<(TMP_BUF+(12*256)+3),<(TMP_BUF+(12*256)+4),<(TMP_BUF+(12*256)+5),<(TMP_BUF+(12*256)+6),<(TMP_BUF+(12*256)+7)
!BYTE <(TMP_BUF+(13*256)+0),<(TMP_BUF+(13*256)+1),<(TMP_BUF+(13*256)+2),<(TMP_BUF+(13*256)+3),<(TMP_BUF+(13*256)+4),<(TMP_BUF+(13*256)+5),<(TMP_BUF+(13*256)+6),<(TMP_BUF+(13*256)+7)
!BYTE <(TMP_BUF+(14*256)+0),<(TMP_BUF+(14*256)+1),<(TMP_BUF+(14*256)+2),<(TMP_BUF+(14*256)+3),<(TMP_BUF+(14*256)+4),<(TMP_BUF+(14*256)+5),<(TMP_BUF+(14*256)+6),<(TMP_BUF+(14*256)+7)
!BYTE <(TMP_BUF+(15*256)+0),<(TMP_BUF+(15*256)+1),<(TMP_BUF+(15*256)+2),<(TMP_BUF+(15*256)+3),<(TMP_BUF+(15*256)+4),<(TMP_BUF+(15*256)+5),<(TMP_BUF+(15*256)+6),<(TMP_BUF+(15*256)+7)
!BYTE <(TMP_BUF+(16*256)+0),<(TMP_BUF+(16*256)+1),<(TMP_BUF+(16*256)+2),<(TMP_BUF+(16*256)+3),<(TMP_BUF+(16*256)+4),<(TMP_BUF+(16*256)+5),<(TMP_BUF+(16*256)+6),<(TMP_BUF+(16*256)+7)
!BYTE <(TMP_BUF+(17*256)+0),<(TMP_BUF+(17*256)+1),<(TMP_BUF+(17*256)+2),<(TMP_BUF+(17*256)+3),<(TMP_BUF+(17*256)+4),<(TMP_BUF+(17*256)+5),<(TMP_BUF+(17*256)+6),<(TMP_BUF+(17*256)+7)
!BYTE <(TMP_BUF+(18*256)+0),<(TMP_BUF+(18*256)+1),<(TMP_BUF+(18*256)+2),<(TMP_BUF+(18*256)+3),<(TMP_BUF+(18*256)+4),<(TMP_BUF+(18*256)+5),<(TMP_BUF+(18*256)+6),<(TMP_BUF+(18*256)+7)
!BYTE <(TMP_BUF+(19*256)+0),<(TMP_BUF+(19*256)+1),<(TMP_BUF+(19*256)+2),<(TMP_BUF+(19*256)+3),<(TMP_BUF+(19*256)+4),<(TMP_BUF+(19*256)+5),<(TMP_BUF+(19*256)+6),<(TMP_BUF+(19*256)+7)
!BYTE <(TMP_BUF+(20*256)+0),<(TMP_BUF+(20*256)+1),<(TMP_BUF+(20*256)+2),<(TMP_BUF+(20*256)+3),<(TMP_BUF+(20*256)+4),<(TMP_BUF+(20*256)+5),<(TMP_BUF+(20*256)+6),<(TMP_BUF+(20*256)+7)
!BYTE <(TMP_BUF+(21*256)+0),<(TMP_BUF+(21*256)+1),<(TMP_BUF+(21*256)+2),<(TMP_BUF+(21*256)+3),<(TMP_BUF+(21*256)+4),<(TMP_BUF+(21*256)+5),<(TMP_BUF+(21*256)+6),<(TMP_BUF+(21*256)+7)
!BYTE <(TMP_BUF+(22*256)+0),<(TMP_BUF+(22*256)+1),<(TMP_BUF+(22*256)+2),<(TMP_BUF+(22*256)+3),<(TMP_BUF+(22*256)+4),<(TMP_BUF+(22*256)+5),<(TMP_BUF+(22*256)+6),<(TMP_BUF+(22*256)+7)
!BYTE <(TMP_BUF+(23*256)+0),<(TMP_BUF+(23*256)+1),<(TMP_BUF+(23*256)+2),<(TMP_BUF+(23*256)+3),<(TMP_BUF+(23*256)+4),<(TMP_BUF+(23*256)+5),<(TMP_BUF+(23*256)+6),<(TMP_BUF+(23*256)+7)
!BYTE <(TMP_BUF+(24*256)+0),<(TMP_BUF+(24*256)+1),<(TMP_BUF+(24*256)+2),<(TMP_BUF+(24*256)+3),<(TMP_BUF+(24*256)+4),<(TMP_BUF+(24*256)+5),<(TMP_BUF+(24*256)+6),<(TMP_BUF+(24*256)+7)

 SPR_SIZE !BYTE
SPR_SIZE_TAB_LO !BYTE <SB_TB_1,<SB_TB_2,<SB_TB_3,<SB_TB_4,<SB_TB_5
SPR_SIZE_TAB_HI !BYTE >SB_TB_1,>SB_TB_2,>SB_TB_3,>SB_TB_4,>SB_TB_5




SPR00_AND_LO !BYTE <SPR00_AND_0,<SPR00_AND_1,<SPR00_AND_2,<SPR00_AND_3
SPR00_AND_HI !BYTE >SPR00_AND_0,>SPR00_AND_2,>SPR00_AND_2,>SPR00_AND_3
SPR00_ORA_LO !BYTE <SPR00_ORA_0,<SPR00_ORA_1,<SPR00_ORA_2,<SPR00_ORA_3
SPR00_ORA_HI !BYTE >SPR00_ORA_0,>SPR00_ORA_2,>SPR00_ORA_2,>SPR00_ORA_3

SPR00_AND_0
; !BYTE $f0,$F1,$f2,$f3,$f4,$f5,$f6,$f7,$f8,$f9,$fa,$fb,$fc,$fd,$fe,$ff
 !BYTE %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000
 !BYTE %11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111
SPR00_AND_1
; !BYTE $f0,$F1,$f2,$f3,$f4,$f5,$f6,$f7,$f8,$f9,$fa,$fb,$fc,$fd,$fe,$ff
 !BYTE %11000000,%11000000,%11000000,%11000000,%11000000,%11000000,%11000000,%11000000
 !BYTE %00111111,%00111111,%00111111,%00111111,%00111111,%00111111,%00111111,%00111111
SPR00_AND_2
; !BYTE $f0,$F1,$f2,$f3,$f4,$f5,$f6,$f7,$f8,$f9,$fa,$fb,$fc,$fd,$fe,$ff
 !BYTE %11110000,%11110000,%11110000,%11110000,%11110000,%11110000,%11110000,%11110000
 !BYTE %00001111,%00001111,%00001111,%00001111,%00001111,%00001111,%00001111,%00001111
SPR00_AND_3
; !BYTE $f0,$F1,$f2,$f3,$f4,$f5,$f6,$f7,$f8,$f9,$fa,$fb,$fc,$fd,$fe,$ff
 !BYTE %11111100,%11111100,%11111100,%11111100,%11111100,%11111100,%11111100,%11111100
 !BYTE %00000011,%00000011,%00000011,%00000011,%00000011,%00000011,%00000011,%00000011

SPR00_ORA_0
; !BYTE $0f,$1f,$2f,$3f,$4f,$5f,$6f,$7f,$8f,$9f,$af,$bf,$cf,$df,$ef,$ff
 !BYTE %11111111,%11011011,%11100111,%11011011,%11100111,%11011011,%11100111,%11111111 ;?
 !BYTE %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000
SPR00_ORA_1
; !BYTE $0f,$1f,$2f,$3f,$4f,$5f,$6f,$7f,$8f,$9f,$af,$bf,$cf,$df,$ef,$ff
 !BYTE %00111111,%00110110,%00111001,%00110110,%00111001,%00110110,%00111001,%00111111 ;?
 !BYTE %11000000,%11000000,%11000000,%11000000,%11000000,%11000000,%11000000,%11000000
SPR00_ORA_2
; !BYTE $0f,$1f,$2f,$3f,$4f,$5f,$6f,$7f,$8f,$9f,$af,$bf,$cf,$df,$ef,$ff
 !BYTE %00001111,%00001101,%00001110,%00001101,%00001110,%00001101,%00001110,%00001111 ;?
 !BYTE %11110000,%10110000,%01110000,%10110000,%01110000,%10110000,%01110000,%11110000
SPR00_ORA_3
; !BYTE $0f,$1f,$2f,$3f,$4f,$5f,$6f,$7f,$8f,$9f,$af,$bf,$cf,$df,$ef,$ff
 !BYTE %00000011,%00000011,%00000011,%00000011,%00000011,%00000011,%00000011,%00000011 ;?
 !BYTE %11111100,%01101100,%10011100,%01101100,%10011100,%01101100,%10011100,%11111100

 
 
SCN_BUF = 41984 ; 41 *1024
;!FILL 200*32,$A5

TMP_BUF = 57344 ; $e000 ; 57344
