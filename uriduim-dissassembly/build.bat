cd bin
64tass -i ../Source/asm/uridium.asm -o ../projectu.prg 
exomizer.exe sfx $900 ../projectu.prg -o ../pjpu.prg -x "LDA #$0B STA $D011 LDA $D020 EOR #$05 STA $D020 STA $D418"
cd ..
