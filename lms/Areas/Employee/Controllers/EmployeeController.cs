using LmsServices.Employee.Interfaces;
using LmsServices.Employee.Implementations;
using LmsServices.Admin.Interfaces;
using Microsoft.AspNetCore.Mvc;
using LmsModels.Employee;
using LmsModels.Admin;
using LmsServices.Admin.Implmentations;
using Microsoft.CodeAnalysis.Operations;
using Microsoft.IdentityModel.Tokens;
using LmsServices.Common;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace lms.Areas.Employee.Controllers
{
	[Area("Employee")]
	public class EmployeeController : Controller
	{
		IEmployeeService _employeeService;
		IRoleService _roleService;
		IBranchService _branchService;
	
		public EmployeeController()
		{
			_employeeService = new EmployeeService();
			_roleService = new RoleService();
			_branchService = new BranchService();

		}


		public IActionResult Index()
		{
			ViewBag.Employees = _employeeService.GetAll();
			return View();
		}

		public IActionResult Create()
		{
			var roles = _roleService.GetAll();
			var branches = _branchService.GetAll();

			ViewBag.Roles = roles != null ? roles : new List<RoleModel>();
			ViewBag.Branches = branches != null ? branches : new List<BranchModel>();

			return View("~/Areas/Employee/Views/Employee/Create.cshtml");
		}

		[HttpPost]
		public IActionResult Create(EmployeeModel employee, string BranchId, string RoleId)
		{
			employee.BranchId = string.IsNullOrEmpty(BranchId) ? null : Convert.ToInt16(BranchId);
			employee.RoleId = string.IsNullOrEmpty(RoleId) ? null : Convert.ToInt16(RoleId);

			// Check if unique data is already in use
			var recordExistErrors = _employeeService.CheckExist(employee.EmployeeCode, employee.MobileNumber, employee.EmailAddress);

			foreach (var error in recordExistErrors)
			{
				ModelState.AddModelError(error.Key, error.Value);
			}

			if (ModelState.IsValid)
			{
				_employeeService.Create(employee);
				TempData["success"] = "Employee Added Successfully";
				return RedirectToAction("Index");
			}
			var roles = _roleService.GetAll();
			var branches = _branchService.GetAll();

			ViewBag.Roles = roles != null ? roles : new List<RoleModel>();
			ViewBag.Branches = branches != null ? branches : new List<BranchModel>();

			// If validation fails, return the same view with error messages
			return View(employee);
		}


		public IActionResult Edit(int id)
		{
			ViewBag.Roles = _roleService.GetAll();
			ViewBag.Branches = _branchService.GetAll();

			var emp = _employeeService.GetById(id);

			return View(emp);
		}


		[HttpPost]
		public IActionResult Edit([Bind("EmployeeId,EmployeeName, EmployeeCode, MobileNumber, EmailAddress, BranchId,RoleId,Status")] EmployeeModel employee)
		{

			_employeeService.Update(employee);

			TempData["success"] = "Employee Updated successfully!";
			return RedirectToAction("Index");
		}



		[HttpPost]
		public IActionResult Delete(int employeeId)
		{
			_employeeService.Delete(employeeId);

			TempData["success"] = "Employee Delete successfully!";
			return RedirectToAction("Index");
		}

	}
}
