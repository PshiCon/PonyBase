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
//using Microsoft.Office.Interop.Word;

namespace DataBase
{

    public partial class formOrder : Form
    {
        Word.Application wordApp;
        Word.Document wordDoc;
        Word.Paragraph wordPar;
        Word.Range wordRange;

        static List<Order> list;

        string path = Application.StartupPath;
        string fullPhoto;
        Bitmap bitmap;
        string NamePicter;
        decimal summaProduct = 0;
        byte summaDiscoun = 0;

        int count;
        int userID;
        string a, b;

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
           
            for (int i = 0; i < list.Count; i++)
            {

                summaProduct = summaProduct + (list[i].productCost);
                 summaDiscoun = (byte)(summaDiscoun + list[i].productDiscountNow * list[i].productCount);

            }
            textBoxDecriptionOrder.Text = "Всего товаров: " + list.Count+ Environment.NewLine;           
            textBoxDecriptionOrder.Text += "Общая сумма товаров: "+ summaProduct + Environment.NewLine;
            textBoxDecriptionOrder.Text += "Общая сумма скидки: "+ summaDiscoun + Environment.NewLine;
            textBoxDecriptionOrder.Text += "Общая сумма за весь товар со скидкой: " + (summaProduct - (summaProduct * summaDiscoun) / 100 + Environment.NewLine);

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
       
        private void buttonCreateOrder_Click(object sender, EventArgs e)//Оформить заказ
        {
            if(comboBoxDelivery.SelectedIndex == -1)
            {
                MessageBox.Show("Вы не выбрали место доставки");
                return;
            }
            Random random = new Random();
            DateTime now= DateTime.Now;
            DateTime nowdelivery = DateTime.Now.AddDays(5);
             a= now.ToString("yyyy-MM-dd");
             b = nowdelivery.ToString("yyyy-MM-dd");

        
            int nomer=random.Next(100,999);
            MessageBox.Show("Код: " + nomer + Environment.NewLine 
                + "Дата создание: " + a + Environment.NewLine
                + "Дата получение: " + b );
           
            for (int i = 0; i < list.Count; i++)
            {
                list[i].orderNomer= nomer;
               
            }
            buttonSaveEditing.Enabled = true;

            }

