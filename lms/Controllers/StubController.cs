using Microsoft.AspNetCore.Mvc;

namespace lms.Controllers
{
	public class StubController : Controller
	{
		public IActionResult Index()
		{
			return View();
		}
	}
}
