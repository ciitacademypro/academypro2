using LmsModels.Batch;
using LmsServices.Batch.Implementations;
using LmsServices.Batch.Implmentations;
using LmsServices.Batch.Interfaces;
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
		IBatchService _batchService;
		IClassRoomService _classRoomService;

		IBatchScheduleService _batchScheduleService;

		public BatchController()
		{
			_courseCategoryService = new CourseCategoryService();
			_courseModuleService = new CourseModuleService();
			_employeeService = new EmployeeService();
			_batchService = new BatchService();
			_classRoomService = new ClassRoomService();
			_batchScheduleService = new BatchScheduleService();
		}
		public IActionResult Index()
		{
			ViewBag.Batches = _batchService.GetAll();
			return View();
		}


		public IActionResult Create()
		{
			ViewBag.Trainers = _employeeService.GetAll(0,2,0);
			ViewBag.CourseModules = _courseModuleService.GetAll(0,0);
            ViewBag.CourseCategories = _courseCategoryService.GetAll();
			ViewBag.ClassRooms = _classRoomService.GetAll(); // ClassRoomId, ClassRoomName

			return View();
		}


		[HttpPost]
		public IActionResult Create(BatchModel batch,  List<BatchScheduleItem> batchScheduleItem){
			
			if (batch == null || batchScheduleItem == null)
			{
				return BadRequest("Invalid data.");
			}

			try
				{

					// add this dynamically afeter login
					batch.BranchId = 1;

					int lastInsertedId = _batchService.Create(batch);


					// Ensure BatchSchedules is properly initialized before setting properties
					if (batch.BatchSchedules == null)
					{
						batch.BatchSchedules = new BatchScheduleModelCreate();
					}

					// Update BatchSchedules properties
					batch.BatchSchedules.BranchId = batch.BranchId;
					batch.BatchSchedules.BatchId = lastInsertedId;


					// Add items from the request to BatchSchedules
					if (batchScheduleItem != null)
					{
						foreach (var item in batchScheduleItem) // Iterate over the Items collection
						{
							// Parse the string back to DateTime before assigning
							DateTime parsedDateTime;
							if (DateTime.TryParse(item.ExpectedDateTime.ToString("yyyy-MM-dd"), out parsedDateTime))
							{
								batch.BatchSchedules.Items.Add(new BatchScheduleItem
								{
									ExpectedDateTime = parsedDateTime,  // Now ExpectedDateTime is DateTime, not string
									ExpectedTrainerId = item.ExpectedTrainerId,
									ContentIds = item.ContentIds,
									ContentNames = item.ContentNames,
								});
							}
							else
							{
								// Handle the case where the date couldn't be parsed, for example:
								Console.WriteLine("Invalid date format.");
							}
						}
					}

					_batchScheduleService.Create(batch.BatchSchedules);
					
					// Return JSON response with success message
					return Json(new { success = true, message = "Batch created successfully!", data = lastInsertedId });
				}
				catch (Exception ex)
				{
					// Handle error, returning JSON with an error message
					return Json(new { success = false, message = "An error occurred: " + ex.Message });
				}

		}

	}
}
