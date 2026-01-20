using Microsoft.AspNetCore.Mvc;

public class AlumnosController : Controller
{
    private readonly SchoolRepo _repo;
    public AlumnosController(SchoolRepo repo) { _repo = repo; }

    public IActionResult Detalle(int alumnoId)
    {
        try
        {
            var alumno = _repo.GetAlumno(alumnoId);
            if (alumno == null) return NotFound();

            var vm = new AlumnoDetalleVM
            {
                Alumno = alumno,
                Pagos = _repo.GetPagosAlumno(alumnoId)
            };

            return View(vm);
        }
        catch (Exception ex)
        {
            ViewBag.Error = ex.Message;
            return View("Error");
        }
    }
}
