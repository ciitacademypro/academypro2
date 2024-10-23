using LmsModels.Employee;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LmsServices.Employee.Interfaces
{
	public interface ITrainerService
	{
		public void Create(TrainerModel trainer);
		public void Update(TrainerModel trainer);
		public void Delete(int id);
		public void Restore(int id);
		public void ToggleStatus(int id);
		public TrainerModel GetById(int id);
		public List<TrainerModel> GetByEmployeeId(int id);
		public List<TrainerModel> GetAll();
	}
}
