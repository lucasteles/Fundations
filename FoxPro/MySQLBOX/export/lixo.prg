SELE BMFLOG
GO TOP
lnANT = 0
SCAN WHILE NOT EOF()
	IF NR_MENSAGE<lnANT
		SUSPEND
		BROW
	ENDIF
	lnANT = NR_MENSAGE
ENDSCAN