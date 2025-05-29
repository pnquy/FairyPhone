using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FairyPhone.Models
{
    [Table("Admin")] 
    
    public class Admin
    {
        [Key]
        public string? Id { get; set; }
        [Required]
        public string? Username { get; set; }
        [Required]
        public string? First_Name { get; set; }
        [Required]
        public string? Last_Name { get; set; }
        [Required]
        public string? Email { get; set; }
        [Required]
        public string? Password { get; set; }
    }
}
