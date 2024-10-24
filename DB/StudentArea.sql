use academy_pro_db_v1;


CREATE TABLE LeadSources
(
	LeadSourceId SMALLINT IDENTITY PRIMARY KEY,
	LeadSourceName VARCHAR(50),
	Status BIT DEFAULT 0,
	DeletedAt DATETIME DEFAULT NULL
);


CREATE TABLE Leads
(
	LeadId	INT IDENTITY PRIMARY KEY,
	FirstName VARCHAR(25) NOT NULL,
	LastName VARCHAR(25) NOT NULL,
	EmailAddress VARCHAR(50),
	MobileNumber VARCHAR(15) NOT NULL,
	LeadSourceId INT NOT NULL,
	CourseId INT DEFAULT NULL,
	QualificationId INT DEFAULT NULL,
	PassoutYear	VARCHAR(4) DEFAULT NULL,
	Status	VARCHAR(20)	NOT NULL DEFAULT 'New',
	Remark NVARCHAR(2000)	 DEFAULT NULL,
	AssignedTo INT DEFAULT NULL,
	AssignedAt DATETIME DEFAULT NULL,
	AssignedBy INT DEFAULT NULL,

	CreatedBy INT DEFAULT NULL,
	CreatedAt DATETIME DEFAULT NULL,
	UpdatedBy INT DEFAULT NULL,
	UpdatedAt DATETIME DEFAULT NULL,

	DeletedAt DATETIME DEFAULT NULL,

	CONSTRAINT ENUM_Leads_Status CHECK (Status in ('New', 'Assigned', 'Contacted','Interested','Follow-Up','Enrolled','Not Interested','Pending','Closed'))
);





CREATE TABLE Enquiries
(
    EnquiryId INT IDENTITY PRIMARY KEY,            
    EnquiryDate DateTime NOT NULL ,
    CandidateName VARCHAR(50) NOT NULL ,
    EmailAddress VARCHAR(50) NOT NULL UNIQUE,
    MobileNumber VARCHAR(15) NOT NULL UNIQUE,
    CityId INT NOT NULL ,
    LocalAddress VARCHAR(150) NOT NULL ,
    Gender VARCHAR(10) NOT NULL ,
    QualificationId INT NOT NULL ,
    DateOfBirth DateTime NOT NULL ,
    LeadSourceId INT NOT NULL ,
    EnquiryForId INT NOT NULL ,
    BranchId INT NOT NULL ,
	Status	VARCHAR(20)	NOT NULL DEFAULT 'New',
    Remark VARCHAR(100) DEFAULT NULL ,
    DeletedAt DATETIME DEFAULT NULL,

	CONSTRAINT ENUM_Enquiries_Status CHECK (Status in ('New', 'From-Lead', 'Registered','Enrolled'))
);

CREATE TABLE Students
(
	StudentId INT IDENTITY PRIMARY KEY,
	StudentName VARCHAR(100) NOT NULL,
	StudentCode VARCHAR(15) UNIQUE NOT NULL,
	MobileNumber VARCHAR(15)  NOT NULL,
	EmailAddress VARCHAR(50)  NOT NULL,
	Password VARCHAR(150) NOT NULL,
	ProfilePhoto VARCHAR(100) DEFAULT NULL,
	Status BIT DEFAULT 0,
	DeletedAt DATETIME DEFAULT NULL
);

CREATE TABLE Enrollments(
	StudentEnrollmentId INT IDENTITY(1,1) PRIMARY KEY,
	StudentId INT NULL,
	EnrollmentDate DATE NULL,
	CourseId INT NULL,
	EnrollmentType VARCHAR(50) NULL DEFAULT NULL,
	PaymentStatus VARCHAR(50) NULL DEFAULT NULL,
	CourseFeeId INT NULL DEFAULT NULL,
	DiscountCode VARCHAR(30) NULL DEFAULT NULL,
	DiscountAmount FLOAT NULL DEFAULT NULL,
	PaidAmount FLOAT NULL DEFAULT NULL,
	Status BIT DEFAULT 0,
	StartDate DATE NULL DEFAULT NULL,
	DroppedDate DATE NULL,
	Remarks VARCHAR(50) NULL,
	DeletedAt DATETIME NULL,

	CONSTRAINT ENUM_Enrollments_EnrollmentType CHECK (EnrollmentType in ('Regular', 'Trial', 'Transfer','Special')),
	CONSTRAINT ENUM_Enrollments_PaymentStatus CHECK (PaymentStatus in ('Paid', 'Pending', 'Partially Paid','Overdue','Refunded','Cancelled'))
);

CREATE TABLE StudentPayments
(
	StudentPaymentId INT IDENTITY PRIMARY KEY,
	StudentEnrollmentId INT NOT NULL,
	InstallmentCount TINYINT NOT NULL,
	InstallmentAmount FLOAT DEFAULT 0,
	AmountPaid FLOAT NOT NULL DEFAULT 0,
	InstallmentDate DATE,
	PaidDate DATE NULL DEFAULT NULL,
	PaymentMode VARCHAR(30) NULL DEFAULT NULL,
	TransactionId VARCHAR(20) NULL DEFAULT NULL,
	Screenshot VARCHAR(50) NULL DEFAULT NULL,
	Status BIT NULL DEFAULT 1,
	DeletedAt DATETIME NULL DEFAULT NULL
)

