using System.Security.Claims;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using webevalint.Infraestructure.DTOs;
using webevalint.Schema;

namespace webevalint.Controllers;
public class AccessController : Controller
    {
        EvalInt2025Context dbcontext;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public AccessController(IHttpContextAccessor httpContextAccessor, EvalInt2025Context db)
        {
            _httpContextAccessor = httpContextAccessor;
            dbcontext = db;
        }


        // GET: /<controller>/
        public async Task<IActionResult> IndexAsync()
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
                        var UserSessionString = User.FindFirstValue(ClaimTypes.UserData);
                        if (!String.IsNullOrEmpty(UserSessionString))
                        {
                            return RedirectToAction("Index", "Home");
                        }
                        else
                        {
                            return await SignOutAsync();
                        }
                    }
                }
            }
            catch (Exception ex)
            {

            }
            return View();
        }

            public IActionResult Login(string? returnUrl = null)
            {
                ViewBag.ReturnUrl = returnUrl;
                return View("Index");
            }

    public IActionResult AccessDenied()
        {
            return View();
        }
    // GET: /<controller>/
         public async Task<IActionResult> SignOutAsync()
        {

            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);

            return View("Index");
        }

        [HttpPost]
        public async Task<IActionResult> LoginRequest([FromBody] LoginRequest? request)
        {
            if (request!=null)
            {
                var IsLogin = dbcontext.Usuarios
                    .AsNoTracking()
                    .Include(x=> x.Rol)
                    .Where(x => x.Usuario1.Equals(request.UserName) || x.Email.Equals(request.UserName))
                    .FirstOrDefault();

                if (IsLogin==null)
                {
                    return Json(new { Result = false, Message = "Usuario no encontrado" });
                }
                else
                {
                    if (IsLogin.Estado != "A")
                    {
                        return Json(new { Result = false, Message = "Usuario inactivo" });
                    }

                    if (IsLogin.Password.Equals(request.Password))
                    {

                    try
                    {
                        var usuarioDto = UsuarioDTO.FromUsuario(IsLogin);
                        var ContentJson = JsonConvert.SerializeObject(usuarioDto, Formatting.Indented);

                        var claims = new List<Claim>
                        {
                            new Claim(ClaimTypes.NameIdentifier, usuarioDto.UsuarioId.ToString()),
                            new Claim(ClaimTypes.Name, usuarioDto.Usuario1),
                            new Claim(ClaimTypes.Email, usuarioDto.Email),
                            new Claim(ClaimTypes.Role, usuarioDto.NombreRol),
                            new Claim(ClaimTypes.UserData, ContentJson)
                        };

                        var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                        var authProperties = new AuthenticationProperties
                        {
                            IsPersistent = true,
                            ExpiresUtc = DateTimeOffset.UtcNow.AddMinutes(30)
                        };

                        await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(claimsIdentity), authProperties);
                        IsLogin.Password = "";
                        return Json(new { Result = true, Message = "Acceso correcto", url = "/Home/Index" });
                    }
                    catch (Exception ex)
                    {
                        return Json(new { Result = false, Message = ex.Message });
                    }
                    
                    }
                    else
                    {
                        return Json(new { Result = false, Message = "Contraseña incorrecta" });
                    }
                }
            }
            else
            {
                return Json(new { Result = false, Message = "Datos incorrectos" });
            }
        }

    }

