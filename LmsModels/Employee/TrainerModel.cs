using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LmsModels.Employee
{
	public class TrainerModel
	{
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public short TrainerId { get; set; }
		public short EmployeeId { get; set; }
		public string EmployeeName { get; set; }
		public bool Status { get; set; }
		public string StatusLabel { get; set; }

	}
}
