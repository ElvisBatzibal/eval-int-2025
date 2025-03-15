using System;
using System.Collections.Generic;

namespace webevalint.Schema;

public partial class VwUsuario
{
    public string NombreCompleto { get; set; } = null!;

    public string Puesto { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string Rol { get; set; } = null!;

    public string Activo { get; set; } = null!;
}
