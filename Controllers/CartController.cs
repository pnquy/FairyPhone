using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FairyPhone.Controllers
{
    public class CartController : Controller
    {
        private readonly AppDbContext _context;
        private readonly ILogger<HomeController> _logger;
        public CartController(AppDbContext context, ILogger<HomeController> logger)
        {
            _context = context;
            _logger = logger;
        }

        [HttpPost]
        public IActionResult AddToCart(int phoneId, int quantity)
        {
            var userIdString = HttpContext.Session.GetString("UserId");

            if (string.IsNullOrEmpty(userIdString))
            {
                return Json(new { success = false, message = "You need to login first" });
            }

            int.TryParse(userIdString, out int userId);

            var existingCartItem = _context.Carts
            .FirstOrDefault(c => c.User_Id == userId && c.Phone_Id == phoneId);

            if (existingCartItem != null)
            {
                existingCartItem.Quantity += quantity;
            }
            else
            {
                var newCartItem = new Cart
                {
                    User_Id = userId,
                    Phone_Id = phoneId,
                    Quantity = quantity
                };

                _context.Carts.Add(newCartItem);
            }

            _context.SaveChanges();

            return Json(new { success = true, message = "Product added to the cart successfully" });
        }
    }
}
