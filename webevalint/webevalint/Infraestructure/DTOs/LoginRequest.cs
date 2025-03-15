using System;
namespace webevalint.Infraestructure.DTOs
{
	public class LoginRequest
	{
		public string UserName { get; set; }
		public string Password { get; set; }

		public LoginRequest()
		{
			UserName = string.Empty;
			Password = string.Empty;
		}
	}
}

