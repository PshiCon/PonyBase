using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;

namespace DataBase
{
    public partial class formEditingProduct : Form
    {
        string path = Application.StartupPath;
        string fullPhoto;
        Bitmap bitmap;
        string NamePicter;
       

        public formEditingProduct()
        {
            InitializeComponent();
        }

        private void buttonClose_Click(object sender, EventArgs e)
        {
            formProduct formClien = new formProduct();
            formClien.Show();
            this.Close();
        }

        private void formEditingProduct_Load(object sender, EventArgs e)
        {

            labelRole.Text = "Role: " + UserClass.NameRole;

            labelUser.Text = "User: " + UserClass.UserSurname + " " + UserClass.UserName + " " + UserClass.UserPatronymic;

            string query = $" Select* From[dbo].[Product],[dbo].[Manufacturer]  Where[dbo].[Product].ProductManufacturerID =[Manufacturer].ManufacturerID and ProductArticleNumber = '{ProductClass.ProductArticleNumber}'";

            Helper.Command = new SqlCommand(query, Helper.connection);

            Helper.Adapter.SelectCommand = Helper.Command;
            Helper.Adapter.Fill(Helper.Table);

            Helper.Reader = Helper.Command.ExecuteReader();

            if (Helper.Reader.Read() == false)
            {

            }
            else
            {

                ProductClass.ProductArticleNumber = (string)Helper.Reader["ProductArticleNumber"];
                ProductClass.ProductName = (string)Helper.Reader["ProductName"];
                ProductClass.ProductDescription = (string)Helper.Reader["ProductDescription"];
                ProductClass.ProductCategoryID = (int)Helper.Reader["ProductCategoryID"];

                NamePicter = (string)Helper.Reader["ProductPhoto"];
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

                ProductClass.ProductManufacturerID = (int)Helper.Reader["ProductManufacturerID"];
                ProductClass.ProductCost = (decimal)Helper.Reader["ProductCost"];
                ProductClass.ProductDiscountMax =(Byte) Helper.Reader["ProductDiscountMax"];
                ProductClass.ProductDiscountNow = (Byte)Helper.Reader["ProductDiscountNow"];
                ProductClass.ProductQuantityInStock = (int)Helper.Reader["ProductQuantityInStock"];
                ProductClass.ProductProviderID = (int)Helper.Reader["ProductProviderID"];
                ProductClass.ProductUnitID = (int)Helper.Reader["ProductUnitID"];

                TextboxProduct();
            }
            Helper.Reader.Close();
            //////////////////////Category///////////////////////////////////////////
            string sqlCategory = "SELECT * FROM Category";
            SqlCommand sqlCommand = new SqlCommand(sqlCategory, Helper.connection);
            Helper.Reader = sqlCommand.ExecuteReader();
            if (Helper.Reader.HasRows)
            {
                while (Helper.Reader.Read())
                {
                    comboBoxCategory.Items.Add((string)Helper.Reader["CategoryName"]);

                }
            }
            comboBoxCategory.SelectedIndex = ProductClass.ProductCategoryID-1;
            Helper.Reader.Close();


            //////////////////////Provider///////////////////////////////////////////
            string sqlProvider = "SELECT * FROM Provider";
            sqlCommand = new SqlCommand(sqlProvider, Helper.connection);
            Helper.Reader = sqlCommand.ExecuteReader();
            if (Helper.Reader.HasRows)
            {
                while (Helper.Reader.Read())
                {
                    comboBoxProvider.Items.Add((string)Helper.Reader["ProviderName"]);

                }
            }
            comboBoxProvider.SelectedIndex = ProductClass.ProductProviderID-1;
            Helper.Reader.Close();

            //////////////////////Manifucter///////////////////////////////////////////
            string sqlManifucter = "SELECT * FROM Manufacturer";
            sqlCommand = new SqlCommand(sqlManifucter, Helper.connection);
            Helper.Reader = sqlCommand.ExecuteReader();
            if (Helper.Reader.HasRows)
            {
                while (Helper.Reader.Read())
                {
                    comboBoxManufactor.Items.Add((string)Helper.Reader["ManufacturerName"]);

                }
            }
            comboBoxManufactor.SelectedIndex = ProductClass.ProductManufacturerID-1 ;

            Helper.Reader.Close();

        }

