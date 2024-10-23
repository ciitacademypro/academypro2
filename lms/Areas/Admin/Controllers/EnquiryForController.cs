using LmsServices.Admin.Implmentations;
using LmsServices.Admin.Interfaces;
using Microsoft.AspNetCore.Mvc;
using LmsModels.Admin;


namespace lms.Areas.Admin.Controllers
{
	[Area("Admin")]
	public class EnquiryForController : Controller
	{
		
		private readonly IEnquiryForService _enquiryForService;
        public EnquiryForController()
        {
            _enquiryForService = new EnquiryForService();
        }

        public IActionResult Index()
		{
			ViewBag.Enquiries=_enquiryForService.GetAll();
			return View();
		}
		[HttpPost]
		public IActionResult Create(EnquiryForModel enquiry)
		{
			_enquiryForService.Create(enquiry);
			TempData["success"] = "Record Added successfully!";

			return RedirectToAction("Index");
		}


		[HttpPost]
		public IActionResult Update(EnquiryForModel enquiry)
		{
			_enquiryForService.Update(enquiry);
			TempData["success"] = "Record updated successfully!";

			return RedirectToAction("Index");
		}


		[HttpPost]
		public IActionResult Delete(int EnquiryForId)
		{
			_enquiryForService.Delete(EnquiryForId);
			TempData["success"] = "Record deleted successfully!";

			return RedirectToAction("Index");
		}

	}
}
