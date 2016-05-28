using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using CountryCityInformationManagementSystem.Models;

namespace CountryCityInformationManagementSystem.DAL
{
    public class CityGateway
    {
        private string connectionString =
            WebConfigurationManager.ConnectionStrings["CountryCityManagementConnString"].ConnectionString;

        private SqlConnection connection = null;

        private StringBuilder htmlTable = new StringBuilder();

        public CityGateway()
        {
            connection = new SqlConnection(connectionString);
        }

        public int Save(City aCity)
        {
            string query = "INSERT INTO Cities VALUES(@name, @about, @noOfDwellers, @location, @weather, @countryId)";
            SqlCommand command = new SqlCommand(query, connection);

            command.Parameters.Clear();
            command.Parameters.Add("name", SqlDbType.NVarChar);
            command.Parameters["name"].Value = aCity.Name;
            command.Parameters.Add("about", SqlDbType.NVarChar);
            command.Parameters["about"].Value = aCity.About;
            command.Parameters.Add("noOfDwellers", SqlDbType.BigInt);
            command.Parameters["noOfDwellers"].Value = aCity.NoOfDwellers;
            command.Parameters.Add("location", SqlDbType.VarChar);
            command.Parameters["location"].Value = aCity.Location;
            command.Parameters.Add("weather", SqlDbType.VarChar);
            command.Parameters["weather"].Value = aCity.Weather;
            command.Parameters.Add("countryId", SqlDbType.Int);
            command.Parameters["countryId"].Value = aCity.CountryId;

            connection.Open();
            int rowsAffected = command.ExecuteNonQuery();
            connection.Close();
            return rowsAffected;
        }

        public List<City> GetAllCityNames()
        {
            List<City> cities = new List<City>();
            string query = "SELECT * FROM Cities";
            SqlCommand command = new SqlCommand(query, connection);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            City aCity = null;

            while (reader.Read())
            {
                string name = reader["Name"].ToString();
                string about = reader["About"].ToString();
                string country = reader["Country"].ToString();
                aCity = new City(name, about, country);
                cities.Add(aCity);
            }
            reader.Close();
            connection.Close();
            return cities;
        }

        public bool IsCityNameExists(string name, int countryId)
        {
            string query = "SELECT * FROM Cities WHERE Name = @name AND CountryId = @countryId";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.Clear();
            command.Parameters.Add("countryId", SqlDbType.Int);
            command.Parameters["countryId"].Value = countryId;
            command.Parameters.Add("name", SqlDbType.VarChar);
            command.Parameters["name"].Value = name;
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            bool isExists = reader.HasRows;
            connection.Close();
            return isExists;
        }

        public StringBuilder BindDataForCityEntryPageTable()
        {
            string query = "SELECT * From CitiesView";
            SqlCommand cmd = new SqlCommand(query, connection);
            connection.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    htmlTable.Append("<tr>");
                    htmlTable.Append("<td>" + reader["Id"] + "</td>");
                    htmlTable.Append("<td>" + reader["Name"] + "</td>");
                    htmlTable.Append("<td>" + reader["NoOfDwellers"] + "</td>");
                    htmlTable.Append("<td>" + reader["CountryName"] + "</td>");
                    htmlTable.Append("</tr>");
                }
            }
            reader.Close();
            connection.Close();
            return htmlTable;
        }

        //View Cities Page

        public StringBuilder BindDataforViewCitiesPageTable()
        {
            string query = "SELECT * From CitiesView";
            SqlCommand cmd = new SqlCommand(query, connection);
            connection.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    htmlTable.Append("<tr>");
                    htmlTable.Append("<td>" + reader["Id"] + "</td>");
                    htmlTable.Append("<td>" + reader["Name"] + "</td>");
                    htmlTable.Append("<td>" + reader["About"] + "</td>");
                    htmlTable.Append("<td>" + reader["NoOfDwellers"] + "</td>");
                    htmlTable.Append("<td>" + reader["Location"] + "</td>");
                    htmlTable.Append("<td>" + reader["Weather"] + "</td>");
                    htmlTable.Append("<td>" + reader["CountryName"] + "</td>");
                    htmlTable.Append("<td>" + reader["AboutCountry"] + "</td>");
                    htmlTable.Append("</tr>");
                }
            }
            reader.Close();
            connection.Close();
            return htmlTable;
        }

        public StringBuilder SearchForCitiesByCityName(string cityName)
        {
            string query = "SELECT * From CitiesView Where Name LIKE '%'+@cityName+'%'";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.Clear();
            command.Parameters.Add("cityName", SqlDbType.NVarChar);
            command.Parameters["cityName"].Value = cityName;
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    htmlTable.Append("<tr>");
                    htmlTable.Append("<td>" + reader["Id"] + "</td>");
                    htmlTable.Append("<td>" + reader["Name"] + "</td>");
                    htmlTable.Append("<td>" + reader["About"] + "</td>");
                    htmlTable.Append("<td>" + reader["NoOfDwellers"] + "</td>");
                    htmlTable.Append("<td>" + reader["Location"] + "</td>");
                    htmlTable.Append("<td>" + reader["Weather"] + "</td>");
                    htmlTable.Append("<td>" + reader["CountryName"] + "</td>");
                    htmlTable.Append("<td>" + reader["AboutCountry"] + "</td>");
                    htmlTable.Append("</tr>");
                }
            }
            reader.Close();
            connection.Close();
            return htmlTable;
        }

        public StringBuilder SearchForCitiesByCountryName(string countryName)
        {
            string query = "SELECT * From CitiesView Where CountryName LIKE '%'+@countryName+'%'";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.Clear();
            command.Parameters.Add("countryName", SqlDbType.VarChar);
            command.Parameters["countryName"].Value = countryName;
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    htmlTable.Append("<tr>");
                    htmlTable.Append("<td>" + reader["Id"] + "</td>");
                    htmlTable.Append("<td>" + reader["Name"] + "</td>");
                    htmlTable.Append("<td>" + reader["About"] + "</td>");
                    htmlTable.Append("<td>" + reader["NoOfDwellers"] + "</td>");
                    htmlTable.Append("<td>" + reader["Location"] + "</td>");
                    htmlTable.Append("<td>" + reader["Weather"] + "</td>");
                    htmlTable.Append("<td>" + reader["CountryName"] + "</td>");
                    htmlTable.Append("<td>" + reader["AboutCountry"] + "</td>");
                    htmlTable.Append("</tr>");
                }
            }
            reader.Close();
            connection.Close();
            return htmlTable;
        }
    }
}