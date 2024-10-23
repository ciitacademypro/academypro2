
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LmsModels.Student;

namespace LmsServices.Student.Interfaces
{
	public interface IEnquiryService
	{
		public void Create(EnquiryModel Enquiry);
		public void Update(EnquiryModel Enquiry);
		public void Delete(int id);
		public void Restore(int id);
		public void ToggleStatus(int id);
		public EnquiryModel GetById(int id);
		public List<EnquiryModel> GetAll();
	}
}
