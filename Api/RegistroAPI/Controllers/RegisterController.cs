using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using RegistroAPI.Data;
using RegistroAPI.Models;
using System.Threading.Tasks;

namespace RegistroAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RegisterController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public RegisterController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] Usuario usuario)
        {
            if (ModelState.IsValid)
            {
                _context.Usuarios.Add(usuario);
                await _context.SaveChangesAsync();
                return Ok("Usuario registrado con éxito");
            }

            return BadRequest(ModelState);
        }

        
    }
}
