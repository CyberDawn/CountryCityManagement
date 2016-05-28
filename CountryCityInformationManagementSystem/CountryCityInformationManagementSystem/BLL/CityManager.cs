using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using CountryCityInformationManagementSystem.DAL;
using CountryCityInformationManagementSystem.Models;

namespace CountryCityInformationManagementSystem.BLL
{
    public class CityManager
    {
        private CityGateway gateway = new CityGateway();

        public string Save(City aCity)
        {
            bool isExists = gateway.IsCityNameExists(aCity.Name, aCity.CountryId);
            string message = "";
            if (isExists)
            {
                message = "City already exists!";
            }
            else
            {
                int rowsAffected = gateway.Save(aCity);
                bool isSaved = rowsAffected > 0;
                //message = isSaved ? "Saved Successfully!" : "Insertion Failed!";
            }
            return message;
        }

        public List<City> GetAllCityNames()
        {
            return gateway.GetAllCityNames();
        }

        public StringBuilder BindDataForCityEntryPageTable()
        {
            return gateway.BindDataForCityEntryPageTable();
        }


        // ViewCities Page Methods

        public StringBuilder BindDataforViewCitiesPageTable()
        {
            return gateway.BindDataforViewCitiesPageTable();
        }

        public StringBuilder SearchForCitiesByCityName(string cityName)
        {
            return gateway.SearchForCitiesByCityName(cityName);
        }

        public StringBuilder SearchForCitiesByCountryName(string countryName)
        {
            return gateway.SearchForCitiesByCountryName(countryName);
        }

        // End of ViewCities Page Methods
    }
}