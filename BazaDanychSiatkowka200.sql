/*
   wtorek, 10 stycznia 202320:40:35
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
ALTER TABLE dbo.Wyniki
	DROP CONSTRAINT FK_Wyniki_Druzyny
GO
ALTER TABLE dbo.Druzyny SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Wyniki
	DROP CONSTRAINT FK_Wyniki_Sedziowie
GO
ALTER TABLE dbo.Sedziowie SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Wyniki ADD CONSTRAINT
	FK_Wyniki_Sedziowie1 FOREIGN KEY
	(
	sedzia
	) REFERENCES dbo.Sedziowie
	(
	sedziaid
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Wyniki SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
