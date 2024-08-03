using OnlineStoreAPI.Data;
using OnlineStoreAPI.Models;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace OnlineStoreAPI.Services
{
    public class ProductoService
    {
        private readonly OnlineStoreContext _context;

        public ProductoService(OnlineStoreContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Producto>> GetProductosAsync()
        {
            return await _context.Productos.ToListAsync(); // Cambiado a mayúsculas
        }
    }
}
