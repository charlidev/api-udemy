@model List<Alumno>
@{
    var carreras = (List<Carrera>)ViewBag.Carreras;
    int? carreraId = ViewBag.CarreraId as int?;
}

<h2>Carreras</h2>

<form method="get">
    <select name="carreraId">
        <option value="">-- Selecciona --</option>
        @foreach (var c in carreras)
        {
            <option value="@c.CarreraId" selected="@(carreraId==c.CarreraId)">@c.Nombre</option>
        }
    </select>
    <button type="submit">Ver alumnos</button>
</form>

@if (Model.Count > 0)
{
    <h3>Alumnos</h3>
    <table border="1" cellpadding="5">
        <tr><th>Alumno</th><th>Email</th><th></th></tr>
        @foreach (var a in Model)
        {
            <tr>
                <td>@a.ApellidoPaterno @a.ApellidoMaterno @a.Nombre</td>
                <td>@a.Email</td>
                <td><a href="/Alumnos/Detalle?alumnoId=@a.AlumnoId">Detalle</a></td>
            </tr>
        }
    </table>
}
