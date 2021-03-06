CREATE PROCEDURE [dbo].[PROC_ANALISA_REFAZ_TODOS_INDICES]
( @FILTRO_TABELA VARCHAR(255) = NULL )
AS
BEGIN
	
	IF COALESCE(@FILTRO_TABELA,'') = ''
	BEGIN
		SET @FILTRO_TABELA = '%'
	END
	
	DECLARE @TABELA VARCHAR(255)
	
	DECLARE CUR_TABELAS CURSOR FAST_FORWARD FOR
	SELECT NAME FROM SYS.TABLES WHERE NAME LIKE @FILTRO_TABELA+'%'
	ORDER BY NAME

	-- GERANDO CURSOR COM TABELAS
	OPEN CUR_TABELAS
	FETCH NEXT FROM CUR_TABELAS INTO @TABELA

	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT('Analisando tabela...' + @TABELA)
		
		EXEC PROC_RECRIAORGANIZA_INDICE @TABELA
		
		FETCH NEXT FROM CUR_TABELAS INTO @TABELA
	END

	CLOSE CUR_TABELAS
	DEALLOCATE CUR_TABELAS
END
