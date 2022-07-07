using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace burakcanyildizbackend.Models
{
    public class Soru : BaseEntity
    {
        [Key]

        public int Id { get; set; }

        public int BursId { get; set; }

        public Burs Burs { get; set; }

        public string Name { get; set; }
    }
}
