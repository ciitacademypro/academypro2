using LmsModels.Employee;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LmsServices.Employee.Interfaces
{
	public interface ITrainerCourseModuleService
	{
		public TrainerCourseModuleModel GetById(int id);
		public List<TrainerCourseModuleModel> GetByTrainerId(int id);
		//public List<TrainerCourseModuleModel> GetAll();

		public void Create(TrainerCourseModuleModel trainer);
	}
}
