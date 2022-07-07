using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace burakcanyildizbackend.Models
{
    public class TestCevap
    {

        [Key]

        public int Id { get; set; }

        public int? UserId { get; set; }

        public User User { get; set; }

        public int? TestId { get; set; }

        public Test Test { get; set; }

        public int? CevapId { get; set; }

        public Cevap Cevap { get; set; }

        public int? SoruId { get; set; }

        public Soru Soru { get; set; }

    }
}
