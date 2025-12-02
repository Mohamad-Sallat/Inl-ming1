-- Mohamad Sallat YH25
-- inlämning 1 - Bokhandel Databaser

-- skapa databasen

CREATE DATABASE bokhandel;
USE bokhandel;

-- Skapa tabeller --
-- Böcker -- 
CREATE TABLE Böcker (
	ISBN VARCHAR(20) PRIMARY KEY,
    Titel VARCHAR(255) NOT NULL,
    Författare VARCHAR(255),
    Pris DECIMAL(10,2) NOT NULL,
    Lagerstatus INT NOT NULL
    );
    
    -- Kunder --
CREATE TABLE Kunder (
	Kund_ID INT AUTO_INCREMENT PRIMARY KEY,
    Namn VARCHAR(255) NOT NULL,
    Epost VARCHAR(255) NOT NULL,
    Telefon VARCHAR(50),
    Adress VARCHAR(255)
    );
    
    -- Beställningar --
CREATE TABLE Beställningar (
	Order_ID INT AUTO_INCREMENT PRIMARY KEY,
    Kund_ID INT NOT NULL,
    Datum DATE NOT NULL,
    Totalbelopp DECIMAL(10,2),
    FOREIGN KEY (Kund_ID) REFERENCES Kunder(Kund_ID)
    );
    
    -- Orderrader -- 
    CREATE TABLE Orderrader (
		Orderrad_ID INT AUTO_INCREMENT PRIMARY KEY,
        Order_ID INT NOT NULL,
        ISBN VARCHAR(20) NOT NULL,
        Antal INT NOT NULL,
        FOREIGN KEY (Order_ID) REFERENCES Beställningar(Order_ID),
        FOREIGN KEY (ISBN) REFERENCES Böcker(ISBN)
        );
  
  show TABLES ;
     
     
     -- Böcker --
     
 Use Bokhandel;    
INSERT INTO Böcker (ISBN, Titel, Författare, Pris, Lagerstatus) VALUES
('9789164200001', 'Game of Thrones', 'Alex Johansson', 129.00, 12),
('9789100170002', 'Breaking Bad', 'Niklas Engman', 159.00, 8),
('9789127350003', 'Shadow', 'Astrid Lindgren', 99.00, 20);

		-- Kunder -- 
INSERT INTO Kunder (Namn, Epost, Telefon, Adress) VALUES
('Anna Svensson', 'anna@example.com', '0701234567', 'Storgatan 12'),
('Mohamad Sallat', 'mohamad@example.com', '0728512293', 'Rimsmedsvägen 9A');

	-- Beställningar -- 
INSERT INTO Beställningar (Kund_ID, Datum, Totalbelopp) VALUES
(1, '2025-11-01', 288.00),
(2, '2025-11-02', 159.00);

	-- Orderrader -- 
INSERT INTO Orderrader (Order_ID, ISBN, Antal) VALUES
(1, '9789164200001', 1),
(1, '9789127350003', 1),
(2, '9789100170002', 1);


SELECT 
    K.Namn AS Kund,
    B.Titel AS Bok,
    O.Antal,
    BE.Datum
FROM Orderrader O
JOIN Böcker B ON O.ISBN = B.ISBN
JOIN Beställningar BE ON O.Order_ID = BE.Order_ID
JOIN Kunder K ON BE.Kund_ID = K.Kund_ID;	