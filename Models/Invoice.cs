using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FairyPhone.Models
{
    [Table("invoices")]
    public class Invoice
    {
        [Key]
        public int Id { get; set; }
        public int UserId {  get; set; }
        [ForeignKey("UserId")]
        public virtual User? User { get; set; }
        public decimal TotalAmount { get; set; }
        public DateTime created_at {  get; set; } 
    }
}
