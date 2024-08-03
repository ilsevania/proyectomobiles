using Microsoft.EntityFrameworkCore;
using OnlineStoreAPI.Models;

namespace OnlineStoreAPI.Data
{
    public class OnlineStoreContext : DbContext
    {
        public OnlineStoreContext(DbContextOptions<OnlineStoreContext> options) : base(options)
        {
        }

        public DbSet<Usuario> Usuarios { get; set; }
        public DbSet<Producto> Productos { get; set; }  // Cambiado a mayúsculas
    }
}
