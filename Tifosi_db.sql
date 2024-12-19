/*Création de la structure de la base de données */

CREATE SCHEMA IF NOT EXISTS `tifosi` DEFAULT CHARACTER SET utf8mb4;
USE `tifosi`;

/* Création de l'utilisateur tifosi */
CREATE USER 'tifosi'@'localhost' IDENTIFIED BY 'CharlyCEF';
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';
FLUSH PRIVILEGES;


/*Création des tables princiaples*/
CREATE TABLE client (
    id_client INT PRIMARY KEY,
    nom_client VARCHAR(45) NOT NULL,
    age INT,
    cp_client INT
);
CREATE TABLE ingredient (
    id_ingredient INT PRIMARY KEY,
    nom_ingredient VARCHAR(45) NOT NULL
);
CREATE TABLE focaccia (
    id_focaccia INT PRIMARY KEY,
    nom_focaccia VARCHAR(45) NOT NULL,
    prix_focaccia FLOAT NOT NULL
);
CREATE TABLE marque (
    id_marque INT PRIMARY KEY,
    nom_marque VARCHAR(45)
);
CREATE TABLE boisson (
    id_boisson INT PRIMARY KEY,
    nom_boisson VARCHAR(45)
);
CREATE TABLE menu (
    id_menu INT PRIMARY KEY,
    nom_menu VARCHAR(45) NOT NULL,
    prix_menu FLOAT NOT NULL
);

/*Création des tables relationelles*/
CREATE TABLE achete (
	jour DATE NOT NULL,
    id_client INT,
    id_focaccia INT,
    CONSTRAINT pk_achete PRIMARY KEY (id_client, id_focaccia),
    CONSTRAINT fk_client1 FOREIGN KEY (id_client) REFERENCES client (id_client) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_focaccia1 FOREIGN KEY (id_focaccia) REFERENCES focaccia (id_focaccia) ON DELETE RESTRICT ON UPDATE CASCADE 
);
CREATE TABLE comprend (
    id_focaccia INT,
    id_ingredient INT,
    CONSTRAINT pk_comprend PRIMARY KEY (id_focaccia, id_ingredient),
    CONSTRAINT fk_focaccia2 FOREIGN KEY (id_focaccia) REFERENCES focaccia (id_focaccia) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_ingredient FOREIGN KEY (id_ingredient) REFERENCES ingredient (id_ingredient) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE paye (
    jour DATE NOT NULL,
    id_client INT,
    id_menu INT,
    CONSTRAINT pk_paye PRIMARY KEY (id_client, id_menu),
    CONSTRAINT fk_client2 FOREIGN KEY (id_client) REFERENCES client (id_client) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_menu1 FOREIGN KEY (id_menu) REFERENCES menu (id_menu) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE contient (
    id_menu INT,
    id_boisson INT,
    CONSTRAINT pk_contient PRIMARY KEY (id_menu, id_boisson),
    CONSTRAINT fk_menu2 FOREIGN KEY (id_menu) REFERENCES menu (id_menu) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_boisson1 FOREIGN KEY (id_boisson) REFERENCES boisson (id_boisson) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE constitue (
    id_menu INT UNIQUE,
    id_focaccia INT,
    CONSTRAINT pk_constitue PRIMARY KEY (id_menu, id_focaccia),
    CONSTRAINT fk_menu3 FOREIGN KEY (id_menu) REFERENCES menu (id_menu) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_focaccia3 FOREIGN KEY (id_focaccia) REFERENCES focaccia (id_focaccia) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE appartient (
    id_boisson INT UNIQUE,
    id_marque INT,
    CONSTRAINT pk_appartient PRIMARY KEY (id_marque, id_boisson),
    CONSTRAINT fk_boisson2 FOREIGN KEY (id_boisson) REFERENCES boisson (id_boisson) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_marque FOREIGN KEY (id_marque) REFERENCES marque (id_marque) ON DELETE RESTRICT ON UPDATE CASCADE
)

