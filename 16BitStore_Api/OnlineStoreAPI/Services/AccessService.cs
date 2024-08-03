using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using OnlineStoreAPI.Data;
using OnlineStoreAPI.Models;
using System.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.IdentityModel.Tokens;
using System.Threading.Tasks;

namespace OnlineStoreAPI.Services
{
    public class AccessService
    {
        private readonly OnlineStoreContext _context;
        private readonly string _connectionString;

        public AccessService(OnlineStoreContext context)
        {
            _context = context;
            _connectionString = context.Database.GetConnectionString();
        }

        public async Task<(bool IsSuccess, string Message, string Token)> LoginAsync(string email, string password)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                using (var command = new SqlCommand("Access", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@Method", "login");
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@Password", password);

                    connection.Open();
                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        if (await reader.ReadAsync())
                        {
                            var isSuccess = reader.GetInt32(0) == 1;
                            var message = reader.GetString(1);

                            if (!isSuccess)
                            {
                                return (false, message, null);
                            }

                            var userId = reader.GetInt32(2);
                            var token = GenerateJwtToken(userId, email);

                            return (true, message, token);
                        }
                    }
                }
            }

            return (false, "Error desconocido", null);
        }

        private string GenerateJwtToken(int userId, string email)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes("clave_de_almenos_32_caracteres_de_largo_vania"));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Sub, email),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                new Claim("userId", userId.ToString())
            };

            var token = new JwtSecurityToken(
                issuer: "your_app_name",
                audience: "your_app_name",
                claims: claims,
                expires: DateTime.Now.AddMinutes(30),
                signingCredentials: credentials
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        public async Task<(bool IsSuccess, string Message)> RegisterAsync(Usuario usuario)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                using (var command = new SqlCommand("Access", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@Method", "register");
                    command.Parameters.AddWithValue("@Email", usuario.Correo);
                    command.Parameters.AddWithValue("@Password", usuario.Password);
                    command.Parameters.AddWithValue("@Nombre", usuario.Nombre);
                    command.Parameters.AddWithValue("@TipoDeUsuario", usuario.TipoDeUsuario);

                    connection.Open();
                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        if (await reader.ReadAsync())
                        {
                            var isSuccess = reader.GetInt32(0) == 1;
                            var message = reader.GetString(1);

                            return (isSuccess, message);
                        }
                    }
                }
            }

            return (false, "Error desconocido");
        }

        public async Task<(bool IsSuccess, string Message, string Password)> RecoveryCheckAsync(string email)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                using (var command = new SqlCommand("Access", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@Method", "recovery_check");
                    command.Parameters.AddWithValue("@Email", email);

                    connection.Open();
                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        if (await reader.ReadAsync())
                        {
                            var isSuccess = reader.GetInt32(0) == 1;
                            var message = reader.GetString(1);

                            if (!isSuccess)
                            {
                                return (false, message, null);
                            }

                            var password = reader.GetString(2);

                            return (true, message, password);
                        }
                    }
                }
            }

            return (false, "Error desconocido", null);
        }

        public async Task<(bool IsSuccess, string Message)> RecoveryChangeAsync(string email, string newPassword)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                using (var command = new SqlCommand("Access", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@Method", "recovery_change");
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@NewPassword", newPassword);

                    connection.Open();
                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        if (await reader.ReadAsync())
                        {
                            var isSuccess = reader.GetInt32(0) == 1;
                            var message = reader.GetString(1);

                            return (isSuccess, message);
                        }
                    }
                }
            }

            return (false, "Error desconocido");
        }
    }
}
