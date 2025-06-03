using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Stripe.Checkout;
using FairyPhone.Models;

namespace FairyPhone.Controllers
{
    public class StripeController : Controller
    {
        private readonly AppDbContext _context;

        public StripeController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost]
        public IActionResult CreateCheckoutSession()
        {
            var userIdString = HttpContext.Session.GetString("UserId");

            if (string.IsNullOrEmpty(userIdString))
                return RedirectToAction("Login", "Account");

            int.TryParse(userIdString, out int userId);

            var carts = _context.Carts
                .Where(c => c.User_Id == userId && !c.IsCheckedOut)
                .Include(c => c.Smartphone)
                .ToList();

            if (carts.Count == 0)
                return RedirectToAction("ViewCart", "Cart");

            var options = new SessionCreateOptions
            {
                PaymentMethodTypes = new List<string> { "card" },
                Mode = "payment",
                SuccessUrl = Url.Action("Success", "Stripe", null, Request.Scheme),
                CancelUrl = Url.Action("ViewCart", "Cart", null, Request.Scheme),
                LineItems = new List<SessionLineItemOptions>()
            };

            foreach (var item in carts)
            {
                options.LineItems.Add(new SessionLineItemOptions
                {
                    Quantity = item.Quantity,
                    PriceData = new SessionLineItemPriceDataOptions
                    {
                        Currency = "usd",
                        UnitAmount = (long)(item.Smartphone.Price * 100), // giá tính bằng cents
                        ProductData = new SessionLineItemPriceDataProductDataOptions
                        {
                            Name = item.Smartphone.Name
                        }
                    }
                });
            }

            var service = new SessionService();
            Session session = service.Create(options);

            return Redirect(session.Url); // chuyển tới trang Stripe để thanh toán
        }

        public IActionResult Success()
        {
            // đánh dấu cart đã thanh toán
            var userIdString = HttpContext.Session.GetString("UserId");
            if (!string.IsNullOrEmpty(userIdString))
            {
                int.TryParse(userIdString, out int userId);
                var carts = _context.Carts
                    .Where(c => c.User_Id == userId && !c.IsCheckedOut)
                    .ToList();

                foreach (var cart in carts)
                {
                    cart.IsCheckedOut = true;
                }

                _context.SaveChanges();
            }

            return View(); // hiển thị trang thanh toán thành công
        }
    }
}
