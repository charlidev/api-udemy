using System.Data;
using System.Data.SqlClient;

public class SchoolRepo
{
    private readonly Db _db;
    public SchoolRepo(Db db) { _db = db; }

    public List<Carrera> GetCarreras()
    {
        var list = new List<Carrera>();
        using var conn = _db.GetConn();
        using var cmd = new SqlCommand("SELECT CarreraId, Nombre FROM Carreras ORDER BY Nombre", conn);
        conn.Open();
        using var rd = cmd.ExecuteReader();
        while (rd.Read())
            list.Add(new Carrera { CarreraId = rd.GetInt32(0), Nombre = rd.GetString(1) });
        return list;
    }

    public List<Alumno> GetAlumnosPorCarrera(int carreraId)
    {
        var list = new List<Alumno>();
        using var conn = _db.GetConn();
        using var cmd = new SqlCommand(@"
            SELECT AlumnoId, Nombre, ApellidoPaterno, ApellidoMaterno, Email, Direccion, Telefono, CarreraId, FechaAlta
            FROM Alumnos WHERE CarreraId=@CarreraId
            ORDER BY ApellidoPaterno, ApellidoMaterno, Nombre", conn);
        cmd.Parameters.AddWithValue("@CarreraId", carreraId);
        conn.Open();
        using var rd = cmd.ExecuteReader();
        while (rd.Read())
        {
            list.Add(new Alumno
            {
                AlumnoId = rd.GetInt32(0),
                Nombre = rd.GetString(1),
                ApellidoPaterno = rd.GetString(2),
                ApellidoMaterno = rd.GetString(3),
                Email = rd.GetString(4),
                Direccion = rd.GetString(5),
                Telefono = rd.GetString(6),
                CarreraId = rd.GetInt32(7),
                FechaAlta = rd.GetDateTime(8)
            });
        }
        return list;
    }

    public Alumno? GetAlumno(int alumnoId)
    {
        using var conn = _db.GetConn();
        using var cmd = new SqlCommand(@"
            SELECT AlumnoId, Nombre, ApellidoPaterno, ApellidoMaterno, Email, Direccion, Telefono, CarreraId, FechaAlta
            FROM Alumnos WHERE AlumnoId=@AlumnoId", conn);
        cmd.Parameters.AddWithValue("@AlumnoId", alumnoId);
        conn.Open();
        using var rd = cmd.ExecuteReader();
        if (!rd.Read()) return null;

        return new Alumno
        {
            AlumnoId = rd.GetInt32(0),
            Nombre = rd.GetString(1),
            ApellidoPaterno = rd.GetString(2),
            ApellidoMaterno = rd.GetString(3),
            Email = rd.GetString(4),
            Direccion = rd.GetString(5),
            Telefono = rd.GetString(6),
            CarreraId = rd.GetInt32(7),
            FechaAlta = rd.GetDateTime(8)
        };
    }

    public List<Pago> GetPagosAlumno(int alumnoId)
    {
        var list = new List<Pago>();
        using var conn = _db.GetConn();
        using var cmd = new SqlCommand(@"
            SELECT p.PagoId, p.Folio, p.AlumnoId, p.ConceptoPagoId, p.FechaPago, p.Importe, c.Nombre
            FROM Pagos p
            INNER JOIN ConceptosPago c ON c.ConceptoPagoId=p.ConceptoPagoId
            WHERE p.AlumnoId=@AlumnoId
            ORDER BY p.FechaPago DESC, p.Folio DESC", conn);
        cmd.Parameters.AddWithValue("@AlumnoId", alumnoId);
        conn.Open();
        using var rd = cmd.ExecuteReader();
        while (rd.Read())
        {
            list.Add(new Pago
            {
                PagoId = rd.GetInt32(0),
                Folio = rd.GetInt32(1),
                AlumnoId = rd.GetInt32(2),
                ConceptoPagoId = rd.GetInt32(3),
                FechaPago = rd.GetDateTime(4),
                Importe = rd.GetDecimal(5),
                ConceptoNombre = rd.GetString(6)
            });
        }
        return list;
    }

    public List<ConceptoPago> GetConceptosPago()
    {
        var list = new List<ConceptoPago>();
        using var conn = _db.GetConn();
        using var cmd = new SqlCommand("SELECT ConceptoPagoId, Nombre FROM ConceptosPago ORDER BY Nombre", conn);
        conn.Open();
        using var rd = cmd.ExecuteReader();
        while (rd.Read())
            list.Add(new ConceptoPago { ConceptoPagoId = rd.GetInt32(0), Nombre = rd.GetString(1) });
        return list;
    }

    public void InsertarPago(int alumnoId, int conceptoPagoId, decimal importe)
    {
        using var conn = _db.GetConn();
        using var cmd = new SqlCommand("sp_InsertarPago", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@AlumnoId", alumnoId);
        cmd.Parameters.AddWithValue("@ConceptoPagoId", conceptoPagoId);
        cmd.Parameters.AddWithValue("@Importe", importe);
        conn.Open();
        cmd.ExecuteNonQuery();
    }

    public void EliminarAlumno(int alumnoId)
    {
        using var conn = _db.GetConn();
        using var cmd = new SqlCommand("sp_EliminarAlumno", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@AlumnoId", alumnoId);
        conn.Open();
        cmd.ExecuteNonQuery();
    }

    public void UpdateAlumnoEditable(int alumnoId, string email, string direccion, string telefono, int carreraId)
    {
        using var conn = _db.GetConn();
        using var cmd = new SqlCommand(@"
            UPDATE Alumnos
            SET Email=@Email, Direccion=@Direccion, Telefono=@Telefono, CarreraId=@CarreraId
            WHERE AlumnoId=@AlumnoId", conn);
        cmd.Parameters.AddWithValue("@AlumnoId", alumnoId);
        cmd.Parameters.AddWithValue("@Email", email);
        cmd.Parameters.AddWithValue("@Direccion", direccion);
        cmd.Parameters.AddWithValue("@Telefono", telefono);
        cmd.Parameters.AddWithValue("@CarreraId", carreraId);
        conn.Open();
        cmd.ExecuteNonQuery();
    }
}
