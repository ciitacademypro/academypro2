
using LmsModels.Student;
using LmsServices.Common;
using LmsServices.Course.Implementations;
using LmsServices.Course.Interfaces;
using LmsServices.Student.Implemenatation;
using LmsServices.Student.Implementations;
using LmsServices.Student.Implmentations;
using LmsServices.Student.Interface;
using LmsServices.Student.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.IO;

namespace lms.Areas.Student.Controllers
{
	[Area("Student")]
	public class StudentController : Controller
	{
		private readonly IStudentService _studentService;
		private readonly IEnquiryService _enquiryService;
		private readonly IEnrollmentService _enrollmentService;
		private readonly ICourseCategoryService _courseCategoryService;

		public StudentController()
		{
			_studentService = new StudentService();
			_enquiryService = new EnquiryService();
			_enrollmentService = new EnrollmentService();
			_courseCategoryService = new CourseCategoryService();
		}

		public IActionResult Index(int status = -1)
		{
			ViewBag.CourseCategories = _courseCategoryService.GetAll();

			// Fetch all students once
				var allStudents = _studentService.GetAll(null);
				var allEnrollment = _enrollmentService.GetAll(null);

				// Calculate counts from the fetched list
				ViewBag.studentListAllCount = allStudents.Count();
				ViewBag.studentListActiveCount = allStudents.Count(s => s.Status == true);
				ViewBag.studentListInactiveCount = allStudents.Count(s => s.Status == false);


				ViewBag.enrollmentAllCount = allEnrollment.Count();
				ViewBag.enrollmentActiveCount = allEnrollment.Count(s => s.Status == true);
				ViewBag.enrollmentInactiveCount = allEnrollment.Count(s => s.Status == false);


				bool statusBool = status != 0;
				
				// Filter based on status
				List<StudentModel> studentList = status == -1 ? allStudents : allStudents.Where(s => s.Status == statusBool).ToList();

			return View(studentList);
		}

