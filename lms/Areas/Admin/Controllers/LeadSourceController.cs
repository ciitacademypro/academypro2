using LmsModels.Admin;
using LmsServices.Admin.Implmentations;
using LmsServices.Admin.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace lms.Areas.Admin.Controllers
{
	[Area("Admin")]
	public class LeadSourceController : Controller
	{
		private readonly ILeadSourceService _leadSourceService;

        public LeadSourceController()
        {
			_leadSourceService = new LeadSourceService();
		}

		public IActionResult Index()
		{
			ViewBag.Branches = _leadSourceService.GetAll();
			return View();
		}

		[HttpPost]
		public IActionResult Create(LeadSourceModel leadSource)
		{
			_leadSourceService.Create(leadSource);
			TempData["success"] = "Record Added successfully!";

			return RedirectToAction("Index");
		}


		[HttpPost]
		public IActionResult Update(LeadSourceModel leadSource)
		{
			_leadSourceService.Update(leadSource);
			TempData["success"] = "Record updated successfully!";

			return RedirectToAction("Index");
		}


		[HttpPost]
		public IActionResult Delete(int LeadSourceId)
		{
			_leadSourceService.Delete(LeadSourceId);
			TempData["success"] = "Record deleted successfully!";

			return RedirectToAction("Index");
		}
	}
}
