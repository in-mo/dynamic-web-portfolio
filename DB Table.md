# dynamic-web-portfolio
# 개발 환경 : MySQL

# 좋아요 표시 테이블
```SQL
CREATE TABLE `like_table` (
   `num` int(11) NOT NULL,
   `id` varchar(20) COLLATE utf8_bin DEFAULT NULL,
   `article` varchar(100) COLLATE utf8_bin DEFAULT NULL,
   `islike` varchar(2) COLLATE utf8_bin DEFAULT NULL,
   PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin
```
 
# 주문 내역 테이블
```SQL
CREATE TABLE `orderlist` (
   `order_num` int(11) NOT NULL AUTO_INCREMENT,
   `article` varchar(100) COLLATE utf8_bin DEFAULT NULL,
   `id` varchar(20) COLLATE utf8_bin DEFAULT NULL,
   `size` varchar(5) COLLATE utf8_bin DEFAULT NULL,
   `color` varchar(10) COLLATE utf8_bin DEFAULT NULL,
   `quantity` int(11) DEFAULT NULL,
   `price` int(11) DEFAULT NULL,
   `name` varchar(10) COLLATE utf8_bin DEFAULT NULL,
   `age` int(11) DEFAULT NULL,
   `gender` varchar(5) COLLATE utf8_bin DEFAULT NULL,
   `tel` varchar(20) COLLATE utf8_bin DEFAULT NULL,
   `absence_msg` varchar(300) COLLATE utf8_bin DEFAULT NULL,
   `address` varchar(500) COLLATE utf8_bin DEFAULT NULL,
   `delivery` varchar(15) COLLATE utf8_bin DEFAULT NULL,
   `expect_date` varchar(20) COLLATE utf8_bin DEFAULT NULL,
   `order_date` datetime DEFAULT NULL,
   PRIMARY KEY (`order_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin
```
 
# 제품 수량 테이블
```SQL
CREATE TABLE `productquantity` (
   `num` int(11) NOT NULL AUTO_INCREMENT,
   `size` varchar(5) COLLATE utf8_bin DEFAULT NULL,
   `red` int(11) DEFAULT NULL,
   `orange` int(11) DEFAULT NULL,
   `yellow` int(11) DEFAULT NULL,
   `green` int(11) DEFAULT NULL,
   `blue` int(11) DEFAULT NULL,
   `reg_article` varchar(100) COLLATE utf8_bin DEFAULT NULL,
   PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin
```
 
# QnA 게시판 테이블
```SQL
CREATE TABLE `qna_table` (
   `num` int(11) NOT NULL AUTO_INCREMENT,
   `id` varchar(20) COLLATE utf8_bin DEFAULT NULL,
   `title` varchar(45) COLLATE utf8_bin DEFAULT NULL,
   `content` varchar(500) COLLATE utf8_bin DEFAULT NULL,
   `type` varchar(100) COLLATE utf8_bin DEFAULT NULL,
   `article` varchar(100) COLLATE utf8_bin DEFAULT NULL,
   `re_ref` int(11) DEFAULT NULL,
   `re_lev` int(11) DEFAULT NULL,
   `reg_date` datetime DEFAULT NULL,
   PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin
```
 
# 제품 리뷰 테이블
```SQL
CREATE TABLE `shop_reply_info` (
   `num` int(11) NOT NULL AUTO_INCREMENT,
   `id` varchar(20) COLLATE utf8_bin DEFAULT NULL,
   `image` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
   `uploadpath` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
   `article` varchar(100) COLLATE utf8_bin DEFAULT NULL,
   `content` varchar(500) COLLATE utf8_bin DEFAULT NULL,
   `grade` varchar(5) COLLATE utf8_bin DEFAULT NULL,
   `reg_date` datetime DEFAULT NULL,
   PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin
```
 
# 장바구니 테이블
```SQL
CREATE TABLE `shopbasket` (
   `num` int(11) NOT NULL AUTO_INCREMENT,
   `id` varchar(20) COLLATE utf8_bin DEFAULT NULL,
   `size` varchar(5) COLLATE utf8_bin DEFAULT NULL,
   `color` varchar(10) COLLATE utf8_bin DEFAULT NULL,
   `quantity` int(11) DEFAULT NULL,
   `article` varchar(100) COLLATE utf8_bin DEFAULT NULL,
   `reg_date` datetime DEFAULT NULL,
   PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin
```
 
# 상품 사진 테이블
```SQL
CREATE TABLE `shopimage` (
   `num` int(11) NOT NULL AUTO_INCREMENT,
   `image` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
   `uploadpath` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
   `reg_article` varchar(100) COLLATE utf8_bin DEFAULT NULL,
   PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin
```
 
# 회원 정보 테이블
```SQL
CREATE TABLE `shopmember` (
   `id` varchar(20) COLLATE utf8_bin NOT NULL,
   `password` varchar(20) COLLATE utf8_bin DEFAULT NULL,
   `name` varchar(10) COLLATE utf8_bin DEFAULT NULL,
   `age` int(11) DEFAULT NULL,
   `gender` varchar(5) COLLATE utf8_bin DEFAULT NULL,
   `email` varchar(100) COLLATE utf8_bin DEFAULT NULL,
   `tel` varchar(20) COLLATE utf8_bin DEFAULT NULL,
   `postcode` varchar(30) COLLATE utf8_bin DEFAULT NULL,
   `address1` varchar(100) COLLATE utf8_bin DEFAULT NULL,
   `address2` varchar(100) COLLATE utf8_bin DEFAULT NULL,
   `reg_date` datetime DEFAULT NULL,
   PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin
```

# 상품 정보 테이블
```SQL
CREATE TABLE `shopproduct` (
   `article` varchar(100) COLLATE utf8_bin NOT NULL,
   `limitedSale` varchar(8) COLLATE utf8_bin DEFAULT NULL,
   `brand` varchar(50) COLLATE utf8_bin DEFAULT NULL,
   `product` varchar(100) COLLATE utf8_bin DEFAULT NULL,
   `gender` varchar(10) COLLATE utf8_bin DEFAULT NULL,
   `part` varchar(20) COLLATE utf8_bin DEFAULT NULL,
   `detail` varchar(30) COLLATE utf8_bin DEFAULT NULL,
   `price` int(11) DEFAULT NULL,
   `sale` int(11) DEFAULT NULL,
   `delivery` varchar(15) COLLATE utf8_bin DEFAULT NULL,
   `releasedate` decimal(2,1) DEFAULT NULL,
   `weekend` varchar(8) COLLATE utf8_bin DEFAULT NULL,
   `readcount` int(11) DEFAULT NULL,
   `salecount` int(11) DEFAULT NULL,
   `likecount` int(11) DEFAULT NULL,
   `grade` varchar(5) COLLATE utf8_bin DEFAULT NULL,
   `avg_age` varchar(5) COLLATE utf8_bin DEFAULT NULL,
   `reg_date` datetime DEFAULT NULL,
   PRIMARY KEY (`article`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin
```
