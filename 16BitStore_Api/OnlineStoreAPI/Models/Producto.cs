using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace OnlineStoreAPI.Models
{
    public class Producto
    {
        [Key]
        public int Id { get; set; }

        [Column("clasificacion")]
        public string Clasificacion { get; set; }

        [Column("codigo_del_producto")]
        public string CodigoDelProducto { get; set; }

        [Column("nombre_del_producto")]
        public string NombreDelProducto { get; set; }

        [Column("precio")]
        public decimal Precio { get; set; }

        [Column("cantidad_en_stock")]
        public int CantidadEnStock { get; set; }
    }
}
