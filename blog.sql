USE [master]
GO
/****** Object:  Database [Lab3]    Script Date: 10/26/2021 10:58:03 AM ******/
CREATE DATABASE [Lab3]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Lab3', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Lab3.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Lab3_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Lab3_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Lab3] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Lab3].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Lab3] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Lab3] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Lab3] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Lab3] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Lab3] SET ARITHABORT OFF 
GO
ALTER DATABASE [Lab3] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Lab3] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Lab3] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Lab3] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Lab3] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Lab3] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Lab3] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Lab3] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Lab3] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Lab3] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Lab3] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Lab3] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Lab3] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Lab3] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Lab3] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Lab3] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Lab3] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Lab3] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Lab3] SET  MULTI_USER 
GO
ALTER DATABASE [Lab3] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Lab3] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Lab3] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Lab3] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Lab3] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Lab3]
GO
/****** Object:  Table [dbo].[tblArticle]    Script Date: 10/26/2021 10:58:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblArticle](
	[articleID] [int] IDENTITY(1,1) NOT NULL,
	[articleTitle] [nvarchar](100) NULL,
	[articleShortDesc] [nvarchar](max) NULL,
	[articleContent] [nvarchar](max) NULL,
	[articleAuthor] [nvarchar](50) NULL,
	[articlePostingDate] [date] NULL,
	[articleStatus] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblArticle] PRIMARY KEY CLUSTERED 
(
	[articleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblArticleStatus]    Script Date: 10/26/2021 10:58:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblArticleStatus](
	[articleStatusID] [nvarchar](50) NOT NULL,
	[articleName] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblarticleStatus] PRIMARY KEY CLUSTERED 
(
	[articleStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblComment]    Script Date: 10/26/2021 10:58:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblComment](
	[commentID] [int] IDENTITY(1,1) NOT NULL,
	[articleID] [int] NULL,
	[commentContent] [nvarchar](250) NULL,
	[commentDate] [date] NULL,
	[commentStatus] [bit] NULL,
	[commentEmail] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblComment] PRIMARY KEY CLUSTERED 
(
	[commentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblRole]    Script Date: 10/26/2021 10:58:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRole](
	[roleID] [nvarchar](50) NOT NULL,
	[roleName] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblRole] PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblSenderEmail]    Script Date: 10/26/2021 10:58:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSenderEmail](
	[senderEmail] [nvarchar](50) NOT NULL,
	[senderPassword] [nvarchar](50) NULL,
	[senderStatus] [bit] NULL,
 CONSTRAINT [PK_tblSenderEmail] PRIMARY KEY CLUSTERED 
(
	[senderEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 10/26/2021 10:58:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[email] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NULL,
	[userName] [nvarchar](50) NULL,
	[roleID] [nvarchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[createDate] [date] NULL,
 CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[tblArticle] ON 

INSERT [dbo].[tblArticle] ([articleID], [articleTitle], [articleShortDesc], [articleContent], [articleAuthor], [articlePostingDate], [articleStatus]) VALUES (3, N'The International Group Stage', N'The Group Stage for The International 2021 starts in less than 24 hours when 18 teams face off for 16 spots at the Main Event.', N'<p><img src="https://cdn.cloudflare.steamstatic.com/steamcommunity/public/images/clans/3703047/a3a0b19b7e25c97584c764e62a113e7194010b49.png" /></p>

<p>The Group Stage for The International 2021 starts in less than 24 hours when 18 teams face off for 16 spots at the Main Event. Two groups of nine teams each will play in a full round robin&mdash;two games against each opponent in the group&mdash;with a trip to the main stage hanging in the balance. The top four teams in each group advance directly to the winner&#39;s bracket in the Main Event. The next four must battle through the loser&#39;s bracket. And the lowest placed team in each group will be eliminated from the event. All teams deserve the recognition of earning their place in this fight, and we wish each of the competitors the best of luck.</p>

<p>Group A</p>

<ul>
	<li>Alliance</li>
	<li>Team Aster</li>
	<li>Evil Geniuses</li>
	<li>Invictus Gaming</li>
	<li>OG</li>
	<li>T1</li>
	<li>Thunder Predator</li>
	<li>Undying</li>
	<li>Virtus.Pro</li>
</ul>

<p>Group B</p>

<ul>
	<li>Beastcoast</li>
	<li>Elephant</li>
	<li>Fnatic</li>
	<li>PSG.LGD</li>
	<li>Quincy Crew</li>
	<li>SG Esports</li>
	<li>Team Secret</li>
	<li>Team Spirit</li>
	<li>Vici Gaming</li>
</ul>

<p>See <a href="https://www.dota2.com/esports/ti10/schedule" target="_blank">www.dota2.com/esports/ti10/schedule</a> for the full schedule.</p>
', N'lutrantungloc9.1@gmail.com', CAST(N'2021-10-19' AS Date), N'A')
INSERT [dbo].[tblArticle] ([articleID], [articleTitle], [articleShortDesc], [articleContent], [articleAuthor], [articlePostingDate], [articleStatus]) VALUES (4, N'Battle Level Bundle', N'The Nemestice 2021 Battle Level Bundle has arrived, bringing with it the opportunity for Battle Pass customers to advance further along the rewards line at a steep discount.', N'<p><img src="https://cdn.cloudflare.steamstatic.com/steamcommunity/public/images/clans/3703047/6d770df6bdf385488fd924ce38f3c128b6aa184e.jpg" /></p>

<p>The Nemestice 2021 Battle Level Bundle has arrived, bringing with it the opportunity for Battle Pass customers to advance further along the rewards line at a steep discount. Each bundle purchase contains 60 Battle Levels, 6 Nemestice Immortal Treasures, and 3 Nemestice Themed Treasures, all for $14.99 each--a 70% savings on the combined value of the levels and treasures. Each Battle Pass owner is able to buy up to two bundles.</p>

<p>This bundle is a great chance to earn many of the rewards within the Battle Pass, including the Davion Dragon Knight persona at Level 195, the Kid Invoker Dark Artistry set at Level 275, and the Phantom Advent Spectre Arcana at level 330. Now is the time to boost your Battle Level, as this bundle will only be available through the weekend, ending Monday, August 9th. In other news, Gameplay Patch 7.30 will be arriving after the Battle Pass ends. We&#39;re working on it.</p>
', N'lutrantungloc9.1@gmail.com', CAST(N'2021-10-19' AS Date), N'A')
INSERT [dbo].[tblArticle] ([articleID], [articleTitle], [articleShortDesc], [articleContent], [articleAuthor], [articlePostingDate], [articleStatus]) VALUES (5, N'Simple Blog', N'You want to build a simple blog. It is a place for member to post their articles, and interact between members through the comment function on each article', N'<p>This system contains the following functions:</p><p>- Function 1: Registration &ndash; 50 points o Registration a new account: email, name, password, role, status (email as ID). o The default role of new account is member. o The default status of new account is New. o Password must be encrypted using SHA-256 before store in database.</p><p>- Function 2: Login &ndash; 50 Points o The actor enters ID and password, the function checks if the ID with the password is in the available account list, then grant the access permission. If not, a message would appear no notify that account is not found. o Login function includes logout and welcome functions.</p><p>- Function 3: Article Search &ndash; 50 Points o List the available article in the system and sort by date: tittle, shortDescription, author, date. o Each page has a maximum of 20 records displayed. Paging is required to use. o User inputs the text that they want to find and click the Search button or the Enter key. A list article which contain the search keyword (search by content). o Login is not required.</p><p>- Function 4: Article Detail &ndash; 50 Points o List the available article in the system and sort by date. o Each page has a maximum of 20 records displayed. Paging is required to use. o When clicking on the title column in each record, the details of the article are displayed: title, short description, content, author, posting date and the list of corresponding comments. o Login is not required.</p><p>- Function 5: Post the article &ndash; 50 points o In order to post the article to the blog an authentication is required. o If the user has not authenticated, the system redirect to the login page. o Members can post their articles on the blog and wait for the admin&#39;s approval. o The default status of the article is New. The status will be changed to Active if the admin accepts that post. o Only member can use this function.</p>', N'tungloc0399@gmail.com', CAST(N'2021-10-19' AS Date), N'A')
INSERT [dbo].[tblArticle] ([articleID], [articleTitle], [articleShortDesc], [articleContent], [articleAuthor], [articlePostingDate], [articleStatus]) VALUES (6, N'The International Main Event', N'The International Main Event kicks off at National Arena in Bucharest in less than twelve hours. Tune in from 10 am EEST via the DPC website, the Dota client, or over on Twitch to catch all of the main stage action as the final 16 teams face off for the Aegis.', N'<p>&nbsp;</p><p>The International Main Event kicks off at National Arena in Bucharest in less than twelve hours. Tune in from 10 am EEST via <a target="_blank" href="https://www.dota2.com/esports/ti10/">the DPC website</a>, the Dota client, or over on <a target="_blank" href="https://www.twitch.tv/dota2ti">Twitch </a>to catch all of the main stage action as the final 16 teams face off for the Aegis.</p><p><strong>Team Standings</strong></p><p>After a hard-fought Group Stage, group leaders PSG.LGD and Invictus Gaming will be joined in the Upper Bracket by Virtus Pro, OG, T1, Team Secret, Vici Gaming, and Team Spirit. In the Lower Bracket, Team Undying, Evil Geniuses, Beastcoast, Quincy Crew, Fnatic, Elephant, Team Aster, and Alliance will all need to battle out of a best-of-one elimination match with their tournament hopes on the line. As those squads move to the main stage, SG esports and Thunder Predator exit the tournament as the first teams to fall. We salute their accomplishments in earning a place amongst the finest teams in the world and wish them luck in their efforts to return next year.</p><p><strong>Crimson Witness Treasures</strong></p><p>Watching matches live at National Arena isn&#39;t an option for fans this year, but that doesn&#39;t mean ticket-holders have to miss out on one of the traditional perks of attending the event. To help celebrate first blood in each match, fans who purchased tickets to attend The International still have a chance to snag this year&#39;s Crimson Witness treasures. You won&#39;t need to sign in or out for each game, just make sure to register your account once over on the <a target="_blank" href="https://www.dota2.com/crimsonwitness">Crimson Witness page</a> to ensure your eligibility.</p><p><strong>The Secret Shop</strong></p><p>Fans looking to raid this year&#39;s Secret Shop can head over to <a target="_blank" href="https://theinternational.wearenations.com/">The International&#39;s official online store</a>, brought to you by our merchandise partners at We Are Nations. In addition to the tournament-themed items, they&#39;ve worked together with members of the Dota Community to develop <a target="_blank" href="https://theinternational.wearenations.com/collections/fan-art-collection">new offerings in a Fan Art Collection</a>.</p><p><strong>Official Tournament Chair</strong></p><p>For those Dota diehards looking for one more piece of The International to add to their home collections, our partners at Secret Lab invite you to check out <a target="_blank" href="https://secretlab.eu/products/titan-evo-2022-series?sku=XL22PU-TI10">this year&#39;s official tournament chair</a>. Designed for use in the player booths on the main stage and themed to match this year&#39;s event, it&#39;s the perfect peripheral to pair with your own Dota games.</p><p><strong>Follow #TI10</strong></p><p>Be sure to follow us on all of our channels for the latest news and updates from The International #TI10.</p><p>Twitter: <a target="_blank" href="https://twitter.com/DOTA2">@dota2ti</a> Instagram: <a target="_blank" href="http://instagram.com/dota2">dota2</a> Facebook: <a target="_blank" href="http://facebook.com/dota2">dota2</a> Flickr: <a target="_blank" href="https://www.flickr.com/photos/dota2ti/">dota2ti</a> YouTube: <a target="_blank" href="http://youtube.com/dota2">dota2</a> Twitch: <a target="_blank" href="http://twitch.tv/dota2ti">dota2ti</a></p>', N'tungloclutran@gmail.com', CAST(N'2021-10-19' AS Date), N'A')
INSERT [dbo].[tblArticle] ([articleID], [articleTitle], [articleShortDesc], [articleContent], [articleAuthor], [articlePostingDate], [articleStatus]) VALUES (7, N'Vietnam Business Operations and the Coronavirus: Updates', N'This article will be updated as further developments in Vietnam become available.', N'<h2>Latest Updates</h2>

<ul>
	<li>As of October 21, 2021, Vietnam&rsquo;s Ministry of Health confirmed a total of 873,901 cases of COVID-19. However, 796,583 of the affected patients have recovered and been discharged from hospitals. Vietnam has also recorded 21,416 deaths due to the pandemic. The latest community transmission cases have been reported from Ho Chi Minh City, Binh Duong, Dong Nai, An Giang, and Soc Trang among others.</li>
</ul>

<p><strong>October 21</strong></p>

<ul>
	<li>From October 21, Vietnam&rsquo;s Transport Ministry scrapped the full vaccination requirement for domestic air passengers. However, passengers from high-risk areas or locked-down areas would still need a negative COVID-19 test 72 hours prior to their flights. Passengers from other areas would need one of the following, such as a negative COVID-19 test, proof of vaccination, or a COVID-19 recovery certificate.</li>
</ul>

<p><strong>October 18</strong></p>

<ul>
	<li>Authorities in Khanh Hoa and Ba Ria-Vung Tau provinces reopened public beaches and restaurants in Nha Trang and Vung Tau respectively with restrictions from October 16.</li>
	<li>Vietnam received 2.02 million of the AstraZeneca COVID-19 vaccines from Italy through the COVAX program on October 15.</li>
</ul>

<p><strong>October 15</strong></p>

<ul>
	<li>Da Nang will resume most activities from October 16 including dine-in services after not recording any COVID-19 cases for the past two weeks.</li>
	<li>Vietnam received 560,000 doses of the AstraZeneca COVID-19 vaccine from Hungary, Croatia, and Slovakia.</li>
</ul>

<p><strong>October 14</strong></p>

<ul>
	<li>Hanoi allowed the resumption of on-site dining, taxis, and hotels from October 14, though with pandemic prevention measures. Restaurants would be allowed on-site dining at half capacity except for businesses that sell alcohol.</li>
	<li>Vietnam received 391,950 doses of the Pfizer-BioNTech COVID-19 vaccine on October 13 from the US.</li>
</ul>

<p><strong>October 12</strong></p>

<ul>
	<li>Hanoi and Hai Phong authorities scrapped the mandatory centralized quarantine requirements for passengers arriving on domestic flights. Instead, passengers would have to isolate at home for 7 to 14 days as per health authorities. Passengers would also need to be fully vaccinated and with a negative COVID-19 test certificate to travel.</li>
	<li>Interprovincial passenger road transport, as well as some train services, will resume on a pilot basis from October 13.</li>
</ul>

<p><strong>October 8</strong></p>

<ul>
	<li>Vietnam is expected to set criteria for vaccine passports recognizing all vaccines approved by the World Health Organization, (WHO), the US Centre for Disease Control (CDC), the European Medicine Agency (EMA), and Vietnam&rsquo;s Ministry of Health.</li>
	<li>Ho Chi Minh City and the neighboring provinces of Binh Duong, Tay Ninh, Dong Nai, and Long An have reached an agreement on the commute of workers and experts between the five localities. Businesses would be allowed to transport staff by company vehicles and those that are fully vaccinated or recovered from COVID-19 and have a negative test certificate.</li>
	<li>Vietnam received 608,400 doses and 397,800 doses of the Pfizer COVID-19 vaccine on October 7 and October 8 respectively from the US.</li>
</ul>

<p><strong>October 5</strong></p>

<ul>
	<li>Vietnam&rsquo;s Immigration Department has announced another automatic stay extension for foreigners stranded in Vietnam due to the pandemic until October 31, 2021. The measure applies to those who entered since March 1, 2020, allowing them to leave the country without any penalty or official procedures. Those that have entered prior to March 1, 2020, are also eligible provided they show documents by their embassies or by Vietnamese authorities to confirm they were quarantined or treated for COVID-19.</li>
	<li>Vietnam received 1.5 million doses of the Pfizer COVID-19 vaccine through the COVAX program with assistance from the US on October 4.</li>
	<li>Ho Chi Minh City has allowed buses, taxis, and contract cars (ride-hailing) under nine seats to resume operations with limited capacity from October 5.</li>
	<li>Residents of Ho Chi Minh City that want to go out must be vaccinated at least once and obtain a QR code through the mandated health apps. If there is no QR code, residents must show proof by paper documentation. Businesses must also register to receive QR codes and receive employees using these codes.</li>
</ul>

<p><strong>October 4</strong></p>

<ul>
	<li>Domestic flights resumed on October 1 under a four-phase plan. Flights resumed with localities that have relaxed pandemic prevention and control measures.</li>
	<li>Ho&nbsp;Chi Minh City authorities have implemented Directive 18 on COVID-19 prevention and control measures while gradually reopening the economy. Residents have been asked to use VNEID and Y te HCM mobile apps to declare their health and destinations prior to going out. The directive includes eight groups of services that have been allowed to resume including manufacturing and trading, outdoor events, international organizations, and government agencies.</li>
</ul>
', N'tungloclutran@gmail.com', CAST(N'2021-10-21' AS Date), N'D')
INSERT [dbo].[tblArticle] ([articleID], [articleTitle], [articleShortDesc], [articleContent], [articleAuthor], [articlePostingDate], [articleStatus]) VALUES (8, N'Mix-and-match COVID vaccines ace the effectiveness test', N'Combining two different COVID-19 vaccines provides protection on par with that of mRNA vaccines â including protection against the Delta variant.', N'<p><img alt="A worker holds a Pfizer COVID-19 vaccine vial up to the light." src="https://media.nature.com/lw800/magazine-assets/d41586-021-02853-4/d41586-021-02853-4_19767828.jpg" /></p>

<p>A health-care worker in Nonthaburi, Thailand, examines a vial of the Pfizer&ndash;BioNTech COVID-19 vaccine.Credit: Peerapon Boonyakiat/SOPA Images/LightRocket via Getty</p>

<p>&lt;hr&gt;</p>

<p>Study after study has shown that people who receive two different COVID-19 vaccines generate potent immune responses, with side effects no worse than those caused by standard regimens.</p>

<p>But now, for the first time, researchers have shown that such &lsquo;mix and match&rsquo; regimens are highly effective at preventing COVID-19 &mdash; roughly matching or even exceeding the performance of&nbsp;<a href="https://www.nature.com/articles/d41586-021-02483-w">mRNA vaccines</a>.</p>

<p>The high antibody levels and other strong immune responses elicited by mix-and-match regimens suggested they would offer good protection against disease. Still, &ldquo;I was delighted to see that it&rsquo;s as effective as one would expect,&rdquo; says immunologist Martina Sester at Saarland University in Homburg, Germany. &ldquo;This is really good news and this will certainly have influence on clinical practice.&rdquo;</p>

<p>&ldquo;These emerging effectiveness data support the use of these approved COVID-19 vaccines in either the standard or mixed schedules,&rdquo; adds Matthew Snape, a vaccinologist at the University of Oxford, UK.</p>
', N'lutrantungloc9.1@gmail.com', CAST(N'2021-10-25' AS Date), N'A')
SET IDENTITY_INSERT [dbo].[tblArticle] OFF
INSERT [dbo].[tblArticleStatus] ([articleStatusID], [articleName]) VALUES (N'A', N'Active')
INSERT [dbo].[tblArticleStatus] ([articleStatusID], [articleName]) VALUES (N'D', N'Delete')
INSERT [dbo].[tblArticleStatus] ([articleStatusID], [articleName]) VALUES (N'N', N'New')
SET IDENTITY_INSERT [dbo].[tblComment] ON 

INSERT [dbo].[tblComment] ([commentID], [articleID], [commentContent], [commentDate], [commentStatus], [commentEmail]) VALUES (4, 3, N'test comment', CAST(N'2021-10-20' AS Date), 1, N'tungloclutran@gmail.com')
INSERT [dbo].[tblComment] ([commentID], [articleID], [commentContent], [commentDate], [commentStatus], [commentEmail]) VALUES (5, 3, N'test comment with out search', CAST(N'2021-10-20' AS Date), 1, N'lutrantungloc@gmail.com')
INSERT [dbo].[tblComment] ([commentID], [articleID], [commentContent], [commentDate], [commentStatus], [commentEmail]) VALUES (8, 3, N'test comment with search', CAST(N'2021-10-20' AS Date), 1, N'lutrantungloc@gmail.com')
INSERT [dbo].[tblComment] ([commentID], [articleID], [commentContent], [commentDate], [commentStatus], [commentEmail]) VALUES (9, 6, N'test', CAST(N'2021-10-20' AS Date), 1, N'lutrantungloc@gmail.com')
INSERT [dbo].[tblComment] ([commentID], [articleID], [commentContent], [commentDate], [commentStatus], [commentEmail]) VALUES (10, 5, N'test', CAST(N'2021-10-25' AS Date), 1, N'tungloclutran@gmail.com')
SET IDENTITY_INSERT [dbo].[tblComment] OFF
INSERT [dbo].[tblRole] ([roleID], [roleName]) VALUES (N'AD', N'Admin')
INSERT [dbo].[tblRole] ([roleID], [roleName]) VALUES (N'MEM', N'Member')
INSERT [dbo].[tblSenderEmail] ([senderEmail], [senderPassword], [senderStatus]) VALUES (N'noxcsgocase01@gmail.com', N'01885678990aA', 1)
INSERT [dbo].[tblSenderEmail] ([senderEmail], [senderPassword], [senderStatus]) VALUES (N'noxcsgocase02@gmail.com', N'01885678990aA', 0)
INSERT [dbo].[tblSenderEmail] ([senderEmail], [senderPassword], [senderStatus]) VALUES (N'noxcsgocase03@gmail.com', N'01885678990aA', 1)
INSERT [dbo].[tblSenderEmail] ([senderEmail], [senderPassword], [senderStatus]) VALUES (N'noxcsgocase04@gmail.com', N'01885678990aA', 1)
INSERT [dbo].[tblSenderEmail] ([senderEmail], [senderPassword], [senderStatus]) VALUES (N'noxcsgocase05@gmail.com', N'01885678990aA', 1)
INSERT [dbo].[tblUser] ([email], [password], [userName], [roleID], [status], [createDate]) VALUES (N'admin', N'pmWkWSBCL51Bfkhn79xPuKBKHz//H6B+mY6G9/eieuM=', N'Admin', N'AD', N'New', CAST(N'2021-10-20' AS Date))
INSERT [dbo].[tblUser] ([email], [password], [userName], [roleID], [status], [createDate]) VALUES (N'loclttse130296@fpt.edu.vn', N's6jg4fmrG/46NvIx9nb3i7MKUZ0rIebFMMDu6Ou0pdA=', N'ILeF', N'MEM', N'New', CAST(N'2021-10-25' AS Date))
INSERT [dbo].[tblUser] ([email], [password], [userName], [roleID], [status], [createDate]) VALUES (N'lutrantungloc@gmail.com', N'jSPPbIboNKeqbt7VTCbOK7LnSQNTjGG91dIZeZerL3I=', N'No Name', N'MEM', N'New', CAST(N'2021-10-13' AS Date))
INSERT [dbo].[tblUser] ([email], [password], [userName], [roleID], [status], [createDate]) VALUES (N'lutrantungloc9.1@gmail.com', N'9uCh4qxBlFqap/+KiqoM68EqO8yYGpKa1c+BCgkOEa4=', N'Tung Loc', N'MEM', N'Active', CAST(N'2021-10-18' AS Date))
INSERT [dbo].[tblUser] ([email], [password], [userName], [roleID], [status], [createDate]) VALUES (N'tungloc0399@gmail.com', N'2nDfpNn5Wsl5+SHo5iM1gjYxPzNK/NBs3filYhz2oek=', N'Loc', N'MEM', N'Active', CAST(N'2021-10-18' AS Date))
INSERT [dbo].[tblUser] ([email], [password], [userName], [roleID], [status], [createDate]) VALUES (N'tungloclutran@gmail.com', N'pmWkWSBCL51Bfkhn79xPuKBKHz//H6B+mY6G9/eieuM=', N'Loc', N'MEM', N'Active', NULL)
ALTER TABLE [dbo].[tblArticle]  WITH CHECK ADD  CONSTRAINT [FK_tblArticle_tblarticleStatus] FOREIGN KEY([articleStatus])
REFERENCES [dbo].[tblArticleStatus] ([articleStatusID])
GO
ALTER TABLE [dbo].[tblArticle] CHECK CONSTRAINT [FK_tblArticle_tblarticleStatus]
GO
ALTER TABLE [dbo].[tblArticle]  WITH CHECK ADD  CONSTRAINT [FK_tblArticle_tblUser] FOREIGN KEY([articleAuthor])
REFERENCES [dbo].[tblUser] ([email])
GO
ALTER TABLE [dbo].[tblArticle] CHECK CONSTRAINT [FK_tblArticle_tblUser]
GO
ALTER TABLE [dbo].[tblComment]  WITH CHECK ADD  CONSTRAINT [FK_tblComment_tblArticle] FOREIGN KEY([articleID])
REFERENCES [dbo].[tblArticle] ([articleID])
GO
ALTER TABLE [dbo].[tblComment] CHECK CONSTRAINT [FK_tblComment_tblArticle]
GO
ALTER TABLE [dbo].[tblComment]  WITH CHECK ADD  CONSTRAINT [FK_tblComment_tblUser] FOREIGN KEY([commentEmail])
REFERENCES [dbo].[tblUser] ([email])
GO
ALTER TABLE [dbo].[tblComment] CHECK CONSTRAINT [FK_tblComment_tblUser]
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD  CONSTRAINT [FK_tblUser_tblRole] FOREIGN KEY([roleID])
REFERENCES [dbo].[tblRole] ([roleID])
GO
ALTER TABLE [dbo].[tblUser] CHECK CONSTRAINT [FK_tblUser_tblRole]
GO
USE [master]
GO
ALTER DATABASE [Lab3] SET  READ_WRITE 
GO
