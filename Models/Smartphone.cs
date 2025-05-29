using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FairyPhone.Models
{
    [Table("smartphones")]
    public class Smartphone
    {
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage = "Name is required")]
        public string? Name { get; set; }

        [Required(ErrorMessage = "Brand is required")]
        public string? Brand { get; set; }

        [Required(ErrorMessage = "Ram is required")]
        public int Ram { get; set; }

        [Required(ErrorMessage = "Rom is required")]
        public int Rom { get; set; }

        [Required(ErrorMessage = "Price is required")]
        public decimal Price { get; set; }

        [Required(ErrorMessage = "Discount is required")]
        public decimal Discount { get; set; }

        [Required(ErrorMessage = "Color is required")]
        public string? Color { get; set; }

        public string? Picture { get; set; }
    }
}
