using System.Data;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;

namespace webevalint;

public static class SessionExtensions
{

    public static void SetObjectAsJson(this ISession session, string key, object value)
    {
        session.SetString(key, JsonConvert.SerializeObject(value));
    }

    public static T GetObjectFromJson<T>(this ISession session, string key)
    {
        var value = session.GetString(key);
        return value == null ? default(T) : JsonConvert.DeserializeObject<T>(value);
    }

    public static void SetSessionStart(this ISession session, string KeyName = "Session_Start")
    {
        session.SetString(KeyName, DateTime.Now.ToString("yyyyMMddHHmmss"));
    }
    public static string GetSessionStart(this ISession session, string KeyName = "Session_Start")
    {
        var value = session.GetString(KeyName);
        return value == null ? String.Empty : value;
    }
   

    public static string GetInstanceId(this HttpContext httpContext)
    {
        var instanceId = httpContext.Session.GetString("InstanceId");

        if (string.IsNullOrEmpty(instanceId))
        {
            instanceId = Guid.NewGuid().ToString();
            httpContext.Session.SetString("InstanceId", instanceId);
        }

        return instanceId;
    }

}

