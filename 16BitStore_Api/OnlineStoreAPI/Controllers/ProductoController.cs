using Microsoft.AspNetCore.Mvc;
using OnlineStoreAPI.Services;
using System.Threading.Tasks;

namespace OnlineStoreAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductosController : ControllerBase
    {
        private readonly ProductoService _productoService;

        public ProductosController(ProductoService productoService)
        {
            _productoService = productoService;
        }

        [HttpGet]
        public async Task<IActionResult> GetProductos()
        {
            var productos = await _productoService.GetProductosAsync();
            return Ok(productos);
        }
    }
}
