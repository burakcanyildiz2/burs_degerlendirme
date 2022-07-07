using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace burakcanyildizbackend.Models
{
    public class Burs : BaseEntity
    {
        [Key]

        public int Id { get; set; }

        public int CompanyId { get; set; }

        public Company Company { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public int isShow { get; set; } = 0;

        public int Kontenjan { get; set; } = 1;
    }
}
