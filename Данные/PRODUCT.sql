USE [master]
GO
/****** Object:  Database [DataBase493]    Script Date: 12.10.2022 20:20:05 ******/
CREATE DATABASE [DataBase493]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DataBase', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\DataBase.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DataBase_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\DataBase_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DataBase493] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DataBase493].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DataBase493] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DataBase493] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DataBase493] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DataBase493] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DataBase493] SET ARITHABORT OFF 
GO
ALTER DATABASE [DataBase493] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DataBase493] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DataBase493] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DataBase493] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DataBase493] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DataBase493] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DataBase493] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DataBase493] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DataBase493] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DataBase493] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DataBase493] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DataBase493] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DataBase493] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DataBase493] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DataBase493] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DataBase493] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DataBase493] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DataBase493] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DataBase493] SET  MULTI_USER 
GO
ALTER DATABASE [DataBase493] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DataBase493] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DataBase493] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DataBase493] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DataBase493] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DataBase493] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [DataBase493] SET QUERY_STORE = OFF
GO
USE [DataBase493]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 12.10.2022 20:20:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manufacturer]    Script Date: 12.10.2022 20:20:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manufacturer](
	[ManufacturerID] [int] NOT NULL,
	[ManufacturerName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Manufacturer] PRIMARY KEY CLUSTERED 
(
	[ManufacturerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 12.10.2022 20:20:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductArticleNumber] [nvarchar](100) NOT NULL,
	[ProductName] [nvarchar](max) NOT NULL,
	[ProductDescription] [nvarchar](max) NULL,
	[ProductCategoryID] [int] NOT NULL,
	[ProductPhoto] [nvarchar](100) NULL,
	[ProductManufacturerID] [int] NOT NULL,
	[ProductCost] [decimal](19, 4) NOT NULL,
	[ProductDiscountMax] [tinyint] NOT NULL,
	[ProductDiscountNow] [tinyint] NOT NULL,
	[ProductQuantityInStock] [int] NOT NULL,
	[ProductProviderID] [int] NOT NULL,
	[ProductUnitID] [int] NOT NULL,
 CONSTRAINT [PK__Product__2EA7DCD5CC15800B] PRIMARY KEY CLUSTERED 
(
	[ProductArticleNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Provider]    Script Date: 12.10.2022 20:20:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provider](
	[ProviderID] [int] NOT NULL,
	[ProviderName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Provider] PRIMARY KEY CLUSTERED 
(
	[ProviderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 12.10.2022 20:20:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK__Role__8AFACE3A7D9D423B] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Unit]    Script Date: 12.10.2022 20:20:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Unit](
	[UnitID] [int] NOT NULL,
	[UnitName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Unit] PRIMARY KEY CLUSTERED 
(
	[UnitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 12.10.2022 20:20:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserSurname] [nvarchar](100) NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[UserPatronymic] [nvarchar](100) NOT NULL,
	[UserLogin] [nvarchar](max) NOT NULL,
	[UserPassword] [nvarchar](max) NOT NULL,
	[UserRole] [int] NOT NULL,
 CONSTRAINT [PK__User__1788CCAC5AB8491E] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (1, N'вилки')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (2, N'ложки')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (3, N'наборы')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (4, N'ножи')
GO
INSERT [dbo].[Manufacturer] ([ManufacturerID], [ManufacturerName]) VALUES (1, N'Davinci')
INSERT [dbo].[Manufacturer] ([ManufacturerID], [ManufacturerName]) VALUES (2, N'Attribute')
INSERT [dbo].[Manufacturer] ([ManufacturerID], [ManufacturerName]) VALUES (3, N'Doria')
INSERT [dbo].[Manufacturer] ([ManufacturerID], [ManufacturerName]) VALUES (4, N'Alaska')
INSERT [dbo].[Manufacturer] ([ManufacturerID], [ManufacturerName]) VALUES (5, N'Apollo')
INSERT [dbo].[Manufacturer] ([ManufacturerID], [ManufacturerName]) VALUES (6, N'Smart Home')
INSERT [dbo].[Manufacturer] ([ManufacturerID], [ManufacturerName]) VALUES (7, N'Mayer & Boch')
GO
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'B736H6', N'Вилка столовая', N'Вилка столовая 21,2 см «Аляска бэйсик» сталь KunstWerk', 2, N'B736H6.jpg', 4, CAST(220.0000 AS Decimal(19, 4)), 5, 3, 4, 1, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'B963H5', N'Ложка', N'Ложка 21 мм металлическая (медная) (Упаковка 10 шт)', 2, N'', 6, CAST(800.0000 AS Decimal(19, 4)), 5, 3, 8, 1, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'C430T4', N'Набор на одну персону', N'Набор на одну персону (4 предмета) серия "Bistro", нерж. сталь, Was, Германия.', 3, N'', 2, CAST(1600.0000 AS Decimal(19, 4)), 30, 3, 6, 1, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'C635Y6', N'Детский столовый набор', N'Детский столовый набор Fissman «Зебра» ', 3, N'', 5, CAST(1000.0000 AS Decimal(19, 4)), 15, 4, 25, 2, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'C730R7', N'Ложка детская', N'Ложка детская столовая', 2, N'', 6, CAST(300.0000 AS Decimal(19, 4)), 5, 3, 17, 1, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'C943G5', N'Набор чайных ложек', N'Attribute Набор чайных ложек Baguette 3 предмета серебристый', 3, N'', 2, CAST(200.0000 AS Decimal(19, 4)), 5, 4, 12, 2, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'C946Y6', N'Вилка столовая', N'Вилка детская столовая', 2, N'', 5, CAST(300.0000 AS Decimal(19, 4)), 15, 2, 16, 1, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'D735T5', N'Ложка чайная', N'Ложка чайная ALASKA Eternum', 2, N'D735T5.jpg', 4, CAST(220.0000 AS Decimal(19, 4)), 5, 2, 13, 1, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'E732R7', N'Набор столовых приборов', N'Набор столовых приборов Smart Home20 Black в подарочной коробке, 4 шт', 3, N'E732R7.jpg', 6, CAST(990.0000 AS Decimal(19, 4)), 15, 5, 6, 2, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'F392G6', N'Набор столовых приборов', N'Apollo Набор столовых приборов Chicago 4 предмета серебристый', 3, N'', 5, CAST(490.0000 AS Decimal(19, 4)), 10, 4, 9, 1, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'F573T5', N'Bилки столовые', N'Bилки столовые на блистере / 6 шт.', 2, N'F573T5.jpg', 1, CAST(650.0000 AS Decimal(19, 4)), 15, 3, 4, 2, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'F745K4', N'Столовые приборы для салата', N'Столовые приборы для салата Orskov Lava, 2шт', 3, N'', 7, CAST(2000.0000 AS Decimal(19, 4)), 10, 3, 2, 1, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'F839R6', N'Ложка чайная', N'Ложка чайная DORIA Eternum', 2, N'', 3, CAST(400.0000 AS Decimal(19, 4)), 15, 2, 6, 2, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'G304H6', N'Набор ложек', N'Набор ложек столовых APOLLO "Bohemica" 3 пр.', 2, N'', 5, CAST(500.0000 AS Decimal(19, 4)), 5, 4, 12, 2, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'G387Y6', N'Ложка столовая', N'Ложка столовая DORIA L=195/60 мм Eternum', 2, N'G387Y6.jpg', 3, CAST(441.0000 AS Decimal(19, 4)), 5, 4, 23, 2, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'H384H3', N'Набор столовых приборов', N'Набор столовых приборов для торта Palette 7 предметов серебристый', 3, N'H384H3.jpg', 5, CAST(600.0000 AS Decimal(19, 4)), 15, 2, 9, 2, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'H495H6', N'Набор стейковых ножей', N'Набор стейковых ножей 4 пр. в деревянной коробке', 4, N'', 7, CAST(7000.0000 AS Decimal(19, 4)), 15, 2, 15, 1, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'K437E6', N'Набор вилок', N'Набор вилок столовых APOLLO "Aurora" 3шт.', 3, N'K437E6.jpg', 5, CAST(530.0000 AS Decimal(19, 4)), 5, 3, 16, 2, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'L593H5', N'набор ножей', N'Набор ножей Mayer & Boch, 4 шт', 3, N'', 7, CAST(1300.0000 AS Decimal(19, 4)), 25, 5, 14, 2, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'N493G6', N'Набор для серверовки', N'Набор для сервировки сыра Select', 3, N'', 6, CAST(2550.0000 AS Decimal(19, 4)), 15, 4, 6, 1, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'R836H6', N'Набор  столовых ножей', N'Attribute Набор столовых ножей Baguette 2 предмета серебристый', 4, N'R836H6.jpg', 2, CAST(250.0000 AS Decimal(19, 4)), 5, 3, 16, 1, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'S394J5', N'Набор чайных ложек', N'Attribute Набор чайных ложек Chaplet 3 предмета серебристый', 3, N'', 2, CAST(170.0000 AS Decimal(19, 4)), 5, 3, 4, 1, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'S395B5', N'Нож для стейка', N'Нож для стейка 11,5 см серебристый/черный', 4, N'', 5, CAST(600.0000 AS Decimal(19, 4)), 10, 4, 15, 1, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'T793T4', N'Набор ложек', N'Набор столовых ложек Baguette 3 предмета серебристый', 2, N'T793T4.jpg', 2, CAST(250.0000 AS Decimal(19, 4)), 10, 3, 16, 1, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'V026J4', N'набор ножей', N'абор ножей для стейка и пиццы Swiss classic 2 шт. желтый', 3, N'', 5, CAST(700.0000 AS Decimal(19, 4)), 15, 3, 9, 2, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'V403G6', N'Ложка чайная', N'Ложка чайная DORIA Eternum', 2, N'', 3, CAST(600.0000 AS Decimal(19, 4)), 15, 5, 24, 2, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'V727Y6', N'Набор десертных ложек', N'Набор десертных ложек на подставке Размер: 7*7*15 см', 2, N'', 7, CAST(3000.0000 AS Decimal(19, 4)), 10, 4, 8, 1, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'W295Y5', N'Сервировочный набор для торта', N'Набор сервировочный для торта "Розанна"', 3, N'', 2, CAST(1100.0000 AS Decimal(19, 4)), 15, 2, 16, 2, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'W405G6', N'Набор столовых приборов', N'Набор сервировочных столовых вилок Цветы', 3, N'', 2, CAST(1300.0000 AS Decimal(19, 4)), 25, 3, 4, 1, 1)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategoryID], [ProductPhoto], [ProductManufacturerID], [ProductCost], [ProductDiscountMax], [ProductDiscountNow], [ProductQuantityInStock], [ProductProviderID], [ProductUnitID]) VALUES (N'А112Т4', N'Набор вилок', N'Набор столовых вилок Davinci, 20 см 6 шт.', 1, N'А112Т4.jpg', 1, CAST(1600.0000 AS Decimal(19, 4)), 30, 2, 6, 2, 1)
GO
INSERT [dbo].[Provider] ([ProviderID], [ProviderName]) VALUES (1, N'LeroiMerlin')
INSERT [dbo].[Provider] ([ProviderID], [ProviderName]) VALUES (2, N'Максидом')
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (1, N'Клиент')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (2, N'Менеджер')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (3, N'Администратор')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
INSERT [dbo].[Unit] ([UnitID], [UnitName]) VALUES (1, N'шт')
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (1, N'Сергей', N'Пантелеймонович', N'Ефремов ', N'loginDEppn2018', N'6}i+FD', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (2, N'Тамара', N'Валентиновна', N'Родионова ', N'loginDElqb2018', N'RNynil', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (3, N'Галина', N'Улебовна', N'Миронова ', N'loginDEydn2018', N'34I}X9', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (4, N'Роман', N'Иринеевич', N'Сидоров ', N'loginDEijg2018', N'4QlKJW', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (5, N'Парфений', N'Всеволодович', N'Ситников ', N'loginDEdpy2018', N'MJ0W|f', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (6, N'Роман', N'Геласьевич', N'Никонов ', N'loginDEwdm2018', N'&PynqU', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (7, N'Владимир', N'Матвеевич', N'Щербаков ', N'loginDEdup2018', N'JM+2{s', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (8, N'Мартын', N'Михаилович', N'Кулаков ', N'loginDEhbm2018', N'9aObu4', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (9, N'Оксана', N'Лаврентьевна', N'Сазонова ', N'loginDExvq2018', N'hX0wJz', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (10, N'Варлам', N'Мэлорович', N'Архипов ', N'loginDErks2018', N'LQNSjo', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (11, N'Ираида', N'Мэлоровна', N'Устинова ', N'loginDErvb2018', N'ceAf&R', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (12, N'Георгий', N'Альбертович', N'Лукин ', N'loginDEulo2018', N'ceAfwR', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (13, N'Эдуард', N'Валентинович', N'Кононов ', N'loginDEgfw2018', N'3c2Ic1', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (14, N'Клавдия', N'Альбертовна', N'Орехова ', N'loginDEmxb2018', N'ZPXcRS', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (15, N'Яков', N'Эдуардович', N'Яковлев ', N'loginDEgeq2018', N'&&Eim0', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (16, N'Мэлс', N'Семёнович', N'Воронов ', N'loginDEkhj2018', N'Pbc0t{', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (17, N'Ия', N'Данииловна', N'Вишнякова ', N'loginDEliu2018', N'32FyTl', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (18, N'Фёдор', N'Вадимович', N'Третьяков ', N'loginDEsmf2018', N'{{O2QG', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (19, N'Максим', N'Ильяович', N'Макаров ', N'loginDEutd2018', N'GbcJvC', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (20, N'Маргарита', N'Анатольевна', N'Шубина ', N'loginDEpgh2018', N'YV2lvh', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (21, N'Ангелина', N'Владленовна', N'Блинова ', N'loginDEvop2018', N'pBP8rO', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (22, N'Владлен', N'Фролович', N'Воробьёв ', N'loginDEwjo2018', N'EQaD|d', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (23, N'Прасковья', N'Фёдоровна', N'Сорокина ', N'loginDEbur2018', N'aZKGeI', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (24, N'Яков', N'Антонович', N'Давыдов ', N'loginDEszw2018', N'EGU{YE', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (25, N'Евдокия', N'Анатольевна', N'Рыбакова ', N'loginDExsu2018', N'*2RMsp', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (26, N'Геннадий', N'Фролович', N'Маслов ', N'loginDEztn2018', N'nJBZpU', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (27, N'Элеонора', N'Аристарховна', N'Цветкова ', N'loginDEtmn2018', N'UObB}N', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (28, N'Ростислав', N'Александрович', N'Евдокимов ', N'loginDEhep2018', N'SwRicr', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (29, N'Венера', N'Станиславовна', N'Никонова ', N'loginDEevr2018', N'zO5l}l', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (30, N'Егор', N'Антонович', N'Громов ', N'loginDEnpa2018', N'M*QLjf', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (31, N'Валерия', N'Борисовна', N'Суворова ', N'loginDEgyt2018', N'Pav+GP', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (32, N'Елизавета', N'Романовна', N'Мишина ', N'loginDEbrr2018', N'Z7L|+i', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (33, N'Ольга', N'Аркадьевна', N'Зимина ', N'loginDEyoo2018', N'UG1BjP', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (34, N'Игнатий', N'Антонинович', N'Игнатьев ', N'loginDEaob2018', N'3fy+3I', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (35, N'Зинаида', N'Витальевна', N'Пахомова ', N'loginDEwtz2018', N'&GxSST', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (36, N'Владимир', N'Федосеевич', N'Устинов ', N'loginDEctf2018', N'sjt*3N', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (37, N'Мэлор', N'Вячеславович', N'Кулаков ', N'loginDEipm2018', N'MAZl6|', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (38, N'Авксентий', N'Брониславович', N'Сазонов ', N'loginDEjoi2018', N'o}C4jv', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (39, N'Наина', N'Брониславовна', N'Бурова ', N'loginDEwap2018', N'4hny7k', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (40, N'Демьян', N'Федосеевич', N'Фадеев ', N'loginDEaxm2018', N'BEc3xq', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (41, N'Дарья', N'Якуновна', N'Бобылёва ', N'loginDEsmq2018', N'ATVmM7', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (42, N'Созон', N'Арсеньевич', N'Виноградов ', N'loginDEeur2018', N'n4V{wP', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (43, N'Владлен', N'Ефимович', N'Гордеев ', N'loginDEvke2018', N'WQLXSl', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (44, N'Зинаида', N'Зинаида', N'Иванова ', N'loginDEvod2018', N'0EW93v', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (45, N'Руслан', N'Дамирович', N'Гусев ', N'loginDEjaw2018', N'h6z&Ky', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (46, N'Дмитрий', N'Иванович', N'Маслов ', N'loginDEpdp2018', N'8NvRfC', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (47, N'Ульяна', N'Семёновна', N'Антонова ', N'loginDEjpp2018', N'oMOQq3', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (48, N'Людмила', N'Владимировна', N'Орехова ', N'loginDEkiy2018', N'BQzsts', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (49, N'Жанна', N'Куприяновна', N'Авдеева ', N'loginDEhmn2018', N'a|Iz|7', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (50, N'Фрол', N'Варламович', N'Кузнецов ', N'loginDEfmn2018', N'cw3|03', 1)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([ProductCategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Manufacturer] FOREIGN KEY([ProductManufacturerID])
REFERENCES [dbo].[Manufacturer] ([ManufacturerID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Manufacturer]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Provider] FOREIGN KEY([ProductProviderID])
REFERENCES [dbo].[Provider] ([ProviderID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Provider]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Unit] FOREIGN KEY([ProductUnitID])
REFERENCES [dbo].[Unit] ([UnitID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Unit]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK__User__UserRole__4BAC3F29] FOREIGN KEY([UserRole])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK__User__UserRole__4BAC3F29]
GO
/****** Object:  Statistic [PK_Category]    Script Date: 12.10.2022 20:20:05 ******/
UPDATE STATISTICS [dbo].[Category]([PK_Category]) WITH STATS_STREAM = 0x01000000010000000000000000000000ED0358EE0000000040000000000000000000000000000000380300003800000004000A00000000000000000000000000, ROWCOUNT = 4, PAGECOUNT = 1
GO
/****** Object:  Statistic [PK_Manufacturer]    Script Date: 12.10.2022 20:20:05 ******/
UPDATE STATISTICS [dbo].[Manufacturer]([PK_Manufacturer]) WITH STATS_STREAM = 0x01000000010000000000000000000000ED0358EE0000000040000000000000000000000000000000380300003800000004000A00000000000000000000000000, ROWCOUNT = 7, PAGECOUNT = 1
GO
/****** Object:  Statistic [PK__Product__2EA7DCD5CC15800B]    Script Date: 12.10.2022 20:20:05 ******/
UPDATE STATISTICS [dbo].[Product]([PK__Product__2EA7DCD5CC15800B]) WITH STATS_STREAM = 0x01000000010000000000000000000000E1BD82760000000040000000000000000000000000000000E7030000E7000000C80000000000000015D0000038000000, ROWCOUNT = 30, PAGECOUNT = 1
GO
/****** Object:  Statistic [PK_Provider]    Script Date: 12.10.2022 20:20:05 ******/
UPDATE STATISTICS [dbo].[Provider]([PK_Provider]) WITH STATS_STREAM = 0x01000000010000000000000000000000A3D3C7DB0000000040000000000000000000000000000000380300003800000004000A00000000000000000038000000, ROWCOUNT = 2, PAGECOUNT = 1
GO
/****** Object:  Statistic [_WA_Sys_00000002_47DBAE45]    Script Date: 12.10.2022 20:20:05 ******/
CREATE STATISTICS [_WA_Sys_00000002_47DBAE45] ON [dbo].[Role]([RoleName]) WITH STATS_STREAM = 0x01000000010000000000000000000000D7204CC9000000002F02000000000000EF01000000000000E7030073E7000000C80000000000000015D0000000020000070000005BF3060125AF000001000000000000000100000000000000000000000000803F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000010000000100000010000000000040410000803F00000000000040410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000130400000000000000000000000000002B000000000000006B0000000000000073000000000000007B000000000000000800000000000000300010000000803F000000000000803F040000010023001A043B04380435043D044204FF0100000000000000010000000100000028000000280000000000000000000000060000001A043B04380435043D04420402000000400000000001060000000001000000000000000000000000000000
GO
/****** Object:  Statistic [PK__Role__8AFACE3A7D9D423B]    Script Date: 12.10.2022 20:20:05 ******/
UPDATE STATISTICS [dbo].[Role]([PK__Role__8AFACE3A7D9D423B]) WITH STATS_STREAM = 0x01000000010000000000000000000000A3D3C7DB0000000040000000000000000000000000000000380300003800000004000A00000000000000000038000000, ROWCOUNT = 3, PAGECOUNT = 1
GO
/****** Object:  Statistic [PK_Unit]    Script Date: 12.10.2022 20:20:05 ******/
UPDATE STATISTICS [dbo].[Unit]([PK_Unit]) WITH STATS_STREAM = 0x01000000010000000000000000000000A3D3C7DB0000000040000000000000000000000000000000380300003800000004000A00000000000000000038000000, ROWCOUNT = 1, PAGECOUNT = 1
GO
/****** Object:  Statistic [_WA_Sys_00000002_49C3F6B7]    Script Date: 12.10.2022 20:20:05 ******/
CREATE STATISTICS [_WA_Sys_00000002_49C3F6B7] ON [dbo].[User]([UserSurname]) WITH STATS_STREAM = 0x01000000010000000000000000000000443F24FE000000002F02000000000000EF01000000000000E7030073E7000000C80000000000000015D0000000020000070000005E24070125AF000001000000000000000100000000000000000000000000803F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000010000000100000010000000000040410000803F00000000000040410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000130400000000000000000000000000002B000000000000006B0000000000000073000000000000007B000000000000000800000000000000300010000000803F000000000000803F04000001002300210435044004330435043904FF01000000000000000100000001000000280000002800000000000000000000000600000021043504400433043504390402000000400000000001060000000001000000000000000000000000000000
GO
/****** Object:  Statistic [_WA_Sys_00000003_49C3F6B7]    Script Date: 12.10.2022 20:20:05 ******/
CREATE STATISTICS [_WA_Sys_00000003_49C3F6B7] ON [dbo].[User]([UserName]) WITH STATS_STREAM = 0x01000000010000000000000000000000BF7727800000000053020000000000001302000000000000E7030000E7000000C80000000000000015D0000000000000070000005D24070125AF000001000000000000000100000000000000000000000000803F0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000100000001000000100000000000F0410000803F000000000000F0410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000130400000000000000000000000000003D000000000000008F0000000000000097000000000000009F000000000000000800000000000000300010000000803F000000000000803F040000010035001F0430043D04420435043B04350439043C043E043D043E04320438044704FF01000000000000000100000001000000280000002800000000000000000000000F0000001F0430043D04420435043B04350439043C043E043D043E04320438044704020000004000000000010F0000000001000000000000000000000000000000
GO
/****** Object:  Statistic [_WA_Sys_00000004_49C3F6B7]    Script Date: 12.10.2022 20:20:05 ******/
CREATE STATISTICS [_WA_Sys_00000004_49C3F6B7] ON [dbo].[User]([UserPatronymic]) WITH STATS_STREAM = 0x010000000100000000000000000000000EF253FE000000003702000000000000F701000000000000E703D307E7000000C80000000000000015D0000000000000070000005C24070125AF000001000000000000000100000000000000000000000000803F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000010000000100000010000000000080410000803F00000000000080410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000130400000000000000000000000000002F0000000000000073000000000000007B0000000000000083000000000000000800000000000000300010000000803F000000000000803F0400000100270015044404400435043C043E0432042000FF01000000000000000100000001000000280000002800000000000000000000000800000015044404400435043C043E043204200002000000400000000001080000000001000000000000000000000000000000
GO
/****** Object:  Statistic [_WA_Sys_00000005_49C3F6B7]    Script Date: 12.10.2022 20:20:05 ******/
CREATE STATISTICS [_WA_Sys_00000005_49C3F6B7] ON [dbo].[User]([UserLogin]) WITH STATS_STREAM = 0x01000000010000000000000000000000B8268EB0000000004F020000000000000F02000000000000E7030000E7000000FFFF00000000000015D0000001000000070000005B24070125AF000001000000000000000100000000000000000000000000803F0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000100000001000000100000000000E0410000803F000000000000E0410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000130400000000000000000000000000003B000000000000008B0000000000000093000000000000009B000000000000000800000000000000300010000000803F000000000000803F040000010033006C006F00670069006E0044004500700070006E003200300031003800FF01000000000000000100000001000000280000002800000000000000000000000E0000006C006F00670069006E0044004500700070006E003200300031003800020000004000000000010E0000000001000000000000000000000000000000
GO
/****** Object:  Statistic [_WA_Sys_00000006_49C3F6B7]    Script Date: 12.10.2022 20:20:05 ******/
CREATE STATISTICS [_WA_Sys_00000006_49C3F6B7] ON [dbo].[User]([UserPassword]) WITH STATS_STREAM = 0x0100000001000000000000000000000032529F01000000002F02000000000000EF01000000000000E703D307E7000000FFFF00000000000015D0000000000000070000005824070125AF000001000000000000000100000000000000000000000000803F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000010000000100000010000000000040410000803F00000000000040410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000130400000000000000000000000000002B000000000000006B0000000000000073000000000000007B000000000000000800000000000000300010000000803F000000000000803F0400000100230036007D0069002B0046004400FF01000000000000000100000001000000280000002800000000000000000000000600000036007D0069002B004600440002000000400000000001060000000001000000000000000000000000000000
GO
/****** Object:  Statistic [_WA_Sys_00000007_49C3F6B7]    Script Date: 12.10.2022 20:20:05 ******/
CREATE STATISTICS [_WA_Sys_00000007_49C3F6B7] ON [dbo].[User]([UserRole]) WITH STATS_STREAM = 0x010000000100000000000000000000001AF683E900000000DB010000000000009B010000000000003803D3073800000004000A00000000000000000000000000070000005524070125AF000001000000000000000100000000000000000000000000803F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000010000000100000014000000000080400000803F00000000000080400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110400000000000000000000000000001F0000000000000027000000000000002F000000000000000800000000000000100014000000803F000000000000803F0100000004000001000000000000000000000000000000
GO
/****** Object:  Statistic [PK__User__1788CCAC5AB8491E]    Script Date: 12.10.2022 20:20:05 ******/
UPDATE STATISTICS [dbo].[User]([PK__User__1788CCAC5AB8491E]) WITH STATS_STREAM = 0x01000000010000000000000000000000129B9B0B0000000040000000000000000000000000000000380383D73800000004000A00000000000000000000000001, ROWCOUNT = 50, PAGECOUNT = 1
GO
USE [master]
GO
ALTER DATABASE [DataBase493] SET  READ_WRITE 
GO
