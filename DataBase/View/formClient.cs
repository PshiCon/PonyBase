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
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using System.Data.Common;
using ComboBox = System.Windows.Forms.ComboBox;

namespace DataBase
{
    public partial class formProduct : Form
    {

        string path = Application.StartupPath;
        string fullPhoto;
        int fillerSort,filterDiscount, filterCategory;
        string[,] arrayDiscount = new string[,] { { "0", "100" }, { "0", "9" }, { "10", "14" }, { "15", "100" } };

        string sqlProduct = $"Select * From[dbo].[Product],[dbo].[Manufacturer]  Where[dbo].[Product].ProductManufacturerID =[Manufacturer].ManufacturerID";
        string sqlCategory = "";
        string sqlDiscoun = "";
        string sqlProductEnd = "";
        string sqlSearchString = "";
        string sqlSortString = "";


        bool exictsOrder;
         List<Order> orders;
        int rowProduct;

        public formProduct()
        {
            InitializeComponent();
        }
       
        private void combo_SelectedIndexChanged(object sender, EventArgs e)
        {
            sqlProduct = $"Select * From[dbo].[Product],[dbo].[Manufacturer]  Where[dbo].[Product].ProductManufacturerID =[Manufacturer].ManufacturerID";
            fillerSort = comboSort.SelectedIndex;
            filterDiscount = comboSkidka.SelectedIndex;
            filterCategory = comboCategory.SelectedIndex;

            ComboBox combo = sender as ComboBox;
            switch (combo.Tag)
            {
                case "sort":
                    if (fillerSort == 0)
                    {
                        string sort = "DESC";
                        sqlSortString = " ORDER BY [Product].ProductCost " + sort;

                    }
                    else
                    {
                        string sort = "ASC";
                         sqlSortString = " ORDER BY [Product].ProductCost " + sort;
                    }
                    ShowProduct();
                    break;
                case "discount":                  
                    if (filterDiscount == 0)
                    {
                        sqlDiscoun = "";
                        
                    }
                    else
                    {
                        sqlDiscoun = $" AND [Product].ProductDiscountMax BETWEEN '{arrayDiscount[filterDiscount, 0]}'  AND  '{arrayDiscount[filterDiscount, 1]}'";
                    }                                                        
                    ShowProduct();

                    break;
                case "category":
                    
                    if (filterCategory == 0)
                    {
                        sqlCategory = "";
                        
                    }
                    else
                    {
                        sqlCategory = $" AND [Product].ProductCategoryID = '{filterCategory}'";
                    }
                    
                    ShowProduct();
                    break;

            }
        }

        private void ShowProduct()
        {
            Helper.Reader.Close();
            Bitmap bitmap;
            string photo;
            int count=0;
            string desc;
            decimal cost=0;
            sqlProductEnd = " " + sqlProduct + " " + sqlDiscoun + " " + sqlCategory + " " + sqlSearchString + " " + sqlSortString;
           Helper.Command = new SqlCommand(sqlProductEnd, Helper.connection);

           Helper.Reader = Helper.Command.ExecuteReader();
            
            dataGridProduct.Rows.Clear();

            if (Helper.Reader.HasRows)
            {
                while(Helper.Reader.Read())
                {
                    count++;
                    int ind = dataGridProduct.Rows.Add();
                    dataGridProduct.Rows[ind].Cells[0].Value=(string)Helper.Reader["ProductArticleNumber"];
                    //Работа с фото

                    photo = (string)Helper.Reader["ProductPhoto"];
                    if (String.IsNullOrEmpty(photo))
                    {
                        bitmap = Properties.Resources.pentagram;
                    }
                    else
                    {
                        fullPhoto = path + "\\Товар\\" + photo;
                        if (File.Exists(fullPhoto))
                        {
                            bitmap = new Bitmap(fullPhoto);
                        }
                        else
                        {
                            bitmap = Properties.Resources.pentagram;
                        }
                    }
                    dataGridProduct.Rows[ind].Cells[1].Value = bitmap;
                    dataGridProduct.Rows[ind].Height = 100;
                    //Описание
                    desc = "Наименование товара: " + (string)Helper.Reader["ProductName"] + Environment.NewLine;
                    desc += "Описание товара: " + (string)Helper.Reader["ProductDescription"] + Environment.NewLine;
                    desc += "Производитель: " + (string)Helper.Reader["ManufacturerName"] + Environment.NewLine;
                    cost = (decimal)Helper.Reader["ProductCost"];
                    desc +="Цена: " + cost.ToString("C2") + Environment.NewLine;
                    int c= Convert.ToInt32( Helper.Reader["ProductDiscountNow"]);
                    desc += "Скидка: " + Helper.Reader["ProductDiscountNow"] + Environment.NewLine;
                    desc += "Цена со скидкой: " + (cost - (cost*c)/100).ToString("C2") +  Environment.NewLine;
                    
                    if (c >= 15)// Отметка скидки
                    {
                        dataGridProduct.Rows[ind].DefaultCellStyle.BackColor = Color.FromArgb(198, 84, 133);
                    }
                   
                    dataGridProduct.Rows[ind].Cells[2].Value = desc;
                   

                   
                }
                
            }

            labelCount.Text = count.ToString();         
            Helper.Reader.Close();
        }

