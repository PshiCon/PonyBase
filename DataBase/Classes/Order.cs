using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataBase
{
    public class Order
    {

        public string productArticleNumber;
        public string productName;
        public int productCount;
        public string productDescription;     
        public int productCategoryID;
        public string productPhoto;
        public int productManufacturerID;
        public decimal productCost;
        public Byte productDiscountNow;
        public int productQuantityInStock;
        public int productProviderID;

        //Word
        public int orderNomer;
        public DateTime orderDate;
        public DateTime orderDateDelivery;
        public string orderDelivery;



    }
}
