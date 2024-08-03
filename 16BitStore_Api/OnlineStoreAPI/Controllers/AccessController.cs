using Microsoft.AspNetCore.Mvc;
using OnlineStoreAPI.Services;
using OnlineStoreAPI.Models;
using System.Threading.Tasks;

namespace OnlineStoreAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccessController : ControllerBase
    {
        private readonly AccessService _accessService;

        public AccessController(AccessService accessService)
        {
            _accessService = accessService;
        }

        [HttpPost]
        public async Task<IActionResult> Access([FromBody] AccessRequest request)
        {
            if (request.Method == "login")
            {
                if (string.IsNullOrEmpty(request.Email) || string.IsNullOrEmpty(request.Password))
                {
                    return BadRequest(new { isSuccess = false, message = "Email y Password son requeridos para login" });
                }

                var (isSuccess, message, token) = await _accessService.LoginAsync(request.Email, request.Password);

                if (!isSuccess)
                {
                    return Ok(new { isSuccess = false, message });
                }

                return Ok(new { isSuccess = true, message, token });
            }

            if (request.Method == "register")
            {
                if (string.IsNullOrEmpty(request.Email) || string.IsNullOrEmpty(request.Password) ||
                    string.IsNullOrEmpty(request.Nombre) || string.IsNullOrEmpty(request.TipoDeUsuario))
                {
                    return BadRequest(new { isSuccess = false, message = "Email, Password, Nombre y TipoDeUsuario son requeridos para register" });
                }

                var newUser = new Usuario
                {
                    Correo = request.Email,
                    Password = request.Password,
                    Nombre = request.Nombre,
                    TipoDeUsuario = request.TipoDeUsuario,
                    Estatus = "1"
                };

                var (isSuccess, message) = await _accessService.RegisterAsync(newUser);

                if (!isSuccess)
                {
                    return Ok(new { isSuccess = false, message });
                }

                return Ok(new { isSuccess = true, message });
            }

            if (request.Method == "recovery_check")
            {
                if (string.IsNullOrEmpty(request.Email))
                {
                    return BadRequest(new { isSuccess = false, message = "Email es requerido para recovery_check" });
                }

                var (isSuccess, message, password) = await _accessService.RecoveryCheckAsync(request.Email);

                if (!isSuccess)
                {
                    return Ok(new { isSuccess = false, message });
                }

                return Ok(new { isSuccess = true, message, password });
            }

            if (request.Method == "recovery_change")
            {
                if (string.IsNullOrEmpty(request.Email) || string.IsNullOrEmpty(request.NewPassword))
                {
                    return BadRequest(new { isSuccess = false, message = "Email y NewPassword son requeridos para recovery_change" });
                }

                var (isSuccess, message) = await _accessService.RecoveryChangeAsync(request.Email, request.NewPassword);

                if (!isSuccess)
                {
                    return Ok(new { isSuccess = false, message });
                }

                return Ok(new { isSuccess = true, message });
            }

            return BadRequest(new { isSuccess = false, message = "Método no válido" });
        }
    }

    public class AccessRequest
    {
        public string Method { get; set; }
        public string Email { get; set; }
        public string? Password { get; set; }
        public string? Nombre { get; set; }
        public string? TipoDeUsuario { get; set; }
        public string? NewPassword { get; set; }
    }
}
