
using LmsModels.Batch;
using LmsServices.Batch.Implmentations;
using LmsServices.Batch.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace lms.Areas.Batch.Controllers
{
    [Area("Batch")]
    public class ClassRoomController : Controller
    {

            private readonly IClassRoomService _ClassRoomService;

            public ClassRoomController()
            {
			    _ClassRoomService = new ClassRoomService();
            }

            public IActionResult Index()
            {
			    ViewBag.ClassRooms = _ClassRoomService.GetAll();

			    return View();
            }

            public IActionResult Create()
            {
                return View();
            }

            [HttpPost]
            public IActionResult Create(ClassRoomModel ClassRoom)
            {
            ClassRoom.BranchId = 1;

			_ClassRoomService.Create(ClassRoom);
                TempData["success"] = "Record Added successfully!";
                return RedirectToAction("Index");
            }

            public IActionResult Edit(int id)
            {
                var ClassRooms = _ClassRoomService.GetById(id);

                return View(ClassRooms);
            }

            [HttpPost]
            public IActionResult Edit(ClassRoomModel ClassRoom)
            {
            _ClassRoomService.Update(ClassRoom);
                TempData["success"] = "Record updated successfully!";
                return RedirectToAction("Index");
            }

            [HttpPost]
            public IActionResult Delete(int id)
            {
            _ClassRoomService.Delete(id);

                TempData["success"] = "Record Delete successfully!";
                return RedirectToAction("Index");
            }



    }
}

