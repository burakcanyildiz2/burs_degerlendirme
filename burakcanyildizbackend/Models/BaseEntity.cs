using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace burakcanyildizbackend.Models
{
    public class BaseEntity
    {

        public DateTime CreateTime { get; set; } = DateTime.Now;
        public bool isActive { get; set; } = true;

    }
}
