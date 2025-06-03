using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using FairyPhone.Models;

namespace FairyPhone.Controllers
{
    public class CartController : Controller
    {
        private readonly AppDbContext _context;
        private readonly ILogger<CartController> _logger;

        public CartController(AppDbContext context, ILogger<CartController> logger)
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
                .FirstOrDefault(c => c.User_Id == userId && c.Phone_Id == phoneId && !c.IsCheckedOut);

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
                    Quantity = quantity,
                    IsCheckedOut = false
                };

                _context.Carts.Add(newCartItem);
            }

            _context.SaveChanges();

            return Json(new { success = true, message = "Product added to the cart successfully" });
        }

        [HttpGet]
        public IActionResult ViewCart()
        {
            var userIdString = HttpContext.Session.GetString("UserId");

            if (string.IsNullOrEmpty(userIdString))
            {
                return RedirectToAction("Login", "Account");
            }

            int.TryParse(userIdString, out int userId);

            var cartItems = _context.Carts
                .Include(c => c.Smartphone)
                .Where(c => c.User_Id == userId && !c.IsCheckedOut)
                .ToList();

            return View(cartItems);
        }

        [HttpPost]
        public IActionResult Checkout()
        {
            var userIdString = HttpContext.Session.GetString("UserId");
            if (string.IsNullOrEmpty(userIdString))
            {
                return RedirectToAction("Login", "Account");
            }

            int.TryParse(userIdString, out int userId);

            var carts = _context.Carts
                .Where(c => c.User_Id == userId && !c.IsCheckedOut)
                .ToList();

            if (carts.Count == 0)
            {
                return RedirectToAction("ViewCart");
            }

            // TODO: tạo đơn hàng nếu có bảng Orders

            // Đánh dấu đã thanh toán
            foreach (var cart in carts)
            {
                cart.IsCheckedOut = true;
            }

            _context.SaveChanges();

            return RedirectToAction("OrderSuccess");
        }

        public IActionResult OrderSuccess()
        {
            return View();
        }
    }
}