        void TextboxProduct()
        {

            Helper.Reader.Close();
            textBoxProductArticleNumber.Text = ProductClass.ProductArticleNumber;
            textBoxProductName.Text=ProductClass.ProductName;
            textBoxProductDescription.Text = ProductClass.ProductDescription;
           
            pictureProduct.BackgroundImage = bitmap;

            textBoxProductCost.Text = Convert.ToInt32(ProductClass.ProductCost).ToString();
            textBoxProductDiscountMax.Text=ProductClass.ProductDiscountMax.ToString();
            textBoxProductDiscountNow.Text=ProductClass.ProductDiscountNow.ToString();
            textBoxProductQuantityInStock.Text =ProductClass.ProductQuantityInStock.ToString();
            
            
        }   

        void CheckingArticle()
        {
            string sqlCheckingArticlet = $"Select * from Product " +
                $"WHERE ProductArticleNumber = '{ProductClass.ProductArticleNumber}' ";

            Helper.Command = new SqlCommand(sqlCheckingArticlet, Helper.connection);

            Helper.Adapter.InsertCommand = Helper.Command;
            Helper.Reader.Close();
            int result = Helper.Adapter.InsertCommand.ExecuteNonQuery();

            if (result != 0)
            {
                MessageBox.Show("Такой артикул уже существует");
                return;
                
            }
            
           
        }
        void DataSave()//Взятие данных из textBox и comboBox
        {
            try
            {
                ProductClass.ProductArticleNumber = textBoxProductArticleNumber.Text;
                ProductClass.ProductName = textBoxProductName.Text;
                ProductClass.ProductDescription = textBoxProductDescription.Text;
                ProductClass.ProductCategoryID = comboBoxCategory.SelectedIndex + 1;
                ProductClass.ProductPhoto = NamePicter;
                ProductClass.ProductManufacturerID = comboBoxManufactor.SelectedIndex + 1;

                ProductClass.ProductCost = Convert.ToInt32(textBoxProductCost.Text);
                ProductClass.ProductDiscountMax = Convert.ToByte(textBoxProductDiscountMax.Text);
                ProductClass.ProductDiscountNow = Convert.ToByte(textBoxProductDiscountNow.Text);
                ProductClass.ProductQuantityInStock = Convert.ToInt32(textBoxProductQuantityInStock.Text);
                ProductClass.ProductProviderID = comboBoxProvider.SelectedIndex + 1;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Неправильный формат данных");
                return;
            }
          
        }
        private void buttonClick(object sender, EventArgs e)
        {
            formProduct formClien = new formProduct();
           
            Button button = (Button)sender;
            switch (button.Tag)
            {
                case "ДобавитьФото": SavePicter(); break;            
                    
                case "УдалитьФото":
                    bitmap = Properties.Resources.pentagram;
                    pictureProduct.BackgroundImage = bitmap; break;

                case "ДобавитьТовар": AddProduct();
                    formClien.Show();
                    this.Close(); break;

                case "УдалитьТовар": DeleteProduct();
                    formClien.Show();
                    this.Close(); break;
                    
                case "ОбновитьТовар":SaveEdittingProduct();
                    formClien.Show();
                    this.Close(); break;
            }
        }
        void AddProduct()
        {
            DataSave();
            CheckingArticle();
            if (NamePicter != null)
            {
                fullPhoto = path + "\\Товар\\" + NamePicter;
                pictureProduct.BackgroundImage.Save(fullPhoto);
            }
            string sqlAddProduct = $"INSERT INTO Product " +
                $"Values ('{ProductClass.ProductArticleNumber}', '{ProductClass.ProductName}', " +
                $"'{ProductClass.ProductDescription}',{ProductClass.ProductCategoryID}, '{ProductClass.ProductPhoto}'" +
                $",{ProductClass.ProductManufacturerID}, {ProductClass.ProductCost}, " +
                $"{ProductClass.ProductDiscountMax}, {ProductClass.ProductDiscountNow}, {ProductClass.ProductQuantityInStock}," +
                $"{ProductClass.ProductProviderID}, 1)";
           
            Helper.Command = new SqlCommand(sqlAddProduct, Helper.connection);

            Helper.Adapter.InsertCommand = Helper.Command;
            Helper.Reader.Close();
            int result = Helper.Adapter.InsertCommand.ExecuteNonQuery();

            if (result != 0)
            {
                MessageBox.Show("Товар добавлен");
            }
            else
            {
                MessageBox.Show("ошибка");
            }
        }
        void SaveEdittingProduct()
        {
            DataSave();
            if(NamePicter != null)
            {
                fullPhoto = path + "\\Товар\\" + NamePicter;
                try
                {
                    pictureProduct.BackgroundImage.Save(fullPhoto);
                }
                catch (System.Runtime.InteropServices.ExternalException)
                {

                }
                
            }

            string SqlUpdate = $"Update Product Set ProductName='{ProductClass.ProductName}', " +
            $"ProductDescription='{ProductClass.ProductDescription}', " +
            $"ProductCategoryID={ProductClass.ProductCategoryID}," +
            $"ProductPhoto='{ProductClass.ProductPhoto}', " +
            $"ProductManufacturerID={ProductClass.ProductManufacturerID}, " +
            $"ProductCost={ProductClass.ProductCost}, " +
            $"ProductDiscountMax={ProductClass.ProductDiscountMax}, " +
            $"ProductDiscountNow={ProductClass.ProductDiscountNow}, " +
            $"ProductQuantityInStock={ProductClass.ProductQuantityInStock}," +
            $"ProductProviderID={ProductClass.ProductProviderID}," +
            $"ProductUnitID=1 " +
            $"WHERE ProductArticleNumber='{ProductClass.ProductArticleNumber}'";


            Helper.Command = new SqlCommand(SqlUpdate, Helper.connection);

            Helper.Adapter.UpdateCommand = Helper.Command;
            Helper.Reader.Close();
            int result=Helper.Adapter.UpdateCommand.ExecuteNonQuery();
            
            if(result != 0)
            {
                MessageBox.Show("Данные изменнены");
            }
            else
            {
                MessageBox.Show("ошибка");
            }

        }
        void DeleteProduct()
        {
            string sqlAddProduct = $"Select from Product " +
                $"WHERE ProductArticleNumber = '{ProductClass.ProductArticleNumber}' ";

            Helper.Command = new SqlCommand(sqlAddProduct, Helper.connection);

            Helper.Adapter.InsertCommand = Helper.Command;
            Helper.Reader.Close();
            int result = Helper.Adapter.InsertCommand.ExecuteNonQuery();

            if (result != 0)
            {
                MessageBox.Show("Товар удален");
            }
            else
            {
                MessageBox.Show("ошибка");
            }
        }
        void SavePicter()
        {
         
            OpenFileDialog open_dialog = new OpenFileDialog(); //создание диалогового окна для выбора файла
            open_dialog.Filter = "Image Files(*.BMP;*.JPG;*.GIF;*.PNG)|*.BMP;*.JPG;*.GIF;*.PNG|All files (*.*)|*.*"; //формат загружаемого файла
            if (open_dialog.ShowDialog() == DialogResult.OK) //если в окне была нажата кнопка "ОК"
            {
                try
                {
                    string path=open_dialog.FileName;
                    NamePicter=Path.GetFileName(path);
                    bitmap = new Bitmap(open_dialog.FileName);
                    //вместо pictureBox1 укажите pictureBox, в который нужно загрузить изображение                     
                    this.pictureProduct.Size = bitmap.Size;
                    pictureProduct.BackgroundImage = bitmap;
                    pictureProduct.BackgroundImageLayout = ImageLayout.Zoom;
                    
                    pictureProduct.Invalidate();
                }
                catch
                {
                    DialogResult rezult = MessageBox.Show("Невозможно открыть выбранный файл",
                    "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        
    }
}
