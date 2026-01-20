public class AlumnoEditVM
{
    public int AlumnoId { get; set; }
    public string Email { get; set; } = "";
    public string Direccion { get; set; } = "";
    public string Telefono { get; set; } = "";
    public int CarreraId { get; set; }
    public List<Carrera> Carreras { get; set; } = new();
}
