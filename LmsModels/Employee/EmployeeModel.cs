using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LmsModels.Employee
{
	public class EmployeeModel
	{
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int EmployeeId { get; set; }

		[Required(ErrorMessage = "Branch is required.")]
		public short? BranchId { get; set; }
		public string? BranchName { get; set; }

		[Required(ErrorMessage = "Employee Code is required.")]
		public string EmployeeCode { get; set; }

		[Required(ErrorMessage = "Employee Name is required.")]
		public string EmployeeName { get; set; }

		[Required(ErrorMessage = "Mobile Number is required.")]
		[StringLength(15, ErrorMessage = "Mobile Number cannot be longer than 15 characters.")]
		[RegularExpression(@"^[0-9]+$", ErrorMessage = "Mobile Number must be numeric.")]
		public string MobileNumber { get; set; }

		[Required(ErrorMessage = "Email Address is required.")]
		[EmailAddress(ErrorMessage = "Invalid Email Address format.")]
		[StringLength(50, ErrorMessage = "Email Address cannot be longer than 50 characters.")]
		public string EmailAddress { get; set; }

		[Required(ErrorMessage = "Role is required.")]
		public short? RoleId { get; set; }
		public string? RoleName { get; set; }

		[Required(ErrorMessage = "Password is required.")]
		public string Password { get; set; }
		public bool Status { get; set; }
		public string? StatusLabel { get; set; }

	}
}
