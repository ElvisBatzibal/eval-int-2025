using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using webevalint.Schema;

namespace webevalint.Controllers
{
    [Authorize(Roles = "Administrador")]  // Solo usuarios con rol "Administrador" pueden acceder
    public class UsuariosController : Controller
    {
        private readonly EvalInt2025Context _context;

        public UsuariosController(EvalInt2025Context context)
        {
            _context = context;
        }

        // GET: Usuarios
        public async Task<IActionResult> Index()
        {
            var evalInt2025Context = _context.Usuarios.AsNoTracking()
                .Include(u => u.Empleado)
                .Include(u => u.Rol);
            return View(await evalInt2025Context.ToListAsync());
        }

        // GET: Usuarios/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var usuario = await _context.Usuarios
                .AsNoTracking()
                .Include(u => u.Empleado)
                .Include(u => u.Rol)
                .FirstOrDefaultAsync(m => m.UsuarioId == id);
            if (usuario == null)
            {
                return NotFound();
            }

            return View(usuario);
        }

        // GET: Usuarios/Create
        public IActionResult Create()
        {
            var ListEmpleados= _context.Empleados
                .AsNoTracking()
            .Select(e => new { 
                EmpleadoId = e.EmpleadoId,
                Nombre = e.Nombre + " " + e.Apellido 
            })
            .ToList();
            ViewData["EmpleadoId"] = new SelectList(ListEmpleados, "EmpleadoId", "Nombre");
            ViewData["RolId"] = new SelectList(_context.Roles.AsNoTracking(), "RolId", "Nombre");
            return View();
        }

        // POST: Usuarios/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("UsuarioId,Usuario1,Email,Password,Estado,RolId,EmpleadoId")] Usuario usuario)
        {
            if (ModelState.IsValid)
            {
                _context.Add(usuario);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            var ListEmpleados= _context.Empleados
            .Select(e => new { 
                EmpleadoId = e.EmpleadoId,
                Nombre = e.Nombre + " " + e.Apellido 
            })
            .ToList();
            ViewData["EmpleadoId"] = new SelectList(ListEmpleados, "EmpleadoId", "Nombre", usuario.EmpleadoId);
            ViewData["RolId"] = new SelectList(_context.Roles.AsNoTracking(), "RolId", "Nombre", usuario.RolId);
            return View(usuario);
        }

        // GET: Usuarios/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var usuario = await _context.Usuarios.FindAsync(id);
            if (usuario == null)
            {
                return NotFound();
            }
            var ListEmpleados= _context.Empleados.AsNoTracking()
            .Select(e => new { 
                EmpleadoId = e.EmpleadoId,
                Nombre = e.Nombre + " " + e.Apellido 
            })
            .ToList();
            ViewData["EmpleadoId"] = new SelectList(ListEmpleados, "EmpleadoId", "Nombre", usuario.EmpleadoId);
            ViewData["RolId"] = new SelectList(_context.Roles.AsNoTracking(), "RolId", "Nombre", usuario.RolId);
            return View(usuario);
        }

        // POST: Usuarios/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("UsuarioId,Usuario1,Email,Password,Estado,RolId,EmpleadoId")] Usuario usuario)
        {
            if (id != usuario.UsuarioId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(usuario);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!UsuarioExists(usuario.UsuarioId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            var ListEmpleados= _context.Empleados.AsNoTracking()
            .Select(e => new { 
                EmpleadoId = e.EmpleadoId,
                Nombre = e.Nombre + " " + e.Apellido 
            })
            .ToList();
            ViewData["EmpleadoId"] = new SelectList(ListEmpleados, "EmpleadoId", "Nombre", usuario.EmpleadoId);
            ViewData["RolId"] = new SelectList(_context.Roles.AsNoTracking(), "RolId", "Nombre", usuario.RolId);
            return View(usuario);
        }

        // GET: Usuarios/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var usuario = await _context.Usuarios
                .AsNoTracking()
                .Include(u => u.Empleado)
                .Include(u => u.Rol)
                .FirstOrDefaultAsync(m => m.UsuarioId == id);
            if (usuario == null)
            {
                return NotFound();
            }

            return View(usuario);
        }

        // POST: Usuarios/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var usuario = await _context.Usuarios.FindAsync(id);
            if (usuario != null)
            {
                _context.Usuarios.Remove(usuario);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool UsuarioExists(int id)
        {
            return _context.Usuarios.Any(e => e.UsuarioId == id);
        }
    }
}
