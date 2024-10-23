﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LmsModels.Admin
{
	public class RoleModel
	{
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public short RoleId { get; set; }
		public string RoleName { get; set; }
		public bool Status { get; set; }
		public string StatusLabel { get; set; }
	}
}
