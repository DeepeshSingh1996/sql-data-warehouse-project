/*
=================================================================================
-- Create or Recreate Data Warehouse Database and Schemas
=================================================================================
-- Purpose:
--   This script ensures a clean setup of the “DataWarehouse” database.
--   If the database already exists, it is dropped and re-created from scratch.
--   After creation, it configures three logical schemas:
--     • bronze   – Staging/raw data
--     • silver   – Cleansed and transformed data
--     • gold     – Curated, analytics-ready tables
--
-- Warning:
--   Running this script will permanently delete any existing DataWarehouse database
--   and all its data. Be certain you have a current backup before proceeding.
=================================================================================
*/

USE master;
GO

-- Drop and recreate the 'Data Warehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name  = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO
  
-- Create Schemas
CREATE SCHEMA bronze;
GO
  
CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