CREATE TABLE StudentPaymentLogs
(
	StudentPaymentLogId INT IDENTITY PRIMARY KEY,
	StudentId INT NOT NULL,
	PaidAmount FLOAT NOT NULL,
	PaymentMode VARCHAR(30) NULL DEFAULT NULL,
	TransactionId VARCHAR(20) NULL DEFAULT NULL,
	Screenshot VARCHAR(50) NULL DEFAULT NULL,
	PaidDate DATETIME DEFAULT GETDATE()
);



CREATE PROCEDURE sp_CreateUpdateDeleteRestore_Leads
(
	@Type VARCHAR(10),
	@LeadId INT = 0,
    @FirstName VARCHAR(25),
    @LastName VARCHAR(25),
	@EmailAddress VARCHAR(50),
	@MobileNumber VARCHAR(15),
	@LeadSourceId INT,
	@CourseId INT = NULL,
	@QualificationId INT = NULL,
	@PassoutYear VARCHAR(4) = NULL,
	@Status	VARCHAR(20),
	@CreatedUpdatedBy INT = NULL,
	@AssignedTo INT = NULL
)
AS
BEGIN
		    IF @Type = 'INSERT'
			BEGIN
				INSERT INTO Leads(FirstName, LastName, EmailAddress, MobileNumber, LeadSourceId, CourseId, QualificationId, PassoutYear, CreatedBy, CreatedAt)
				VALUES ( @FirstName, @LastName, @EmailAddress, @MobileNumber, @LeadSourceId, @CourseId, @QualificationId, @PassoutYear, @CreatedUpdatedBy, GETDATE())
			END

		    IF @Type = 'UPDATE'
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM Leads WHERE LeadId = @LeadId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid LeadId. The specified LeadId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				BEGIN
					UPDATE Leads SET 
					FirstName = @FirstName,
					LastName = @LastName,
					EmailAddress = @EmailAddress,
					MobileNumber = @MobileNumber,
					LeadSourceId = @LeadSourceId,
					CourseId = @CourseId,
					QualificationId = @QualificationId,
					PassoutYear = @PassoutYear,
					Status = @Status,
					UpdatedBy = @CreatedUpdatedBy,
					UpdatedAt = GETDATE()
					WHERE LeadId = @LeadId AND  DeletedAt IS NULL
				END
			END

		    IF @Type = 'DELETE'			-- DELETE BY CourseFeesId
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM Leads WHERE LeadId = @LeadId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid LeadId. The specified LeadId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				UPDATE Leads SET DeletedAt = GETDATE() WHERE LeadId = @LeadId AND DeletedAt IS NULL
			END

		    IF @Type = 'RESTORE'			-- RESTORE BY CourseFeesId
			BEGIN
				UPDATE Leads SET DeletedAt = NULL WHERE LeadId = @LeadId
			END	

		    IF @Type = 'ASSIGNTO'			-- RESTORE BY CourseFeesId
			BEGIN
				UPDATE Leads SET 
					AssignedTo = @AssignedTo,
					AssignedAt = GETDATE(),
					AssignedBy = @CreatedUpdatedBy,
					UpdatedBy = @CreatedUpdatedBy,	
					UpdatedAt = GETDATE(),
					Status = 'Assigned'
				WHERE LeadId = @LeadId
			END

END;



