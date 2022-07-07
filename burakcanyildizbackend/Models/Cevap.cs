using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace burakcanyildizbackend.Models
{
    public class Cevap : BaseEntity
    {

        [Key]

        public int Id { get; set; }

        public int SoruId { get; set; }

        public Soru Soru { get; set; }

        public string Name { get; set; }

        public int Puan { get; set; }

    }
}
