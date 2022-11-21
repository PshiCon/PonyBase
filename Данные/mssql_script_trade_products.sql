use [DataBase493]
go

create table Product
(
	ProductArticleNumber nvarchar(100) primary key,
	ProductName nvarchar(max) not null,
	ProductDescription nvarchar(max) ,
	ProductCategoryID int not null,
	ProductPhoto nvarchar(100) ,
	ProductManufacturerID int not null,
	ProductCost decimal(19,4) not null,
	ProductDiscountMax tinyint not null,
	ProductDiscountNow tinyint not  null,
	ProductQuantityInStock int not null,
	ProductProviderID int not null,
	ProductUnitID int not null,
	
)