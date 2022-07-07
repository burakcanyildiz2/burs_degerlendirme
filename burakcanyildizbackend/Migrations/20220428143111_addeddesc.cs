using Microsoft.EntityFrameworkCore.Migrations;

namespace burakcanyildizbackend.Migrations
{
    public partial class addeddesc : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "WonPoint",
                table: "Burss");

            migrationBuilder.AddColumn<string>(
                name: "Description",
                table: "Burss",
                type: "nvarchar(max)",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Description",
                table: "Burss");

            migrationBuilder.AddColumn<int>(
                name: "WonPoint",
                table: "Burss",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }
    }
}
