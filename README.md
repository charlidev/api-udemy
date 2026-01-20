using System.Data.SqlClient;

public class Db
{
    private readonly string _cs;

    public Db(IConfiguration config)
    {
        _cs = config.GetConnectionString("DefaultConnection")!;
    }

    public SqlConnection GetConn()
    {
        try
        {
            var conn = new SqlConnection(_cs);
            // NO abrimos aquí, solo creamos
            return conn;
        }
        catch (SqlException ex)
        {
            // Aquí cumples manejo de excepciones
            throw new Exception("Error al crear la conexión a la BD", ex);
        }
    }

    // Método SOLO para pruebas (opcional pero bien visto)
    public bool TestConexion(out string mensaje)
    {
        try
        {
            using var conn = new SqlConnection(_cs);
            conn.Open();
            mensaje = "Conexión exitosa";
            return true;
        }
        catch (Exception ex)
        {
            mensaje = ex.Message;
            return false;
        }
    }
}