		public async Task<IActionResult> Details(int id)
		{
			StudentModel student = _studentService.GetById(id);
			if (student == null)
			{
				TempData["msg"] = "Student not found.";
				return RedirectToAction("Index");
			}


				var enrollments = await _enrollmentService.GetEnrollmentWisePayments(id);

				ViewBag.payments = enrollments;

				// Find the first enrollment and its first payment with status = 0
				var firstPendingEnrollment = enrollments
					.Where(e => e.Payments.Any(p => p.Status == false)) // Filter enrollments with pending payments
					.Select(e => new
					{
						e.StudentEnrollmentId,  // Include the enrollment ID
						Payment = e.Payments.FirstOrDefault(p => p.Status == false) // Get the first payment with status = 0
					})
					.FirstOrDefault();

				// Pass the data to the view
				ViewBag.FirstPendingPayment = firstPendingEnrollment?.Payment;
				ViewBag.FirstPendingEnrollmentId = firstPendingEnrollment?.StudentEnrollmentId;

				if(student.Status == false){
					return RedirectToAction("Index");
				}

				return View(student);
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public IActionResult UpdateProfilePhoto(int studentId, IFormFile profilePhoto)
		{
			var student = _studentService.GetById(studentId);
			if (student == null)
			{
				TempData["msg"] = "Student not found.";
				return RedirectToAction("Index");
			}


			string uploadPath = $@"uploads\students\{studentId}\ProfilePhoto";

			MultiMediaService mms = new MultiMediaService();
			string photoName = mms.ImageUpload(profilePhoto, uploadPath);
			_studentService.UpdateProfilePhoto(studentId, photoName);

/*
			if (profilePhoto != null && profilePhoto.Length > 0)
			{
				string rootFolder = Path.Combine(Directory.GetCurrentDirectory(), uploadPath);
				string studentFolder = Path.Combine(uploadPath, student.StudentName);

				if (!Directory.Exists(studentFolder))
				{
					Directory.CreateDirectory(studentFolder);
				}

				string photoName = student.StudentName + Path.GetExtension(profilePhoto.FileName);
				string photoPath = Path.Combine(studentFolder, photoName);

				using (var stream = new FileStream(photoPath, FileMode.Create))
				{
					profilePhoto.CopyTo(stream);
				}

				_studentService.UpdateProfilePhoto(studentId, photoName);
				TempData["success"] = "Profile photo updated successfully.";
			}
			else
			{
				TempData["msg"] = "Please select a photo to upload.";
			}
*/
			TempData["success"] = "Profile photo updated successfully.";

			return RedirectToAction("Details", new { id = studentId });
		}


		[HttpPost]
		[ValidateAntiForgeryToken]
		public IActionResult ChangePassword(int studentId, string Password, string ConfirmPassword)
		{
			var student = _studentService.GetById(studentId);
			if (student == null)
			{
				TempData["msg"] = "Student not found.";
				return RedirectToAction("Index");
			}

			bool isUpdated = _studentService.ChangePassword(studentId, Password);
			if (isUpdated)
			{
				TempData["success"] = "Password changed successfully.";
			}
			else
			{
				TempData["msg"] = "Failed to change the password. Please try again.";
			}


			return RedirectToAction("Details", new { id = studentId });
		}

		public IActionResult Create()
		{
            return View("~/Areas/Student/Views/Student/Create.cshtml");
		}


		[HttpPost]
		[ValidateAntiForgeryToken]
		public IActionResult Create(StudentAddModel student)
		{

            if (!ModelState.IsValid)
			{
				return View(student);
			}
            // Create Student Entry
			int lastId =  _studentService.Create(student);

			// Update Enquiry Status
			var oldEnquiry =  _enquiryService.GetById(student.EnquiryId);
			oldEnquiry.Status = "Registered";
			_enquiryService.Update(oldEnquiry);


			// Create Enrollment Entry
            //_enrollmentService.Create(new StudentEnrollmentModel
            //{
            //    StudentId = lastId,
            //    CourseId = student.CourseId,
            //    EnrollmentDate = DateOnly.FromDateTime(DateTime.Now),
            //});
		
			TempData["success"] = "Student Added successfully";

			return RedirectToAction("Index");
		}

		// [HttpGet]
		// public IActionResult Edit(int id)
		// {
		// 	StudentModel student = _studentService.GetById(id);
		// 	if (student == null)
		// 	{
		// 		TempData["msg"] = "Student not found.";
		// 		return RedirectToAction("Index");
		// 	}
		// 	return View(student);
		// }

		[HttpPost]
		[ValidateAntiForgeryToken]
		public IActionResult Edit(int StudentId, string StudentName, string MobileNumber, string EmailAddress, string redirectTo="Index")
		{

			var student = new StudentModel{
				StudentId = StudentId,
				StudentName = StudentName,
				MobileNumber = MobileNumber,
				EmailAddress = EmailAddress
			};

			if (!ModelState.IsValid)
			{
				// Get the referring URL (the previous page)
				var refererUrl = Request.Headers["Referer"].ToString();
				
				// If referer exists, redirect back to it
				if (!string.IsNullOrEmpty(refererUrl))
				{
					return Redirect(refererUrl);
				}

				// If no referer, you can default to another action like Index
				if(redirectTo == "Index")
				{
					return RedirectToAction("Index");
				}else{
					return RedirectToAction("Details", new { id = StudentId });
				}
			}

			student.Status = redirectTo == "Index"?false:true;

			_studentService.Update(student);
			TempData["success"] = "Student updated successfully.";

			if(redirectTo == "Index")
			{
				return RedirectToAction("Index");
			}else{
			return RedirectToAction("Details", new { id = StudentId });
			}

		}

		public IActionResult Delete(int id)
		{
			var student = _studentService.GetById(id);
			if (student != null)
			{
				_studentService.Delete(id);
				TempData["success"] = "Student deleted successfully.";
			}
			else
			{
				TempData["msg"] = "Student not found.";
			}
			return RedirectToAction("Index");
		}
	}
}

