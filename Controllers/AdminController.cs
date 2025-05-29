using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NuGet.Protocol.Core.Types;
using System.Diagnostics;
using System.Net;
using System.Reflection.Metadata;

namespace FairyPhone.Controllers
{
    public class AdminController : Controller
    {
        private readonly ILogger<AdminController> _logger;
        private readonly AppDbContext _context;

        public AdminController(ILogger<AdminController> logger, AppDbContext context)
        {
            _logger = logger;
            _context = context;
        }

        public IActionResult Index()
        {
			ViewData["CurrentTab"] = "Index";
            return View();
        }

        public IActionResult ProductCRUD()
        {
			List<Smartphone> smartphones = _context.Smartphones.ToList();
			return View(smartphones);
        }

        public IActionResult Info() {
            List<User> users = _context.Users.ToList();
            return View(users);
        }
        public IActionResult Invoices() {
            List<Invoice> invoices = _context.Invoices.ToList();
            return View(invoices);
        }
        public IActionResult EditUser(int Id, string Username, string Password, string Full_Name, string Email, string Phone_Number, string Province_City, string District, string Ward, string Specific_Address)
        {
            //List<User> users= new List<User>();
            //var user = users.FirstOrDefault(u=>u.Id == Id);
            
                User user = new User
                {
                    Id = Id,
                    Username = Username,
                    Password = Password,
                    Full_Name = Full_Name,
                    Email = Email,
                    Phone_Number = Phone_Number,
                    Province_City = Province_City,
                    District = District,
                    Ward = Ward,
                    Specific_Address = Specific_Address,
                };
                return View(user);
        }
        public IActionResult EditProduct(int Id, string Name, string Brand, int Ram, int Rom, decimal Price, decimal Discount, string Color)
        {

            Smartphone smartphone=new Smartphone
            {
                Id = Id,
                Name= Name,
                Brand = Brand,
                Ram = Ram,
                Rom = Rom,
                Price = Price,
                Discount = Discount,
                Color = Color
            };
            return View(smartphone);
        }
        public IActionResult UpdateUser(User user) {

            var users = user;
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var existingUser = _context.Users.Find(user.Id);
                existingUser.Username = user.Username;
                existingUser.Password = user.Password;
                existingUser.Full_Name = user.Full_Name;
                existingUser.Email = user.Email;
                existingUser.Phone_Number = user.Phone_Number;
                existingUser.Province_City = user.Province_City;
                existingUser.District = user.District;
                existingUser.Ward = user.Ward;
                existingUser.Specific_Address = user.Specific_Address;

                try
                {
                    // Save changes back to the database
                    _context.SaveChanges();
                    return Ok("User updated successfully");
                }
                catch (Exception ex)
                {
                    // Handle database update exception
                    // Log the exception or return an appropriate error message
                    return StatusCode(500, "Error updating user");
                }
        }
        public IActionResult DeleteUser(User user)
        {
			var users = user;
			if (!ModelState.IsValid)
			{
				return BadRequest(ModelState);
			}
            
            try
			{
                var userToDelete = _context.Users.Find(user.Id);
                if (userToDelete != null)
                {
                    _context.Users.Remove(userToDelete);
                    _context.SaveChanges();
                    return Ok("User deleted successfully");
                }
                else
                {
                    return NotFound(new { success = false, error = "User not found" });
                }
			}
			catch (Exception ex)
			{
                
                return StatusCode(500, new { success = false, error = "Error deleting user" });
            }

		}
        [HttpPost]
        public async Task<IActionResult> UpdateProduct(Smartphone smartphone, IFormFile? Picture)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var existingProduct = _context.Smartphones.Find(smartphone.Id);
            if (existingProduct == null)
            {
                return NotFound("Product not found");
            }

            existingProduct.Name = smartphone.Name;
            existingProduct.Brand = smartphone.Brand;
            existingProduct.Ram = smartphone.Ram;
            existingProduct.Rom = smartphone.Rom;
            existingProduct.Price = smartphone.Price;
            existingProduct.Discount = smartphone.Discount;
            existingProduct.Color = smartphone.Color;

            if (Picture != null && Picture.Length > 0)
            {
                var fileName = Path.GetFileName(Picture.FileName);
                var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/img/phones", fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await Picture.CopyToAsync(stream);
                }

                existingProduct.Picture = "/img/phones/" + fileName;
            }

            try
            {
                _context.SaveChanges();
                return Ok("Phone updated successfully");
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Error updating Phone");
            }
        }
        [HttpPost]
        public IActionResult DeleteProduct(Smartphone smartphone)
        {
            var smartphones = smartphone;
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                var ProductToDelete = _context.Smartphones.Find(smartphone.Id);
                if (ProductToDelete != null)
                {
                    _context.Smartphones.Remove(ProductToDelete);
                    _context.SaveChanges();
                    return Ok("Phone deleted successfully");
                }
                else
                {
                    return NotFound(new { success = false, error = "Phone not found" });
                }
            }
            catch (Exception ex)
            {

                return StatusCode(500, new { success = false, error = "Phone deleting user" });
            }

        }
        [HttpGet]
        public IActionResult CreateProduct()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> CreateProduct(Smartphone product, IFormFile? Picture)
        {
            if (ModelState.IsValid)
            {
                if (Picture != null && Picture.Length > 0)
                {
                    var fileName = Path.GetFileName(Picture.FileName);
                    var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/img/phones", fileName);

                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        await Picture.CopyToAsync(stream);
                    }

                    product.Picture = "/img/phones/" + fileName;
                }

                _context.Smartphones.Add(product);
                await _context.SaveChangesAsync();

                return RedirectToAction("ProductCRUD");
            }

            return View(product);
        }
        public IActionResult Category()
		{
            //var users = _context.User.ToList();

            //// Log the car features to the console
            //foreach (var user in users)
            //{
            //    _logger.LogInformation($"User - Id: {user.User_Id}, FeatureName: {user.First_Name}");
            //}

            //return Ok(); // Optionally, you can return an IActionResult indicating success
            return View();
        }   


		public IActionResult Profile()
		{
			ViewData["CurrentTab"] = "Profile";
			return View();
		}

		public IActionResult SignUp()
		{
			ViewData["CurrentTab"] = "SignUp";
			return View();
		}

		public IActionResult SignIn()
		{
			ViewData["CurrentTab"] = "SignIn";
			return View();
		}

		[ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }


        public IActionResult RedirectToInfo()
        {
            return RedirectToAction("Info", "Admin");
        }

        public IActionResult ContactMessages()
        {
            var contactMessages = _context.ContactMessages.OrderByDescending(c => c.DateSubmitted).ToList();
            return View(contactMessages);
        }
    }
}
