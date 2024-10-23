using LmsModels.Course;
using LmsServices.Course.Implementations;
using LmsServices.Course.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace lms.Areas.Course.Controllers
{
	[Area("Course")]
	public class CourseModuleController : Controller
	{
		ICourseModuleService _courseModuleService;
		ICourseService _courseService;
		ICourseCategoryService _courseCategoryService;

		public CourseModuleController()
        {
			
			_courseModuleService = new CourseModuleService();
			_courseService = new CourseService();
			_courseCategoryService = new CourseCategoryService();

		}

		public IActionResult Index()
		{
			ViewBag.courseModules = _courseModuleService.GetAllCourseModules(0, 0);
			return View("~/Areas/Course/Views/CourseModule/Index.cshtml");
		}

		public IActionResult Create()
		{
           
            ViewBag.CourseCategories = _courseCategoryService.GetAll();
            return View("~/Areas/Course/Views/CourseModule/Create.cshtml");
		}

		[HttpPost]
		public IActionResult Create(CourseModuleModel courseModule)
		{
			_courseModuleService.CreateCourseModule(courseModule);

			TempData["success"] = "Course Module created successfully!";
			return RedirectToAction("Index");
		}

		public ActionResult Edit(int id)
		{
			
			var courseModule = _courseModuleService.GetById(id);

		    if (courseModule == null)
			{
				TempData["error"] = "Course Module not found!";
				return RedirectToAction("Index");
			}
			ViewBag.Course = _courseService.GetAll();
            ViewBag.CourseCategories = _courseCategoryService.GetAll();

			return View("~/Areas/Course/Views/CourseModule/Edit.cshtml", courseModule);
		}

		[HttpPost]
		public ActionResult Edit(CourseModuleModel courseModule)
		{
	
			var existingModule = _courseModuleService.GetById(courseModule.CourseModuleId);

			if (existingModule == null)
			{
				TempData["error"] = "Course Module not found!";
				return RedirectToAction("Index");
			}

			
			_courseModuleService.UpdateCourseModule(courseModule);

			TempData["success"] = "Course Module updated successfully!";
			return RedirectToAction("Index");
		}



		[HttpPost]
		public IActionResult Delete(int id) 
		{
			_courseModuleService.DeleteCourseModule(id);
			TempData["success"] = "Course Module Deleted successfully!";
			return RedirectToAction("Index");
		}

	}
}
