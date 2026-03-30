-- Slutprojekt Databaser -- 
-- Restaurang Bokningssystem -- 
-- Mohamad Sallat -- 

-- ===================================
CREATE DATABASE restaurang_db;
USE restaurang_db;

-- Tabell kunder -- 
CREATE TABLE kunder (
    kund_id INT AUTO_INCREMENT PRIMARY KEY,
    namn VARCHAR(100) NOT NULL,
    telefon VARCHAR(20) NOT NULL UNIQUE,
    epost VARCHAR(100) UNIQUE
);

-- Tabell restaurang_bord -- 
CREATE TABLE restaurang_bord (
    bord_id INT AUTO_INCREMENT PRIMARY KEY,
    bordsnummer INT NOT NULL UNIQUE,
    antal_platser INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Ledigt',
    CHECK (antal_platser > 0),
    CHECK (status IN ('Ledigt', 'Bokat'))
   );

 -- Tabell Bokningar -- 
 CREATE TABLE bokningar (
    bokning_id INT AUTO_INCREMENT PRIMARY KEY,
    kund_id INT NOT NULL,
    bord_id INT NOT NULL,
    bokningsdatum DATE NOT NULL,
    bokningstid TIME NOT NULL,
    antal_personer INT NOT NULL DEFAULT 1,
    skapad_tid TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_bokning_kund
        FOREIGN KEY (kund_id) REFERENCES kunder(kund_id),
        
    CONSTRAINT fk_bokning_bord
        FOREIGN KEY (bord_id) REFERENCES restaurang_bord(bord_id),

    CHECK (antal_personer > 0),

    CONSTRAINT unik_bokningstid
        UNIQUE (bord_id, bokningsdatum, bokningstid)
);

-- Tabell logg -- 
CREATE TABLE logg (
    logg_id INT AUTO_INCREMENT PRIMARY KEY,
    meddelande VARCHAR(255) NOT NULL,
    skapad_tid TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger 
-- när en bokning läggs till 
-- skriv ett meddelande i loggen 
-- uppdatera bordets status till bokat 

DELIMITER $$

CREATE TRIGGER trg_efter_bokning
AFTER INSERT ON bokningar
FOR EACH ROW
BEGIN
    INSERT INTO logg (meddelande)
    VALUES (
        CONCAT(
            'Ny bokning skapad. BokningID: ',
            NEW.bokning_id,
            ', KundID: ',
            NEW.kund_id,
            ', BordID: ',
            NEW.bord_id
        )
    );

    UPDATE restaurang_bord
    SET status = 'Bokat'
    WHERE bord_id = NEW.bord_id;
END$$

DELIMITER ;


-- testdata -- 
INSERT INTO kunder (namn, telefon, epost) VALUES
('Ali Hassan', '0701234567', 'ali@mail.com'),
('Sara Nilsson', '0702345678', 'sara@mail.com'),
('Erik Larsson', '0703456789', 'erik@mail.com');

INSERT INTO restaurang_bord (bordsnummer, antal_platser) VALUES
(1, 2),
(2, 4),
(3, 6),
(4, 8);

INSERT INTO bokningar (kund_id, bord_id, bokningsdatum, bokningstid, antal_personer) VALUES
(1, 1, '2026-04-05', '18:00:00', 2),
(2, 2, '2026-04-05', '19:00:00', 4),
(3, 3, '2026-04-06', '20:00:00', 5);

-- innehåll i tabellerna -- 
SELECT * FROM kunder;
SELECT * FROM restaurang_bord;
SELECT * FROM bokningar;
SELECT * FROM logg;

-- Join visa kundnamn, bordnr, datum och tid för bokningar 
SELECT 
    b.bokning_id,
    k.namn AS kund_namn,
    rb.bordsnummer,
    b.bokningsdatum,
    b.bokningstid,
    b.antal_personer
FROM bokningar b
JOIN kunder k ON b.kund_id = k.kund_id
JOIN restaurang_bord rb ON b.bord_id = rb.bord_id
ORDER BY b.bokningsdatum, b.bokningstid;

-- =====================================================
-- GROUP BY-fråga
-- Visa hur många bokningar varje kund har gjort
-- =====================================================
SELECT 
    k.namn AS kund_namn,
    COUNT(b.bokning_id) AS antal_bokningar
FROM kunder k
LEFT JOIN bokningar b ON k.kund_id = b.kund_id
GROUP BY k.kund_id, k.namn
ORDER BY antal_bokningar DESC;

-- group by Visa hur många gånger varje bord har bokats 

SELECT
    rb.bordsnummer,
    COUNT(b.bokning_id) AS antal_bokningar
FROM restaurang_bord rb
LEFT JOIN bokningar b ON rb.bord_id = b.bord_id
GROUP BY rb.bord_id, rb.bordsnummer
ORDER BY rb.bordsnummer;




