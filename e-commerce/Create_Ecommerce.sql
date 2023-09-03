-- Criação do banco de dados para o E-commerce
CREATE DATABASE e_commerce DEFAULT CHARACTER SET utf8;
USE e_commerce;


-- Cria tabela cliente
CREATE TABLE clients (
	idClient INT AUTO_INCREMENT,
	Fname VARCHAR(10),
    Minit CHAR(3),
	Lname VARCHAR(20),
	CPF CHAR(11) NOT NULL,
	Address VARCHAR(30),
	Phone VARCHAR(15),
	CONSTRAINT unique_cpf_client UNIQUE (CPF),
	PRIMARY KEY (idClient)
);


-- Cria tabela produto
CREATE TABLE product (
	idProduct INT AUTO_INCREMENT,
	Pname VARCHAR(10) NOT NULL,
	Classification_kids BOOL DEFAULT FALSE,
	Category ENUM('Alimentos', 'Brinquedos', 'Eletrônicos', 'Móveis', 'Vestimenta') NOT NULL,
	Price FLOAT NOT NULL,
	Rating FLOAT DEFAULT 0,
	Size VARCHAR(10),
	PRIMARY KEY (idProduct)
);


-- Cria tabela formas de pagamento
CREATE TABLE  paymentTypes (
	idPayment INT NOT NULL AUTO_INCREMENT,
	PayType ENUM('Credito', 'Debito', 'Boleto', 'Pix') NOT NULL DEFAULT 'Boleto',
	PRIMARY KEY (idPayment)
);


-- Cria tabela de cartões
CREATE TABLE Cards(
	idCard INT NOT NULL AUTO_INCREMENT ,
	Name VARCHAR(45) NOT NULL,
	Number VARCHAR(15) NOT NULL,
	Flag VARCHAR(45) NOT NULL,
	ExpDate DATE NOT NULL,
	fk_idClient INT NOT NULL,
	PRIMARY KEY (idCard),
	CONSTRAINT fk_Payments_Clients FOREIGN KEY (fk_idClient) REFERENCES clients (idClient)
);


-- Cria tabela de entregas
CREATE TABLE Deliver (
	idDeliver INT NOT NULL AUTO_INCREMENT,
	TrackingCod INT NOT NULL,
	DeliverStatus ENUM('Em preparação', 'Enviado', 'Em trânsito', 'Saiu para entrega', 'Entregue') NOT NULL DEFAULT 'Em preparação',
	ShipValue FLOAT NOT NULL DEFAULT 0 ,
	PRIMARY KEY (idDeliver)
  );


-- Cria tabela de pedidos
CREATE TABLE orders(
	idOrder INT AUTO_INCREMENT,
	fk_idClient INT,
	fk_idDeliver INT NOT NULL,
	fk_idPaymentType INT NOT NULL,
	fk_idCard INT,
	TotalValue FLOAT NOT NULL,
	`Date` DATE NOT NULL,
	OrderStatus ENUM('Cancelado', 'Confirmado', 'Em processamento') DEFAULT 'Em processamento',
	OrderDescription VARCHAR(255),
	PRIMARY KEY(idOrder, fk_idClient, fk_idDeliver),
	CONSTRAINT fk_orders_client FOREIGN KEY(fk_idClient) REFERENCES clients(idClient),
	CONSTRAINT fk_Orders_Deliver FOREIGN KEY (fk_idDeliver) REFERENCES Deliver(idDeliver),
	CONSTRAINT fk_Orders_Card FOREIGN KEY (fk_idCard) REFERENCES Cards(idCard),
	CONSTRAINT fk_Orders_PaymentType FOREIGN KEY (fk_idPaymentType) REFERENCES paymentTypes(idPayment)
);


-- Cria associação de pedido e produto
CREATE TABLE orders_Product (
	fk_idProduct INT NOT NULL,
	fk_idOrder INT NOT NULL,
	Quantity INT NULL DEFAULT 1,
	PRIMARY KEY (fk_idProduct, fk_idOrder),
	CONSTRAINT fk_Product_has_Order_Pd FOREIGN KEY (fk_idProduct) REFERENCES Product (idProduct),
	CONSTRAINT fk_Product_has_Order_Od FOREIGN KEY (fk_idOrder) REFERENCES Orders (idOrder)
);


-- Cria tabela de estoque
CREATE TABLE stock(
	idStock INT AUTO_INCREMENT,
	StockLocation VARCHAR(255) NOT NULL,
	PRIMARY KEY(idStock)
);

-- Cria associação de stoque e produto
CREATE TABLE product_stock(
	fk_idProduct INT NOT NULL,
	fk_idStock INT NOT NULL,
	Quantity INT DEFAULT 0,
	PRIMARY KEY (fk_idProduct, fk_idStock),
	CONSTRAINT fk_Product_has_Stock_Pd FOREIGN KEY (fk_idProduct) REFERENCES product(idProduct),
	CONSTRAINT fk_Product_has_Stock_St FOREIGN KEY (fk_idStock) REFERENCES Stock (idStock)
);


-- Cria tabela de fornecedor
CREATE TABLE supplier(
	idSupplier INT AUTO_INCREMENT,
	SocialName VARCHAR(255) NOT NULL,
	CNPJ CHAR(15) NOT NULL,
	Contact CHAR(11) NOT NULL,
	PRIMARY KEY(idSupplier),
	CONSTRAINT unique_supplier UNIQUE(CNPJ)
); 

-- Cria associação de fornecedor e produto
CREATE TABLE supplier_Product (
	fk_idSupplier INT NOT NULL ,
	fk_idProduct INT NOT NULL,
	Quantity INT NOT NULL,
	PRIMARY KEY (fk_idSupplier, fk_idProduct),
	CONSTRAINT fk_Supplier_has_Product_Sp FOREIGN KEY (fk_idSupplier)REFERENCES Supplier(idSupplier),
	CONSTRAINT fk_Supplier_has_Product_Pd FOREIGN KEY (fk_idProduct) REFERENCES Product (idProduct)
);


-- Cria tabela de vendedor
/*CREATE TABLE seller (
	idSeller INT NOT NULL AUTO_INCREMENT,
	SocialName VARCHAR(255) NOT NULL,
	AbstName VARCHAR(255),
	CNPJ CHAR(15),
	CPF CHAR(11),
	Location VARCHAR(255) NOT NULL,
	Contact CHAR(11) NOT NULL,
	PRIMARY KEY (idSeller),
    CONSTRAINT unique_cnpj_seller UNIQUE(CNPJ),
    CONSTRAINT unique_cpf_seller UNIQUE(CPF)
);
*/


