--##------------------------------------------------------------------------------
--## 1.


--##------------------------------------------------------------------------------
--## 2. 
--## You should have right clicked and the choose `select top 1000`.


--##------------------------------------------------------------------------------
--## 3.
SELECT TOP (1000) [HistoryKey]
      ,[Id]
      ,[OpportunityId]
      ,[SortOrder]
      ,[PricebookEntryId]
      ,[Product2Id]
      ,[ProductCode]
      ,[Name]
      ,[Quantity]
      ,[Discount]
      ,[Subtotal]
      ,[TotalPrice]
      ,[UnitPrice]
      ,[ListPrice]
      ,[ServiceDate]
      ,[Description]
      ,[CreatedDate]
      ,[CreatedById]
      ,[LastModifiedDate]
      ,[LastModifiedById]
      ,[SystemModstamp]
      ,[IsDeleted]
      ,[ConnectionReceivedId]
  FROM [dbo].[OpportunityLineItem]

--##------------------------------------------------------------------------------
--## 4.
SELECT TOP (1000) [HistoryKey]
      ,[Id]
      ,[OpportunityId]
      ,[SortOrder]
      ,[PricebookEntryId]
      ,[Product2Id]
      ,[ProductCode]
      ,[Name]
      ,[Quantity]
      ,[Discount]
      ,[Subtotal]
      ,[TotalPrice]
      ,[UnitPrice]
      ,[ListPrice]
      ,[ServiceDate]
      ,[Description]
      ,[CreatedDate]
      ,[CreatedById]
      ,[LastModifiedDate]
      ,[LastModifiedById]
      ,[SystemModstamp]
      ,[IsDeleted]
      ,[ConnectionReceivedId]
  FROM [dbo].[OpportunityLineItem]
  WHERE LastModifiedDate < '2018-01-01'


--##------------------------------------------------------------------------------
--## 5. 
SELECT TOP (1000) [HistoryKey]
      ,[Id]
      ,[OpportunityId]
      ,[SortOrder]
      ,[PricebookEntryId]
      ,[Product2Id]
      ,[ProductCode]
      ,[Name]
      ,[Quantity]
      ,[Discount]
      ,[Subtotal]
      ,[TotalPrice]
      ,[UnitPrice]
      ,[ListPrice]
      ,[ServiceDate]
      ,[Description]
      ,[CreatedDate]
      ,[CreatedById]
      ,[LastModifiedDate]
      ,[LastModifiedById]
      ,[SystemModstamp]
      ,[IsDeleted]
      ,[ConnectionReceivedId]
  FROM [dbo].[OpportunityLineItem]
  WHERE LastModifiedDate < '2018-01-01'
    AND Product2Id IN ('01t70000005Qt75AAC', '01t3900000SW3jeAAD')

--##------------------------------------------------------------------------------
--## 6.
SELECT TOP (1000) [HistoryKey]
      ,[Id]
      ,[OpportunityId]
      ,[SortOrder]
      ,[PricebookEntryId]
      ,[Product2Id]
      ,[ProductCode]
      ,[Name]
      ,[Quantity]
      ,[Discount]
      ,[Subtotal]
      ,[TotalPrice]
      ,[UnitPrice]
      ,[ListPrice]
      ,[ServiceDate]
      ,[Description]
      ,[CreatedDate]
      ,[CreatedById]
      ,[LastModifiedDate]
      ,[LastModifiedById]
      ,[SystemModstamp]
      ,[IsDeleted]
      ,[ConnectionReceivedId]
  FROM [dbo].[OpportunityLineItem]
  WHERE LastModifiedDate < '2018-01-01'
    AND Product2Id IN ('01t70000005Qt75AAC', '01t3900000SW3jeAAD')
  ORDER BY TotalPrice DESC

--##------------------------------------------------------------------------------
--## 7.
SELECT 
      [Id]
      ,[Name]
  FROM [dbo].[Product2]
  WHERE Id IN ('01t70000005Qt75AAC', '01t3900000SW3jeAAD')

--## CoursEval & Annual Subscription: Umbrella Portal

--##------------------------------------------------------------------------------
--## 8.








