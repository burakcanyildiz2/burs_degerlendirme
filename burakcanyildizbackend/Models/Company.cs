﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace burakcanyildizbackend.Models
{
    public class Company : BaseEntity
    {
        [Key]

        public int Id { get; set; }

        public string? CompanyName { get; set; }

        public string City { get; set; }

        public string? ServiceLane { get; set; }

        public string Email { get; set; }

        public string Password { get; set; }

        public string? FirstName { get; set; }

        public string? LastName { get; set; }

        public string? TCKN { get; set; }

        public string? BirthDate { get; set; }

        public string? Phone { get; set; }

        public bool IsCompany { get; set; } = false;

    }
}
