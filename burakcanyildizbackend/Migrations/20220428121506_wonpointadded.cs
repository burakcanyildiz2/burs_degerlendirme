using Microsoft.EntityFrameworkCore.Migrations;

namespace burakcanyildizbackend.Migrations
{
    public partial class wonpointadded : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "WonPoint",
                table: "Burss",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "WonPoint",
                table: "Burss");
        }
    }
}