CREATE PROCEDURE sp_GetAll_Leads
(
	@LeadId INT = 0,
	@SearchByColumn VARCHAR(30) = NULL,
	@SearchByValue INT = null
)
AS
BEGIN
	-- If a specific LeadId is provided, return that record
	IF (@LeadId <> 0)
	BEGIN
		SELECT 
			l.LeadId,
			l.FirstName,
			l.LastName,
			l.EmailAddress,
			l.MobileNumber,
			l.LeadSourceId,
			ls.LeadSourceName,
			l.CourseId,
			c.CourseName,
			l.QualificationId,
			q.QualificationName,
			l.PassoutYear,
			l.Status,
			l.Remark,
			l.AssignedTo,
			e1.EmployeeName AssignedToName,
			l.AssignedBy,
			e2.EmployeeName AssignedByName,
			l.AssignedAt,
			l.CreatedBy,
			e3.EmployeeName CreatedByName,
			l.CreatedAt,
			l.UpdatedBy,
			e4.EmployeeName UpdatedByName,
			l.UpdatedAt
		FROM Leads l
		LEFT JOIN LeadSources ls ON ls.LeadSourceId = l.LeadSourceId
		LEFT JOIN Courses c ON c.CourseId = l.CourseId
		LEFT JOIN Qualifications q ON q.QualificationId = l.QualificationId
		LEFT JOIN Employees e1 ON e1.EmployeeId = l.AssignedTo
		LEFT JOIN Employees e2 ON e1.EmployeeId = l.AssignedBy
		LEFT JOIN Employees e3 ON e1.EmployeeId = l.CreatedBy
		LEFT JOIN Employees e4 ON e1.EmployeeId = l.UpdatedBy
		WHERE l.LeadId = @LeadId
			AND l.DeletedAt IS NULL
		ORDER BY l.LeadId DESC;
	END
	-- If searching by a column
	ELSE IF (@SearchByColumn IS NOT NULL)
	BEGIN
		DECLARE @SQL NVARCHAR(MAX);

		-- Build the base dynamic SQL
		SET @SQL = '
			SELECT 
				l.LeadId,
				l.FirstName,
				l.LastName,
				l.EmailAddress,
				l.MobileNumber,
				l.LeadSourceId,
				ls.LeadSourceName,
				l.CourseId,
				c.CourseName,
				l.QualificationId,
				q.QualificationName,
				l.PassoutYear,
				l.Status,
				l.Remark,
				l.AssignedTo,
				e1.EmployeeName AssignedToName,
				l.AssignedBy,
				e2.EmployeeName AssignedByName,
				l.AssignedAt,
				l.CreatedBy,
				e3.EmployeeName CreatedByName,
				l.CreatedAt,
				l.UpdatedBy,
				e4.EmployeeName UpdatedByName,
				l.UpdatedAt
			FROM Leads l
			LEFT JOIN LeadSources ls ON ls.LeadSourceId = l.LeadSourceId
			LEFT JOIN Courses c ON c.CourseId = l.CourseId
			LEFT JOIN Qualifications q ON q.QualificationId = l.QualificationId
			LEFT JOIN Employees e1 ON e1.EmployeeId = l.AssignedTo
			LEFT JOIN Employees e2 ON e1.EmployeeId = l.AssignedBy
			LEFT JOIN Employees e3 ON e1.EmployeeId = l.CreatedBy
			LEFT JOIN Employees e4 ON e1.EmployeeId = l.UpdatedBy
			WHERE l.DeletedAt IS NULL ';

		-- Handle AssignedTo column filtering
		IF(@SearchByColumn = 'AssignedTo')
		BEGIN
			IF (@SearchByValue IS NULL)
			BEGIN
				SET @SQL = @SQL + ' AND l.AssignedTo IS NULL ';
			END
			ELSE IF (@SearchByValue = 0)
			BEGIN
				SET @SQL = @SQL + ' AND l.AssignedTo IS NOT NULL ';
			END
			ELSE
			BEGIN
				SET @SQL = @SQL + ' AND l.AssignedTo = ' + CAST(@SearchByValue AS NVARCHAR(10));
			END
		END
		-- Handle other columns (ensure numeric comparison or string as needed)
		ELSE
		BEGIN
			SET @SQL = @SQL + ' AND l.' + @SearchByColumn + ' = ' + CAST(@SearchByValue AS NVARCHAR(10));
		END

		SET @SQL = @SQL + ' ORDER BY l.LeadId DESC';
		
		-- Execute the dynamic SQL query
		EXEC sp_executesql @SQL;
	END
	-- Default behavior when no specific search criteria is provided
	ELSE
	BEGIN
		SELECT 
			l.LeadId,
			l.FirstName,
			l.LastName,
			l.EmailAddress,
			l.MobileNumber,
			l.LeadSourceId,
			ls.LeadSourceName,
			l.CourseId,
			c.CourseName,
			l.QualificationId,
			q.QualificationName,
			l.PassoutYear,
			l.Status,
			l.Remark,
			l.AssignedTo,
			e1.EmployeeName AssignedToName,
			l.AssignedBy,
			e2.EmployeeName AssignedByName,
			l.AssignedAt,
			l.CreatedBy,
			e3.EmployeeName CreatedByName,
			l.CreatedAt,
			l.UpdatedBy,
			e4.EmployeeName UpdatedByName,
			l.UpdatedAt
		FROM Leads l
		LEFT JOIN LeadSources ls ON ls.LeadSourceId = l.LeadSourceId
		LEFT JOIN Courses c ON c.CourseId = l.CourseId
		LEFT JOIN Qualifications q ON q.QualificationId = l.QualificationId
		LEFT JOIN Employees e1 ON e1.EmployeeId = l.AssignedTo
		LEFT JOIN Employees e2 ON e1.EmployeeId = l.AssignedBy
		LEFT JOIN Employees e3 ON e1.EmployeeId = l.CreatedBy
		LEFT JOIN Employees e4 ON e1.EmployeeId = l.UpdatedBy
		WHERE l.DeletedAt IS NULL
		ORDER BY l.LeadId DESC;
	END
END;


CREATE PROCEDURE sp_UpdateRemark_Leads
(
	@LeadId INT,
	@Remark	NVARCHAR(2000),
	@Status	VARCHAR(20),
	@UpdatedBy INT = NULL
)
AS
BEGIN
	IF NOT EXISTS (SELECT 1 FROM Leads WHERE LeadId = @LeadId AND DeletedAt IS NULL)
		BEGIN
			RAISERROR('Invalid LeadId. The specified LeadId does not exist.', 16, 1)
			RETURN
		END
	ELSE
	BEGIN
		UPDATE Leads SET 
			Remark = @Remark,
			Status = @Status,
			UpdatedBy = @UpdatedBy,
			UpdatedAt = GETDATE()
		WHERE LeadId = @LeadId
	END
END;


