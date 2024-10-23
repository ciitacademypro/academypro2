using LmsEnv;
using LmsModels.Admin;
using LmsServices.Admin.Interfaces;
using LmsServices.Common;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LmsServices.Admin.Implmentations
{
	public class RoleService : IRoleService
	{
		private readonly string connString;
		public RoleService() {
			connString = DbConnect.DefaultConnection;
		}

		public void Create(RoleModel role)
		{
			var parameters = new List<KeyValuePair<string, object>>
			{
				new ("@Type", "INSERT"),
				new ("@RoleId", 0),
				new ("@RoleName", role.RoleName),
				new ("@Status", role.Status)
			};

			QueryService.NonQuery("[sp_CreateUpdateDeleteRestore_Roles]", parameters);
		}

		public void Delete(int id)
		{
			var parameters = new List<KeyValuePair<string, object>>
			{
				new ("@Type", "DELETE"),
				new ("@RoleId", id),
				new ("@RoleName", ""),
				new ("@Status", false)
			};

			QueryService.NonQuery("[sp_CreateUpdateDeleteRestore_Roles]", parameters);

		}

		public List<RoleModel> GetAll()
		{
			return QueryService.Query(
				"sp_GetAll_Roles",
				reader =>
				{
					return new RoleModel
					{
						RoleId = Convert.ToInt16(reader["RoleId"]),
						RoleName = reader["RoleName"].ToString(),
						Status = reader["Status"] == "1",
						StatusLabel = reader["StatusLabel"].ToString()
					};
				},
				new SqlParameter("@RoleId", 0)
				);
		}

		public RoleModel GetById(int id)
		{
			var result =  QueryService.Query(
				"sp_GetAll_Roles",
				reader =>
				{
					return new RoleModel
					{
						RoleId = Convert.ToInt16(reader["RoleId"]),
						RoleName = reader["RoleName"].ToString(),
						Status = reader["Status"] == "1",
						StatusLabel = reader["StatusLabel"].ToString()
					};
				},
				new SqlParameter("@RoleId", id)
			);
			return result?.FirstOrDefault();
		}

		public void Restore(int id)
		{
			var parameters = new List<KeyValuePair<string, object>>
			{
				new ("@Type", "RESTORE"),
				new ("@RoleId", id),
				new ("@RoleName", ""),
				new ("@Status", false)
			};

			QueryService.NonQuery("[sp_CreateUpdateDeleteRestore_Roles]", parameters);

		}

		public void ToggleStatus(int id)
		{
			throw new NotImplementedException();
		}

		public void Update(RoleModel role)
		{
			var parameters = new List<KeyValuePair<string, object>>
			{
				new ("@Type", "UPDATE"),
				new ("@RoleId", role.RoleId),
				new ("@RoleName", role.RoleName),
				new ("@Status", role.Status)
			};

			QueryService.NonQuery("[sp_CreateUpdateDeleteRestore_Roles]", parameters);

		}
	}
}
