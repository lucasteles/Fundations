CD C:\BACKUP_SQL\SEXTA\
DEL LOG.TXT
DEL VolpeApaf.bak

osql -S(local) -E -dmaster -iC:\BACKUP_SQL\SEXTA\BKP_SEXTA.SQL -oC:\BACKUP_SQL\SEXTA\LOG.TXT

EXIT