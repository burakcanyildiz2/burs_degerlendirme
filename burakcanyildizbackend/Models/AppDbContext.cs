using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace burakcanyildizbackend.Models
{
    public class AppDbContext : DbContext
    {
        //  

        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {

        }

        public DbSet<User> Users { get; set; }

        public DbSet<Company> Companies { get; set; }

        public DbSet<Burs> Burss { get; set; }

        public DbSet<Soru> Sorus { get; set; }

        public DbSet<Cevap> Cevaps { get; set; }

        public DbSet<Test> Tests { get; set; }

        public DbSet<TestCevap> TestCevaps { get; set; }
    }
}
