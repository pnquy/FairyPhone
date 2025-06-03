using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FairyPhone.Migrations
{
    public partial class AddIsCheckedOutToCart : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "IsCheckedOut",
                table: "cart",
                type: "bit",
                nullable: false,
                defaultValue: false);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IsCheckedOut",
                table: "cart");
        }
    }
}