CREATE PROCEDURE sp_UpdateRemark_Enquiries
(
	@EnquiryId INT,
	@Remark	NVARCHAR(2000)
)
AS
BEGIN
	IF NOT EXISTS (SELECT 1 FROM Enquiries WHERE EnquiryId = @EnquiryId AND DeletedAt IS NULL)
		BEGIN
			RAISERROR('Invalid EnquiryId. The specified EnquiryId does not exist.', 16, 1)
			RETURN
		END
	ELSE
	BEGIN
		UPDATE Enquiries SET 
			Remark = @Remark
		WHERE EnquiryId = @EnquiryId
	END
END;



CREATE PROCEDURE sp_CreateUpdateDeleteRestore_Enquiries
(
	@Type VARCHAR(10),
	@EnquiryId INT = 0,
    @EnquiryDate DateTime,
    @CandidateName VARCHAR(50),
    @EmailAddress VARCHAR(50),
    @MobileNumber VARCHAR(15),
    @CityId INT,
    @LocalAddress VARCHAR(150),
    @Gender VARCHAR(10),
    @QualificationId INT,
    @DateOfBirth DateTime,
    @LeadSourceId INT,
    @EnquiryForId INT,
    @BranchId INT,
	@Status VARCHAR(20),
    @Remark VARCHAR(100),
	@LastInsertedId INT OUTPUT
)
AS
BEGIN
		    IF @Type = 'INSERT'
			BEGIN
				INSERT INTO Enquiries(EnquiryDate, CandidateName, EmailAddress, MobileNumber, CityId, LocalAddress, Gender, QualificationId, DateOfBirth, LeadSourceId, EnquiryForId, BranchId, Remark, Status) values (@EnquiryDate, @CandidateName, @EmailAddress, @MobileNumber, @CityId, @LocalAddress, @Gender, @QualificationId, @DateOfBirth, @LeadSourceId, @EnquiryForId, @BranchId, @Remark, @Status);
				
				SET @LastInsertedId = SCOPE_IDENTITY();

			END

		    IF @Type = 'UPDATE'
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM Enquiries WHERE EnquiryId = @EnquiryId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid EnquiryId. The specified EnquiryId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				BEGIN
					UPDATE Enquiries SET 
					EnquiryDate = @EnquiryDate,CandidateName = @CandidateName,EmailAddress = @EmailAddress,MobileNumber = @MobileNumber,CityId = @CityId,LocalAddress = @LocalAddress,Gender = @Gender,QualificationId = @QualificationId,DateOfBirth = @DateOfBirth,LeadSourceId = @LeadSourceId,EnquiryForId = @EnquiryForId,BranchId = @BranchId,Remark = @Remark, Status = @Status
					WHERE EnquiryId = @EnquiryId AND  DeletedAt IS NULL

				END
			END

		    IF @Type = 'DELETE'
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM Enquiries WHERE EnquiryId = @EnquiryId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid EnquiryId. The specified EnquiryId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				UPDATE Enquiries SET DeletedAt = GETDATE() WHERE EnquiryId = @EnquiryId AND DeletedAt IS NULL
			END

		    IF @Type = 'RESTORE'
			BEGIN
				UPDATE Enquiries SET DeletedAt = NULL WHERE EnquiryId = @EnquiryId
			END	
END;


CREATE PROCEDURE sp_GetAll_Enquiries
(
	@EnquiryId INT = 0
)
AS
	BEGIN
		IF (@EnquiryId <> 0)
			BEGIN
				SELECT 
					e.EnquiryId,
                    e.EnquiryDate, 
					e.CandidateName, 
					e.EmailAddress, 
					e.MobileNumber, 
					e.CityId, 
					c.CityName,
					e.LocalAddress, 
					e.Gender,
					e.QualificationId,
					q.QualificationName, 
					e.DateOfBirth, 
					e.LeadSourceId,
					l.LeadSourceName, 
					e.EnquiryForId,
					ef.EnquiryForName, 					
					e.BranchId,
					b.BranchName, 
					e.Remark,
					e.Status
                    
				FROM Enquiries e 
				JOIN Cities c ON e.CityId=c.CityId 
				JOIN Qualifications q ON e.QualificationId=q.QualificationId 
				JOIN LeadSources l ON e.LeadSourceId=l.LeadSourceId 
				JOIN Branches b	ON e.BranchId=b.BranchId
				JOIN EnquiryFors ef ON e.EnquiryForId=ef.EnquiryForId
				WHERE 
					e.DeletedAt IS NULL 
					AND c.DeletedAt IS NULL 
					AND q.DeletedAt IS NULL
					AND l.DeletedAt IS NULL
					AND b.DeletedAt IS NULL
					AND ef.DeletedAt IS NULL
					AND (e.Status != 'Registered' AND e.Status != 'Enrolled')
					AND EnquiryId = @EnquiryId
				ORDER BY EnquiryId desc
			END
		ELSE
			BEGIN
				SELECT 
					e.EnquiryId,
                    e.EnquiryDate, 
					e.CandidateName, 
					e.EmailAddress, 
					e.MobileNumber, 
					e.CityId, 
					c.CityName,
					e.LocalAddress, 
					e.Gender,
					e.QualificationId,
					q.QualificationName, 
					e.DateOfBirth, 
					e.LeadSourceId,
					l.LeadSourceName, 
					e.EnquiryForId, 
					ef.EnquiryForName,
					e.BranchId,
					b.BranchName, 
					e.Remark,
					e.Status
                    
				FROM Enquiries e 
				JOIN Cities c ON e.CityId=c.CityId 
				JOIN Qualifications q ON e.QualificationId=q.QualificationId 
				JOIN LeadSources l ON e.LeadSourceId=l.LeadSourceId 
				JOIN Branches b	ON e.BranchId=b.BranchId   
				JOIN EnquiryFors ef ON e.EnquiryForId=ef.EnquiryForId				
				
				WHERE 
					e.DeletedAt IS NULL 
					AND c.DeletedAt IS NULL 
					AND q.DeletedAt IS NULL
					AND l.DeletedAt IS NULL
					AND b.DeletedAt IS NULL
					AND ef.DeletedAt IS NULL
					AND (e.Status != 'Registered' AND e.Status != 'Enrolled')

				ORDER BY EnquiryId desc
			END
	END;



