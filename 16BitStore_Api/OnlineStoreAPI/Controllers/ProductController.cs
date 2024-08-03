// using Microsoft.AspNetCore.Mvc;
// using OnlineStoreAPI.Services;
// using OnlineStoreAPI.Models;
// using System.Threading.Tasks;

// namespace OnlineStoreAPI.Controllers
// {
//     [Route("api/[controller]")]
//     [ApiController]
//     public class ProductsController : ControllerBase
//     {
//         private readonly ProductService _productService;

//         public ProductsController(ProductService productService)
//         {
//             _productService = productService;
//         }

//         [HttpGet]
//         public async Task<IActionResult> GetAllProducts()
//         {
//             var products = _productService.GetAllProducts();
//             return Ok(products);
//         }

//         // Otros métodos para manejar productos
//     }
// }