        private void formClient_Load_1(object sender, EventArgs e)
        {
            if (orders != null)
            {
                buttonOrder.Visible = true;
            }
            else
            {
                buttonOrder.Visible = false;
            }
           

            Cursor.Current = Cursors.Default;
           
            Helper.Reader.Close();

            labelRole.Text = "Role: " + UserClass.NameRole;

            labelUser.Text = "User: " + UserClass.UserSurname + " " + UserClass.UserName + " " + UserClass.UserPatronymic;

            if(UserClass.NameRole== "Администратор")
            {
                buttonAddProduct.Visible = true;
            }

            //Категория         
            comboCategory.Items.Clear();

            comboCategory.Items.Insert(0, "Все категории");
           
            string sqlCatagory = "SELECT * FROM Category";
            SqlCommand sqlCommand = new SqlCommand(sqlCatagory, Helper.connection);
            Helper.Reader = sqlCommand.ExecuteReader();
            if (Helper.Reader.HasRows)
            {
                while (Helper.Reader.Read())
                {
                    comboCategory.Items.Add((string)Helper.Reader["CategoryName"]);
                    
                }
            }
          
            comboSort.SelectedIndex = 0;
            comboSkidka.SelectedIndex = 0;
            comboCategory.SelectedIndex = 0;
            Helper.Reader.Close();
            ShowProduct();


            if (UserClass.NameRole == "Менеджер" || UserClass.NameRole == "Клиент")
            {
                dataGridProduct.ContextMenuStrip = contextMenuStripOrder;
                exictsOrder = false;
              
                orders = new List<Order>();

            }
            else
            {
                dataGridProduct.ContextMenuStrip = null;

            }

        }
        private void buttonAddProduct_Click_1(object sender, EventArgs e)//Добавление товара
        {
            clearProductDataBase();
            formEditingProduct editingProduct = new formEditingProduct();
            editingProduct.buttonSaveEditing.Text = "Добавить";
            editingProduct.buttonSaveEditing.Tag = "ДобавитьТовар";
            editingProduct.buttonDeleteProduct.Enabled = false;
            this.Hide();
            editingProduct.Show();
        }

     
        private void dataGridProduct_DoubleClick(object sender, EventArgs e)//Выбор товара
        {
            if(UserClass.NameRole== "Администратор")
            {           
                
                formEditingProduct formEditing = new formEditingProduct();
               formEditing.textBoxProductArticleNumber.Enabled = false;
                formEditing.Show();
                this.Close();
            }
            
        }

        private void dataGridProduct_CellClick(object sender, DataGridViewCellEventArgs e)//Выбор товара
        {
            try
            {
                if (UserClass.NameRole == "Администратор")
                {
                    if (e.ColumnIndex == 2)
                    {
                        ProductClass.ProductArticleNumber = dataGridProduct.Rows[e.RowIndex].Cells[e.ColumnIndex - 2].Value.ToString();

                    }
                    else
                    {
                        ProductClass.ProductArticleNumber = dataGridProduct.Rows[e.RowIndex].Cells[e.ColumnIndex - 1].Value.ToString();
                    }
                }
            }
            catch (System.ArgumentOutOfRangeException)
            {

            }
           
        }

        private void textFind_TextChanged_1(object sender, EventArgs e)
        {          
            string search = textFind.Text;

             sqlSearchString = " AND [Product].ProductName LIKE '%" + search + "%'";
           

            ShowProduct();
        }

        private void dataGridProduct_CellMouseClick(object sender, DataGridViewCellMouseEventArgs e)//Заказы
        {
            rowProduct = e.RowIndex;
            if (e.Button == MouseButtons.Right)
            {
                try
                {
                    if (UserClass.NameRole == "Менеджер"|| UserClass.NameRole == "Клиент")
                    {
                        if (e.ColumnIndex == 2)
                        {
                            ProductClass.ProductArticleNumber = dataGridProduct.Rows[e.RowIndex].Cells[e.ColumnIndex - 2].Value.ToString();

                        }
                        else
                        {
                            ProductClass.ProductArticleNumber = dataGridProduct.Rows[e.RowIndex].Cells[e.ColumnIndex - 1].Value.ToString();
                        }
                        
                        dataGridProduct.ContextMenuStrip = contextMenuStripOrder;
                        
                    }
                    else
                    {
                        dataGridProduct.ContextMenuStrip = null;

                    }
                }
                catch (System.ArgumentOutOfRangeException)
                {

                }
            }
        }