CREATE PROCEDURE sp_CreateUpdateDeleteRestore_EnquiryFors
(
	@Type VARCHAR(10),
	@EnquiryForId INT = 0,
    @EnquiryForName VARCHAR(50),
	@Status BIT = 0
)
AS
BEGIN
		    IF @Type = 'INSERT'
			BEGIN
				INSERT INTO EnquiryFors(EnquiryForName, Status) values ( @EnquiryForName, @Status)
			END

		    IF @Type = 'UPDATE'			-- UPDATE BY EnquireForId
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM EnquiryFors WHERE EnquiryForId = @EnquiryForId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid LeadSource. The specified EnquiryForId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				BEGIN
					UPDATE EnquiryFors  SET 
					EnquiryForName = @EnquiryForName,
					Status = @Status
					WHERE EnquiryForId = @EnquiryForId AND  DeletedAt IS NULL
				END
			END

		    IF @Type = 'DELETE'			-- DELETE BY EnquiryForId
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM EnquiryFors  WHERE EnquiryForId = @EnquiryForId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid EnquiryFor. The specified EnquiryForId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				UPDATE EnquiryFors  SET DeletedAt = GETDATE() WHERE EnquiryForId = @EnquiryForId AND DeletedAt IS NULL
			END

		    IF @Type = 'RESTORE'			-- RESTORE BY EnquiryForId
			BEGIN
				UPDATE EnquiryFors  SET DeletedAt = NULL WHERE EnquiryForId = @EnquiryForId
			END	
END;



CREATE PROCEDURE sp_GetAll_EnquiryFors
(
	@EnquiryForId INT = 0
)
AS
	BEGIN
		IF (@EnquiryForId <> 0)
			BEGIN
				SELECT 
					EnquiryForId,
					EnquiryForName,
					Status,
					CASE 
						WHEN Status = 1 THEN 'Active' 
						WHEN Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM EnquiryFors
				WHERE 
					DeletedAt IS NULL 
					AND EnquiryForId = @EnquiryForId
				ORDER BY EnquiryForId desc
			END
		ELSE		
			BEGIN
				SELECT 
					EnquiryForId,
					EnquiryForName,
					Status,
					CASE 
						WHEN Status = 1 THEN 'Active' 
						WHEN Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM EnquiryFors
				WHERE 
					DeletedAt IS NULL 					
				ORDER BY EnquiryForId desc
			END
	END;




CREATE PROCEDURE sp_CreateUpdateDeleteRestore_Enrollments
(
    @Type VARCHAR(10),
    @StudentEnrollmentId INT = NULL,
    @StudentId INT = NULL,
    @EnrollmentDate DATETIME = NULL,
    @CourseId INT = NULL,
    @EnrollmentType VARCHAR(50) = NULL,
    @PaymentStatus VARCHAR(50) = NULL,
    @CourseFeeId INT = NULL,
    @DiscountCode VARCHAR(30) = NULL,
    @DiscountAmount FLOAT = NULL,
    @PaidAmount FLOAT = NULL,
    @StartDate DATE = NULL,
    @DroppedDate DATE = NULL,
    @Remarks VARCHAR(50) = NULL,
    @LastInsertedId INT OUTPUT  -- Add output parameter here

)
AS
BEGIN
    
    IF @Type = 'INSERT'
    BEGIN
        INSERT INTO Enrollments
        (
            StudentId, EnrollmentDate, CourseId, EnrollmentType,
            PaymentStatus, CourseFeeId, DiscountCode, DiscountAmount, 
            PaidAmount, StartDate, Status, Remarks
        )
        VALUES
        (
            @StudentId, @EnrollmentDate, @CourseId, @EnrollmentType,
            @PaymentStatus, @CourseFeeId, @DiscountCode, @DiscountAmount, 
            @PaidAmount, @StartDate, 1, @Remarks  
        )
		SET @LastInsertedId = SCOPE_IDENTITY();

    END

    IF @Type = 'UPDATE'
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM Enrollments WHERE StudentEnrollmentId = @StudentEnrollmentId AND DeletedAt IS NULL)
        BEGIN
            RAISERROR('Invalid StudentEnrollmentId. The specified record does not exist or has been deleted.', 16, 1);
            RETURN;
        END
        ELSE
        BEGIN
            UPDATE Enrollments
            SET
                StudentId = @StudentId,
                EnrollmentDate = @EnrollmentDate,
                CourseId = @CourseId,
                EnrollmentType = @EnrollmentType,
                PaymentStatus = @PaymentStatus,
                CourseFeeId = @CourseFeeId,
                DiscountCode = @DiscountCode,
                DiscountAmount = @DiscountAmount,
                PaidAmount = @PaidAmount,
                StartDate = @StartDate,
                DroppedDate = @DroppedDate,
                Remarks = @Remarks
            WHERE 
				StudentEnrollmentId = @StudentEnrollmentId
				AND DeletedAt IS NULL
        END
    END

    -- DELETE operation (Logical delete)
    IF @Type = 'DELETE'
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM Enrollments WHERE StudentEnrollmentId = @StudentEnrollmentId AND DeletedAt IS NULL)
        BEGIN
            RAISERROR('Invalid StudentEnrollmentId. The specified record does not exist or has been deleted.', 16, 1);
            RETURN;
        END
        ELSE
        BEGIN
            UPDATE Enrollments
            SET DeletedAt = GETDATE(), Status = 0  
            WHERE StudentEnrollmentId = @StudentEnrollmentId AND DeletedAt IS NULL
        END
    END


    IF @Type = 'RESTORE'
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM Enrollments WHERE StudentEnrollmentId = @StudentEnrollmentId AND DeletedAt IS NOT NULL)
        BEGIN
            RAISERROR('Invalid StudentEnrollmentId. The specified record has not been deleted.', 16, 1);
            RETURN;
        END
        ELSE
        BEGIN
            UPDATE Enrollments
            SET DeletedAt = NULL, Status = 1 
            WHERE StudentEnrollmentId = @StudentEnrollmentId;
        END
    END
