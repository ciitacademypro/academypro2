using LmsEnv;
using LmsModels.Common;
using LmsModels.Course;
using LmsModels.Employee;
using LmsServices.Common;
using LmsServices.Employee.Interfaces;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LmsServices.Employee.Implementations
{
	public class EmployeeService : IEmployeeService
	{
		private readonly string connString;
		public EmployeeService()
        {
			connString = DbConnect.DefaultConnection;
		}

		public void Create(EmployeeModel employee)
		{
			var parameters = new List<KeyValuePair<string, object>>
			{
				new("@Type", "INSERT"),
				new("@EmployeeId", 0),
				new("@BranchId", employee.BranchId),
				new("@EmployeeCode", employee.EmployeeCode),
				new("@EmployeeName", employee.EmployeeName),
				new("@MobileNumber", employee.MobileNumber),
				new("@EmailAddress", employee.EmailAddress),
				new("@RoleId", employee.RoleId),
				new("@Password", employee.Password),
				new("@Status", employee.Status)
			};

			QueryService.NonQuery("[sp_CreateUpdateDeleteRestorePassword_Employees]", parameters);
		}

		public void Delete(int id)
		{
			var parameters = new List<KeyValuePair<string, object>>
			{
				new("@Type", "DELETE"),
				new("@EmployeeId", id),
				new("@BranchId", 0),
				new("@EmployeeCode", ""),
				new("@EmployeeName", ""),
				new("@MobileNumber", ""),
				new("@EmailAddress", ""),
				new("@RoleId", 0),
				new("@Password", ""),
				new("@Status", false)
			};

			QueryService.NonQuery("[sp_CreateUpdateDeleteRestorePassword_Employees]", parameters);
		}

		public List<EmployeeModel> GetAll(int employeeId = 0, int roleId = 0, int branchId = 0)
		{
			return QueryService.Query(
				"sp_GetAll_Employees",
				reader =>
				{
					return new EmployeeModel
					{
						EmployeeId = Convert.ToInt32(reader["EmployeeId"]),
						BranchId = Convert.ToInt16(reader["BranchId"]),
						BranchName = reader["BranchName"].ToString(),
						EmployeeCode = reader["EmployeeCode"].ToString(),
						EmployeeName = reader["EmployeeName"].ToString(),
						MobileNumber = reader["MobileNumber"].ToString(),
						EmailAddress = reader["EmailAddress"].ToString(),
						RoleId = Convert.ToInt16(reader["RoleId"]),
						RoleName = reader["RoleName"].ToString(),
						Password = reader["Password"].ToString(),
						Status = Convert.ToBoolean(reader["Status"]),
						StatusLabel = reader["StatusLabel"].ToString(),
					};
				},
				new SqlParameter("@EmployeeId", employeeId),
				new SqlParameter("@BranchId", branchId),
				new SqlParameter("@RoleId", roleId)
			);
		}

		public List<EmployeeModel> GetByBranchId(int branchId)
		{
			return QueryService.Query(
				"sp_GetAll_Employees",
				reader =>
				{
					return new EmployeeModel
					{
						EmployeeId = Convert.ToInt32(reader["EmployeeId"]),
						BranchId = Convert.ToInt16(reader["BranchId"]),
						BranchName = reader["BranchName"].ToString(),
						EmployeeCode = reader["EmployeeCode"].ToString(),
						EmployeeName = reader["EmployeeName"].ToString(),
						MobileNumber = reader["MobileNumber"].ToString(),
						EmailAddress = reader["EmailAddress"].ToString(),
						RoleId = Convert.ToInt16(reader["RoleId"]),
						RoleName = reader["RoleName"].ToString(),
						Password = reader["Password"].ToString(),
						Status = reader["Status"] == "1",
						StatusLabel = reader["StatusLabel"].ToString(),
					};
				},
				new SqlParameter("@EmployeeId", 0),
				new SqlParameter("@BranchId", branchId),
				new SqlParameter("@RoleId", 0)
			);
		}

		public Dictionary<string, string> CheckExist(string EmployeeCode, string MobileNumber, string EmailAddress)
		{
			var conditions = new List<ColumnValuePairModel>
			{
				new()
				{
					ColumnName = "EmployeeCode",
					Value = EmployeeCode != null ? EmployeeCode.Trim() : ""
				},
				new()
				{
					ColumnName = "MobileNumber",
					Value = MobileNumber != null ? MobileNumber.Trim() : ""
				},
				new()
				{
					ColumnName = "EmailAddress",
					Value = EmailAddress != null ? EmailAddress.Trim() : ""
				}
			};

			var results = CheckExisitService.Record("Employees", "EmployeeId",  conditions);
			var errors = new Dictionary<string, string>(); // Dictionary to store error messages

			foreach (var row in results)
			{
				var columnName = row["ColumnName"].ToString();
				var primaryKeyValue = Convert.ToInt32(row["PrimaryKeyValue"]);

				// Check if PrimaryKeyValue is not zero, and add an error message if so
				if (primaryKeyValue != 0)
				{
					errors[columnName] = $"{columnName} already exists."; // Store column name and error message
				}

			}

			return errors;
		}


		public EmployeeModel GetById(int id)
		{
			var result = QueryService.Query(
				"sp_GetAll_Employees",
				reader =>
				{
					return new EmployeeModel
					{
						EmployeeId = Convert.ToInt32(reader["EmployeeId"]),
						BranchId = Convert.ToInt16(reader["BranchId"]),
						BranchName = reader["BranchName"].ToString(),
						EmployeeCode = reader["EmployeeCode"].ToString(),
						EmployeeName = reader["EmployeeName"].ToString(),
						MobileNumber = reader["MobileNumber"].ToString(),
						EmailAddress = reader["EmailAddress"].ToString(),
						RoleId = Convert.ToInt16(reader["RoleId"]),
						RoleName = reader["RoleName"].ToString(),
						//Password = reader["Password"].ToString(),
						Status = Convert.ToBoolean(reader["Status"]),
						StatusLabel = reader["StatusLabel"].ToString(),
					};
				},
				new SqlParameter("@EmployeeId", id),
				new SqlParameter("@BranchId", 0),
				new SqlParameter("@RoleId", 0)
			);

			return result?.FirstOrDefault();
		}

		public List<EmployeeModel> GetByRoleId(int roleId)
		{
			return QueryService.Query(
				"sp_GetAll_Employees",
				reader =>
				{
					return new EmployeeModel
					{
						EmployeeId = Convert.ToInt32(reader["EmployeeId"]),
						BranchId = Convert.ToInt16(reader["BranchId"]),
						BranchName = reader["BranchName"].ToString(),
						EmployeeCode = reader["EmployeeCode"].ToString(),
						EmployeeName = reader["EmployeeName"].ToString(),
						MobileNumber = reader["MobileNumber"].ToString(),
						EmailAddress = reader["EmailAddress"].ToString(),
						RoleId = Convert.ToInt16(reader["RoleId"]),
						RoleName = reader["RoleName"].ToString(),
						//Password = reader["Password"].ToString(),
						Status = reader["Status"] == "1",
						StatusLabel = reader["StatusLabel"].ToString(),
					};
				},
				new SqlParameter("@EmployeeId", 0),
				new SqlParameter("@BranchId", 0),
				new SqlParameter("@RoleId", roleId)
			);
		}

		public void Restore(int id)
		{
			var parameters = new List<KeyValuePair<string, object>>
			{
				new("@Type", "RESTORE"),
				new("@EmployeeId", id),
				new("@BranchId", 0),
				new("@EmployeeCode", ""),
				new("@EmployeeName", ""),
				new("@MobileNumber", ""),
				new("@EmailAddress", ""),
				new("@RoleId", 0),
				new("@Password", ""),
				new("@Status", false)
			};

			QueryService.NonQuery("[sp_CreateUpdateDeleteRestorePassword_Employees]", parameters);

		}

		public void ToggleStatus(int id)
		{
			throw new NotImplementedException();
		}

		public void Update(EmployeeModel employee)
		{
			var parameters = new List<KeyValuePair<string, object>>
			{
				new("@Type", "UPDATE"),
				new("@EmployeeId", employee.EmployeeId),
				new("@BranchId", employee.BranchId),
				new("@EmployeeCode", employee.EmployeeCode),
				new("@EmployeeName", employee.EmployeeName),
				new("@MobileNumber", employee.MobileNumber),
				new("@EmailAddress", employee.EmailAddress),
				new("@RoleId", employee.RoleId),
				new("@Password", employee.Password),
				new("@Status", employee.Status)
			};

			QueryService.NonQuery("[sp_CreateUpdateDeleteRestorePassword_Employees]", parameters);
		}
	}
}
