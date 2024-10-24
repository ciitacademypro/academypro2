USE [academy_pro_db_v1]
GO
/****** Object:  UserDefinedTableType [dbo].[ColumnValuePair_type]    Script Date: 24-Oct-24 6:10:03 PM ******/
CREATE TYPE [dbo].[ColumnValuePair_type] AS TABLE(
	[ColumnName] [nvarchar](50) NULL,
	[Value] [nvarchar](100) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[CourseFees_type]    Script Date: 24-Oct-24 6:10:03 PM ******/
CREATE TYPE [dbo].[CourseFees_type] AS TABLE(
	[TotalInstallments] [tinyint] NOT NULL,
	[FeeAmount] [float] NOT NULL,
	[GstPercentage] [float] NOT NULL
)
GO
/****** Object:  Table [dbo].[Branches]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branches](
	[BranchId] [smallint] IDENTITY(1,1) NOT NULL,
	[BranchName] [varchar](50) NULL,
	[Status] [bit] NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[BranchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[CityId] [int] IDENTITY(1,1) NOT NULL,
	[StateId] [int] NULL,
	[CityName] [varchar](50) NULL,
	[Status] [bit] NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryId] [smallint] IDENTITY(1,1) NOT NULL,
	[CountryName] [varchar](50) NULL,
	[Status] [bit] NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseCategories]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseCategories](
	[CourseCategoryId] [smallint] IDENTITY(1,1) NOT NULL,
	[ParentId] [smallint] NULL,
	[CourseCategoryName] [varchar](100) NOT NULL,
	[Status] [bit] NULL,
	[CourseCategoryOrder] [smallint] NOT NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[CourseCategoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseFees]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseFees](
	[CourseFeeId] [int] IDENTITY(1,1) NOT NULL,
	[CourseId] [smallint] NULL,
	[TotalInstallments] [tinyint] NOT NULL,
	[FeeAmount] [float] NOT NULL,
	[GstPercentage] [float] NOT NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseFeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseModuleContents]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseModuleContents](
	[CourseModuleContentId] [int] IDENTITY(1,1) NOT NULL,
	[CourseModuleId] [int] NOT NULL,
	[ContentName] [varchar](250) NOT NULL,
	[ContentDescription] [nvarchar](max) NULL,
	[DurationInHrs] [tinyint] NULL,
	[ContentOrder] [smallint] NOT NULL,
	[Status] [bit] NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseModuleContentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseModules]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseModules](
	[CourseModuleId] [int] IDENTITY(1,1) NOT NULL,
	[CourseId] [smallint] NULL,
	[ModuleName] [varchar](250) NOT NULL,
	[ModuleDescription] [nvarchar](max) NULL,
	[ModuleOrder] [smallint] NOT NULL,
	[Status] [bit] NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseModuleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[CourseId] [smallint] IDENTITY(1,1) NOT NULL,
	[CourseCategoryId] [smallint] NOT NULL,
	[CourseName] [nvarchar](100) NOT NULL,
	[CourseDescription] [nvarchar](max) NULL,
	[CourseLevel] [varchar](30) NOT NULL,
	[Status] [bit] NULL,
	[CourseOrder] [smallint] NOT NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[BranchId] [smallint] NOT NULL,
	[EmployeeCode] [varchar](10) NOT NULL,
	[EmployeeName] [varchar](100) NOT NULL,
	[MobileNumber] [varchar](15) NULL,
	[EmailAddress] [varchar](50) NULL,
	[RoleId] [tinyint] NULL,
	[Password] [varchar](150) NULL,
	[Status] [bit] NOT NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[EmployeeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[MobileNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[EmailAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Enquiries]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enquiries](
	[EnquiryId] [int] IDENTITY(1,1) NOT NULL,
	[EnquiryDate] [datetime] NOT NULL,
	[CandidateName] [varchar](50) NOT NULL,
	[EmailAddress] [varchar](50) NOT NULL,
	[MobileNumber] [varchar](15) NOT NULL,
	[CityId] [int] NOT NULL,
	[LocalAddress] [varchar](150) NOT NULL,
	[Gender] [varchar](10) NOT NULL,
	[QualificationId] [int] NOT NULL,
	[DateOfBirth] [datetime] NOT NULL,
	[LeadSourceId] [int] NOT NULL,
	[EnquiryForId] [int] NOT NULL,
	[BranchId] [int] NOT NULL,
	[Status] [varchar](20) NOT NULL,
	[Remark] [varchar](100) NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[EnquiryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[MobileNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[EmailAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EnquiryFors]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnquiryFors](
	[EnquiryForId] [smallint] IDENTITY(1,1) NOT NULL,
	[EnquiryForName] [varchar](50) NOT NULL,
	[Status] [bit] NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[EnquiryForId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[EnquiryForName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Enrollments]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enrollments](
	[StudentEnrollmentId] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NULL,
	[EnrollmentDate] [date] NULL,
	[CourseId] [int] NULL,
	[EnrollmentType] [varchar](50) NULL,
	[PaymentStatus] [varchar](50) NULL,
	[CourseFeeId] [int] NULL,
	[DiscountCode] [varchar](30) NULL,
	[DiscountAmount] [float] NULL,
	[PaidAmount] [float] NULL,
	[Status] [bit] NULL,
	[StartDate] [date] NULL,
	[DroppedDate] [date] NULL,
	[Remarks] [varchar](50) NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentEnrollmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Leads]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Leads](
	[LeadId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](25) NOT NULL,
	[LastName] [varchar](25) NOT NULL,
	[EmailAddress] [varchar](50) NULL,
	[MobileNumber] [varchar](15) NOT NULL,
	[LeadSourceId] [int] NOT NULL,
	[CourseId] [int] NULL,
	[QualificationId] [int] NULL,
	[PassoutYear] [varchar](4) NULL,
	[Status] [varchar](20) NOT NULL,
	[Remark] [nvarchar](2000) NULL,
	[AssignedTo] [int] NULL,
	[AssignedAt] [datetime] NULL,
	[AssignedBy] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedAt] [datetime] NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LeadId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeadSources]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeadSources](
	[LeadSourceId] [smallint] IDENTITY(1,1) NOT NULL,
	[LeadSourceName] [varchar](50) NULL,
	[Status] [bit] NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LeadSourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Qualifications]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qualifications](
	[QualificationId] [smallint] IDENTITY(1,1) NOT NULL,
	[QualificationName] [varchar](50) NULL,
	[Status] [bit] NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[QualificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [smallint] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NULL,
	[Status] [bit] NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[States]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[States](
	[StateId] [int] IDENTITY(1,1) NOT NULL,
	[CountryId] [smallint] NULL,
	[StateName] [varchar](50) NULL,
	[Status] [bit] NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentPaymentLogs]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentPaymentLogs](
	[StudentPaymentLogId] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NOT NULL,
	[PaidAmount] [float] NOT NULL,
	[PaymentMode] [varchar](30) NULL,
	[TransactionId] [varchar](20) NULL,
	[Screenshot] [varchar](50) NULL,
	[PaidDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentPaymentLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentPayments]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentPayments](
	[StudentPaymentId] [int] IDENTITY(1,1) NOT NULL,
	[StudentEnrollmentId] [int] NOT NULL,
	[InstallmentCount] [tinyint] NOT NULL,
	[InstallmentAmount] [float] NULL,
	[AmountPaid] [float] NOT NULL,
	[InstallmentDate] [date] NULL,
	[PaidDate] [date] NULL,
	[PaymentMode] [varchar](30) NULL,
	[TransactionId] [varchar](20) NULL,
	[Screenshot] [varchar](50) NULL,
	[Status] [bit] NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentPaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[StudentId] [int] IDENTITY(1,1) NOT NULL,
	[StudentName] [varchar](100) NOT NULL,
	[StudentCode] [varchar](15) NOT NULL,
	[MobileNumber] [varchar](15) NOT NULL,
	[EmailAddress] [varchar](50) NOT NULL,
	[Password] [varchar](150) NOT NULL,
	[ProfilePhoto] [varchar](100) NULL,
	[Status] [bit] NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[StudentCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Branches] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Branches] ADD  DEFAULT (NULL) FOR [DeletedAt]
GO
ALTER TABLE [dbo].[Cities] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Cities] ADD  DEFAULT (NULL) FOR [DeletedAt]
GO
ALTER TABLE [dbo].[Countries] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Countries] ADD  DEFAULT (NULL) FOR [DeletedAt]
GO
ALTER TABLE [dbo].[CourseCategories] ADD  DEFAULT (NULL) FOR [ParentId]
GO
ALTER TABLE [dbo].[CourseCategories] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[CourseCategories] ADD  DEFAULT ((1)) FOR [CourseCategoryOrder]
GO
ALTER TABLE [dbo].[CourseCategories] ADD  DEFAULT (NULL) FOR [DeletedAt]
GO
ALTER TABLE [dbo].[CourseFees] ADD  DEFAULT ((0)) FOR [FeeAmount]
GO
ALTER TABLE [dbo].[CourseFees] ADD  DEFAULT ((0)) FOR [GstPercentage]
GO
ALTER TABLE [dbo].[CourseFees] ADD  DEFAULT (NULL) FOR [DeletedAt]
GO
ALTER TABLE [dbo].[CourseModuleContents] ADD  DEFAULT (NULL) FOR [ContentDescription]
GO
ALTER TABLE [dbo].[CourseModuleContents] ADD  DEFAULT ((1)) FOR [ContentOrder]
GO
ALTER TABLE [dbo].[CourseModuleContents] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[CourseModuleContents] ADD  DEFAULT (NULL) FOR [DeletedAt]
GO
ALTER TABLE [dbo].[CourseModules] ADD  DEFAULT (NULL) FOR [CourseId]
GO
ALTER TABLE [dbo].[CourseModules] ADD  DEFAULT (NULL) FOR [ModuleDescription]
GO
ALTER TABLE [dbo].[CourseModules] ADD  DEFAULT ((1)) FOR [ModuleOrder]
GO
ALTER TABLE [dbo].[CourseModules] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[CourseModules] ADD  DEFAULT (NULL) FOR [DeletedAt]
GO
ALTER TABLE [dbo].[Courses] ADD  DEFAULT (NULL) FOR [CourseDescription]
GO
ALTER TABLE [dbo].[Courses] ADD  DEFAULT ('Beginner') FOR [CourseLevel]
GO
ALTER TABLE [dbo].[Courses] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Courses] ADD  DEFAULT ((1)) FOR [CourseOrder]
GO
ALTER TABLE [dbo].[Courses] ADD  DEFAULT (NULL) FOR [DeletedAt]
GO
ALTER TABLE [dbo].[Employees] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Employees] ADD  DEFAULT (NULL) FOR [DeletedAt]
GO
ALTER TABLE [dbo].[Enquiries] ADD  DEFAULT ('New') FOR [Status]
GO
ALTER TABLE [dbo].[Enquiries] ADD  DEFAULT (NULL) FOR [Remark]
GO
ALTER TABLE [dbo].[Enquiries] ADD  DEFAULT (NULL) FOR [DeletedAt]
GO
ALTER TABLE [dbo].[EnquiryFors] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[EnquiryFors] ADD  DEFAULT (NULL) FOR [DeletedAt]
GO
ALTER TABLE [dbo].[Enrollments] ADD  DEFAULT (NULL) FOR [EnrollmentType]
GO
ALTER TABLE [dbo].[Enrollments] ADD  DEFAULT (NULL) FOR [PaymentStatus]
GO
ALTER TABLE [dbo].[Enrollments] ADD  DEFAULT (NULL) FOR [CourseFeeId]
GO
ALTER TABLE [dbo].[Enrollments] ADD  DEFAULT (NULL) FOR [DiscountCode]
GO
ALTER TABLE [dbo].[Enrollments] ADD  DEFAULT (NULL) FOR [DiscountAmount]
GO
ALTER TABLE [dbo].[Enrollments] ADD  DEFAULT (NULL) FOR [PaidAmount]
GO
ALTER TABLE [dbo].[Enrollments] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Enrollments] ADD  DEFAULT (NULL) FOR [StartDate]
GO
ALTER TABLE [dbo].[Leads] ADD  DEFAULT (NULL) FOR [CourseId]
GO
ALTER TABLE [dbo].[Leads] ADD  DEFAULT (NULL) FOR [QualificationId]
GO
ALTER TABLE [dbo].[Leads] ADD  DEFAULT (NULL) FOR [PassoutYear]
GO
ALTER TABLE [dbo].[Leads] ADD  DEFAULT ('New') FOR [Status]
GO
ALTER TABLE [dbo].[Leads] ADD  DEFAULT (NULL) FOR [Remark]
GO
ALTER TABLE [dbo].[Leads] ADD  DEFAULT (NULL) FOR [AssignedTo]
GO
ALTER TABLE [dbo].[Leads] ADD  DEFAULT (NULL) FOR [AssignedAt]
GO
ALTER TABLE [dbo].[Leads] ADD  DEFAULT (NULL) FOR [AssignedBy]
GO
ALTER TABLE [dbo].[Leads] ADD  DEFAULT (NULL) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[Leads] ADD  DEFAULT (NULL) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Leads] ADD  DEFAULT (NULL) FOR [UpdatedBy]
GO
ALTER TABLE [dbo].[Leads] ADD  DEFAULT (NULL) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[Leads] ADD  DEFAULT (NULL) FOR [DeletedAt]
GO
ALTER TABLE [dbo].[LeadSources] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[LeadSources] ADD  DEFAULT (NULL) FOR [DeletedAt]
GO
ALTER TABLE [dbo].[Qualifications] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Qualifications] ADD  DEFAULT (NULL) FOR [DeletedAt]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT (NULL) FOR [DeletedAt]
GO
ALTER TABLE [dbo].[States] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[States] ADD  DEFAULT (NULL) FOR [DeletedAt]
GO
ALTER TABLE [dbo].[StudentPaymentLogs] ADD  DEFAULT (NULL) FOR [PaymentMode]
GO
ALTER TABLE [dbo].[StudentPaymentLogs] ADD  DEFAULT (NULL) FOR [TransactionId]
GO
ALTER TABLE [dbo].[StudentPaymentLogs] ADD  DEFAULT (NULL) FOR [Screenshot]
GO
ALTER TABLE [dbo].[StudentPaymentLogs] ADD  DEFAULT (getdate()) FOR [PaidDate]
GO
ALTER TABLE [dbo].[StudentPayments] ADD  DEFAULT ((0)) FOR [InstallmentAmount]
GO
ALTER TABLE [dbo].[StudentPayments] ADD  DEFAULT ((0)) FOR [AmountPaid]
GO
ALTER TABLE [dbo].[StudentPayments] ADD  DEFAULT (NULL) FOR [PaidDate]
GO
ALTER TABLE [dbo].[StudentPayments] ADD  DEFAULT (NULL) FOR [PaymentMode]
GO
ALTER TABLE [dbo].[StudentPayments] ADD  DEFAULT (NULL) FOR [TransactionId]
GO
ALTER TABLE [dbo].[StudentPayments] ADD  DEFAULT (NULL) FOR [Screenshot]
GO
ALTER TABLE [dbo].[StudentPayments] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[StudentPayments] ADD  DEFAULT (NULL) FOR [DeletedAt]
GO
ALTER TABLE [dbo].[Students] ADD  DEFAULT (NULL) FOR [ProfilePhoto]
GO
ALTER TABLE [dbo].[Students] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Students] ADD  DEFAULT (NULL) FOR [DeletedAt]
GO
ALTER TABLE [dbo].[CourseFees]  WITH CHECK ADD  CONSTRAINT [FK_CourseFees_CourseId] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([CourseId])
GO
ALTER TABLE [dbo].[CourseFees] CHECK CONSTRAINT [FK_CourseFees_CourseId]
GO
ALTER TABLE [dbo].[CourseModules]  WITH CHECK ADD  CONSTRAINT [FK_CourseModules_CourseId] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([CourseId])
GO
ALTER TABLE [dbo].[CourseModules] CHECK CONSTRAINT [FK_CourseModules_CourseId]
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD  CONSTRAINT [ENUM_Courses_CourseLevel] CHECK  (([CourseLevel]='Expert' OR [CourseLevel]='Intermediate' OR [CourseLevel]='Beginner'))
GO
ALTER TABLE [dbo].[Courses] CHECK CONSTRAINT [ENUM_Courses_CourseLevel]
GO
ALTER TABLE [dbo].[Enquiries]  WITH CHECK ADD  CONSTRAINT [ENUM_Enquiries_Status] CHECK  (([Status]='Enrolled' OR [Status]='Registered' OR [Status]='From-Lead' OR [Status]='New'))
GO
ALTER TABLE [dbo].[Enquiries] CHECK CONSTRAINT [ENUM_Enquiries_Status]
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [ENUM_Enrollments_EnrollmentType] CHECK  (([EnrollmentType]='Special' OR [EnrollmentType]='Transfer' OR [EnrollmentType]='Trial' OR [EnrollmentType]='Regular'))
GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [ENUM_Enrollments_EnrollmentType]
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [ENUM_Enrollments_PaymentStatus] CHECK  (([PaymentStatus]='Cancelled' OR [PaymentStatus]='Refunded' OR [PaymentStatus]='Overdue' OR [PaymentStatus]='Partially Paid' OR [PaymentStatus]='Pending' OR [PaymentStatus]='Paid'))
GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [ENUM_Enrollments_PaymentStatus]
GO
ALTER TABLE [dbo].[Leads]  WITH CHECK ADD  CONSTRAINT [ENUM_Leads_Status] CHECK  (([Status]='Closed' OR [Status]='Pending' OR [Status]='Not Interested' OR [Status]='Enrolled' OR [Status]='Follow-Up' OR [Status]='Interested' OR [Status]='Contacted' OR [Status]='Assigned' OR [Status]='New'))
GO
ALTER TABLE [dbo].[Leads] CHECK CONSTRAINT [ENUM_Leads_Status]
GO
/****** Object:  StoredProcedure [dbo].[sp_CheckExist_TableRecords]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CheckExist_TableRecords]
    @tableName1 NVARCHAR(256),
	@PrimaryKeyColumn NVARCHAR(256),
    @conditions ColumnValuePair_type READONLY
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    DECLARE @columnName NVARCHAR(256);
    DECLARE @value NVARCHAR(256);
    DECLARE @primaryKey NVARCHAR(256) = @PrimaryKeyColumn; -- Replace with your actual primary key column name

    -- Initialize a temporary table to store results
    CREATE TABLE #Results (ColumnName NVARCHAR(50), PrimaryKeyValue INT);

    -- Process each condition
    DECLARE cur CURSOR FOR SELECT ColumnName, Value FROM @conditions;
    OPEN cur;

    FETCH NEXT FROM cur INTO @columnName, @value;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Check for matching records
        SET @sql = 'IF EXISTS (SELECT 1 FROM ' + QUOTENAME(@tableName1) + ' WHERE ' + QUOTENAME(@columnName) + ' = @value) ' +
                   'BEGIN ' +
                   'INSERT INTO #Results (ColumnName, PrimaryKeyValue) ' +
                   'SELECT ''' + @columnName + ''', ' + @primaryKey + ' ' +
                   'FROM ' + QUOTENAME(@tableName1) + ' WHERE ' + QUOTENAME(@columnName) + ' = @value; ' +
                   'END ' +
                   'ELSE ' +
                   'BEGIN ' +
                   'INSERT INTO #Results (ColumnName, PrimaryKeyValue) ' +
                   'VALUES (''' + @columnName + ''', 0); ' +
                   'END';

        -- Execute the constructed SQL
        EXEC sp_executesql @sql, N'@value NVARCHAR(256)', @value;

        FETCH NEXT FROM cur INTO @columnName, @value;
    END

    CLOSE cur;
    DEALLOCATE cur;

    -- Return results
    SELECT * FROM #Results;

    -- Clean up
    DROP TABLE #Results;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Create_CourseWithFees]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_Create_CourseWithFees]
(
	@CourseId INT OUTPUT,
	@CourseCategoryId INT,
    @CourseName VARCHAR(100),
	@CourseDescription VARCHAR(MAX) = '',
	@CourseLevel VARCHAR(20) = 'Beginner',
	@Status BIT = 0,
	@CourseFeesList CourseFees_type READONLY
)
AS
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT INTO Courses(CourseCategoryId, CourseName, CourseDescription, CourseLevel, Status) 
			values (@CourseCategoryId, @CourseName, @CourseDescription, @CourseLevel, @Status)
			SET @CourseId = SCOPE_IDENTITY();

			INSERT INTO CourseFees(CourseId, TotalInstallments, FeeAmount, GstPercentage)
			SELECT @CourseId, TotalInstallments, FeeAmount, GstPercentage FROM @CourseFeesList
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
				RAISERROR('Invalid FeesDetails. Please check given Fees Details".', 16, 1)
	END CATCH;

		SELECT 	* 
		FROM CourseFees
		WHERE DeletedAt IS NULL
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateUpdateDeleteRestore_Branches]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateUpdateDeleteRestore_Branches]
(
	@Type VARCHAR(10),
	@BranchId INT = 0,
    @BranchName VARCHAR(100),
	@Status BIT = 0
)
AS
BEGIN
		    IF @Type = 'INSERT'
			BEGIN
				INSERT INTO Branches(BranchName, Status) values ( @BranchName, @Status)
			END

		    IF @Type = 'UPDATE'			-- UPDATE BY CourseFeesId
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM Branches WHERE BranchId = @BranchId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid BranchId. The specified BranchId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				BEGIN
					UPDATE Branches SET 
					BranchName = @BranchName,
					Status = @Status
					WHERE BranchId = @BranchId AND  DeletedAt IS NULL
				END
			END

		    IF @Type = 'DELETE'			-- DELETE BY CourseFeesId
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM Branches WHERE BranchId = @BranchId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid BranchId. The specified BranchId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				UPDATE Branches SET DeletedAt = GETDATE() WHERE BranchId = @BranchId AND DeletedAt IS NULL
			END

		    IF @Type = 'RESTORE'			-- RESTORE BY CourseFeesId
			BEGIN
				UPDATE Branches SET DeletedAt = NULL WHERE BranchId = @BranchId
			END	
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateUpdateDeleteRestore_Cities]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateUpdateDeleteRestore_Cities]
(
	@Type VARCHAR(10),
	@CityId INT = 0,
	@StateId INT = 0,
    @CityName VARCHAR(100),
	@Status BIT = 0
)
AS
BEGIN
		    IF @Type = 'INSERT'
			BEGIN
				INSERT INTO Cities(StateId,CityName, Status) values (@StateId, @CityName, @Status)
			END

		    IF @Type = 'UPDATE'			-- UPDATE BY CourseFeesId
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM Cities WHERE CityId = @CityId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid CityId. The specified CityId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				BEGIN
					UPDATE Cities SET 
					StateId = @StateId,
					CityName = @CityName,
					Status = @Status
					WHERE CityId = @CityId AND  DeletedAt IS NULL
				END
			END

		    IF @Type = 'DELETE'			-- DELETE BY CourseFeesId
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM Cities WHERE CityId = @CityId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid CityId. The specified CityId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				UPDATE Cities SET DeletedAt = GETDATE() WHERE CityId = @CityId AND DeletedAt IS NULL
			END

		    IF @Type = 'RESTORE'			-- RESTORE BY CourseFeesId
			BEGIN
				UPDATE Cities SET DeletedAt = NULL WHERE CityId = @CityId
			END	
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateUpdateDeleteRestore_Countries]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CreateUpdateDeleteRestore_Countries]
(
	@Type VARCHAR(10),
	@CountryId INT = 0,
    @CountryName VARCHAR(100),
	@Status BIT = 0
)
AS
BEGIN
		    IF @Type = 'INSERT'
			BEGIN
				INSERT INTO Countries(CountryName, Status) values ( @CountryName, @Status)
			END

		    IF @Type = 'UPDATE'			-- UPDATE BY CourseFeesId
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM Countries WHERE CountryId = @CountryId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid CountryId. The specified CountryId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				BEGIN
					UPDATE Countries SET 
					CountryName = @CountryName,
					Status = @Status
					WHERE CountryId = @CountryId AND  DeletedAt IS NULL
				END
			END

		    IF @Type = 'DELETE'			-- DELETE BY CourseFeesId
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM Countries WHERE CountryId = @CountryId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid CountryId. The specified CountryId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				UPDATE Countries SET DeletedAt = GETDATE() WHERE CountryId = @CountryId AND DeletedAt IS NULL
			END

		    IF @Type = 'RESTORE'			-- RESTORE BY CourseFeesId
			BEGIN
				UPDATE Countries SET DeletedAt = NULL WHERE CountryId = @CountryId
			END	
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateUpdateDeleteRestore_CourseCategories]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateUpdateDeleteRestore_CourseCategories]
(
	@Type VARCHAR(10),
	@CourseCategoryId INT,
    @ParentId INT NULL,
    @CourseCategoryName VARCHAR(100),
	@Status BIT = 0
)
AS
BEGIN
		    IF @Type = 'INSERT'
			BEGIN
				INSERT INTO CourseCategories( ParentId,CourseCategoryName, Status) values ( @ParentId, @CourseCategoryName, @Status)
			END

		    IF @Type = 'UPDATE'			-- UPDATE BY CourseFeesId
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM CourseCategories WHERE CourseCategoryId = @CourseCategoryId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid CourseCategoryId. The specified CourseCategoryId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				BEGIN
					UPDATE CourseCategories SET 
					ParentId = @ParentId,
					CourseCategoryName = @CourseCategoryName,
					Status = @Status
					WHERE CourseCategoryId = @CourseCategoryId AND  DeletedAt IS NULL
				END
			END

		    IF @Type = 'DELETE'			-- DELETE BY CourseFeesId
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM CourseCategories WHERE CourseCategoryId = @CourseCategoryId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid CourseCategoryId. The specified CourseCategoryId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				UPDATE CourseCategories SET DeletedAt = GETDATE() WHERE CourseCategoryId = @CourseCategoryId AND DeletedAt IS NULL
			END

		    IF @Type = 'RESTORE'			-- RESTORE BY CourseFeesId
			BEGIN
				UPDATE CourseCategories SET DeletedAt = NULL WHERE CourseCategoryId = @CourseCategoryId
			END	
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateUpdateDeleteRestore_CourseModuleContents]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateUpdateDeleteRestore_CourseModuleContents]
(
	@Type VARCHAR(10),
	@CourseModuleContentId INT = 0,
	@CourseModuleId INT = 0,
    @ContentName VARCHAR(250) = '',
    @ContentDescription NVARCHAR(MAX) = '',
	@DurationInHrs TINYINT = 1,
	@ContentOrder INT = 1,
	@Status BIT = 0
)
AS
BEGIN
	IF @Type = 'INSERT'
	BEGIN
		-- Check if CourseId exists and is not deleted
		IF NOT EXISTS (SELECT 1 FROM CourseModules WHERE CourseModuleId = @CourseModuleId AND DeletedAt IS NULL)
		BEGIN
			RAISERROR('Invalid CourseModuleId. The specified CourseModuleId does not exist.', 16, 1);
			RETURN;
		END
		
		-- Insert a new Course Module
		INSERT INTO CourseModuleContents(CourseModuleId, ContentName, ContentDescription, DurationInHrs, ContentOrder, Status) 
		VALUES (@CourseModuleId, @ContentName, @ContentDescription, @DurationInHrs, @ContentOrder, @Status);
	END

	ELSE IF @Type = 'UPDATE'
		BEGIN
			-- Check if CourseModuleId exists and is not deleted
			IF NOT EXISTS (SELECT 1 FROM CourseModuleContents WHERE CourseModuleContentId = @CourseModuleContentId AND DeletedAt IS NULL)
			BEGIN
					RAISERROR('Invalid CourseModuleContentId. The specified CourseModuleContentId does not exist.', 16, 1);
				RETURN;
			END
		
			-- Update an existing Course Module
			UPDATE CourseModuleContents 
			SET CourseModuleId = @CourseModuleId,
				ContentName = @ContentName,
				ContentDescription = @ContentDescription,
				DurationInHrs = @DurationInHrs,
				Status = @Status
			WHERE CourseModuleContentId = @CourseModuleContentId AND DeletedAt IS NULL;
		END

	ELSE IF @Type = 'DELETE'
	BEGIN
		-- Check if CourseModuleId exists and is not deleted
				IF NOT EXISTS (SELECT 1 FROM CourseModuleContents WHERE CourseModuleContentId = @CourseModuleContentId AND DeletedAt IS NULL)
			BEGIN
					RAISERROR('Invalid CourseModuleContentId. The specified CourseModuleContentId does not exist.', 16, 1);
				RETURN;
			END


		-- Soft delete the Course Module
		UPDATE CourseModuleContents 
		SET DeletedAt = GETDATE() 
		WHERE CourseModuleContentId = @CourseModuleContentId AND DeletedAt IS NULL;
	END

	ELSE IF @Type = 'RESTORE'
	BEGIN
		-- Restore a soft-deleted Course Module
		UPDATE CourseModuleContents 
		SET DeletedAt = NULL 
		WHERE CourseModuleContentId = @CourseModuleContentId;
	END

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateUpdateDeleteRestore_CourseModules]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateUpdateDeleteRestore_CourseModules]
(
	@Type VARCHAR(10),
	@CourseModuleId INT = 0,
    @CourseId INT = 0,
    @ModuleName VARCHAR(100) = '',
    @ModuleDescription NVARCHAR(MAX) = '',
	@ModuleOrder INT = 1,
	@Status BIT = 0
)
AS
BEGIN
	IF @Type = 'INSERT'
	BEGIN
		-- Check if CourseId exists and is not deleted
		IF NOT EXISTS (SELECT 1 FROM Courses WHERE CourseId = @CourseId AND DeletedAt IS NULL)
		BEGIN
			RAISERROR('Invalid CourseId. The specified CourseId does not exist.', 16, 1);
			RETURN;
		END
		
		-- Insert a new Course Module
		INSERT INTO CourseModules(CourseId, ModuleName, ModuleDescription, ModuleOrder, Status) 
		VALUES (@CourseId, @ModuleName, @ModuleDescription, @ModuleOrder, @Status);
	END

	ELSE IF @Type = 'UPDATE'
	BEGIN
		-- Check if CourseModuleId exists and is not deleted
		IF NOT EXISTS (SELECT 1 FROM Courses WHERE CourseId = @CourseId AND DeletedAt IS NULL)
		BEGIN
				RAISERROR('Invalid CourseId. The specified CourseId does not exist.', 16, 1);
			RETURN;
		END
		
		-- Update an existing Course Module
		UPDATE CourseModules 
		SET CourseId = @CourseId,
		    ModuleName = @ModuleName,
			ModuleDescription = @ModuleDescription,
		    ModuleOrder = @ModuleOrder,
		    Status = @Status
		WHERE CourseModuleId = @CourseModuleId AND DeletedAt IS NULL;
	END

	ELSE IF @Type = 'DELETE'
	BEGIN
		-- Check if CourseModuleId exists and is not deleted
		IF NOT EXISTS (SELECT 1 FROM CourseModules WHERE CourseModuleId = @CourseModuleId AND DeletedAt IS NULL)
		BEGIN
			RAISERROR('Invalid CourseModuleId. The specified CourseModuleId does not exist.', 16, 1);
			RETURN;
		END

		-- Soft delete the Course Module
		UPDATE CourseModules 
		SET DeletedAt = GETDATE() 
		WHERE CourseModuleId = @CourseModuleId AND DeletedAt IS NULL;
	END

	ELSE IF @Type = 'RESTORE'
	BEGIN
		-- Restore a soft-deleted Course Module
		UPDATE CourseModules 
		SET DeletedAt = NULL 
		WHERE CourseModuleId = @CourseModuleId;
	END
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_CreateUpdateDeleteRestore_Courses]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateUpdateDeleteRestore_Courses]
(
	@Type VARCHAR(10),
	@CourseId INT = 0,
	@CourseCategoryId INT = 0,
    @CourseName VARCHAR(100) = '',
	@CourseDescription VARCHAR(MAX) = '',
	@CourseLevel VARCHAR(20) = 'Beginner',
	@Status BIT = 0
)
AS
BEGIN

		IF @Type = 'INSERT'
		BEGIN
			IF NOT EXISTS (SELECT 1 FROM CourseCategories WHERE CourseCategoryId = @CourseCategoryId AND DeletedAt IS NULL)
			BEGIN
				RAISERROR('Invalid CourseCategoryId. The specified CourseCategoryId does not exist.', 16, 1)
				RETURN
			END

			INSERT INTO Courses( CourseCategoryId, CourseName, CourseDescription, CourseLevel, Status) values ( @CourseCategoryId, @CourseName, @CourseDescription, @CourseLevel, @Status)
		END

		IF @Type = 'UPDATE'			-- UPDATE BY CourseFeesId
		BEGIN
			IF NOT EXISTS (SELECT 1 FROM CourseCategories WHERE CourseCategoryId = @CourseCategoryId AND DeletedAt IS NULL)
			BEGIN
				RAISERROR('Invalid CourseCategoryId. The specified CourseCategoryId does not exist.', 16, 1)
				RETURN
			END

				UPDATE Courses SET 
				CourseCategoryId = @CourseCategoryId,
				CourseName = @CourseName,
				CourseDescription = @CourseDescription,
				CourseLevel = @CourseLevel,
				Status = @Status
				WHERE CourseId = @CourseId AND  DeletedAt IS NULL
		END

		IF @Type = 'DELETE'			-- DELETE BY CourseFeesId
		BEGIN
			UPDATE Courses SET DeletedAt = GETDATE() WHERE CourseId = @CourseId AND DeletedAt IS NULL
		END

		IF @Type = 'RESTORE'			-- RESTORE BY CourseFeesId
		BEGIN
			UPDATE Courses SET DeletedAt = NULL WHERE CourseId = @CourseId AND DeletedAt IS NOT NULL
		END

		IF @Type = 'STATUS'			-- RESTORE BY CourseFeesId
		BEGIN
			UPDATE Courses SET Status = Status WHERE CourseId = @CourseId AND DeletedAt IS NULL
		END

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateUpdateDeleteRestore_Enquiries]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateUpdateDeleteRestore_Enquiries]
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

GO
/****** Object:  StoredProcedure [dbo].[sp_CreateUpdateDeleteRestore_EnquiryFors]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateUpdateDeleteRestore_EnquiryFors]
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


GO
/****** Object:  StoredProcedure [dbo].[sp_CreateUpdateDeleteRestore_Enrollments]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CreateUpdateDeleteRestore_Enrollments]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateUpdateDeleteRestore_Leads]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateUpdateDeleteRestore_Leads]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateUpdateDeleteRestore_LeadSources]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateUpdateDeleteRestore_LeadSources]
(
	@Type VARCHAR(10),
	@LeadSourceId INT = 0,
    @LeadSourceName VARCHAR(100),
	@Status BIT = 0
)
AS
BEGIN
		    IF @Type = 'INSERT'
			BEGIN
				INSERT INTO LeadSources(LeadSourceName, Status) values ( @LeadSourceName, @Status)
			END

		    IF @Type = 'UPDATE'			-- UPDATE BY CourseFeesId
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM LeadSources WHERE LeadSourceId = @LeadSourceId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid LeadSourceId. The specified LeadSourceId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				BEGIN
					UPDATE LeadSources SET 
					LeadSourceName = @LeadSourceName,
					Status = @Status
					WHERE LeadSourceId = @LeadSourceId AND  DeletedAt IS NULL
				END
			END

		    IF @Type = 'DELETE'			-- DELETE BY CourseFeesId
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM LeadSources WHERE LeadSourceId = @LeadSourceId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid LeadSourceId. The specified LeadSourceId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				UPDATE LeadSources SET DeletedAt = GETDATE() WHERE LeadSourceId = @LeadSourceId AND DeletedAt IS NULL
			END

		    IF @Type = 'RESTORE'			-- RESTORE BY CourseFeesId
			BEGIN
				UPDATE LeadSources SET DeletedAt = NULL WHERE LeadSourceId = @LeadSourceId
			END	
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateUpdateDeleteRestore_Qualifications]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateUpdateDeleteRestore_Qualifications]
(
	@Type VARCHAR(10),
	@QualificationId INT = 0,
    @QualificationName VARCHAR(100),
	@Status BIT = 0
)
AS
BEGIN
		    IF @Type = 'INSERT'
			BEGIN
				INSERT INTO Qualifications(QualificationName, Status) values ( @QualificationName, @Status)
			END

		    IF @Type = 'UPDATE'			-- UPDATE BY CourseFeesId
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM Qualifications WHERE QualificationId = @QualificationId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid QualificationId. The specified QualificationId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				BEGIN
					UPDATE Qualifications SET 
					QualificationName = @QualificationName,
					Status = @Status
					WHERE QualificationId = @QualificationId AND  DeletedAt IS NULL
				END
			END

		    IF @Type = 'DELETE'			-- DELETE BY CourseFeesId
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM Qualifications WHERE QualificationId = @QualificationId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid QualificationId. The specified QualificationId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				UPDATE Qualifications SET DeletedAt = GETDATE() WHERE QualificationId = @QualificationId AND DeletedAt IS NULL
			END

		    IF @Type = 'RESTORE'			-- RESTORE BY CourseFeesId
			BEGIN
				UPDATE Qualifications SET DeletedAt = NULL WHERE QualificationId = @QualificationId
			END	
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateUpdateDeleteRestore_Roles]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	
CREATE PROCEDURE [dbo].[sp_CreateUpdateDeleteRestore_Roles]
(
	@Type VARCHAR(10),
	@RoleId INT = 0,
    @RoleName VARCHAR(100),
	@Status BIT = 0
)
AS
BEGIN
		    IF @Type = 'INSERT'
			BEGIN
				INSERT INTO Roles(RoleName, Status) values ( @RoleName, @Status)
			END

		    IF @Type = 'UPDATE'			-- UPDATE BY CourseFeesId
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM Roles WHERE RoleId = @RoleId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid RoleId. The specified RoleId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				BEGIN
					UPDATE Roles SET 
					RoleName = @RoleName,
					Status = @Status
					WHERE RoleId = @RoleId AND  DeletedAt IS NULL
				END
			END

		    IF @Type = 'DELETE'			-- DELETE BY CourseFeesId
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM Roles WHERE RoleId = @RoleId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid RoleId. The specified RoleId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				UPDATE Roles SET DeletedAt = GETDATE() WHERE RoleId = @RoleId AND DeletedAt IS NULL
			END

		    IF @Type = 'RESTORE'			-- RESTORE BY CourseFeesId
			BEGIN
				UPDATE Roles SET DeletedAt = NULL WHERE RoleId = @RoleId
			END	
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateUpdateDeleteRestore_States]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateUpdateDeleteRestore_States]
(
	@Type VARCHAR(10),
	@StateId INT = 0,
	@CountryId SMALLINT = 0,
    @StateName VARCHAR(100),
	@Status BIT = 0
)
AS
BEGIN
		    IF @Type = 'INSERT'
			BEGIN
				INSERT INTO States(CountryId,StateName, Status) values (@CountryId, @StateName, @Status)
			END

		    IF @Type = 'UPDATE'			-- UPDATE BY CourseFeesId
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM States WHERE StateId = @StateId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid StateId. The specified StateId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				BEGIN
					UPDATE States SET 
					CountryId = @CountryId,
					StateName = @StateName,
					Status = @Status
					WHERE StateId = @StateId AND  DeletedAt IS NULL
				END
			END

		    IF @Type = 'DELETE'			-- DELETE BY CourseFeesId
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM States WHERE StateId = @StateId AND DeletedAt IS NULL)
					BEGIN
						RAISERROR('Invalid StateId. The specified StateId does not exist.', 16, 1)
						RETURN
					END
				ELSE
				UPDATE States SET DeletedAt = GETDATE() WHERE StateId = @StateId AND DeletedAt IS NULL
			END

		    IF @Type = 'RESTORE'			-- RESTORE BY CourseFeesId
			BEGIN
				UPDATE States SET DeletedAt = NULL WHERE StateId = @StateId
			END	
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateUpdateDeleteRestore_StudentPayments]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CreateUpdateDeleteRestore_StudentPayments]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateUpdateDeleteRestore_Students]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateUpdateDeleteRestore_Students]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateUpdateDeleteRestorePassword_Employees]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateUpdateDeleteRestorePassword_Employees]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_Branches]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_Branches]
(
	@BranchId INT = 0
)
AS
	BEGIN
		IF (@BranchId <> 0)
			BEGIN
				SELECT 
					BranchId,
					BranchName,
					Status,
					CASE 
						WHEN Status = 1 THEN 'Active' 
						WHEN Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM Branches
				WHERE 
					DeletedAt IS NULL 
					AND BranchId = @BranchId
				ORDER BY BranchId desc
			END
		ELSE
			BEGIN
				SELECT 
					BranchId,
					BranchName,
					Status,
					CASE 
						WHEN Status = 1 THEN 'Active' 
						WHEN Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM Branches
				WHERE 
					DeletedAt IS NULL 
				ORDER BY BranchId desc
			END
	END;

GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_Cities]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_Cities]
(
	@CityId INT = 0,
	@StateId INT = 0
)
AS
	BEGIN
		IF (@CityId <> 0)	
			BEGIN
				SELECT
					c.CityId,
					s.StateId,
					s.StateName,
					c.CityName,
					ct.CountryId,
					ct.CountryName,
					c.Status,
					CASE 
						WHEN c.Status = 1 THEN 'Active' 
						WHEN c.Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM Cities c
				JOIN States s ON c.StateId = s.StateId
				JOIN Countries ct ON ct.CountryId = s.CountryId
				WHERE
					s.DeletedAt IS NULL 
					AND c.DeletedAt IS NULL 
					AND ct.DeletedAt IS NULL 
					AND c.CityId = @CityId
				ORDER BY c.CityId desc
			END
		ELSE IF (@StateId <> 0)
			BEGIN
				SELECT
					c.CityId,
					s.StateId,
					s.StateName,
					c.CityName,
					ct.CountryId,
					ct.CountryName,
					c.Status,
					CASE 
						WHEN c.Status = 1 THEN 'Active' 
						WHEN c.Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM Cities c
				JOIN States s ON c.StateId = s.StateId
				JOIN Countries ct ON ct.CountryId = s.CountryId
				WHERE
					s.DeletedAt IS NULL 
					AND c.DeletedAt IS NULL 
					AND ct.DeletedAt IS NULL 
					AND s.StateId = @StateId
				ORDER BY c.CityId desc
			END
		ELSE
			BEGIN
				SELECT
					c.CityId,
					s.StateId,
					s.StateName,
					c.CityName,
					ct.CountryId,
					ct.CountryName,
					c.Status,
					CASE 
						WHEN c.Status = 1 THEN 'Active' 
						WHEN c.Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM Cities c
				JOIN States s ON c.StateId = s.StateId
				JOIN Countries ct ON ct.CountryId = s.CountryId
				WHERE
					s.DeletedAt IS NULL 
					AND c.DeletedAt IS NULL 
					AND ct.DeletedAt IS NULL 
				ORDER BY c.CityId desc

			END
	END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_Countries]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetAll_Countries]
(
	@CountryId INT = 0
)
AS
	BEGIN
		IF (@CountryId <> 0)
			BEGIN
				SELECT 
					CountryId,
					CountryName,
					Status,
					CASE 
						WHEN Status = 1 THEN 'Active' 
						WHEN Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM Countries
				WHERE 
					DeletedAt IS NULL 
					AND CountryId = @CountryId
				ORDER BY CountryId desc
			END
		ELSE
			BEGIN
				SELECT 
					CountryId,
					CountryName,
					Status,
					CASE 
						WHEN Status = 1 THEN 'Active' 
						WHEN Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM Countries
				WHERE 
					DeletedAt IS NULL 
				ORDER BY CountryId desc
			END
	END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_Course]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetAll_Course]
(
	@CourseId INT = 0,
	@CourseCategoryId INT = 0
)
AS
	BEGIN
		IF (@CourseId <> 0)
			BEGIN
				SELECT 
					c.CourseId,
					c.CourseCategoryId,
					cc.CourseCategoryName,
					c.CourseName,
					c.CourseDescription,
					c.CourseLevel,
					c.CourseOrder,
					c.Status,
					CASE 
						WHEN c.Status = 1 THEN 'Active' 
						WHEN c.Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column

				FROM Courses c
				JOIN CourseCategories cc ON cc.CourseCategoryId = c.CourseCategoryId
				WHERE 
					c.DeletedAt IS NULL 
					AND cc.DeletedAt IS NULL 
					AND c.CourseId = @CourseId
				ORDER BY c.CourseOrder ASC
			END
		ELSE IF (@CourseCategoryId <> 0)
			BEGIN
				SELECT 
					c.CourseId,
					c.CourseCategoryId,
					cc.CourseCategoryName,
					c.CourseName,
					c.CourseDescription,
					c.CourseLevel,
					c.CourseOrder,
					c.Status,
					CASE 
						WHEN c.Status = 1 THEN 'Active' 
						WHEN c.Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column

				FROM Courses c
				JOIN CourseCategories cc ON cc.CourseCategoryId = c.CourseCategoryId
				WHERE 
					c.DeletedAt IS NULL 
					AND cc.DeletedAt IS NULL 
					AND c.CourseCategoryId = @CourseCategoryId
				ORDER BY c.CourseOrder ASC

			END
		ELSE
			BEGIN
				SELECT 
					c.CourseId,
					c.CourseCategoryId,
					cc.CourseCategoryName,
					c.CourseName,
					c.CourseDescription,
					c.CourseLevel,
					c.CourseOrder,
					c.Status,
					CASE 
						WHEN c.Status = 1 THEN 'Active' 
						WHEN c.Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column

				FROM Courses c
				JOIN CourseCategories cc ON cc.CourseCategoryId = c.CourseCategoryId
				WHERE 
					c.DeletedAt IS NULL 
					AND cc.DeletedAt IS NULL 
				ORDER BY c.CourseOrder ASC

			END
	END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_CourseCategories]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_CourseCategories]
	AS
	BEGIN
	 SELECT 
			c.CourseCategoryId,
			c.ParentId,
			c.CourseCategoryName,
			ISNULL(pc.CourseCategoryName, '-') AS ParentCategoryName, -- Parent category name or '-' if null
			c.Status,
			CASE 
				WHEN c.Status = 1 THEN 'Active' 
				WHEN c.Status = 0 THEN 'Inactive' 
				ELSE 'Unknown'
			END AS StatusLabel,  -- Custom StatusLabel column
			NULL AS ParentCategoryCourseCategoryId -- Include this if using navigation properties
		FROM 
			CourseCategories c
		LEFT JOIN 
			CourseCategories pc ON c.ParentId = pc.CourseCategoryId
		WHERE 
			c.DeletedAt IS NULL
		ORDER BY c.CourseCategoryOrder DESC
	END;

GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_CourseFees]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_CourseFees]
(
    @CourseId INT = 0,
    @CourseFeeId INT = 0
)
AS
BEGIN
		IF (@CourseFeeId <> 0)
		BEGIN
			SELECT 
				cf.CourseFeeId, 
				cf.CourseId, 
				c.CourseName, 
				cf.TotalInstallments, 
				cf.FeeAmount, 
				cf.GstPercentage, 
				(cf.FeeAmount * cf.GstPercentage / 100) AS GstAmount,  -- Calculating GST Amount
				(cf.FeeAmount + (cf.FeeAmount * cf.GstPercentage / 100)) AS TotalAmountWithGst  -- Calculating Total Amount including GST
			FROM 
				CourseFees cf
				JOIN Courses c ON c.CourseId = cf.CourseId

			WHERE 
				cf.DeletedAt IS NULL
				AND c.DeletedAt IS NULL
				AND cf.CourseFeeId = @CourseFeeId
		END
		ELSE
		BEGIN

			SELECT 
				cf.CourseFeeId, 
				cf.CourseId, 
				c.CourseName, 
				cf.TotalInstallments, 
				cf.FeeAmount, 
				cf.GstPercentage, 
				(cf.FeeAmount * cf.GstPercentage / 100) AS GstAmount,  -- Calculating GST Amount
				(cf.FeeAmount + (cf.FeeAmount * cf.GstPercentage / 100)) AS TotalAmountWithGst  -- Calculating Total Amount including GST
			FROM 
				CourseFees cf
				JOIN Courses c ON c.CourseId = cf.CourseId

			WHERE 
				cf.DeletedAt IS NULL
				AND c.DeletedAt IS NULL
				AND (@CourseId = 0 OR cf.CourseId = @CourseId)  -- Optional filter for CourseId
		END
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_CourseModuleContents]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_CourseModuleContents]
(
	@CourseModuleContentId INT = 0,
	@CourseModuleId INT = 0
)
AS
	BEGIN
		IF (@CourseModuleContentId <> 0)
			BEGIN
				SELECT 
					cmc.CourseModuleContentId,
					cmc.CourseModuleId,
					cm.ModuleName,
					c.CourseId,
					c.CourseName,
					cmc.ContentName,
					cmc.ContentDescription,
					cmc.DurationInHrs,
					cmc.ContentOrder,
					cmc.Status,
					CASE 
						WHEN cmc.Status = 1 THEN 'Active' 
						WHEN cmc.Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column

				FROM CourseModuleContents cmc
				JOIN CourseModules cm ON cm.CourseModuleId = cmc.CourseModuleId
				JOIN Courses c ON c.CourseId = cm.CourseId
				JOIN CourseCategories cc ON cc.CourseCategoryId = c.CourseCategoryId
				WHERE 
					c.DeletedAt IS NULL 
					AND cmc.DeletedAt IS NULL 
					AND cm.DeletedAt IS NULL 
					AND cc.DeletedAt IS NULL 
					AND cmc.CourseModuleContentId= @CourseModuleContentId
				ORDER BY cmc.ContentOrder ASC
			END
		ELSE IF (@CourseModuleId <> 0)
			BEGIN
				SELECT 
					cmc.CourseModuleContentId,
					cmc.CourseModuleId,
					cm.ModuleName,
					c.CourseId,
					c.CourseName,
					cmc.ContentName,
					cmc.ContentDescription,
					cmc.DurationInHrs,
					cmc.ContentOrder,
					cmc.Status,
					CASE 
						WHEN cmc.Status = 1 THEN 'Active' 
						WHEN cmc.Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column

				FROM CourseModuleContents cmc
				JOIN CourseModules cm ON cm.CourseModuleId = cmc.CourseModuleId
				JOIN Courses c ON c.CourseId = cm.CourseId
				JOIN CourseCategories cc ON cc.CourseCategoryId = c.CourseCategoryId
				WHERE 
					c.DeletedAt IS NULL 
					AND cmc.DeletedAt IS NULL 
					AND cm.DeletedAt IS NULL 
					AND cc.DeletedAt IS NULL 
					AND cmc.CourseModuleId= @CourseModuleId
				ORDER BY cmc.ContentOrder ASC
			END
		ELSE
			BEGIN
				SELECT 
					cmc.CourseModuleContentId,
					cmc.CourseModuleId,
					cm.ModuleName,
					c.CourseId,
					c.CourseName,
					cmc.ContentName,
					cmc.ContentDescription,
					cmc.DurationInHrs,
					cmc.ContentOrder,
					cmc.Status,
					CASE 
						WHEN cmc.Status = 1 THEN 'Active' 
						WHEN cmc.Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column

				FROM CourseModuleContents cmc
				JOIN CourseModules cm ON cm.CourseModuleId = cmc.CourseModuleId
				JOIN Courses c ON c.CourseId = cm.CourseId
				JOIN CourseCategories cc ON cc.CourseCategoryId = c.CourseCategoryId
				WHERE 
					c.DeletedAt IS NULL 
					AND cmc.DeletedAt IS NULL 
					AND cm.DeletedAt IS NULL 
					AND cc.DeletedAt IS NULL 
				ORDER BY cmc.ContentOrder ASC
			END
	END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_CourseModules]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_CourseModules]
(
	@CourseModuleId INT = 0,
	@CourseId INT = 0
)
AS
	BEGIN
		IF (@CourseModuleId <> 0)
			BEGIN
				SELECT 
					cm.CourseModuleId,
					cm.CourseId,
					c.CourseName,
					cc.CourseCategoryId,
					cc.CourseCategoryName,
					cm.ModuleName,
					cm.ModuleDescription,
					cm.ModuleOrder,
					cm.Status,
					CASE 
						WHEN cm.Status = 1 THEN 'Active' 
						WHEN cm.Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column

				FROM CourseModules cm
				JOIN Courses c ON c.CourseId = cm.CourseId 
				JOIN CourseCategories cc ON cc.CourseCategoryId = c.CourseCategoryId
				WHERE 
					c.DeletedAt IS NULL 
					AND cm.DeletedAt IS NULL 
					AND cc.DeletedAt IS NULL 
					AND cm.CourseModuleId = @CourseModuleId
				ORDER BY cm.ModuleOrder ASC
			END
		ELSE IF (@CourseId <> 0)
			BEGIN
				SELECT 
					cm.CourseModuleId,
					cm.CourseId,
					c.CourseName,
					cc.CourseCategoryId,
					cc.CourseCategoryName,
					cm.ModuleName,
					cm.ModuleDescription,
					cm.ModuleOrder,
					cm.Status,
					CASE 
						WHEN cm.Status = 1 THEN 'Active' 
						WHEN cm.Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM CourseModules cm
				JOIN Courses c ON c.CourseId = cm.CourseId 
				JOIN CourseCategories cc ON cc.CourseCategoryId = c.CourseCategoryId
				WHERE 
					c.DeletedAt IS NULL 
					AND cm.DeletedAt IS NULL 
					AND cc.DeletedAt IS NULL 
					AND cm.CourseModuleId = @CourseModuleId

					AND c.CourseId = @CourseId
				ORDER BY cm.ModuleOrder ASC
			END
		ELSE
			BEGIN
				SELECT 
					cm.CourseModuleId,
					cm.CourseId,
					c.CourseName,
					cc.CourseCategoryId,
					cc.CourseCategoryName,
					cm.ModuleName,
					cm.ModuleDescription,
					cm.ModuleOrder,
					cm.Status,
					CASE 
						WHEN cm.Status = 1 THEN 'Active' 
						WHEN cm.Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM CourseModules cm
				JOIN Courses c ON c.CourseId = cm.CourseId 
				JOIN CourseCategories cc ON cc.CourseCategoryId = c.CourseCategoryId
				WHERE 
					c.DeletedAt IS NULL 
					AND cm.DeletedAt IS NULL 
					AND cc.DeletedAt IS NULL 
				ORDER BY cm.ModuleOrder ASC

			END
	END;


GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_Employees]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_Employees]
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

GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_Enquiries]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_Enquiries]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_EnquiryFors]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_EnquiryFors]
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

GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_Enrollments]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetAll_Enrollments]
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

GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_EnrollmentWiseStudentPayments]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_EnrollmentWiseStudentPayments]
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

GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_Leads]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_Leads]
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

GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_LeadSources]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_LeadSources]
(
	@LeadSourceId INT = 0
)
AS
	BEGIN
		IF (@LeadSourceId <> 0)
			BEGIN
				SELECT 
					LeadSourceId,
					LeadSourceName,
					Status,
					CASE 
						WHEN Status = 1 THEN 'Active' 
						WHEN Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM LeadSources
				WHERE 
					DeletedAt IS NULL 
					AND LeadSourceId = @LeadSourceId
				ORDER BY LeadSourceId desc
			END
		ELSE
			BEGIN
				SELECT 
					LeadSourceId,
					LeadSourceName,
					Status,
					CASE 
						WHEN Status = 1 THEN 'Active' 
						WHEN Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM LeadSources
				WHERE 
					DeletedAt IS NULL 
				ORDER BY LeadSourceId desc
			END
	END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_Qualifications]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_Qualifications]
(
	@QualificationId INT = 0
)
AS
	BEGIN
		IF (@QualificationId <> 0)
			BEGIN
				SELECT 
					QualificationId,
					QualificationName,
					Status,
					CASE 
						WHEN Status = 1 THEN 'Active' 
						WHEN Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM Qualifications
				WHERE 
					DeletedAt IS NULL 
					AND QualificationId = @QualificationId
				ORDER BY QualificationId desc
			END
		ELSE
			BEGIN
				SELECT 
					QualificationId,
					QualificationName,
					Status,
					CASE 
						WHEN Status = 1 THEN 'Active' 
						WHEN Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM Qualifications
				WHERE 
					DeletedAt IS NULL 
				ORDER BY QualificationId desc
			END
	END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_Roles]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_Roles]
(
	@RoleId INT = 0
)
AS
	BEGIN
		IF (@RoleId <> 0)
			BEGIN
				SELECT 
					RoleId,
					RoleName,
					Status,
					CASE 
						WHEN Status = 1 THEN 'Active' 
						WHEN Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM Roles
				WHERE 
					DeletedAt IS NULL 
					AND RoleId = @RoleId
				ORDER BY RoleId desc
			END
		ELSE
			BEGIN
				SELECT 
					RoleId,
					RoleName,
					Status,
					CASE 
						WHEN Status = 1 THEN 'Active' 
						WHEN Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM Roles
				WHERE 
					DeletedAt IS NULL 
				ORDER BY RoleId desc
			END
	END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_States]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_States]
(
	@StateId INT = 0,
	@CountryId INT = 0
)
AS
	BEGIN
		IF (@StateId <> 0)
			BEGIN
				SELECT
					c.CountryId,
					c.CountryName,
					s.StateId,
					s.StateName,
					s.Status,
					CASE 
						WHEN s.Status = 1 THEN 'Active' 
						WHEN s.Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM States s
				JOIN Countries c ON c.CountryId = s.CountryId
				WHERE 
					s.DeletedAt IS NULL 
					AND c.DeletedAt IS NULL 
					AND s.StateId = @StateId
				ORDER BY StateId desc
			END
		ELSE IF (@CountryId <> 0)
			BEGIN
				SELECT
					c.CountryId,
					c.CountryName,
					s.StateId,
					s.StateName,
					s.Status,
					CASE 
						WHEN s.Status = 1 THEN 'Active' 
						WHEN s.Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM States s
				JOIN Countries c ON c.CountryId = s.CountryId
				WHERE 
					s.DeletedAt IS NULL 
					AND c.DeletedAt IS NULL 
					AND c.CountryId = @CountryId
				ORDER BY StateId desc
			END
		ELSE
			BEGIN
				SELECT
					c.CountryId,
					c.CountryName,
					s.StateId,
					s.StateName,
					s.Status,
					CASE 
						WHEN s.Status = 1 THEN 'Active' 
						WHEN s.Status = 0 THEN 'Inactive' 
						ELSE 'Unknown'
					END AS StatusLabel  -- Custom StatusLabel column
				FROM States s
				JOIN Countries c ON c.CountryId = s.CountryId
				WHERE 
					s.DeletedAt IS NULL 
					AND c.DeletedAt IS NULL 
				ORDER BY StateId desc
			END

	END;

GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_Students]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_Students]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCount_tables]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetCount_tables]
(
    @TableName VARCHAR(80),
    @Count INT OUTPUT
)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);
    
    -- Build the dynamic SQL query
    SET @SQL = N'SELECT @Count = COUNT(*) FROM ' + QUOTENAME(@TableName);

    -- Execute the dynamic SQL query
    EXEC sp_executesql @SQL, N'@Count INT OUTPUT', @Count OUTPUT;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_GetNextPendingPayment_studentPayments]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetNextPendingPayment_studentPayments]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateRemark_Enquiries]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_UpdateRemark_Enquiries]
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

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateRemark_Leads]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateRemark_Leads]
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

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateStudentPayment_StudentPayments]    Script Date: 24-Oct-24 6:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateStudentPayment_StudentPayments]
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
GO
