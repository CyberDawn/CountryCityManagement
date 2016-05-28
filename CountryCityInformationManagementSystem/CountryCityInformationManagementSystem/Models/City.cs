using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CountryCityInformationManagementSystem.Models
{
    public class City
    {
        public string Name { set; get; }
        public string About { set; get; }
        public long NoOfDwellers { set; get; }         // int64 nite hobe 

        public string Location { set; get; }
        public string Weather { set; get; }
        public string Country { set; get; }

        public int CountryId { set; get; }

        public City()
        {
            
        }

        public City(string name, string about, int noOfDwellers, string location, string weather, string country)
        {
            Name = name;
            About = about;
            NoOfDwellers = noOfDwellers;
            Location = location;
            Weather = weather;
            Country = country;
        }

        public City(string name, string about, string country)
        {
            Name = name;
            About = about;
            Country = country;
        }
    }
}