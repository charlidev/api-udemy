public IActionResult Edit(int alumnoId)
{
    try
    {
        var a = _repo.GetAlumno(alumnoId);
        if (a == null) return NotFound();

        var vm = new AlumnoEditVM
        {
            AlumnoId = a.AlumnoId,
            Email = a.Email,
            Direccion = a.Direccion,
            Telefono = a.Telefono,
            CarreraId = a.CarreraId,
            Carreras = _repo.GetCarreras()
        };
        return View(vm);
    }
    catch (Exception ex)
    {
        ViewBag.Error = ex.Message;
        return View("Error");
    }
}

[HttpPost]
public IActionResult Edit(AlumnoEditVM vm)
{
    try
    {
        if (string.IsNullOrWhiteSpace(vm.Email))
            ModelState.AddModelError("", "Email es requerido");

        if (!ModelState.IsValid)
        {
            vm.Carreras = _repo.GetCarreras();
            return View(vm);
        }

        _repo.UpdateAlumnoEditable(vm.AlumnoId, vm.Email, vm.Direccion, vm.Telefono, vm.CarreraId);
        return RedirectToAction("Detalle", new { alumnoId = vm.AlumnoId });
    }
    catch (Exception ex)
    {
        ViewBag.Error = ex.Message;
        return View("Error");
    }
}

[HttpPost]
public IActionResult Eliminar(int alumnoId)
{
    try
    {
        _repo.EliminarAlumno(alumnoId); // SP: solo borra si no hay pagos
        return RedirectToAction("Index", "Carreras");
    }
    catch (Exception ex)
    {
        ViewBag.Error = ex.Message;
        return View("Error");
    }
}
