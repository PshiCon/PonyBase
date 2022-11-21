using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;

namespace DataBase
{
    static class Helper
    {
        public static SqlDataAdapter Adapter = new SqlDataAdapter();
        public static DataTable Table = new DataTable();
        public static SqlCommand Command = new SqlCommand();
        public static SqlDataReader Reader;

        public static SqlConnection connection = new SqlConnection(@"SERVER=LAPTOP-OVJ72171\SQLEXPRESS;DATABASE=DataBase493;Trusted_Connection=True");
        //public static SqlConnection connection = new SqlConnection(@Data Source=LAPTOP-OVJ72171\SQLEXPRESSLAPTOP-OVJ72171\SQLEXPRESS;Initial Catalog = DataBase493
        //Persist Security Info = True; User Id=iam 15;Password=Password

       // public static SqlConnection connection = new SqlConnection(@"SERVER=DESKTOP-89SKSIE\SQLEXPRESS;DATABASE=DataBase493;Trusted_Connection=True");
    }
}
