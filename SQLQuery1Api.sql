CREATE DATABASE BitStoredDB
GO

USE BitStoredDB
GO

CREATE TABLE Usuarios (
    Id INT PRIMARY KEY IDENTITY(1,1),
    NombreUsuario NVARCHAR(50),
    Email NVARCHAR(50),
    Contrasena NVARCHAR(256),
    TipoUsuario NVARCHAR(50),
    Status NVARCHAR(20)
);

SELECT * FROM Usuarios
DELETE FROM Usuarios;
