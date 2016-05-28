using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CountryCityInformationManagementSystem.Models
{
    public class Country
    {
        public int Id { set; get; } 
        public string Name { get; set; }
        public string About { set; get; }

        public int NoOfDwellers { set; get; }
        public int NoOfCities { set; get; }

        public Country()
        {

        }

        public Country(int id, string name)
        {
            Name = name;
            Id = id;
        }

        public Country(int noOfCities , int noOfDwellers)
        {
            NoOfCities = noOfCities;
            NoOfDwellers = noOfDwellers;
        }
    }
}