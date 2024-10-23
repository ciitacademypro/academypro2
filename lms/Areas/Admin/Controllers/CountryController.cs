using LmsServices.Admin.Interfaces;
using LmsServices.Admin.Implmentations;
using Microsoft.AspNetCore.Mvc;
using LmsModels.Admin;

namespace lms.Areas.Admin.Controllers
{
	[Area("Admin")]
	public class CountryController : Controller
	{
		ICountryService _countryService;

        public CountryController()
        {
			_countryService = new CountryService();
		}

		public IActionResult Test(string CountryId, string CountryName)
		{
			ViewBag.TestData = "This is Test Data";
			ViewBag.TestData2 = new List<string>()
			{
				"Apple",
				"Mango",
				"Potato",
				"Banana"
			};

			ViewBag.TestData3 = _countryService.GetAll();


            return View();
		}



		public IActionResult Index()
		{
			ViewBag.Countries = _countryService.GetAll();
			return View();
		}

		[HttpPost]
		public IActionResult Create(CountryModel country)
		{
			_countryService.Create(country);
			TempData["success"] = "Record Added successfully!";

			return RedirectToAction("Index");
		}


		[HttpPost]
		public IActionResult Update(CountryModel country)
		{
			_countryService.Update(country);
			TempData["success"] = "Record updated successfully!";

			return RedirectToAction("Index");
		}


		[HttpPost]
		public IActionResult Delete(int countryId)
		{
			_countryService.Delete(countryId);
			TempData["success"] = "Record deleted successfully!";

			return RedirectToAction("Index");
		}

	}
}
