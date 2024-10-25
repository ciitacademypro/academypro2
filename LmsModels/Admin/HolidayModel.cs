using System.ComponentModel.DataAnnotations;

namespace LmsModels.Admin
{
    public class HolidayModel
    {
        public int HolidayId { get; set; }

        [Display(Name = "Holiday Name")]
        public string HolidayName { get; set; }

        [Display(Name = "Holiday Date")]
        public DateOnly HolidayDate { get; set; }

        [Display(Name = "Description")]
        public string Description { get; set; }
    }
}