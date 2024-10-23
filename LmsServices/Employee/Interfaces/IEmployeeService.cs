using LmsModels.Course;
using LmsModels.Employee;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LmsServices.Employee.Interfaces
{
	public interface IEmployeeService
	{
		public void Create(EmployeeModel employee);
		public void Update(EmployeeModel employee);
		public void Delete(int id);
		public void Restore(int id);
		public void ToggleStatus(int id);
		public List<EmployeeModel> GetAll();
		public EmployeeModel GetById(int id);
		public List<EmployeeModel> GetByBranchId(int branchId);
		public List<EmployeeModel> GetByRoleId(int roleId);
		public Dictionary<string, string> CheckExist(string EmployeeCode, string MobileNumber, string EmailAddress);
	}
}
