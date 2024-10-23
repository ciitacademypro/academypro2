using LmsEnv;
using LmsModels.Admin;
using LmsModels.Employee;
using LmsServices.Common;
using LmsServices.Employee.Interfaces;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LmsServices.Employee.Implementations
{
	public class TrainerService:ITrainerService
	{
		private readonly string connString;

        public TrainerService()
        {
			connString = DbConnect.DefaultConnection;
		}

		public void Create(TrainerModel trainer)
		{
			var parameters = new List<KeyValuePair<string, object>>
			{
				new ("@Type", "INSERT"),
				new ("@TrainerId", 0),
				new ("@EmployeeId", trainer.EmployeeId),
				new ("@Status", trainer.Status)
			};
			QueryService.NonQuery("[sp_CreateUpdateDeleteRestore_Trainers]", parameters);
		}

		public void Delete(int id)
		{
			var parameters = new List<KeyValuePair<string, object>>
			{
				new ("@Type", "DELETE"),
				new ("@TrainerId", id),
				new ("@EmployeeId", 0),
				new ("@Status", false)
			};
			QueryService.NonQuery("[sp_CreateUpdateDeleteRestore_Trainers]", parameters);
		}

		public List<TrainerModel> GetAll()
		{
			return QueryService.Query(
			"sp_GetAll_Trainers",
			reader =>
			{
				return new TrainerModel
				{
					TrainerId = Convert.ToInt16(reader["TrainerId"]),
					EmployeeName = reader["EmployeeName"].ToString(),
					EmployeeId = Convert.ToInt16(reader["EmployeeId"]),
					Status = reader["Status"] == "1",
					StatusLabel = reader["StatusLabel"].ToString()
				};
			},
			new SqlParameter("@TrainerId", 0),
			new SqlParameter("@EmployeeId", 0)
		);
		}

		public List<TrainerModel> GetByEmployeeId(int id)
		{
			return QueryService.Query(
			  "sp_GetAll_Trainers",
			  reader =>
			  {
				  return new TrainerModel
				  {
					  TrainerId = Convert.ToInt16(reader["TrainerId"]),
					  EmployeeName = reader["EmployeeName"].ToString(),
					  EmployeeId = Convert.ToInt16(reader["EmployeeId"]),
					  Status = reader["Status"] == "1",
					  StatusLabel = reader["StatusLabel"].ToString()
				  };
			  },
			  new SqlParameter("@TrainerId", 0),
			  new SqlParameter("@EmployeeId", id)
		  );
		}

		public TrainerModel GetById(int id)
		{
			var result = QueryService.Query(
						  "sp_GetAll_Trainers",
						  reader =>
						  {
							  return new TrainerModel
							  {
								  TrainerId = Convert.ToInt16(reader["TrainerId"]),
								  EmployeeName = reader["EmployeeName"].ToString(),
								  EmployeeId = Convert.ToInt16(reader["EmployeeId"]),
								  Status = reader["Status"] == "1",
								  StatusLabel = reader["StatusLabel"].ToString()
							  };
						  },
						  new SqlParameter("@TrainerId", id),
						  new SqlParameter("@EmployeeId", 0)
					  );
			return result?.FirstOrDefault();
		}

		public void Restore(int id)
		{
			var parameters = new List<KeyValuePair<string, object>>
			{
				new ("@Type", "RESTORE"),
				new ("@TrainerId", id),
				new ("@EmployeeId", 0),
				new ("@Status", false)
			};
			QueryService.NonQuery("[sp_CreateUpdateDeleteRestore_Trainers]", parameters);
		}

		public void ToggleStatus(int id)
		{
			throw new NotImplementedException();
		}

		public void Update(TrainerModel trainer)
		{
			var parameters = new List<KeyValuePair<string, object>>
			{
				new ("@Type", "UPDATE"),
				new ("@TrainerId", trainer.TrainerId),
				new ("@EmployeeId", trainer.EmployeeId),
				new ("@Status", trainer.Status)
			};
			QueryService.NonQuery("[sp_CreateUpdateDeleteRestore_Trainers]", parameters);
		}
	}
}
