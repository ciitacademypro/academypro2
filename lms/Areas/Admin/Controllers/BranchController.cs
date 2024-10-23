using LmsServices.Admin.Interfaces;
using LmsServices.Admin.Implmentations;
using Microsoft.AspNetCore.Mvc;
using LmsServices.Course.Interfaces;
using LmsModels.Admin;

namespace lms.Areas.Admin.Controllers
{
	[Area("Admin")]
	public class BranchController : Controller
	{
		private readonly IBranchService _branchService;
		public BranchController() {

			_branchService = new BranchService();
		}

		public IActionResult Index()
		{
			ViewBag.Branches = _branchService.GetAll();
			return View();
		}

		[HttpPost]
		public IActionResult Create(BranchModel branch)
		{
			_branchService.Create(branch);
			TempData["success"] = "Record Added successfully!";

			return RedirectToAction("Index");
		}


		[HttpPost]
		public IActionResult Update(BranchModel branch)
		{
			_branchService.Update(branch);
			TempData["success"] = "Record updated successfully!";

			return RedirectToAction("Index");
		}


		[HttpPost]
		public IActionResult Delete(int BranchId)
		{
			_branchService.Delete(BranchId);
			TempData["success"] = "Record deleted successfully!";

			return RedirectToAction("Index");
		}

	}
}
