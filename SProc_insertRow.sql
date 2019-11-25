/*
Stored proc to add shipping records to table. It will not add duplicate records if no shipping
updates have been found.
*/ 

CREATE PROCEDURE update_track 
@trackNo VARCHAR(20), 
@orderNum VARCHAR(10), 
@accountNum VARCHAR(10), 
@shipDate DATETIME, 
@origin VARCHAR(3), 
@dest VARCHAR(3), 
@lastUpdate DATETIME, 
@signedBy VARCHAR(20)
AS
IF NOT EXISTS (
    SELECT 
    trackno, 
    orderNum, 
    accountNum, 
    shipDate, 
    origin, 
    dest, 
    lastUpdate, 
    signedBy 
    FROM dbo.trackingOrders 
    WHERE trackno = @trackNo 
    AND lastUpdate = @lastUpdate
)
INSERT INTO dbo.trackingOrders
VALUES (
    @trackNo, 
    @orderNum, 
    @accountNum, 
    @shipDate, 
    @origin, 
    @dest, 
    @lastUpdate, 
    @signedBy
)
GO
