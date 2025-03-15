using System;
using System.Collections.Generic;

namespace webevalint.Schema;

public partial class Marca
{
    public int MarcaId { get; set; }

    public string Marca1 { get; set; } = null!;

    public virtual ICollection<Equipo> Equipos { get; set; } = new List<Equipo>();
}
