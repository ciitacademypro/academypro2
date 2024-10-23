using LmsEnv;
using LmsModels.Employee;
using LmsServices.Common;
using LmsServices.Employee.Interfaces;
using Microsoft.Data.SqlClient;


namespace LmsServices.Employee.Implementations
{
	public class TrainerCourseModuleService : ITrainerCourseModuleService
	{
		private readonly string connString;

        public TrainerCourseModuleService()
        {
			connString = DbConnect.DefaultConnection;

		}

		public void Create(TrainerCourseModuleModel trainer)
		{
			var parameters = new List<KeyValuePair<string, object>>
			{
				new("@Type", "INSERT"),
				new("@TrainerCourseModuleId", 0),
				new("@TrainerId", trainer.TrainerId),
				new("@CourseModuleId", trainer.CourseModuleId),
				new("@Status", trainer.Status)
			};

			QueryService.NonQuery("[sp_Create_TrainerCourseModules]", parameters);
		}





		//public List<TrainerCourseModuleModel> GetAll()
		//{
		//	return QueryService.Query(
		//	"sp_GetAll_TrainerCourseModules",
		//	reader =>
		//	{
		//		return new TrainerCourseModuleModel
		//		{
		//			TrainerCourseModuleId = Convert.ToInt16(reader["TrainerCourseModuleId"]),
		//			TrainerId = Convert.ToInt16(reader["TrainerId"]),
		//			CourseId = Convert.ToInt16(reader["CourseId"]),
		//			CourseName = reader["CourseName"].ToString(),
		//			CourseModuleId = Convert.ToInt16(reader["CourseModuleId"]),
		//			ModuleName = reader["ModuleName"].ToString(),
		//			Status = reader["Status"] == "1",
		//			StatusLabel = reader["StatusLabel"].ToString()
		//		};
		//	},
		//	new SqlParameter("@TrainerCourseModuleId", 0),
		//	new SqlParameter("@TrainerId", 0)
		//);
		//}

		public TrainerCourseModuleModel GetById(int id)
		{
			var result = QueryService.Query(
			"sp_GetAll_TrainerCourseModules",
			reader =>
			{
				return new TrainerCourseModuleModel
				{
					TrainerCourseModuleId = Convert.ToInt16(reader["TrainerCourseModuleId"]),
					TrainerId = Convert.ToInt16(reader["TrainerId"]),
					CourseId = Convert.ToInt16(reader["CourseId"]),
					CourseName = reader["CourseName"].ToString(),
					CourseModuleId = Convert.ToInt16(reader["CourseModuleId"]),
					ModuleName = reader["ModuleName"].ToString(),
					Status = reader["Status"] == "1",
					StatusLabel = reader["StatusLabel"].ToString()
				};
			},
			new SqlParameter("@TrainerCourseModuleId", id),
			new SqlParameter("@TrainerId", 0)
					  );
			return result?.FirstOrDefault();
		}

		public List<TrainerCourseModuleModel> GetByTrainerId(int id)
		{
			return QueryService.Query(
			"sp_GetAll_TrainerCourseModules",
			reader =>
			{
				return new TrainerCourseModuleModel
				{
					TrainerCourseModuleId = Convert.ToInt16(reader["TrainerCourseModuleId"]),
					TrainerId = Convert.ToInt16(reader["TrainerId"]),
					CourseId = Convert.ToInt16(reader["CourseId"]),
					CourseName = reader["CourseName"].ToString(),
					CourseModuleId = Convert.ToInt16(reader["CourseModuleId"]),
					ModuleName = reader["ModuleName"].ToString(),
					Status = reader["Status"] == "1",
					StatusLabel = reader["StatusLabel"].ToString()
				};
			},
			new SqlParameter("@TrainerCourseModuleId", 0),
			new SqlParameter("@TrainerId", id)
		);
		}
	}
}
