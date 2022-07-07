using Microsoft.EntityFrameworkCore.Migrations;

namespace burakcanyildizbackend.Migrations
{
    public partial class kontenjanadded : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Kontenjan",
                table: "Burss",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Kontenjan",
                table: "Burss");
        }
    }
}
