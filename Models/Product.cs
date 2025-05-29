using System.ComponentModel.DataAnnotations;

namespace FairyPhone.Models
{
    public class Product
    {
        [Key]
        public int Id { get; set; }

        public string? Name { get; set; }

        public string? Brand { get; set; }

        public string? SessionId { get; set; }
        public string? PaymentIntentId { get; set; }
    }
}