END;



CREATE PROCEDURE sp_GetAll_EnrollmentWiseStudentPayments
(
    @StudentId INT
)
AS
BEGIN
    SELECT 
        e.StudentEnrollmentId,
        e.StudentId,
        e.CourseId,
        c.CourseName,
        e.EnrollmentDate,
        e.Status,
        sp.StudentPaymentId,
        sp.InstallmentCount,
        sp.InstallmentAmount,
        sp.AmountPaid,
        sp.InstallmentDate,
        sp.PaidDate,
        sp.PaymentMode,
        sp.TransactionId,
        sp.Screenshot,
        sp.Status AS PaymentStatus,
        sp.DeletedAt AS PaymentDeletedAt
    FROM Enrollments e
    JOIN Courses c ON c.CourseId = e.CourseId
    LEFT JOIN StudentPayments sp ON sp.StudentEnrollmentId = e.StudentEnrollmentId
    WHERE 
        e.DeletedAt IS NULL
        AND c.DeletedAt IS NULL
        AND e.Status = 1
        AND e.StudentId = @StudentId
    ORDER BY e.StudentEnrollmentId, sp.InstallmentDate;
END;


CREATE PROCEDURE sp_GetAll_Enrollments
(
	@StudentEnrollmentId int = 0,
	@Status BIT = NULL
)

AS
BEGIN
    if(@StudentEnrollmentId<>0)
	BEGIN
		SELECT 
			e.StudentEnrollmentId,
			e.StudentId,
			s.StudentName,
			s.MobileNumber,
			s.EmailAddress,
			s.ProfilePhoto,
			e.EnrollmentDate,
			e.CourseId,
			c.CourseName,
			e.EnrollmentType,
			e.PaymentStatus,
			e.CourseFeeId,
			e.DiscountCode,
			e.DiscountAmount,
			e.PaidAmount,
			e.StartDate,
			e.DroppedDate,
			e.Remarks,
			e.Status,
            CASE 
                WHEN e.Status = 1 THEN 'Active' 
                WHEN e.Status = 0 THEN 'Inactive' 
                ELSE 'Unknown'
            END AS StatusLabel  -- Custom StatusLabel column

		FROM 
			Enrollments e
			JOIN Students s ON s.StudentId = e.StudentId
			JOIN Courses c ON c.CourseId= e.CourseId
		WHERE 
			e.DeletedAt IS NULL
			AND s.DeletedAt IS NULL
			AND c.DeletedAt IS NULL
			AND e.StudentEnrollmentId=@StudentEnrollmentId
			AND (@Status IS NULL OR e.Status = @Status) -- Condition to handle @Status
		END
	ELSE
		BEGIN
		SELECT 
			e.StudentEnrollmentId,
			e.StudentId,
			s.StudentName,
			s.MobileNumber,
			s.EmailAddress,
			s.ProfilePhoto,
			e.EnrollmentDate,
			e.CourseId,
			c.CourseName,
			e.EnrollmentType,
			e.PaymentStatus,
			e.CourseFeeId,
			e.DiscountCode,
			e.DiscountAmount,
			e.PaidAmount,
			e.StartDate,
			e.DroppedDate,
			e.Remarks,
			e.Status,
            CASE 
                WHEN e.Status = 1 THEN 'Active' 
                WHEN e.Status = 0 THEN 'Inactive' 
                ELSE 'Unknown'
            END AS StatusLabel  -- Custom StatusLabel column

		FROM 
			Enrollments e
			JOIN Students s ON s.StudentId = e.StudentId
			JOIN Courses c ON c.CourseId= e.CourseId
		WHERE 
			e.DeletedAt IS NULL
			AND s.DeletedAt IS NULL
			AND c.DeletedAt IS NULL	 
			AND (@Status IS NULL OR e.Status = @Status) -- Condition to handle @Status
		END
