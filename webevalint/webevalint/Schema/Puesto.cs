using System;
using System.Collections.Generic;

namespace webevalint.Schema;

public partial class Puesto
{
    public int PuestoId { get; set; }

    public string Puesto1 { get; set; } = null!;

    public virtual ICollection<Empleado> Empleados { get; set; } = new List<Empleado>();
}
