using LmsModels.Admin;
using LmsModels.Employee;
using LmsServices.Admin.Implmentations;
using LmsServices.Admin.Interfaces;
using LmsServices.Course.Implementations;
using LmsServices.Course.Interfaces;
using LmsServices.Employee.Implementations;
using LmsServices.Employee.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;

namespace lms.Areas.Employee.Controllers
{
	[Area("Employee")]

	public class TrainerController : Controller
	{
		private readonly ITrainerService _trainerService;
		private readonly IEmployeeService _employeeService;
		private readonly ITrainerCourseModuleService _trainerCourseModuleService;
		private readonly ICourseModuleService _courseModuleService;


		public TrainerController()
        {
            _trainerService =new TrainerService();
			_employeeService =new EmployeeService();
			_trainerCourseModuleService=new TrainerCourseModuleService();
			_courseModuleService=new CourseModuleService();
        }

        public IActionResult Index()
		{
			ViewBag.Trainers = _trainerService.GetAll();
			ViewBag.Employees = _employeeService.GetAll();
			return View();
		}

		[HttpPost]
		public IActionResult Create(TrainerModel trainer)
		{
			_trainerService.Create(trainer);
			TempData["success"] = "Record Added successfully!";

			return RedirectToAction("Index");
		}


		[HttpPost]
		public IActionResult Update(TrainerModel trainer)
		{
			_trainerService.Update(trainer);
			TempData["success"] = "Record updated successfully!";

			return RedirectToAction("Index");
		}


		[HttpPost]
		public IActionResult Delete(int id)
		{
			_trainerService.Delete(id);
			TempData["success"] = "Record deleted successfully!";

			return RedirectToAction("Index");
		}

		public IActionResult GetIdNameList(int id)
		{
			var trainers = _trainerService.GetByEmployeeId(id); // trainerId, EmployeeId
			if (trainers == null || !trainers.Any())
			{
				return Json(new object[] { }); // Return an empty JSON array
			}

			// Select only the trainerId and trainerName
			var idNameList = trainers.Select(c => new
			{
				c.EmployeeId,
				c.EmployeeName
			}).ToList();
			return Json(idNameList);
		}


		public IActionResult AssignTo(int id)
		{
			ViewBag.TrainerId = id;
			ViewBag.CourseModules = _courseModuleService.GetAllCourseModules();
			ViewBag.Employee = _employeeService.GetById(id);
			ViewBag.CourseList=_trainerCourseModuleService.GetByTrainerId(id);

			return View();
		}
		[HttpPost]
		public IActionResult AssignTo()
		{

			try
			{
				var trainerId = Convert.ToInt16(Request.Form["TrainerId"]);
				var modules = Request.Form["modules[]"].ToArray();

				foreach (var module in modules)
				{
					// Create the TrainerCourseModuleModel object
					TrainerCourseModuleModel trainer = new TrainerCourseModuleModel
					{
						TrainerId = trainerId,
						CourseModuleId = Convert.ToInt16(module),
						Status = true
					};

					// Call the service method to save the data
					_trainerCourseModuleService.Create(trainer);
				}

				TempData["success"] = "Details saved successfully!";
				return RedirectToAction("Index", new { id = trainerId });
			}
			catch (SqlException ex)
			{
				// Check if the exception is related to a unique constraint violation
				if (ex.Message.Contains("This Trainer or CourseModule already exists"))
				{
					TempData["error"] = "This Trainer and CourseModule  already exists.";
				}
				

				// Reload the data for the view and return the view
				var trainerId = Convert.ToInt16(Request.Form["TrainerId"]);
				ViewBag.TrainerId = trainerId;
				ViewBag.CourseModules = _courseModuleService.GetAllCourseModules();
				ViewBag.Employee = _employeeService.GetById(trainerId);
				ViewBag.CourseList = _trainerCourseModuleService.GetByTrainerId(trainerId);

				return RedirectToAction("AssignTo");
			}

		}
	}
}