END;



CREATE PROCEDURE sp_CreateUpdateDeleteRestore_Students
(
    @Type VARCHAR(15),
    @StudentId INT = NULL,
	@Password VARCHAR(150)=Null,
    @StudentName VARCHAR(100)=Null,
    @StudentCode VARCHAR(15)=Null,
    @MobileNumber VARCHAR(15)=Null,
    @EmailAddress VARCHAR(50)=Null,
	@ProfilePhoto VARCHAR(100) = NULL,
    @Status BIT = 0,
	@LastInsertedId INT OUTPUT
)
AS
BEGIN
  
    IF @Type = 'INSERT'
    BEGIN
        INSERT INTO Students
        (
            StudentName, StudentCode, MobileNumber, EmailAddress, ProfilePhoto, Password, Status
        )
        VALUES
        (
            @StudentName, @StudentCode, @MobileNumber, @EmailAddress, @ProfilePhoto,  @Password, @Status
        )
		SET @LastInsertedId = SCOPE_IDENTITY();


    END

    IF @Type = 'ProfilePhoto'
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM Students WHERE StudentId = @StudentId AND DeletedAt IS NULL)
        BEGIN
            RAISERROR('Invalid StudentId. The specified StudentId does not exist.', 16, 1)
            RETURN
        END
        ELSE
        BEGIN
            UPDATE Students SET ProfilePhoto = @ProfilePhoto WHERE StudentId = @StudentId AND DeletedAt IS NULL
        END
    END


    IF @Type = 'ChangePassword'
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM Students WHERE StudentId = @StudentId AND DeletedAt IS NULL)
        BEGIN
            RAISERROR('Invalid StudentId. The specified StudentId does not exist.', 16, 1)
            RETURN
        END
        ELSE
        BEGIN
          
            UPDATE Students SET Password = @Password WHERE StudentId = @StudentId AND DeletedAt IS NULL
        END
    END

    IF @Type = 'UPDATE'
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM Students WHERE StudentId = @StudentId AND DeletedAt IS NULL)
        BEGIN
            RAISERROR('Invalid StudentId. The specified StudentId does not exist.', 16, 1)
            RETURN
        END
        ELSE
        BEGIN
            UPDATE Students SET
                StudentName = @StudentName,
                MobileNumber = @MobileNumber,
                EmailAddress = @EmailAddress,
                Status = @Status
            WHERE StudentId = @StudentId AND DeletedAt IS NULL
        END
    END

 
    IF @Type = 'DELETE'
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM Students WHERE StudentId = @StudentId AND DeletedAt IS NULL)
        BEGIN
            RAISERROR('Invalid StudentId. The specified StudentId does not exist.', 16, 1)
            RETURN
        END
        ELSE
        BEGIN
            UPDATE Students SET DeletedAt = GETDATE() WHERE StudentId = @StudentId AND DeletedAt IS NULL
        END
    END

    IF @Type = 'RESTORE'
    BEGIN
        UPDATE Students SET DeletedAt = NULL WHERE StudentId = @StudentId
    END

    IF @Type = 'STATUS'
    BEGIN
        UPDATE Students SET Status = @Status WHERE StudentId = @StudentId
    END

END;



CREATE PROCEDURE sp_GetAll_Students
(
    @StudentId INT = 0,  -- Optional parameter for filtering by StudentId
	@Status BIT = NULL
)
AS
BEGIN
    IF (@StudentId <> 0)
    BEGIN
        SELECT 
            s.StudentId,
            s.StudentName,
            s.StudentCode,
            s.MobileNumber,
            s.EmailAddress,
            s.Password,
            ISNULL(s.ProfilePhoto, '-') AS ProfilePhoto, -- If ProfilePhoto is NULL, return '-'
            s.Status,
            CASE 
                WHEN s.Status = 1 THEN 'Active' 
                WHEN s.Status = 0 THEN 'Inactive' 
                ELSE 'Unknown'
            END AS StatusLabel,  -- Custom StatusLabel column
            s.DeletedAt
        FROM 
            Students s
        WHERE 
            s.DeletedAt IS NULL 
            AND s.StudentId = @StudentId  -- Fetch a specific student
			AND (@Status IS NULL OR s.Status = @Status)

        ORDER BY 
            s.StudentId DESC;
    END
    ELSE
    BEGIN
        SELECT 
            s.StudentId,
            s.StudentName,
            s.StudentCode,
            s.MobileNumber,
            s.EmailAddress,
            s.Password,
            ISNULL(s.ProfilePhoto, '-') AS ProfilePhoto, -- If ProfilePhoto is NULL, return '-'
            s.Status,
            CASE 
                WHEN s.Status = 1 THEN 'Active' 
                WHEN s.Status = 0 THEN 'Inactive' 
                ELSE 'Unknown'
            END AS StatusLabel,  -- Custom StatusLabel column
            s.DeletedAt
        FROM 
            Students s
        WHERE 
            s.DeletedAt IS NULL  -- Fetch only non-deleted records
			AND (@Status IS NULL OR s.Status = @Status)

        ORDER BY 
            s.StudentId DESC;
    END
