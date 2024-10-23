﻿using LmsEnv;
using LmsModels.Admin;
using LmsModels.Course;
using LmsServices.Admin.Interfaces;
using LmsServices.Common;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LmsServices.Admin.Implmentations
{
	public class BranchService : IBranchService
	{
		private readonly string connString;
		public BranchService() {
			connString = DbConnect.DefaultConnection;
		}

		public void Create(BranchModel branch)
		{
			var parameters = new List<KeyValuePair<string, object>>
			{
				new ("@Type", "INSERT"),
				new ("@BranchId", 0),
				new ("@BranchName", branch.BranchName),
				new ("@Status", branch.Status)
			};

			QueryService.NonQuery("[sp_CreateUpdateDeleteRestore_Branches]", parameters);
		}

		public void Delete(int id)
		{
			var parameters = new List<KeyValuePair<string, object>>
			{
				new ("@Type", "DELETE"),
				new ("@BranchId", id),
				new ("@BranchName", ""),
				new ("@Status", false)
			};

			QueryService.NonQuery("[sp_CreateUpdateDeleteRestore_Branches]", parameters);

		}

		public List<BranchModel> GetAll()
		{
			return QueryService.Query(
				"sp_GetAll_Branches",
				reader =>
				{
					return new BranchModel
					{
						BranchId = Convert.ToInt16(reader["BranchId"]),
						BranchName = reader["BranchName"].ToString(),
						Status = reader["Status"] == "1",
						StatusLabel = reader["StatusLabel"].ToString()
					};
				},
				new SqlParameter("@BranchId", 0)
			);
		}

		public BranchModel GetById(int id)
		{
			var result =  QueryService.Query(
				"sp_GetAll_Branches",
				reader =>
				{
					return new BranchModel
					{
						BranchId = Convert.ToInt16(reader["BranchId"]),
						BranchName = reader["BranchName"].ToString(),
						Status = reader["Status"] == "1",
						StatusLabel = reader["StatusLabel"].ToString()
					};
				},
				new SqlParameter("@BranchId", id)
			);
			return result?.FirstOrDefault();
		}

		public void Restore(int id)
		{
			var parameters = new List<KeyValuePair<string, object>>
			{
				new ("@Type", "RESTORE"),
				new ("@BranchId", id),
				new ("@BranchName", ""),
				new ("@Status", false)
			};

			QueryService.NonQuery("[sp_CreateUpdateDeleteRestore_Branches]", parameters);
		}

		public void ToggleStatus(int id)
		{
			throw new NotImplementedException();
		}

		public void Update(BranchModel branch)
		{
			var parameters = new List<KeyValuePair<string, object>>
			{
				new ("@Type", "UPDATE"),
				new ("@BranchId", branch.BranchId),
				new ("@BranchName", branch.BranchName),
				new ("@Status", branch.Status)
			};

			QueryService.NonQuery("[sp_CreateUpdateDeleteRestore_Branches]", parameters);

		}


	}
}
