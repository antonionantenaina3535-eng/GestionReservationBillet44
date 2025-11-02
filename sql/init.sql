-- Active la vérification des clés étrangères (optionnelle, activée par défaut dans MariaDB)
SET FOREIGN_KEY_CHECKS = 1;

-- Création de la table des utilisateurs
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user') NOT NULL
);

-- Création de la table des clients
CREATE TABLE IF NOT EXISTS clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    telephone VARCHAR(20)
);

-- Création de la table des vols
CREATE TABLE IF NOT EXISTS vols (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    date DATE NOT NULL,
    heure TIME NOT NULL,
    compagnie VARCHAR(100),
    prix DECIMAL(10,2) DEFAULT 0
);

-- Création de la table des réservations
CREATE TABLE IF NOT EXISTS reservations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    vol_id INT NOT NULL,
    date_reservation DATE NOT NULL,
    statut VARCHAR(50) NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE CASCADE,
    FOREIGN KEY (vol_id) REFERENCES vols(id) ON DELETE CASCADE
);

-- Insertion des utilisateurs (utilise INSERT IGNORE pour éviter les doublons)
INSERT IGNORE INTO users (username, password, role) VALUES ('admin', 'admin123', 'admin');
INSERT IGNORE INTO users (username, password, role) VALUES ('user', 'user123', 'user');

-- Insertion des clients
INSERT IGNORE INTO clients (nom, prenom, email, telephone)
VALUES 
('Dupont', 'Jean', 'jean.dupont@example.com', '+33123456789'),
('Martin', 'Claire', 'claire.martin@example.com', '+33788990011');

-- Insertion des vols
INSERT IGNORE INTO vols (code, destination, date, heure, compagnie, prix)
VALUES 
('AF123', 'Paris', '2025-11-01', '08:30:00', 'AirFrance', 150.00),
('BA456', 'Londres', '2025-11-02', '12:00:00', 'BritishAirways', 120.00);

-- Insertion d'une réservation
INSERT IGNORE INTO reservations (client_id, vol_id, date_reservation, statut)
VALUES (1, 1, '2025-09-30', 'Confirmée');
