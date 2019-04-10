create database CuocThiHat

use CuocThiHat

-- Bảng 1: Người
create table Nguoi (
id varchar(12) primary key,
cmnd char(12) not null,
ten nvarchar(50) not null,
gioitinh int check(gioitinh=1 or gioitinh=0),
ngaysinh date not null,
noisinh nvarchar(50) not null
)
-- Search google: Pattern regular expression matching in sql
alter table Nguoi add constraint CK_ID_TS check(id like '[T][S][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
											 or id like '[N][S][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')

-- Bảng 2: Thí Sinh
create table ThiSinh (
mathisinh varchar(12) not null,
diachi nvarchar(50) not null,
dienthoai char(12) not null,
gioithieu nvarchar(50) not null,
primary key(mathisinh),
foreign key (mathisinh) references Nguoi(id) on update cascade on delete cascade
)
alter table ThiSinh add constraint CK_MATS_TS check(mathisinh like '[T][S][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')

-- Bảng 3: Nghệ Sĩ
create table NgheSi (
manghesi varchar(12) not null,
nghedanh nvarchar(20) not null,
thanhtich varchar(10) not null,
MCFlag int check(MCFlag=0 or MCFLAG=1),
CSFlag int check(CSFlag=0 or CSFLAG=1),
NSFlag int check(NSFlag=0 or NSFLAG=1),
primary key(manghesi),
foreign key (manghesi) references Nguoi(id) on update cascade on delete cascade
)
alter table NgheSi add constraint CK_MANS_NS check(manghesi like '[N][S][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')

-- Bảng 4: Chương trình MC dẫn
create table CTMC (
maMC varchar(12) not null,
CT nvarchar(50) not null,
primary key(maMC, CT),
foreign key (maMC) references NgheSi(manghesi) on update cascade on delete cascade
)

-- Bảng 5: Album ca sĩ
create table AlbumCS (
maCS varchar(12) not null,
album nvarchar(50) not null,
primary key(maCS, album),
foreign key(maCS) references NgheSi(manghesi) on update cascade on delete cascade
)

-- Bảng 6: Bài Hát
create table BaiHat (
maBH varchar(8) not null,
tuaBH nvarchar(20) not null,
primary key(maBH)
)
alter table BaiHat add constraint CK_MABH_BH check(maBH like '[B][H][0-9][0-9][0-9][0-9][0-9][0-9]')

-- Bảng 7: Thể Loại
create table TheLoai (
maTL varchar(6) not null,
tenTL nvarchar(10) unique,
primary key(maTL)
)
alter table TheLoai add constraint CK_MATL_TL check(maTL like '[T][L][0-9][0-9][0-9]')

-- Bảng 8: Bài hát thuộc thể loại
create table TL_BH (
maBH varchar(8) not null,
maTL varchar(6) not null,
)
alter table TL_BH add constraint PK_TLBH_MABH_MATL primary key(maBH, maTL)
alter table TL_BH add constraint FK_TLBH_MABH_BH foreign key(maBH) references BaiHat(maBH) on update cascade on delete cascade
alter table TL_BH add constraint FK_TLBH_MATL_TL foreign key(maTL) references TheLoai(maTL) on update cascade on delete cascade

-- Bảng 9: Nhạc sĩ sáng tác
create table NhacSiSangTac(
manhacsi varchar(12) not null,
infosangtac int, 
primary key(manhacsi)
)
alter table NhacSiSangTac add constraint FK_NSST_MNS_NS foreign key(manhacsi) references NgheSi(manghesi) on update cascade on delete cascade
alter table NhacSiSangTac add constraint CK_INFOST check(infosangtac = 1 or infosangtac = 2 or infosangtac = 3)

-- Bảng 10: Tỉnh thành

-----------------------------------
insert into Nguoi values ('TS2019000001', '025711690', N'Đỗ Duy Thịnh', 0, '08/24/1999', N'Tp.Hồ Chí Minh'),
						 ('NS2019000002', '025711696', N'Haruka Nakano', 1, '08/24/1999', N'Tp.Hồ Chí Minh')
--select * from Nguoi
--delete from Nguoi
drop table ThiSinh
drop table NgheSi
drop table Nguoi
----------------------------------
