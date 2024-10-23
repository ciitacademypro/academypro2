using LmsModels.Admin;
using LmsServices.Admin.Implmentations;
using LmsServices.Admin.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace lms.Areas.Admin.Controllers
{
	[Area("Admin")]
	public class CityController : Controller
	{
		private readonly ICountryService _countryService;
		private readonly IStateService _stateService;
		private readonly ICityService _cityService;

        public CityController()
        {
			_countryService = new CountryService();
			_stateService = new StateService();
			_cityService = new CityService();            
        }


		public IActionResult Index()
		{
			ViewBag.Countries = _countryService.GetAll();
			ViewBag.Cities = _cityService.GetAll();
			return View();
		}

		[HttpPost]
		public IActionResult Create(CityModel city)
		{
			_cityService.Create(city);
			TempData["success"] = "Record Added successfully!";

			return RedirectToAction("Index");
		}


		[HttpPost]
		public IActionResult Update(CityModel city)
		{
			_cityService.Update(city);
			TempData["success"] = "Record updated successfully!";

			return RedirectToAction("Index");
		}


		[HttpPost]
		public IActionResult Delete(int CityId)
		{
			_cityService.Delete(CityId);
			TempData["success"] = "Record deleted successfully!";

			return RedirectToAction("Index");
		}


	}
}
