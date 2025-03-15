using System.Diagnostics;
using System.Security.Claims;
using Microsoft.AspNetCore.Mvc;
using webevalint.Models;

namespace webevalint.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;

    public HomeController(ILogger<HomeController> logger)
    {
        _logger = logger;
    }

    public IActionResult Index()
    {
        try
        {

            if (User != null)
            {
                // Establecer el inicio de la sesión
                HttpContext.Session.SetSessionStart();

                var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
                if (!String.IsNullOrEmpty(userId))
                {
                    var UserRole = User.FindFirstValue(ClaimTypes.Role);
                    if (UserRole.Equals("Administrador"))
                    {
                        return RedirectToAction("Index", "Usuarios");
                    }
                    else
                    {
                        return View();
                    }
                }
            }else{
                return RedirectToAction("Index", "Access");
            }
        }
        catch (Exception ex)
        {
            return RedirectToAction("Index", "Access");
        }
        return View();
    }

    public IActionResult Privacy()
    {
        return View();
    }

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}

