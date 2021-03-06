USE [master]
GO
/****** Object:  Database [CountryCityInformationManagementSystemApp]    Script Date: 11-04-2016 04:25:09 ******/
CREATE DATABASE [CountryCityInformationManagementSystemApp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CountryCityInformationManagementSystemApp', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\CountryCityInformationManagementSystemApp.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CountryCityInformationManagementSystemApp_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\CountryCityInformationManagementSystemApp_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CountryCityInformationManagementSystemApp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET ARITHABORT OFF 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET  MULTI_USER 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'CountryCityInformationManagementSystemApp', N'ON'
GO
USE [CountryCityInformationManagementSystemApp]
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 11-04-2016 04:25:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[About] [nvarchar](max) NULL,
	[NoOfDwellers] [bigint] NULL,
	[Location] [nvarchar](50) NULL,
	[Weather] [nvarchar](50) NULL,
	[CountryId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Countries]    Script Date: 11-04-2016 04:25:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Countries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[About] [nvarchar](max) NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[CitiesView]    Script Date: 11-04-2016 04:25:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view  [dbo].[CitiesView]
as
Select  ci.Id, ci.Name, ci.About, ci.NoOfDwellers, ci.Location, 
ci.Weather, co.Name CountryName, co.About AboutCountry
from cities ci inner join Countries co 
On ci.CountryId = co.Id



GO
/****** Object:  View [dbo].[CityEntryView]    Script Date: 11-04-2016 04:25:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view  [dbo].[CityEntryView]
as
Select  ci.Id, ci.Name, ci.NoOfDwellers, co.Name CountryName  from cities ci inner join Countries co On ci.CountryId = co.Id


GO
/****** Object:  View [dbo].[CountriesView]    Script Date: 11-04-2016 04:25:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CountriesView]
AS
SELECT        c.Id, c.Name, c.About, COUNT(d.Id) AS NoOfCities, SUM(d.NoOfDwellers) AS NoOfDwellers
FROM            dbo.Countries AS c LEFT OUTER JOIN
                         dbo.Cities AS d ON c.Id = d.CountryId
GROUP BY c.Id, c.Name, c.About

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Cities]    Script Date: 11-04-2016 04:25:09 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Cities] ON [dbo].[Cities]
(
	[Name] ASC,
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Countries]    Script Date: 11-04-2016 04:25:09 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Countries] ON [dbo].[Countries]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cities]  WITH CHECK ADD  CONSTRAINT [FK_Cities_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[Cities] CHECK CONSTRAINT [FK_Cities_Countries]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "d"
            Begin Extent = 
               Top = 6
               Left = 262
               Bottom = 136
               Right = 448
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CountriesView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CountriesView'
GO
USE [master]
GO
ALTER DATABASE [CountryCityInformationManagementSystemApp] SET  READ_WRITE 
GO
