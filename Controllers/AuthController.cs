using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Http;

namespace FairyPhone.Controllers
{
    public class AuthController : Controller
    {
        private readonly AppDbContext _dbContext;
        public AuthController(AppDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public IActionResult SignIn(string username, string password)
        {
            var user = _dbContext.Users.FirstOrDefault(u => u.Username == username && u.Password == password);

            if (user != null)
            {
                HttpContext.Session.SetString("UserId", user.Id.ToString());
                HttpContext.Session.SetString("FullName", user.Full_Name);
                return RedirectToAction("Index", "Home");
            }
            else
            {
                ViewData["ValidateMessage"] = "Invalid username or password";
                return View("~/Views/Home/SignIn.cshtml");
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult SignUp(User modelSignUp)
        {
            // Kiểm tra đầu vào
            if (!ModelState.IsValid)
            {
                return View("~/Views/Home/SignUp.cshtml", modelSignUp);
            }

            // Kiểm tra username hoặc email đã tồn tại
            var existingUser = _dbContext.Users.FirstOrDefault(u => u.Username == modelSignUp.Username || u.Email == modelSignUp.Email);

            if (existingUser != null)
            {
                if (existingUser.Username == modelSignUp.Username)
                {
                    ViewData["ValidateMessage"] = "Username already exists";
                }
                else if (existingUser.Email == modelSignUp.Email)
                {
                    ViewData["ValidateMessage"] = "Email already exists";
                }

                return View("~/Views/Home/SignUp.cshtml", modelSignUp);
            }

            // Nếu không tồn tại => tạo user mới
            var newUser = new User
            {
                Username = modelSignUp.Username,
                Password = modelSignUp.Password, // 👉 NÊN dùng mã hóa ở môi trường thật
                Full_Name = modelSignUp.Full_Name,
                Email = modelSignUp.Email,
                Phone_Number = modelSignUp.Phone_Number,
                Province_City = modelSignUp.Province_City,
                District = modelSignUp.District,
                Ward = modelSignUp.Ward,
                Specific_Address = modelSignUp.Specific_Address
            };

            _dbContext.Users.Add(newUser);
            _dbContext.SaveChanges();

            // Đăng nhập ngay
            HttpContext.Session.SetString("UserId", newUser.Id.ToString());
            HttpContext.Session.SetString("FullName", newUser.Full_Name);

            return RedirectToAction("Index", "Home");
        }



    }
}