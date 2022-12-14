/*
   piątek, 30 grudnia 202219:15:12
   User: 
   Server: DESKTOP-7BQ2H0J\MISSQLSEWER
   Database: Siatkowka
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Obiekty ADD CONSTRAINT
	PK_Obiekty PRIMARY KEY CLUSTERED 
	(
	obiektid
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Obiekty SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Wyniki ADD CONSTRAINT
	FK_Wyniki_Obiekty FOREIGN KEY
	(
	meczid
	) REFERENCES dbo.Obiekty
	(
	obiektid
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Wyniki SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
