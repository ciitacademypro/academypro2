using LmsServices.Admin.Interfaces;
using LmsServices.Admin.Implmentations;
using Microsoft.AspNetCore.Mvc;
using LmsModels.Admin;

namespace lms.Areas.Admin.Controllers
{
	[Area("Admin")]
	public class RoleController : Controller
	{
		private readonly IRoleService _roleService;

        public RoleController()
        {
			_roleService = new RoleService();
		}

		public IActionResult Index()
		{
			ViewBag.Branches = _roleService.GetAll();
			return View();
		}

		[HttpPost]
		public IActionResult Create(RoleModel role)
		{
			_roleService.Create(role);
			TempData["success"] = "Record Added successfully!";

			return RedirectToAction("Index");
		}


		[HttpPost]
		public IActionResult Update(RoleModel role)
		{
			_roleService.Update(role);
			TempData["success"] = "Record updated successfully!";

			return RedirectToAction("Index");
		}


		[HttpPost]
		public IActionResult Delete(int RoleId)
		{
			_roleService.Delete(RoleId);
			TempData["success"] = "Record deleted successfully!";

			return RedirectToAction("Index");
		}

	}
}
