using System;
using System.Collections.Generic;

namespace webevalint.Schema;

public partial class Equipo
{
    public int EquipoId { get; set; }

    public string NoSerie { get; set; } = null!;

    public int MarcaId { get; set; }

    public string Descripcion { get; set; } = null!;

    public DateOnly FechaCompra { get; set; }

    public decimal Precio { get; set; }

    public int TipoEquipo { get; set; }

    public int EmpleadoId { get; set; }

    public virtual Empleado Empleado { get; set; } = null!;

    public virtual Marca Marca { get; set; } = null!;

    public virtual TipoEquipo TipoEquipoNavigation { get; set; } = null!;
}
