using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LmsModels.Admin
{
	public class QualificationModel
	{
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public short QualificationId { get; set; }
		public string QualificationName { get; set; }
		public bool Status { get; set; }
		public string StatusLabel { get; set; }
	}
}
