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



-- ======================================================
-- Inläming 2 YH2025 -- 
-- Mohamad Sallat --


-- ======================================================
-- Lägg till fler kunder,  beställningar och orderrader -- 
-- ======================================================
USE bokhandel;
INSERT INTO Kunder (Namn, Epost, Telefon, Adress) VALUES
('Erik Larsson', 'erik@example.com', '0731112233', 'Parkgatan 5'),
('Sara Nilsson', 'sara@example.com', '0742223344', 'Kungsgatan 18');

INSERT INTO Beställningar (Kund_ID, Datum, Totalbelopp) VALUES
(1, '2025-11-03', 129.00),
(1, '2025-11-04', 99.00),
(3, '2025-11-05', 258.00);

INSERT INTO Orderrader (Order_ID, ISBN, Antal) VALUES
(3, '9789164200001', 1),
(4, '9789127350003', 1),
(5, '9789164200001', 2);

-- =========================================================
-- Hämta, filtrera och sortera data -- 
-- =========================================================
-- hämta -- 
USE bokhandel; 
SELECT * 
FROM Kunder;

SELECT * 
FROM Beställningar;

-- Filtrera -- 
SELECT * 
FROM Kunder
WHERE Namn = 'Anna Svensson';

SELECT * 
FROM Kunder
WHERE Epost LIKE '%example.com';

-- Sortera -- 
SELECT * 
FROM Böcker
ORDER BY Pris ASC;

SELECT * 
FROM Böcker
ORDER BY Pris DESC;

-- =====================================================
-- Update, delete och transaktioner -- 
-- =====================================================
START TRANSACTION;

UPDATE Kunder
SET Epost = 'anna.ny@example.com'
WHERE Kund_ID = 1;

SELECT * 
FROM Kunder
WHERE Kund_ID = 1;

ROLLBACK;

SELECT * 
FROM Kunder
WHERE Kund_ID = 1;


START TRANSACTION;

DELETE FROM Kunder
WHERE Namn = 'Sara Nilsson';

SELECT * 
FROM Kunder;

ROLLBACK;

SELECT * 
FROM Kunder;

-- ===============================================
-- Join, Group by och havning -- 
-- ===============================================
-- innre join -- 
SELECT 
    K.Kund_ID,
    K.Namn,
    B.Order_ID,
    B.Datum,
    B.Totalbelopp
FROM Kunder K
INNER JOIN Beställningar B ON K.Kund_ID = B.Kund_ID;

-- Left join -- 
SELECT 
    K.Kund_ID,
    K.Namn,
    B.Order_ID,
    B.Datum,
    B.Totalbelopp
FROM Kunder K
LEFT JOIN Beställningar B ON K.Kund_ID = B.Kund_ID;

-- Group by -- 
SELECT 
    K.Kund_ID,
    K.Namn,
    COUNT(B.Order_ID) AS Antal_Bestallningar
FROM Kunder K
LEFT JOIN Beställningar B ON K.Kund_ID = B.Kund_ID
GROUP BY K.Kund_ID, K.Namn;

-- Having -- 
SELECT 
    K.Kund_ID,
    K.Namn,
    COUNT(B.Order_ID) AS Antal_Bestallningar
FROM Kunder K
LEFT JOIN Beställningar B ON K.Kund_ID = B.Kund_ID
GROUP BY K.Kund_ID, K.Namn
HAVING COUNT(B.Order_ID) > 2;

-- ======================================================
-- Index och constraint -- 
-- ======================================================

CREATE INDEX idx_epost ON Kunder(Epost);

ALTER TABLE Böcker
ADD CONSTRAINT chk_pris_positivt CHECK (Pris > 0);

SHOW INDEX FROM Kunder;

-- =======================================================
-- loggtabell 
-- =======================================================
CREATE TABLE Kundlogg (
    Logg_ID INT AUTO_INCREMENT PRIMARY KEY,
    Kund_ID INT,
    Namn VARCHAR(255),
    Registrerad_Datum DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Triggers  -- 
DELIMITER $$

CREATE TRIGGER trg_minska_lager_efter_order
AFTER INSERT ON Orderrader
FOR EACH ROW
BEGIN
    UPDATE Böcker
    SET Lagerstatus = Lagerstatus - NEW.Antal
    WHERE ISBN = NEW.ISBN;
END$$


CREATE TRIGGER trg_logga_ny_kund
AFTER INSERT ON Kunder
FOR EACH ROW
BEGIN
    INSERT INTO Kundlogg (Kund_ID, Namn)
    VALUES (NEW.Kund_ID, NEW.Namn);
END$$

DELIMITER ;

-- ======================================================
-- Test av trigger 1: lagersaldo
-- ======================================================

SELECT ISBN, Titel, Lagerstatus
FROM Böcker
WHERE ISBN = '9789100170002';

INSERT INTO Orderrader (Order_ID, ISBN, Antal)
VALUES (2, '9789100170002', 1);

SELECT ISBN, Titel, Lagerstatus
FROM Böcker
WHERE ISBN = '9789100170002';

-- ======================================================
-- Test av trigger 2: kundlogg
-- ======================================================

INSERT INTO Kunder (Namn, Epost, Telefon, Adress)
VALUES ('Test Kund', 'testkund@example.com', '0700000000', 'Testgatan 1');

SELECT * FROM Kundlogg;

