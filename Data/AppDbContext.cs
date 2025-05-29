namespace FairyPhone.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options): base(options)
        {
            ChangeTracker.LazyLoadingEnabled = true;

        }

        public DbSet<Admin>? Admins { get; set; }
        public DbSet<Smartphone> Smartphones { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Cart> Carts { get; set; }
        public DbSet<Invoice> Invoices { get; set; }
        public DbSet<InvoiceItem> InvoiceItems { get; set; }
        public DbSet<FairyPhone.Models.ContactMessage> ContactMessages { get; set; }
    }
}