        private void добавитьТоварToolStripMenuItem_Click(object sender, EventArgs e)
        {

            string article = dataGridProduct.Rows[rowProduct].Cells[0].Value.ToString();
           
            int index = orders.FindIndex(x => x.productArticleNumber == article);
            if (index < 0)
            {

                Order product = new Order();
                product.productArticleNumber = article;
                DataOrders(article);

                product.productCount = 1;
                product.productName = ProductClass.ProductName;
                product.productDescription = ProductClass.ProductDescription;
                product.productCategoryID = ProductClass.ProductCategoryID;
                product.productPhoto = ProductClass.ProductPhoto;
                product.productManufacturerID = ProductClass.ProductManufacturerID;
                product.productCost = ProductClass.ProductCost;
                product.productDiscountNow = ProductClass.ProductDiscountNow;
                product.productQuantityInStock = ProductClass.ProductQuantityInStock;
                product.productProviderID = ProductClass.ProductProviderID;
                product.productProviderID = ProductClass.ProductProviderID;



                orders.Add(product);
                
                buttonOrder.Visible = true;

            }
            else
            {
                orders[index].productCount++;
            }
            dataGridProduct.ContextMenuStrip = null;

        }

        void DataOrders(string a)
        {
            string photo;
            Bitmap bitmap;
            string sqlOrderProduct = $"Select * From[dbo].[Product],[dbo].[Manufacturer]  Where[dbo].[Product].ProductManufacturerID =[Manufacturer].ManufacturerID AND ProductArticleNumber = '{a}'";
            Helper.Command = new SqlCommand(sqlOrderProduct, Helper.connection);

            Helper.Reader = Helper.Command.ExecuteReader();

            if (Helper.Reader.HasRows)
            {
                while (Helper.Reader.Read())
                {
                                  
                    ProductClass.ProductName = (string)Helper.Reader["ProductName"];                   
                    ProductClass.ProductDescription= (string)Helper.Reader["ProductDescription"];
                    ProductClass.ProductCategoryID=(int)Helper.Reader["ProductCategoryID"];

                    ProductClass.ProductPhoto = (string)Helper.Reader["ProductPhoto"];
                    if (String.IsNullOrEmpty(ProductClass.ProductPhoto))
                    {
                        bitmap = Properties.Resources.pentagram;
                    }
                    else
                    {
                        fullPhoto = path + "\\Товар\\" + ProductClass.ProductPhoto;
                        if (File.Exists(fullPhoto))
                        {
                            bitmap = new Bitmap(fullPhoto);
                        }
                        else
                        {
                            bitmap = Properties.Resources.pentagram;
                        }
                    }
                    ProductClass.ProductManufacturerID= (int)Helper.Reader["ProductManufacturerID"];
                    ProductClass.ProductCost = (decimal)Helper.Reader["ProductCost"];
                    ProductClass.ProductDiscountNow = (byte)Helper.Reader["ProductDiscountNow"];
                    ProductClass.ProductQuantityInStock = (int)Helper.Reader["ProductQuantityInStock"];
                    ProductClass.ProductProviderID= (int)Helper.Reader["ProductProviderID"];
                    ProductClass.ProductUnitID= (int)Helper.Reader["ProductUnitID"];
                                       
                }

            }
            Helper.Reader.Close();
        }
        private void buttonOrder_Click(object sender, EventArgs e)
        {
            formOrder form = new formOrder(orders);
            this.Hide();
            form.ShowDialog();
            this.Show();
        }

        private void buttonClose_Click(object sender, EventArgs e)
        {
            Helper.connection.Close();
            formAuthorization formAuthorization = new formAuthorization();
            formAuthorization.Show();
           
            this.Close();
        }
    
        void clearProductDataBase()
        {
            ProductClass.ProductArticleNumber = null;
            ProductClass.ProductName=null;
            ProductClass.ProductDescription = null;
            ProductClass.ProductCategoryID = 0;
            ProductClass.ProductPhoto = null;
            ProductClass.ProductManufacturerID = 0;
            ProductClass.ProductCost = 0;
            ProductClass.ProductDiscountMax = 0;
            ProductClass.ProductDiscountNow = 0;
            ProductClass.ProductQuantityInStock = 0;
            ProductClass.ProductProviderID = 0;
            ProductClass.ProductUnitID = 0;
        }
    }
}
