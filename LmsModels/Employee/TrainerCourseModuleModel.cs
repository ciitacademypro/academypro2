using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LmsModels.Employee
{
	public class TrainerCourseModuleModel
	{
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]

		public short TrainerCourseModuleId { get; set; }
		public short TrainerId { get; set; }
		public short? CourseId { get; set; }
		public string? CourseName { get; set; }
		public short CourseModuleId { get; set; }
		public string? ModuleName { get; set; }
		public bool Status { get; set; }
		public string? StatusLabel { get; set; }


	}
}
