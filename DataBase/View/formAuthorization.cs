using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Threading;

namespace DataBase
{
    public partial class formAuthorization : Form
    {     
        private string text = String.Empty;
        private int popitki=0;

        void ClearDataBase()//очитска
        {
            UserClass.UserId = 0;
            UserClass.UserSurname=null;
            UserClass.UserName = null;
            UserClass.UserPatronymic=null;
            UserClass.UserLogin = null;
            UserClass.UserPassword=null;
            UserClass.UserRole=0;
            UserClass.NameRole=null;
        }
        private void formAuthorization_Load(object sender, EventArgs e)
        {
            Helper.connection.Open();

            try
            {
                
                labelStatus.ForeColor = Color.Green;
            }
            catch (Exception)
            {
                labelStatus.ForeColor = Color.Red;

            }

            String query = $"SELECT * FROM [User]";

            Helper.Command = new SqlCommand(query, Helper.connection);
           try
           {
            
            Helper.Reader = Helper.Command.ExecuteReader();
          
            ViewDataBase.RowCount = 1;
            int i = -1;
            while (Helper.Reader.Read())
            {
                i++;
                ViewDataBase.Rows.Add();
                for (int j = 0; j < Helper.Reader.FieldCount; j++)
                {
                    this.ViewDataBase[j, i].Value = Helper.Reader.GetValue(j).ToString();
                }

            }
            Helper.Reader.Close();
            }
            catch (System.InvalidOperationException)
            {
                MessageBox.Show("Ошибка подключение");
            }
        }
        public formAuthorization()
        {
            InitializeComponent();
            
         
        }

        private void ButtonAuthorization_Click(object sender, EventArgs e)
        {
            if (popitki > 0)
            {

                if (textCapcha.Text != captcha.CaptchaText)
                {
                    popitki++;
                    MessageBox.Show("Неправильная капча! Если количество ошибок превышает 2 то," +
                        " при следущем неправильном вводе,будет ограничение 10 сек. Попытка= " + popitki);

                    if (popitki > 2) Thread.Sleep(10000);//Ограничение 10 сек 

                    return;
                }    
            }

                String login = textLogin.Text;
                String password = textPassword.Text;


                String query = $"SELECT UserId,UserSurname,UserName,UserPatronymic,UserLogin, UserPassword,UserRole FROM [User] WHERE UserLogin='{login}' and UserPassword='{password}'";

                Helper.Command = new SqlCommand(query, Helper.connection);

                Helper.Adapter.SelectCommand = Helper.Command;
                Helper.Adapter.Fill(Helper.Table);

                Helper.Reader = Helper.Command.ExecuteReader();


                if (Helper.Reader.Read() == false)
                {
                    
                }
                else
                {
                UserClass.UserId = (int)Helper.Reader["UserId"];
                UserClass.UserSurname = (string)Helper.Reader["UserSurname"];
                UserClass.UserName = (string)Helper.Reader["UserName"];
                UserClass.UserPatronymic = (string)Helper.Reader["UserPatronymic"];
                UserClass.UserLogin = (string)Helper.Reader["UserLogin"];
                UserClass.UserPassword = (string)Helper.Reader["UserPassword"];
                UserClass.UserRole = (int)Helper.Reader["UserRole"];

                    switch (UserClass.UserRole)
                    {

                        case 1:
                        UserClass.NameRole = Role.Клиент.ToString();
                            formProduct formClient = new formProduct();
                            formClient.Show();

                            break;
                        case 2:
                        UserClass.NameRole = Role.Менеджер.ToString();
                        formProduct formMegent = new formProduct();
                        formMegent.Show();
                        break;
                        case 3:
                        UserClass.NameRole = Role.Администратор.ToString();
                        formProduct formAdmin = new formProduct();
                        formAdmin.Show();
                        break;
                    }
                    this.Hide();
                }

                if (Helper.Table.Rows.Count == 0)
                {
                    MessageBox.Show("Неправильный логин или пароль");
                  
                    captcha.Visible = true;
                    textCapcha.Visible = true;
                     popitki++;
                }
                else
                {
                    
                }
          
            Helper.Table.Rows.Clear();
            Helper.Reader.Close();
            
        }

        private void buttonClose_Click(object sender, EventArgs e)
        {
            Application.Exit();

        }

        private void butGuest_Click_1(object sender, EventArgs e)
        {
            formProduct formClient = new formProduct();
            ClearDataBase();
            Helper.Reader.Close();
            this.Hide();
            formClient.Show();
        }
    }
}
