using System;
using System.Security.Claims;
namespace webevalint;

public static class ClaimsHelper
{
    public static T GetUserData<T>(ClaimsPrincipal user)
    {
        var userDataClaim = user?.FindFirst(ClaimTypes.UserData)?.Value;

        if (userDataClaim != null)
        {
            try
            {
                // Intenta deserializar el valor del claim a un tipo T
                var userData = Newtonsoft.Json.JsonConvert.DeserializeObject<T>(userDataClaim);
                return userData;
            }
            catch (Exception)
            {
                // Manejar la excepción si no se puede deserializar
            }
        }

        return default; // Devuelve el valor predeterminado de T si no se pudo obtener el valor
    }
    public static string GetUserName(ClaimsPrincipal user)
    {
        var userDataClaim = user?.FindFirst(ClaimTypes.Name)?.Value;

        if (userDataClaim != null)
        {
            return userDataClaim;
        }

        return default; // Devuelve el valor predeterminado de T si no se pudo obtener el valor
    }
    public static int GetUserID(ClaimsPrincipal user)
    {
        var userDataClaim = user?.FindFirst(ClaimTypes.NameIdentifier)?.Value;

        if (userDataClaim != null)
        {
            return int.Parse(userDataClaim);
        }

        return default; // Devuelve el valor predeterminado de T si no se pudo obtener el valor
    }
}

