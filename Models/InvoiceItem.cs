using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FairyPhone.Models
{
    [Table("invoiceitems")]
    public class InvoiceItem
    {
        [Key]
        public int Id { get; set; }
        public int InvoiceId { get; set; }
        [ForeignKey("InvoiceId")]
        public virtual Invoice? Invoice { get; set; }
        public int PhoneId { get; set; }
        [ForeignKey("PhoneId")]
        public virtual Smartphone? Smartphone { get; set; }
        public int Quantity { get; set; }
    }
}
