@model AlumnoDetalleVM

<h2>Detalle del alumno</h2>

<p><b>Nombre:</b> @Model.Alumno.ApellidoPaterno @Model.Alumno.ApellidoMaterno @Model.Alumno.Nombre</p>
<p><b>Email:</b> @Model.Alumno.Email</p>
<p><b>Dirección:</b> @Model.Alumno.Direccion</p>
<p><b>Teléfono:</b> @Model.Alumno.Telefono</p>

<p>
    <a href="/Alumnos/Edit?alumnoId=@Model.Alumno.AlumnoId">Editar</a> |
    <a href="/Pagos/Nuevo?alumnoId=@Model.Alumno.AlumnoId">Registrar pago</a>
</p>

@if (Model.PuedeEliminar)
{
    <form method="post" action="/Alumnos/Eliminar" onsubmit="return confirm('¿Eliminar alumno?');">
        <input type="hidden" name="alumnoId" value="@Model.Alumno.AlumnoId" />
        <button type="submit">Eliminar</button>
    </form>
}
else
{
    <p style="color:gray">No se puede eliminar porque tiene pagos registrados.</p>
}

<h3>Pagos</h3>
@if (Model.Pagos.Count == 0)
{
    <p>No hay pagos.</p>
}
else
{
    <table border="1" cellpadding="5">
        <tr><th>Folio</th><th>Concepto</th><th>Fecha</th><th>Importe</th></tr>
        @foreach (var p in Model.Pagos)
        {
            <tr>
                <td>@p.Folio</td>
                <td>@p.ConceptoNombre</td>
                <td>@p.FechaPago.ToString("yyyy-MM-dd")</td>
                <td>@p.Importe</td>
            </tr>
        }
    </table>
}
