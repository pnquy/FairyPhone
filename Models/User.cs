using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FairyPhone.Models
{
    [Table("users")]
    public class User
    {
        [Key]
        public int Id { get; set; }
        [Required]
        public string? Username { get; set; }
        [Required]
        public string? Password { get; set; }
        [Required]
        public string? Full_Name { get; set; }
        [Required]
        public string? Email { get; set; }
        [Required]
        public string? Phone_Number { get; set; }
        public string? Province_City { get; set; }

        public string? District { get; set; }
        public string? Ward { get; set; }
        public string? Specific_Address { get; set; }
    }
}
