using System.ComponentModel.DataAnnotations.Schema;

namespace FairyPhone.Models
{
    [Table("cart")]
    public class Cart
    {
        public int Id { get; set; }

        public int User_Id { get; set; }
        [ForeignKey("User_Id")]
        public virtual User? User { get; set; }

        public int Phone_Id { get; set; }
        [ForeignKey("Phone_Id")]
        public virtual Smartphone? Smartphone { get; set; }

        public int Quantity { get; set; }
        public bool IsCheckedOut { get; set; } = false;
        
    }
}
