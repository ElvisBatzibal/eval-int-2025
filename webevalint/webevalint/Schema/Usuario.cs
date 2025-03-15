using System;
using System.Collections.Generic;

namespace webevalint.Schema;

public partial class Usuario
{
    public int UsuarioId { get; set; }

    public string Usuario1 { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string Password { get; set; } = null!;

    public string Estado { get; set; } = null!;

    public int RolId { get; set; }

    public int EmpleadoId { get; set; }

    public virtual Empleado Empleado { get; set; } = null!;

    public virtual Role Rol { get; set; } = null!;
}
