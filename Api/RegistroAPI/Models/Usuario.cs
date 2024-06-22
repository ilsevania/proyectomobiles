using System.ComponentModel.DataAnnotations;

namespace RegistroAPI.Models
{
    public class Usuario
    {
        public int Id { get; set; }
        
        [Required]
        [StringLength(50)]
        public string NombreUsuario { get; set; }
        
        [Required]
        [StringLength(50)]
        public string Email { get; set; }
        
        [Required]
        [StringLength(256)]
        public string Contrasena { get; set; }
        
        [StringLength(50)]
        public string TipoUsuario { get; set; }
        
        [StringLength(20)]
        public string Status { get; set; }
    }
}
