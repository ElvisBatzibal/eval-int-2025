using System;
using webevalint.Schema;

namespace webevalint.Infraestructure.DTOs
{
	public class UsuarioDTO
	{
        public int UsuarioId { get; set; }
        public string Usuario1 { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string Estado { get; set; } = null!;
        public int RolId { get; set; }
        public string NombreRol { get; set; }

        public static UsuarioDTO FromUsuario(Usuario usuario)
        {
            return new UsuarioDTO
            {
                UsuarioId = usuario.UsuarioId,
                Usuario1 = usuario.Usuario1,
                Email = usuario.Email,
                Estado = usuario.Estado,
                RolId = usuario.RolId,
                NombreRol= usuario.Rol.Nombre,
            };
        }

    }
}