        private void buttonSaveEditing_Click(object sender, EventArgs e)//Word талон
        {
            DataCount();
            DataUser();
            DataOrdern();
            try
            {
                wordApp = new Word.Application();
                wordApp.Visible = false;
            }
            catch
            {
                MessageBox.Show("Товарный чек в Word создать не удалось");
                return;
            }

            wordDoc = wordApp.Documents.Add();
            wordDoc.PageSetup.Orientation = Word.WdOrientation.wdOrientPortrait;
            
            wordDoc.Content.ParagraphFormat.Alignment = Word.WdParagraphAlignment.wdAlignParagraphLeft;

            Word.Paragraph paragraphPicter = wordDoc.Paragraphs.Add();
            Word.Range rangePicter = paragraphPicter.Range;
            wordDoc.Content.Font.Size = 14;
            Word.InlineShape wordPicter = wordDoc.InlineShapes.AddPicture(path + "\\Товар\\" + "D735T5.jpg", Range: wordApp.Selection.Range);
            wordPicter.Width = 70;
            wordPicter.Height = 70;
            rangePicter.Paragraphs.Alignment = Word.WdParagraphAlignment.wdAlignParagraphLeft;
            rangePicter.InsertParagraphAfter();

            Word.Paragraph paragraphTitle = wordDoc.Paragraphs.Add();
            Word.Range rangeTitle = paragraphTitle.Range;
            rangeTitle.Text = " Номер заказа: №" + list[0].orderNomer;
            rangeTitle.Font.Bold = 1;
            rangeTitle.Font.Size = 20;

            rangeTitle.Paragraphs.Alignment = Word.WdParagraphAlignment.wdAlignParagraphCenter;
            rangeTitle.InsertParagraphAfter();

            Word.Paragraph summa = wordDoc.Paragraphs.Add();
            Word.Range rangesumma = summa.Range;
            rangesumma.Text += "Дата заказа: " +a;
            rangesumma.Paragraphs.Alignment = Word.WdParagraphAlignment.wdAlignParagraphLeft;
            rangesumma.InsertParagraphAfter();
            
      
            wordPar = (Word.Paragraph)wordDoc.Paragraphs[1];    
            wordPar = wordDoc.Paragraphs.Add();
            wordRange = wordPar.Range;     


            Word.Table wordTable;
            wordTable = wordDoc.Tables.Add(wordRange, dataGridViewOrder.RowCount + 1, 2);
            wordTable.Borders.InsideLineStyle = Word.WdLineStyle.wdLineStyleSingle;
            wordTable.Borders.OutsideLineStyle = Word.WdLineStyle.wdLineStyleSingle;


             Word.Range cellRange;
             cellRange = wordTable.Cell(1, 1).Range; 
             cellRange.Text = "Товар";
             cellRange = wordTable.Cell(1, 2).Range;
             cellRange.Text = "Количество";
              for (int i = 0; i < list.Count; i++)       
              {
                  cellRange = wordTable.Cell(i+2, 1).Range; 
                  cellRange.Text = list[i].productName;

                   cellRange = wordTable.Cell(i + 2, 2).Range; 
                   cellRange.Text = list[i].productCount.ToString();
              }
            
            Word.Paragraph paragraphtext = wordDoc.Paragraphs.Add();
            Word.Range rangetext = paragraphtext.Range;
            rangetext.Text = "Сумма заказа: " + summaProduct + Environment.NewLine;
            rangetext.Text += "Сумма скидки: " + summaDiscoun + Environment.NewLine;
            rangetext.Text += "Пункт выдачи: " + comboBoxDelivery.Text + Environment.NewLine;
            rangetext.Text += "Дата получение: " + b;
            rangetext.Paragraphs.Alignment = Word.WdParagraphAlignment.wdAlignParagraphLeft;
            rangetext.InsertParagraphAfter();

            ///
            wordDoc.Saved = true;
           
            string pathDoc = path +  "\\Word\\" +"test";
            wordDoc.SaveAs(pathDoc + ".docx");
           
            wordDoc.SaveAs(pathDoc + ".pdf", Word.WdExportFormat.wdExportFormatPDF);
            wordDoc.Close(true, null, null);
            wordDoc = null;
            MessageBox.Show("Талон создан");
            System.Runtime.InteropServices.Marshal.FinalReleaseComObject(wordApp);
            GC.Collect();


        }
        void DataUser()
        {
            Helper.Reader.Close();
            string sqlCount = $"SELECT * FROM [dbo].[User] WHERE UserLogin ='{UserClass.UserLogin}'";
            Helper.Command = new SqlCommand(sqlCount, Helper.connection);

            Helper.Reader = Helper.Command.ExecuteReader();
            if (Helper.Reader.HasRows)
            {
                while (Helper.Reader.Read())
                {
                    userID = (int)Helper.Reader["UserID"];

                }
            }
        }
        void DataCount()
        {
            Helper.Reader.Close();
            string sqlCount = $"SELECT * FROM [dbo].[Order] WHERE [OrderID]=(SELECT max(OrderID)FROM [Order])";
            Helper.Command = new SqlCommand(sqlCount, Helper.connection);
              
            Helper.Reader = Helper.Command.ExecuteReader();
            if (Helper.Reader.HasRows)
            {
                while (Helper.Reader.Read())
                {
                    count = (int)Helper.Reader["OrderID"];

                }
            }
           
            Helper.Reader.Close();
        }
        void DataOrdern()
        {
            string sqlTalonOrden = $"Insert Into [dbo].[Order] (OrderDate,OrderDeliveryDate,OrderPickupPointID,OrderStatusID,OrderClient,OrderUniqueCode)" +
                $"Values({a}, {b}, " +
                $"{comboBoxDelivery.SelectedIndex + 1 }, 1,{userID}, {list[0].orderNomer})" + Environment.NewLine;
            for (int i = 0; i < list.Count; i++)
            {
                sqlTalonOrden += $" Insert Into [dbo].[OrderProduct] ([OrderID],[ProductArticleNumber],[ProductCount])" +
                $"Values({count+1}, '{list[i].productArticleNumber}', {list[i].productCount})";
            }
            Helper.Command = new SqlCommand(sqlTalonOrden, Helper.connection);

            Helper.Adapter.InsertCommand = Helper.Command;
            Helper.Reader.Close();
            int result = Helper.Adapter.InsertCommand.ExecuteNonQuery();
            if (result != 0)
            {
               
            }
            else
            {
                MessageBox.Show("ошибка");
            }
        }
    }
}
