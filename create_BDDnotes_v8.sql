set sql_mode = "NO_AUTO_VALUE_ON_ZERO" ;
set time_zone = "+00:00" ;


CREATE TABLE Annee_Scol (
    id_annee int(10) auto_increment PRIMARY KEY,
    lbl_annee VARCHAR(10) COLLATE utf8_unicode_ci NOT NULL,
    date_deb DATE,
    date_fin DATE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE Trimestre (
    id_trim int(10) auto_increment PRIMARY KEY,
    lbl_trim VARCHAR(10) COLLATE utf8_unicode_ci NOT NULL,
    date_deb DATE,
    date_fin DATE,
    id_annee int(10),
    FOREIGN KEY(id_annee) REFERENCES Annee_Scol(id_annee)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE Date_devoir (
    id_devoir int(10) auto_increment PRIMARY KEY,
    date_eval DATE,
    id_trim int(10),
    FOREIGN KEY(id_trim) REFERENCES Trimestre(id_trim)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin; 

CREATE TABLE Prof (
    id_prof int(10) auto_increment PRIMARY KEY,
    nom VARCHAR(50) COLLATE utf8_unicode_ci NOT NULL,
    prenom VARCHAR(50) COLLATE utf8_unicode_ci NOT NULL,
    sexe CHAR(1)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;  

CREATE TABLE Niveau (
   id_niveau int(10) auto_increment PRIMARY KEY,
   lbl_niveau VARCHAR(10) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;  

CREATE TABLE Cours(
    code_cours int(10) auto_increment PRIMARY KEY,
    matiere VARCHAR(50) COLLATE utf8_unicode_ci NOT NULL,
    categ VARCHAR(50),
    id_niveau int(10) NOT NULL,
    FOREIGN KEY(id_niveau) REFERENCES Niveau(id_niveau)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;   

CREATE TABLE Classe(
    id_classe int(10) auto_increment PRIMARY KEY,
    lbl_classe VARCHAR(50) COLLATE utf8_unicode_ci NOT NULL,
    id_niveau int(10) NOT NULL,
    FOREIGN KEY(id_niveau) REFERENCES Niveau(id_niveau)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;   

CREATE TABLE Eleve(
    id_eleve int(10) auto_increment PRIMARY KEY,
    nom VARCHAR(50) COLLATE utf8_unicode_ci NOT NULL,
    prenom VARCHAR(50) COLLATE utf8_unicode_ci NOT NULL,
    sexe CHAR(1),
    date_naiss DATE,
    id_classe int(10) NOT NULL,
    FOREIGN KEY(id_classe) REFERENCES Classe(id_classe)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;   

CREATE TABLE Inscrire(
    id_annee int(10) NOT NULL,
    id_eleve int(10) NOT NULL,
    PRIMARY KEY(id_annee, id_eleve),
    FOREIGN KEY(id_annee) REFERENCES Annee_Scol(id_annee),
    FOREIGN KEY(id_eleve) REFERENCES Eleve(id_eleve)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;   

CREATE TABLE Titulariser(
    id_annee int(10) NOT NULL,
    id_prof int(10) NOT NULL,
    PRIMARY KEY(id_annee, id_prof),
    FOREIGN KEY(id_annee) REFERENCES Annee_Scol(id_annee),
    FOREIGN KEY(id_prof) REFERENCES Prof(id_prof)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;   

CREATE TABLE Evaluer(
    id_devoir int(10) NOT NULL,
    id_eleve int(10) NOT NULL,
    id_prof int(10) NOT NULL,
    code_cours int(10) NOT NULL,
    note DECIMAL(4,2) NOT NULL,
    PRIMARY KEY(id_devoir, id_eleve, id_prof, code_cours),
    FOREIGN KEY(id_devoir) REFERENCES Date_devoir(id_devoir),
    FOREIGN KEY(id_eleve) REFERENCES Eleve(id_eleve),
    FOREIGN KEY(id_prof) REFERENCES Prof(id_prof),
    FOREIGN KEY(code_cours) REFERENCES Cours(code_cours)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;   

CREATE TABLE Enseigner(
    id_prof int(10) NOT NULL,
    code_cours int(10) NOT NULL,
    PRIMARY KEY(id_prof,code_cours),
    FOREIGN KEY(id_prof) REFERENCES Prof(id_prof),
    FOREIGN KEY(code_cours) REFERENCES Cours(code_cours)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;   
