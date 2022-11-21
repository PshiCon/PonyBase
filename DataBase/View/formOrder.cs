using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.IO;

using Word = Microsoft.Office.Interop.Word;//талон
using System.Reflection;

namespace DataBase
{

    public partial class formOrder : Form
    {
        static List<Order> list;

        string path = Application.StartupPath;
        string fullPhoto;
        Bitmap bitmap;
        string NamePicter;

        public formOrder(List<Order> orders)
        {
            InitializeComponent();
            list = orders;
        }

        private void formOrder_Load(object sender, EventArgs e)
        {

            string sqlPickupPoint = "SELECT * FROM PickupPoint";
            SqlCommand sqlCommand = new SqlCommand(sqlPickupPoint, Helper.connection);
            Helper.Reader = sqlCommand.ExecuteReader();
            if (Helper.Reader.HasRows)
            {
                while (Helper.Reader.Read())
                {
                    comboBoxDelivery.Items.Add((string)Helper.Reader["PickupPointAddres"]);

                }
            }

            labelRole.Text = "Role: " + UserClass.NameRole;

            labelUser.Text = "User: " + UserClass.UserSurname + " " + UserClass.UserName + " " + UserClass.UserPatronymic;
            labelNameKlient.Text = UserClass.UserSurname + " " + UserClass.UserName + " " + UserClass.UserPatronymic;
            InstalData();
            Data();
        }
        void InstalData()
        {
            dataGridViewOrder.Rows.Clear();
            for (int i = 0; i < list.Count; i++)
            {

                int ind = dataGridViewOrder.Rows.Add();
                dataGridViewOrder.Rows[ind].Cells[0].Value = list[i].productArticleNumber;
                dataGridViewOrder.Rows[ind].Cells[1].Value = list[i].productName;
                dataGridViewOrder.Rows[ind].Cells[2].Value = list[i].productCount;


            }
        }
        void Data()
        {
            decimal summaProduct = 0;
            byte symmaDiscoun = 0;
            for (int i = 0; i < list.Count; i++)
            {

                 summaProduct = summaProduct + list[i].productCost;
                 symmaDiscoun = (byte)(symmaDiscoun + list[i].productDiscountNow);

            }
            textBoxDecriptionOrder.Text = "Всего товаров: " + list.Count+ Environment.NewLine;           
            textBoxDecriptionOrder.Text += "Общая сумма товаров: "+ summaProduct + Environment.NewLine;
            textBoxDecriptionOrder.Text += "Общая сумма скидки: "+ symmaDiscoun + Environment.NewLine;
            textBoxDecriptionOrder.Text += "Общая сумма за весь товар со скидкой: "+ (summaProduct - symmaDiscoun) + Environment.NewLine;

        }
    
        private void buttonClose_Click(object sender, EventArgs e)
        {
            
            formProduct formProduct=new formProduct();
            formProduct.Show();

            this.Close();
        }

        private void dataGridViewOrder_CellMouseClick(object sender, DataGridViewCellMouseEventArgs e)
        {
            int rowProduct = e.RowIndex;
            try
            {

                string article = dataGridViewOrder.Rows[rowProduct].Cells[0].Value.ToString();

                for (int i = 0; i < list.Count; i++)
                {
                    if (article == list[i].productArticleNumber)
                    {
                        NamePicter = list[i].productPhoto;
                        if (String.IsNullOrEmpty(NamePicter))
                        {
                            bitmap = Properties.Resources.pentagram;
                        }
                        else
                        {
                            fullPhoto = path + "\\Товар\\" + NamePicter;
                            if (File.Exists(fullPhoto))
                            {
                                bitmap = new Bitmap(fullPhoto);
                            }
                            else
                            {
                                bitmap = Properties.Resources.pentagram;
                            }
                        }
                        pictureBoxOrder.BackgroundImage = bitmap;
                        textBoxDecription.Text = "Наименование: " + list[i].productName + Environment.NewLine;
                        textBoxDecription.Text += "Описание: " + list[i].productDescription + Environment.NewLine;
                        textBoxDecription.Text += "Категории: " + SqlQuest.SqlCategory(list[i].productCategoryID) + Environment.NewLine;
                        textBoxDecription.Text += "Проиводитель: " + SqlQuest.SqlManufacturer(list[i].productManufacturerID) + Environment.NewLine;
                        textBoxDecription.Text += "Цена без скидки : " + list[i].productCost + Environment.NewLine;
                        textBoxDecription.Text += "Скидка: " + list[i].productDiscountNow + Environment.NewLine;
                        textBoxDecription.Text += "Поставщик: " + SqlQuest.SqlProvider(list[i].productProviderID) + Environment.NewLine;

                    }

                }
            }
            catch(Exception x)
            {

            }
        }

        private void dataGridViewOrder_CellContentClick_1(object sender, DataGridViewCellEventArgs e)
        {
           int rowProduct = e.RowIndex;
            try
            {
                if (dataGridViewOrder.Columns[e.ColumnIndex].Name == "DeleteProduct")
                {
                    string article = dataGridViewOrder.Rows[rowProduct].Cells[0].Value.ToString();

                    if(list[rowProduct].productCount == 1)
                    {
                        list.RemoveAt(rowProduct);
                       
                    }
                    else
                    {
                        list[rowProduct].productCount--;
                    }
                    InstalData();
                    Data();


                }
            }         
            catch (Exception x)
            {

            }
        }
       
        private void buttonCreateOrder_Click(object sender, EventArgs e)
        {
            Random random = new Random();  
            
            int nomer=random.Next(100,999);
            MessageBox.Show("Код: " + nomer + Environment.NewLine 
                + "Дата создание: " + DateTime.Now + Environment.NewLine
                + "Дата получение: " + DateTime.Now.AddDays(5) );
           
            for (int i = 0; i < list.Count; i++)
            {
                list[i].orderNomer= nomer;
                list[i].orderDateDelivery= DateTime.Now;
                list[i].orderDate = DateTime.Now.AddDays(5);
            }


            }

        private void buttonSaveEditing_Click(object sender, EventArgs e)//Word талон
        {

        }
    }
}
