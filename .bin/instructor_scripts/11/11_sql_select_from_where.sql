--##========================================
--## select, from, where & exporting
--##========================================
--## In this demonstration we'll be learning how to do basic SQL querying and 
--## exporting the results.

--## 1. Connect to the salesforce database
--## 2. Expand the table view.  See:
--##    A. Columns
--##    B. Keys
--## 3. Right click on the opportunity table and select the top 1000 rows
--##
--##    A successful query!!!!!!! [returns rows + code...sweet!!]
--##
--##    The 2 most important tables (many tasks with just them):
--##      - dbo.Opportunity
--##      - dbo.OpportunityLineItem
--##
--##    To learn about the tables: (A) Explore & (B) Ask Rich Burke
--## 4. Notice that the following boiler plate is in the returned code:
--##
--##     SELECT 
--##         columns
--##     FROM table
--##     WHERE condition







--##==========
--## Selecting
--##==========

-- ## SELECT the first 18-20 columns.





--##==========
--## Filtering
--##==========

-- ## Filter WHERE `LastModified` is less than or equal to 2018-01-01
-- ## This gives you all the approximate state of sales on this date 
SELECT TOP (1000) [HistoryKey]
      ,[Id]
      ,[IsDeleted]
      ,[AccountId]
      ,[RecordTypeId]
      ,[Name]
      ,[Description]
      ,[StageName]
      ,[Amount]
      ,[Probability]
      ,[ExpectedRevenue]
      ,[TotalOpportunityQuantity]
      ,[CloseDate]
      ,[Type]
      ,[NextStep]
      ,[LeadSource]
      ,[IsClosed]
      ,[IsWon]
  FROM [dbo].[Opportunity]
  WHERE LastModifiedDate < '2018-01-01'
  
  
-- ## Use this same code and look at only the opportunities that are not closed
SELECT TOP (1000) [HistoryKey]
      ,[Id]
      ,[IsDeleted]
      ,[AccountId]
      ,[RecordTypeId]
      ,[Name]
      ,[Description]
      ,[StageName]
      ,[Amount]
      ,[Probability]
      ,[ExpectedRevenue]
      ,[TotalOpportunityQuantity]
      ,[CloseDate]
      ,[Type]
      ,[NextStep]
      ,[LeadSource]
      ,[IsClosed]
      ,[IsWon]
  FROM [dbo].[Opportunity]
  WHERE LastModifiedDate < '2018-01-01'  
      AND StageName NOT IN ('Closed Won','Closed Lost')
      
      
      
      
      
      
--##==========
--## Ordering
--##==========

--## Use the previous query but order descending on the `CloseDate` variable
--##   to allow the projected future & latest close dates to rise to the top.
SELECT TOP (1000) [HistoryKey]
      ,[Id]
      ,[IsDeleted]
      ,[AccountId]
      ,[RecordTypeId]
      ,[Name]
      ,[Description]
      ,[StageName]
      ,[Amount]
      ,[Probability]
      ,[ExpectedRevenue]
      ,[TotalOpportunityQuantity]
      ,[CloseDate]
      ,[Type]
      ,[NextStep]
      ,[LeadSource]
      ,[IsClosed]
      ,[IsWon]
  FROM [dbo].[Opportunity]
  WHERE LastModifiedDate < '2018-01-01'
      AND StageName NOT IN ('Closed Won','Closed Lost')
  ORDER BY CloseDate DESC
  
--##==================  
--## Exporting Results
--##==================
--## Right click the table and select the proper save format (usually .csv).
 
