CLEAR
_CLIPTEXT=''

nDIMENSAO=INT(VAL(INPUTBOX('QUAL A DIMENS�O DA MATRIZ?')))

DIMENSION MATRIZ[nDIMENSAO,nDIMENSAO]
DIMENSION IDENT[nDIMENSAO,nDIMENSAO]

CRIA_IDENTIDADE()


LOCAL lnXI,lnXIi AS Integer

FOR lnXI = 1 TO nDIMENSAO
	FOR lnXII = 1 TO nDIMENSAO
		MATRIZ[lnXI,lnXII] = ROUND(VAL(TRANSFORM(ROUND(EVALUATE(INPUTBOX('VALOR DA POSI��O '+TRANSFORM(lnXI)+','+TRANSFORM(lnXIi))),1))),1)
	ENDFOR	
ENDFOR


PRINTAMATRIZ()
PRINTA()


*PRIMEIRO QUADRANTE
AUX=0
FOR H = 1 TO nDIMENSAO -1
	
	AUX = AUX + 1
	FOR J = nDIMENSAO TO 1+H STEP -1	
		
		nFATOR=FATOR(AUX ,J,H)
		
		IF AJUST(AUX ,nFATOR,J)
			PRINTA()
			PRINTAMATRIZ()
		ENDIF
		
	ENDFOR
		
ENDFOR

*SEGUNDO QUADRANTE
AUX=nDIMENSAO 
 
FOR H = nDIMENSAO TO 2 STEP -1 
	
	FOR J = 1 TO H-1
		
		nFATOR=FATOR(AUX ,J,H)
		
		IF AJUST(AUX ,nFATOR,J)	
			PRINTA()	
			PRINTAMATRIZ()	
		ENDIF
		
	ENDFOR
	AUX = AUX - 1
		
ENDFOR


*ACERTA DIAGONAL 
ACERTA_DIAGONAL()


PRINTA()
PRINTA("MATRIZ INVERSA:")
LINHA()
PRINTAMATRIZ()
PRINTA()
LINHA()
*RESOLVE SISTEMA
RESOLVE_SISTEMA()

*************************************************
FUNC PRINTAMATRIZ
	LOCAL lnXI,lnXIi AS Integer 
	LOCAL lcLINHA AS String
	FOR lnXI = 1 TO nDIMENSAO
		lcLINHA ='| '
		FOR lnXII = 1 TO nDIMENSAO
			 lcLINHA = lcLINHA +;
			 PADR(TRANSFORM(ROUND(MATRIZ[lnXI,lnXII],1)),6)
		ENDFOR	
		lcLINHA=lcLINHA+"|" 
		
		lcLINHA=lcLINHA +  '     | '
		FOR lnXII = 1 TO nDIMENSAO
			 lcLINHA = lcLINHA +;
			 PADR(TRANSFORM(ROUND(IDENT[lnXI,lnXII],1)),6)
		ENDFOR	
		lcLINHA = lcLINHA+" |" 
		PRINTA( lcLINHA )
	ENDFOR


FUNC AJUST
	LPARAMETERS tnLINHA,tnMULT,tnSOMA
	
	IF tnMULT=0
		RETURN .F.
	ENDIF
	
	PRINTA()
	LINHA()
	PRINTA( 'L'+TRANSFORM(tnSOMA)+'='+IIF(tnMULT<>1,TRANSFORM(tnMULT),'')+'L'+TRANSFORM(tnLINHA)+' + L'+TRANSFORM(tnSOMA))
	LINHA()
	
	FOR I = 1 TO nDIMENSAO
		MATRIZ[tnSOMA,I] = ROUND((tnMULT*MATRIZ[tnLINHA,I]),1) + ROUND(MATRIZ[tnSOMA,I],1)
	ENDFOR
	
	FOR I = 1 TO nDIMENSAO
		IDENT[tnSOMA,I] = ROUND((tnMULT*IDENT[tnLINHA,I]),1) + ROUND(IDENT[tnSOMA,I],1)
	ENDFOR


FUNC FATOR
	LPARAMETERS nL1,nL2,nCOL
	
	IF MATRIZ[nL1,nCOL]=0
		RETURN 0
	ENDIF
	
	nRET=(-(MATRIZ[nL2,nCOL]))/MATRIZ[nL1,nCOL]
	
	RETURN ROUND(nRET,4)
	
	
FUNC LINHA()
	PRINTA(REPLICATE('-',25))
	
FUNC PRINTA
	LPARAMETERS TEXTO
	IF EMPTY(TEXTO) and TYPE('TEXTO') <> 'N'
		TEXTO=''
	ENDIF 
	? TEXTO
	_CLIPTEXT=_CLIPTEXT+TEXTO+CHR(13)
	

FUNC ACERTA_DIAGONAL
	PRINTA()
	LINHA()	
	FOR Y=1 TO nDIMENSAO
		
		IF MATRIZ[Y,Y] = 1
			LOOP
		ENDIF
		
		PRINTA( 'L'+TRANSFORM(Y)+'=L'+TRANSFORM(Y)+'/'+TRANSFORM(ROUND(MATRIZ[Y,Y],1)) )
		FOR X = 1 TO nDIMENSAO
			IDENT[Y,X]= IDENT[Y,X] / MATRIZ[Y,Y] 	
		ENDFOR

		
		MATRIZ[Y,Y]	= 1
		
		
	
	NEXT
	LINHA()


PROC CRIA_IDENTIDADE
	IDENT=0
	
	FOR Y=1 TO nDIMENSAO
	
		IDENT[Y,Y]=1	
	
	NEXT
	
FUNC RESOLVE_SISTEMA
	
	DIMENSION RESULT[nDIMENSAO,2]
	RESULT=0
	
	FOR lnXI = 1 TO nDIMENSAO
		RESULT[lnXI,1] = VAL(TRANSFORM(ROUND(EVALUATE(INPUTBOX('DIGITE O VALOR DO RESULTADO N�'+TRANSFORM(lnXI))),1)))
	ENDFOR

	FOR lnXI = 1 TO nDIMENSAO
		FOR lnXII = 1 TO nDIMENSAO
			RESULT[lnXI,2] =RESULT[lnXI,2] + ROUND(RESULT[lnXII,1],1)*ROUND(IDENT[lnXI,lnXII],1)
		ENDFOR
	ENDFOR
	
	PRINTA()
	LINHA()
	
	FOR lnXI = 1 TO nDIMENSAO
		LINHA='| '
		FOR lnXII = 1 TO nDIMENSAO
			LINHA = LINHA+ PADR(TRANSFORM(ROUND(IDENT[lnXI,lnXII],1)),6)
		ENDFOR
		LINHA = LINHA + '|  ' + IIF(lnXI=1,'* ','  ')
		LINHA = LINHA + '|'+PADR(RESULT[lnXI,1],4)+'| '+IIF(lnXI=1,' = ','   ')+;
						'|'+PADR(RESULT[lnXI,2],4)+'|'
		PRINTA(LINHA)	
	ENDFOR
	
	