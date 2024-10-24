using Microsoft.AspNetCore.Mvc;

namespace lms.Areas.Batch.Controllers
{
	[Area("Batch")]
	public class BatchController : Controller
	{
		public IActionResult Index()
		{
			return View();
		}
	}
}
