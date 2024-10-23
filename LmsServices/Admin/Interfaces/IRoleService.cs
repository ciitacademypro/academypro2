using LmsModels.Admin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LmsServices.Admin.Interfaces
{
	public interface IRoleService
	{
		public void Create(RoleModel role);
		public void Update(RoleModel role);
		public void Delete(int id);
		public void Restore(int id);
		public void ToggleStatus(int id);
		public RoleModel GetById(int id);
		public List<RoleModel> GetAll();
	}
}
