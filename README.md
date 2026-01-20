@model AlumnoEditVM

<h2>Editar alumno</h2>

<form method="post">
    <input type="hidden" name="AlumnoId" value="@Model.AlumnoId" />

    <div>
        <label>Email</label>
        <input name="Email" value="@Model.Email" />
    </div>

    <div>
        <label>Dirección</label>
        <input name="Direccion" value="@Model.Direccion" />
    </div>

    <div>
        <label>Teléfono</label>
        <input name="Telefono" value="@Model.Telefono" />
    </div>

    <div>
        <label>Carrera</label>
        <select name="CarreraId">
            @foreach (var c in Model.Carreras)
            {
                <option value="@c.CarreraId" selected="@(Model.CarreraId==c.CarreraId)">@c.Nombre</option>
            }
        </select>
    </div>

    <button type="submit">Guardar</button>
    <a href="/Alumnos/Detalle?alumnoId=@Model.AlumnoId">Cancelar</a>
</form>

@if (!ViewData.ModelState.IsValid)
{
    <p style="color:red">Revisa los campos</p>
}
