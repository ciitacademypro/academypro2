using LmsServices.Course.Implementations;
using LmsServices.Course.Interfaces;
using LmsServices.Employee.Implementations;
using LmsServices.Employee.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace lms.Areas.Batch.Controllers
{
	[Area("Batch")]
	public class BatchController : Controller
	{
		ICourseCategoryService _courseCategoryService;
		ICourseModuleService _courseModuleService; 
		IEmployeeService _employeeService;

		public BatchController()
		{
			_courseCategoryService = new CourseCategoryService();
			_courseModuleService = new CourseModuleService();
			_employeeService = new EmployeeService();
		}
		public IActionResult Index()
		{
			ViewBag.Trainers = _employeeService.GetAll(0,2,0);
			ViewBag.CourseModules = _courseModuleService.GetAll(0,0);
            ViewBag.CourseCategories = _courseCategoryService.GetAll();
			return View();
		}
	}
}
