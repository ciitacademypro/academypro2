use academy_pro_db_v1;

CREATE TABLE Employees
(
    EmployeeId INT IDENTITY PRIMARY KEY,
	BranchId SMALLINT NOT NULL,
	EmployeeCode VARCHAR(10)NOT NULL UNIQUE,
	EmployeeName VARCHAR(100)NOT NULL,
	MobileNumber VARCHAR(15) UNIQUE,
	EmailAddress VARCHAR(50) UNIQUE,
	RoleId	TINYINT,
	Password VARCHAR(150),
	Status BIT NOT NULL DEFAULT 0,
	DeletedAt DATETIME DEFAULT NULL,	
);



CREATE PROCEDURE sp_CreateUpdateDeleteRestorePassword_Employees
(
	@Type VARCHAR(10),
	@EmployeeId INT = 0,
	@BranchId SMALLINT,
	@EmployeeCode VARCHAR(10),
	@EmployeeName VARCHAR(100),
	@MobileNumber VARCHAR(15),
	@EmailAddress VARCHAR(50),
	@RoleId	TINYINT,
	@Password VARCHAR(150) = '123456',
	@Status BIT = 0
)
AS 
BEGIN
       IF @Type = 'INSERT'
	   BEGIN 
			 INSERT INTO Employees(BranchId,EmployeeCode,EmployeeName,MobileNumber,EmailAddress,RoleId,Password,Status) values(@BranchId,@EmployeeCode,@EmployeeName,@MobileNumber,@EmailAddress,@RoleId,@Password,@Status)
	   END

	   IF @Type='Update'
	   BEGIN
			IF NOT EXISTS(Select 1 from Employees WHERE EmployeeId=@EmployeeId AND DeletedAt IS NULL)
			    BEGIN 
				      RAISERROR('Invalid EmployeeId. The Specified EMployeeId Does Not Exist.',16,1);
					  RETURN
				END
			ELSE
			   BEGIN 
			        Update Employees SET
					BranchId = @BranchId,
					EmployeeCode =@EmployeeCode,
					EmployeeName=@EmployeeName,
					MobileNumber =@MobileNumber,
					EmailAddress =@EmailAddress,
					RoleId	=@RoleId,
					Status=@Status
					Where EmployeeId=@EmployeeId AND DeletedAt IS NULL
			   END
	   END

      IF @Type='DELETE'
	  BEGIN
	  IF NOT EXISTS(Select 1 From Employees WHERE EmployeeId = @EmployeeId AND DeletedAt IS NULL)
			BEGIN 
				  RAISERROR('Invalid EmployeeId. The Specified EMployeeId Does Not Exist.',16,1);
				  RETURN
			END
			ELSE
			Update Employees SET DeletedAt=GETDATE() WHERE EmployeeId=@EmployeeId AND DeletedAt IS NULL
	  END

	    IF @Type = 'RESTORE'
			BEGIN
				UPDATE Employees SET DeletedAt = NULL WHERE EmployeeId = @EmployeeId
			END	
	    IF @Type = 'PASSWORD'			-- RESET Password
			BEGIN
				UPDATE Employees SET Password = @Password WHERE EmployeeId = @EmployeeId
			END	


END;



CREATE PROCEDURE sp_GetAll_Employees
(
	@EmployeeId INT = 0,
	@BranchId INT = 0,
	@RoleId INT = 0
)
AS
	BEGIN
		IF (@EmployeeId <> 0)
			BEGIN
				SELECT 
					e.EmployeeId,
					e.BranchId,
					b.BranchName,
					e.EmployeeCode,
					e.EmployeeName,
					e.MobileNumber,
					e.EmailAddress,
					e.RoleId,
					r.RoleName,
					e.Password,
					e.Status,
					CASE 
						WHEN e.Status = 1 THEN 'Active' 
						WHEN e.Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM Employees e
				JOIN Branches b ON b.BranchId = e.BranchId
				JOIN Roles r ON r.RoleId = e.RoleId

				WHERE 
					e.DeletedAt IS NULL 
					AND b.DeletedAt IS NULL 
					AND r.DeletedAt IS NULL 
					AND e.EmployeeId = @EmployeeId
				ORDER BY e.EmployeeId desc
			END
		ELSE IF (@BranchId <> 0 AND @RoleId <> 0)
			BEGIN
				SELECT 
					e.EmployeeId,
					e.BranchId,
					b.BranchName,
					e.EmployeeCode,
					e.EmployeeName,
					e.MobileNumber,
					e.EmailAddress,
					e.RoleId,
					r.RoleName,
					e.Password,
					e.Status,
					CASE 
						WHEN e.Status = 1 THEN 'Active' 
						WHEN e.Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM Employees e
				JOIN Branches b ON b.BranchId = e.BranchId
				JOIN Roles r ON r.RoleId = e.RoleId
				WHERE 
					e.DeletedAt IS NULL 
					AND b.DeletedAt IS NULL 
					AND r.DeletedAt IS NULL 
					AND e.BranchId = @BranchId
					AND e.RoleId = @RoleId
				ORDER BY e.EmployeeId desc
			END

		ELSE IF (@BranchId <> 0)
			BEGIN
				SELECT 
					e.EmployeeId,
					e.BranchId,
					b.BranchName,
					e.EmployeeCode,
					e.EmployeeName,
					e.MobileNumber,
					e.EmailAddress,
					e.RoleId,
					r.RoleName,
					e.Password,
					e.Status,
					CASE 
						WHEN e.Status = 1 THEN 'Active' 
						WHEN e.Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM Employees e
				JOIN Branches b ON b.BranchId = e.BranchId
				JOIN Roles r ON r.RoleId = e.RoleId
				WHERE 
					e.DeletedAt IS NULL 
					AND b.DeletedAt IS NULL 
					AND r.DeletedAt IS NULL 
					AND e.BranchId = @BranchId
				ORDER BY e.EmployeeId desc
			END

		ELSE IF (@RoleId <> 0)
			BEGIN
				SELECT 
					e.EmployeeId,
					e.BranchId,
					b.BranchName,
					e.EmployeeCode,
					e.EmployeeName,
					e.MobileNumber,
					e.EmailAddress,
					e.RoleId,
					r.RoleName,
					e.Password,
					e.Status,
					CASE 
						WHEN e.Status = 1 THEN 'Active' 
						WHEN e.Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM Employees e
				JOIN Branches b ON b.BranchId = e.BranchId
				JOIN Roles r ON r.RoleId = e.RoleId
				WHERE 
					e.DeletedAt IS NULL 
					AND b.DeletedAt IS NULL 
					AND r.DeletedAt IS NULL 
					AND e.RoleId = @RoleId
				ORDER BY e.EmployeeId desc
			END
		ELSE
			BEGIN
				SELECT 
					e.EmployeeId,
					e.BranchId,
					b.BranchName,
					e.EmployeeCode,
					e.EmployeeName,
					e.MobileNumber,
					e.EmailAddress,
					e.RoleId,
					r.RoleName,
					e.Password,
					e.Status,
					CASE 
						WHEN e.Status = 1 THEN 'Active' 
						WHEN e.Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM Employees e
				JOIN Branches b ON b.BranchId = e.BranchId
				JOIN Roles r ON r.RoleId = e.RoleId
				WHERE 
					e.DeletedAt IS NULL 
					AND b.DeletedAt IS NULL 
					AND r.DeletedAt IS NULL 
				ORDER BY e.EmployeeId desc
			END
	END;



