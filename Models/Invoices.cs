using NuGet.Packaging.Signing;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FairyPhone.Models
{
    [Table("invoices")]
    public class Invoices
    {
        [Key]
        public int? Id { get; set; }
        public int? UserId {  get; set; }
        [Required]
        public decimal? TotalAmount { get; set; }
        public DateTime? created_at { get; set; }
        public Invoices()
        {
            created_at = DateTime.UtcNow;
        }

    }
}
