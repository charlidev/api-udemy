using Microsoft.AspNetCore.Mvc;

public class CarrerasController : Controller
{
    private readonly SchoolRepo _repo;
    public CarrerasController(SchoolRepo repo) { _repo = repo; }

    public IActionResult Index(int? carreraId)
    {
        try
        {
            ViewBag.Carreras = _repo.GetCarreras();
            ViewBag.CarreraId = carreraId;

            var alumnos = carreraId.HasValue
                ? _repo.GetAlumnosPorCarrera(carreraId.Value)
                : new List<Alumno>();

            return View(alumnos);
        }
        catch (Exception ex)
        {
            ViewBag.Error = ex.Message;
            return View("Error");
        }
    }
}
