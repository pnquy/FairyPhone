using Microsoft.AspNetCore.Mvc.Rendering;

namespace FairyPhone.Controllers
{
    public static class HTMLHelperExtensions
    {
        public static string ActiveClass(this IHtmlHelper htmlHelper, string route)
        {
            var routeData = htmlHelper.ViewContext.RouteData;

            Debug.WriteLine(routeData.Values["action"]);

            var pageRoute = routeData.Values["action"]?.ToString();

            return route == pageRoute ? "active" : "";
        }
    }
}
