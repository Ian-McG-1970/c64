..\64tass -Wall -Wno-implied-reg --cbm-prg -o bin/pd.prg -L bin/list-co1.txt -l bin/labels.txt src/paradroid.asm
	
..\64tass -Wall -Wno-implied-reg --cbm-prg -o bin/data.prg src/data.asm
	
..\exomizer sfx 0x1000 bin/pd.prg bin/data.prg,0xe000 -n -o bin/paradroid.prg
