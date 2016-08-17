using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(QLHDCD.Startup))]
namespace QLHDCD
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
