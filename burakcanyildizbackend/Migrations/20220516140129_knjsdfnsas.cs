using Microsoft.EntityFrameworkCore.Migrations;

namespace burakcanyildizbackend.Migrations
{
    public partial class knjsdfnsas : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "SoruId",
                table: "TestCevaps",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_TestCevaps_SoruId",
                table: "TestCevaps",
                column: "SoruId");

            migrationBuilder.AddForeignKey(
                name: "FK_TestCevaps_Sorus_SoruId",
                table: "TestCevaps",
                column: "SoruId",
                principalTable: "Sorus",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_TestCevaps_Sorus_SoruId",
                table: "TestCevaps");

            migrationBuilder.DropIndex(
                name: "IX_TestCevaps_SoruId",
                table: "TestCevaps");

            migrationBuilder.DropColumn(
                name: "SoruId",
                table: "TestCevaps");
        }
    }
}
