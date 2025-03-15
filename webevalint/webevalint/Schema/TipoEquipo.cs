using System;
using System.Collections.Generic;

namespace webevalint.Schema;

public partial class TipoEquipo
{
    public int TipoId { get; set; }

    public string Nombre { get; set; } = null!;

    public virtual ICollection<Equipo> Equipos { get; set; } = new List<Equipo>();
}
