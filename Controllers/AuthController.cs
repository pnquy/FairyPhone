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

        public IActionResult SignUp(User modelSignUp)
        {
            var user = _dbContext.Users.FirstOrDefault(u => u.Username == modelSignUp.Username || u.Email == modelSignUp.Email);
            bool usernameExists = user != null && user.Username == modelSignUp.Username;
            bool emailExists = user != null && user.Email == modelSignUp.Email;

            if (user == null)
            {

                User newUser = new User
                {
                    Username = modelSignUp.Username,
                    Password = modelSignUp.Password,
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

                int newUserId = newUser.Id;

                HttpContext.Session.SetString("UserId", newUserId.ToString());
                HttpContext.Session.SetString("FullName", newUser.Full_Name);


                return RedirectToAction("Index", "Home");
            }
            else if (usernameExists)
            {
                ViewData["ValidateMessage"] = "Username already exists";
            }
            else if (emailExists)
            {
                ViewData["ValidateMessage"] = "Email already exists";
            }

            return View();
        }


    }
}
