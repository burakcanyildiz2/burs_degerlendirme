using Microsoft.EntityFrameworkCore.Migrations;

namespace burakcanyildizbackend.Migrations
{
    public partial class knjsdfns : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "TestCevaps",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserId = table.Column<int>(type: "int", nullable: true),
                    TestId = table.Column<int>(type: "int", nullable: true),
                    CevapId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TestCevaps", x => x.Id);
                    table.ForeignKey(
                        name: "FK_TestCevaps_Cevaps_CevapId",
                        column: x => x.CevapId,
                        principalTable: "Cevaps",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_TestCevaps_Tests_TestId",
                        column: x => x.TestId,
                        principalTable: "Tests",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_TestCevaps_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_TestCevaps_CevapId",
                table: "TestCevaps",
                column: "CevapId");

            migrationBuilder.CreateIndex(
                name: "IX_TestCevaps_TestId",
                table: "TestCevaps",
                column: "TestId");

            migrationBuilder.CreateIndex(
                name: "IX_TestCevaps_UserId",
                table: "TestCevaps",
                column: "UserId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "TestCevaps");
        }
    }
}
