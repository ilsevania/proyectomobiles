namespace OnlineStoreAPI.Models
{
    public class Usuario
    {
        public int Id { get; set; }
        public string? Correo { get; set; }
        public string? Password { get; set; }
        public string? Nombre { get; set; }
        public string? TipoDeUsuario { get; set; }
        public string? Estatus { get; set; }
    }
}
