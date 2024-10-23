using LmsModels.Admin;
using LmsServices.Admin.Implmentations;
using LmsServices.Admin.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace lms.Areas.Admin.Controllers
{
	[Area("Admin")]
	public class QualificationController : Controller
	{
		private readonly IQualificationService _qualificationService;

        public QualificationController()
        {
			_qualificationService = new QualificationService();
		}

		public IActionResult Index()
		{
			ViewBag.Qualifications = _qualificationService.GetAll();
			return View();
		}

		

		[HttpPost]
		public IActionResult Create(QualificationModel qualification)
		{
			_qualificationService.Create(qualification);
			TempData["success"] = "Record Added successfully!";

			return RedirectToAction("Index");
		}


		[HttpPost]
		public IActionResult Update(QualificationModel qualification)
		{
			_qualificationService.Update(qualification);
			TempData["success"] = "Record updated successfully!";

			return RedirectToAction("Index");
		}


		[HttpPost]
		public IActionResult Delete(int QualificationId)
		{
			_qualificationService.Delete(QualificationId);
			TempData["success"] = "Record deleted successfully!";

			return RedirectToAction("Index");
		}


	}
}
