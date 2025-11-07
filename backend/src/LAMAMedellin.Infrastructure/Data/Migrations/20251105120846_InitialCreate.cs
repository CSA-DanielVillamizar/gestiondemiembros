using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace LAMAMedellin.Infrastructure.Data.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Comites",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Nombre = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Descripcion = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true),
                    Activo = table.Column<bool>(type: "bit", nullable: false),
                    FechaCreacion = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Comites", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Miembros",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    NumeroIdentificacion = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Nombres = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Apellidos = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Email = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Telefono = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    Direccion = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    Ciudad = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    FechaNacimiento = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Profesion = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    Empresa = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    FechaIngreso = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Estado = table.Column<int>(type: "int", nullable: false),
                    TipoMembresia = table.Column<int>(type: "int", nullable: false),
                    Notas = table.Column<string>(type: "nvarchar(1000)", maxLength: 1000, nullable: true),
                    FotoUrl = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true),
                    FechaCreacion = table.Column<DateTime>(type: "datetime2", nullable: false),
                    FechaModificacion = table.Column<DateTime>(type: "datetime2", nullable: true),
                    CreadoPor = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    ModificadoPor = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Miembros", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "MiembroComites",
                columns: table => new
                {
                    MiembroId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    ComiteId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Rol = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    FechaIngreso = table.Column<DateTime>(type: "datetime2", nullable: false),
                    EsCoordinador = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MiembroComites", x => new { x.MiembroId, x.ComiteId });
                    table.ForeignKey(
                        name: "FK_MiembroComites_Comites_ComiteId",
                        column: x => x.ComiteId,
                        principalTable: "Comites",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_MiembroComites_Miembros_MiembroId",
                        column: x => x.MiembroId,
                        principalTable: "Miembros",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "Comites",
                columns: new[] { "Id", "Activo", "Descripcion", "FechaCreacion", "Nombre" },
                values: new object[,]
                {
                    { new Guid("11111111-1111-1111-1111-111111111111"), true, "Organización de eventos del capítulo", new DateTime(2025, 11, 5, 12, 8, 45, 979, DateTimeKind.Utc).AddTicks(8277), "Comité de Eventos" },
                    { new Guid("22222222-2222-2222-2222-222222222222"), true, "Gestión de comunicación interna y externa", new DateTime(2025, 11, 5, 12, 8, 45, 979, DateTimeKind.Utc).AddTicks(8282), "Comité de Comunicaciones" },
                    { new Guid("33333333-3333-3333-3333-333333333333"), true, "Desarrollo de proyectos de impacto social", new DateTime(2025, 11, 5, 12, 8, 45, 979, DateTimeKind.Utc).AddTicks(8290), "Comité de Proyectos Sociales" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Comites_Nombre",
                table: "Comites",
                column: "Nombre",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_MiembroComites_ComiteId",
                table: "MiembroComites",
                column: "ComiteId");

            migrationBuilder.CreateIndex(
                name: "IX_Miembros_Email",
                table: "Miembros",
                column: "Email",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Miembros_Estado",
                table: "Miembros",
                column: "Estado");

            migrationBuilder.CreateIndex(
                name: "IX_Miembros_NumeroIdentificacion",
                table: "Miembros",
                column: "NumeroIdentificacion",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Miembros_TipoMembresia",
                table: "Miembros",
                column: "TipoMembresia");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "MiembroComites");

            migrationBuilder.DropTable(
                name: "Comites");

            migrationBuilder.DropTable(
                name: "Miembros");
        }
    }
}
