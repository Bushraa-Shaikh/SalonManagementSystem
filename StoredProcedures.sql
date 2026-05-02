CREATE PROCEDURE sp_AddClient
@ClientName VARCHAR(50),
@ClientPhone VARCHAR(50)
AS
BEGIN
    INSERT INTO clients (ClientName, ClientPhone)
    VALUES (@ClientName, @ClientPhone)
END
GO


CREATE PROCEDURE sp_GetClientByPhone
@Phone VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM clients
    WHERE ClientPhone = @Phone
END
GO


CREATE PROCEDURE sp_SearchClientByName
@Name VARCHAR(50)
AS
BEGIN
    SELECT TOP 10 ClientId, ClientName, ClientPhone
    FROM clients
    WHERE ClientName LIKE @Name + '%'
END
GO


CREATE PROCEDURE sp_GetStaffDropdown
AS
BEGIN
    SELECT StaffId, StaffName
    FROM staff
END
GO


CREATE PROCEDURE sp_SearchStaffByName
@Name VARCHAR(50)
AS
BEGIN
    SELECT StaffId, StaffName, StaffPhone
    FROM staff
    WHERE StaffName LIKE @Name + '%'
END
GO


CREATE PROCEDURE sp_AddStaff
@UserId INT,
@StaffName VARCHAR(50),
@StaffPhone VARCHAR(50),
@StaffEmail VARCHAR(50),
@StaffAddress VARCHAR(50),
@JoiningDate DATE,
@StaffSalary DECIMAL(10,2),
@StaffSpeciality VARCHAR(50),
@StaffStatus INT
AS
BEGIN
    INSERT INTO staff
    (UsId, StaffName, StaffPhone, StaffEmail, StaffAddress,
     JoiningDate, StaffSalary, StaffSpecialilty, StaffStatus)
    VALUES
    (@UserId, @StaffName, @StaffPhone, @StaffEmail, @StaffAddress,
     @JoiningDate, @StaffSalary, @StaffSpeciality, @StaffStatus)
END
GO


CREATE PROCEDURE sp_CreateAppointment
@ClientId INT,
@BookedFor INT,
@BookedBy INT,
@AppTime TIME,
@AppDate DATE
AS
BEGIN
    DECLARE @StatusId INT

    SELECT @StatusId = StatusId 
    FROM activestatus 
    WHERE StatusType = 'Scheduled'

    INSERT INTO appointments
    (CId, App_Booked_For, App_Booked_By, AppTime, AppDate, AppStatus)
    VALUES
    (@ClientId, @BookedFor, @BookedBy, @AppTime, @AppDate, @StatusId)
END
GO


CREATE PROCEDURE sp_GetAppointmentsDetailed
AS
BEGIN
    SELECT 
        a.AppId,
        c.ClientName,
        s1.StaffName AS BookedFor,
        s2.StaffName AS BookedBy,
        a.AppDate,
        a.AppTime,
        a.AppStatus
    FROM appointments a
    JOIN clients c ON a.CId = c.ClientId
    JOIN staff s1 ON a.App_Booked_For = s1.StaffId
    JOIN staff s2 ON a.App_Booked_By = s2.StaffId
END
GO



CREATE PROCEDURE sp_GetServices
AS
BEGIN
    SELECT ServiceId, ServiceName, ServicePrice
    FROM salonservices
END
GO


CREATE PROCEDURE sp_CreateBill
@AppointmentId INT = NULL,
@ClientId INT,
@TotalAmount DECIMAL(10,2),
@PaymentMethodId INT
AS
BEGIN
    INSERT INTO bills
    (AppointId, ClId, BillDate, TotalAmount, PayId)
    VALUES
    (@AppointmentId, @ClientId, GETDATE(), @TotalAmount, @PaymentMethodId)
END
GO