END;



CREATE PROCEDURE sp_GetNextPendingPayment_studentPayments
	@StudentEnrollmentId INT,
	@NextStudentPaymentId INT OUTPUT
AS
BEGIN
	-- Fetch the StudentPaymentId with status = 0 and the earliest InstallmentDate
	SELECT TOP 1 @NextStudentPaymentId = StudentPaymentId
	FROM StudentPayments
	WHERE 
		StudentEnrollmentId = @StudentEnrollmentId
		AND Status = 0
	ORDER BY InstallmentDate ASC;
END;




CREATE PROCEDURE sp_UpdateStudentPayment_StudentPayments
	@StudentEnrollmentIdIn INT,
	@StudentPaymentId INT = 0,
	@NewAmountPaid FLOAT,
	@PaymentMode VARCHAR(30),
	@TransactionId VARCHAR(20),
	@Screenshot VARCHAR(50),
	@CustomStatus BIT
AS
BEGIN
	-- Start transaction
	BEGIN TRANSACTION;

	-- Declare variables
	DECLARE @InstallmentAmount FLOAT;
	DECLARE @AmountPaid FLOAT;
	DECLARE @StudentEnrollmentId INT;
	DECLARE @ExcessAmount FLOAT;
	DECLARE @NextStudentPaymentId INT;

	-- Call GetNextPendingPayment to fetch the next pending payment ID
	EXEC sp_GetNextPendingPayment_studentPayments @StudentEnrollmentIdIn, @NextStudentPaymentId OUTPUT;


	-- If @StudentPaymentId is 0, use the result from GetNextPendingPayment
	IF @StudentPaymentId = 0
	BEGIN
		SET @StudentPaymentId = @NextStudentPaymentId;
	END

	-- Fetch existing data for the student payment
	SELECT 
		@InstallmentAmount = InstallmentAmount,
		@AmountPaid = AmountPaid,
		@StudentEnrollmentId = StudentEnrollmentId
	FROM StudentPayments
	WHERE StudentPaymentId = @NextStudentPaymentId;

	-- Calculate the latest amount paid
	SET @AmountPaid = @AmountPaid + @NewAmountPaid;

	-- Check if the amount exceeds the installment amount
	IF @AmountPaid > @InstallmentAmount
	BEGIN
		-- Calculate the excess amount
		SET @ExcessAmount = @AmountPaid - @InstallmentAmount;

		-- Update the current installment with the maximum allowable amount
		UPDATE StudentPayments
		SET 
			AmountPaid = @InstallmentAmount,
			PaymentMode = @PaymentMode,
			TransactionId = @TransactionId,
			Screenshot = @Screenshot,
			PaidDate = GETDATE(),
			Status = 1 -- Mark as fully paid
		WHERE StudentPaymentId = @StudentPaymentId;

		-- Use CTE to update the next unpaid installment (Status = 0) in the correct order
		;WITH NextInstallment AS (
			SELECT TOP 1 StudentPaymentId
			FROM StudentPayments
			WHERE 
				StudentEnrollmentId = @StudentEnrollmentId
				AND Status = 0
			ORDER BY InstallmentDate ASC
		)
		UPDATE StudentPayments
		SET 
			AmountPaid = AmountPaid + @ExcessAmount,
			PaidDate = GETDATE(),
			Status = CASE WHEN (AmountPaid + @ExcessAmount) >= InstallmentAmount THEN 1 ELSE 0 END
		FROM NextInstallment
		WHERE StudentPayments.StudentPaymentId = NextInstallment.StudentPaymentId;

	END
	ELSE
	BEGIN
		-- Update the current installment
		UPDATE StudentPayments
		SET 
			AmountPaid = @AmountPaid,
			PaymentMode = @PaymentMode,
			TransactionId = @TransactionId,
			Screenshot = @Screenshot,
			PaidDate = GETDATE(),
			Status = CASE WHEN @AmountPaid >= @InstallmentAmount THEN 1 ELSE @CustomStatus END
		WHERE StudentPaymentId = @StudentPaymentId;
	END

	-- Commit transaction
	COMMIT TRANSACTION;
END;



CREATE PROCEDURE sp_CreateUpdateDeleteRestore_StudentPayments
(
	@Type VARCHAR(10),
	@StudentPaymentId INT = 0, 
	@StudentEnrollmentId INT = 0,
	@InstallmentCount TINYINT = 0,
	@InstallmentAmount FLOAT = 0,
	@InstallmentDate DATE = NULL,
	@Status BIT = 0
)
AS
BEGIN
		IF @Type = 'INSERT'
		BEGIN
			INSERT INTO StudentPayments(StudentEnrollmentId, InstallmentCount,InstallmentAmount, InstallmentDate,status) 
			values (@StudentEnrollmentId, @InstallmentCount, @InstallmentAmount, @InstallmentDate,0)
		END
		
		IF @Type = 'PAYNOW'
		BEGIN
			UPDATE StudentPayments 
				SET 
				AmountPaid=0,
				PaymentMode='cash',
				TransactionId='' ,
				Screenshot = '',
				PaidDate=GETDATE()
		END
END;


