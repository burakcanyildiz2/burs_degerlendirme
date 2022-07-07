using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace burakcanyildizbackend.Models
{
    public class Test : BaseEntity
    {
        [Key]

        public int Id { get; set; }

        public int BursId { get; set; }

        public Burs Burs { get; set; }

        public int UserId { get; set; }

        public User User { get; set; }

        public int Puan { get; set; }

        public int? IsWon { get; set; } = 0;
    }
}
