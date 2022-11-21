using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataBase
{
    internal class UserClass
    {
       

        public static int UserId;
        public static string UserSurname;
        public static string UserName;
        public static string UserPatronymic;
        public static string UserLogin;
        public static string UserPassword;
        public static int UserRole;

        public static string NameRole;

    }
    public enum Role
    {
        Клиент = 1,
        Менеджер = 2,
        Администратор = 3,
    }
}

