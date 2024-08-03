USE [16store]
GO
/****** Object:  StoredProcedure [dbo].[Access]    Script Date: 7/25/2024 3:50:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        <Edwin.Hernandez>
-- Create date: <01-06-2024>
-- Description:    <Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Access]
    @Method NVARCHAR(100),
    @Email NVARCHAR(200) = null,
    @Password NVARCHAR(50) = null,
    @Nombre NVARCHAR(255) = NULL,
    @TipoDeUsuario NVARCHAR(50) = NULL,
    @NewPassword NVARCHAR(50) = NULL
AS
BEGIN
    IF (@Method = 'login')
    BEGIN
        IF @Email IS NULL or @Email = ''
        BEGIN
            SELECT 
            0 AS 'IsSuccess',
            'Es requerido enviar un correo' AS Message
            Return
        END
        
        IF @Password IS NULL or @Password = ''
        BEGIN
            SELECT 
            0 AS 'IsSuccess',
            'Es requerido enviar una contrasena' AS Message
            Return
        END
        Declare @Exists int
        
        SELECT  
        @Exists = COUNT(Id)
        FROM [16Store].[dbo].[Usuarios] where Correo = @Email and Estatus = 1

        IF @Exists <= 0
        BEGIN
            SELECT 
            0 AS 'IsSuccess',
            'EL USUARIO INGRESADO NO EXISTE' AS Message
            Return
        END

        DECLARE @UserId INT
        DECLARE @StoredPassword NVARCHAR(255)

        SELECT 
            @UserId = Id,
            @StoredPassword = Password
        FROM [16Store].[dbo].[Usuarios]
        WHERE Correo = @Email AND Estatus = 1

        IF @StoredPassword <> @Password
        BEGIN
            SELECT 
                0 AS 'IsSuccess',
                'Contraseña incorrecta' AS Message
            RETURN
        END
        SELECT 
            1 AS 'IsSuccess',
            'Has ingresado' AS Message,
            Id,
            Correo,
            Nombre,
            TipoDeUsuario,
            Estatus
        FROM [16Store].[dbo].[Usuarios]
        WHERE Id = @UserId

        Return
    END




    IF (@Method = 'register')
    BEGIN
        -- Validación de campos requeridos
        IF @Email IS NULL OR @Email = ''
        BEGIN
            SELECT 
                0 AS 'IsSuccess',
                'El correo es requerido' AS 'Message'
            RETURN
        END

        -- Validación del formato del correo
        IF NOT (@Email LIKE '%_@__%.__%')
        BEGIN
            SELECT 
                0 AS 'IsSuccess',
                'El formato del correo es inválido' AS 'Message'
            RETURN
        END

        IF @Password IS NULL OR @Password = ''
        BEGIN
            SELECT 
                0 AS 'IsSuccess',
                'La contraseña es requerida' AS 'Message'
            RETURN
        END

        IF @Nombre IS NULL OR @Nombre = ''
        BEGIN
            SELECT 
                0 AS 'IsSuccess',
                'El nombre es requerido' AS 'Message'
            RETURN
        END

        IF @TipoDeUsuario IS NULL OR @TipoDeUsuario = ''
        BEGIN
            SELECT 
                0 AS 'IsSuccess',
                'El tipo de usuario es requerido' AS 'Message'
            RETURN
        END

        -- Verificación de existencia de usuario
        IF EXISTS (SELECT 1 FROM [16store].[dbo].[Usuarios] WHERE Correo = @Email)
        BEGIN
            SELECT 
                0 AS 'IsSuccess',
                'El correo ya está registrado' AS 'Message'
            RETURN
        END

        -- Inserción del nuevo usuario
        INSERT INTO [16store].[dbo].[Usuarios] (Correo, Password, Nombre, TipoDeUsuario, Estatus)
        VALUES (@Email, @Password, @Nombre, @TipoDeUsuario, 1)

        SELECT 
            1 AS 'IsSuccess',
            'Registro exitoso' AS 'Message'
        RETURN
    END

    IF (@Method = 'recovery_check')
    BEGIN
        SELECT 
            1 AS 'IsSuccess',
            'Usuario encontrado' AS Message,
            Password
        FROM [16store].[dbo].[Usuarios]
        WHERE Correo = @Email
        RETURN
    END

    IF (@Method = 'recovery_change')
    BEGIN
        UPDATE [16store].[dbo].[Usuarios]
        SET Password = @NewPassword
        WHERE Correo = @Email

        SELECT 
            1 AS 'IsSuccess',
            'Contraseña actualizada exitosamente' AS Message
        RETURN
    END    
END


SELECT * FROM Usuarios


EXEC [dbo].[Access]
    @Method = 'login',
    @Email = 'vani2@gmail.com',
    @Password = 'maricon';

USE [16store]

select * from productos
GO

-- Insertar 50 productos de ejemplo en la tabla Productos

INSERT INTO productos (clasificacion, codigo_del_producto, nombre_del_producto, precio, cantidad_en_stock) VALUES 
('Electrónica', 'E005', 'Smartphone', 499.99, 30),
('Electrónica', 'E006', 'Smartwatch', 199.99, 60),
('Electrónica', 'E007', 'Laptop', 799.99, 15),
('Electrónica', 'E008', 'Televisor', 999.99, 20),
('Electrónica', 'E009', 'Auriculares', 79.99, 50),
('Electrónica', 'E010', 'Altavoces', 149.99, 35),
('Electrodomésticos', 'A005', 'Lavadora', 450.00, 8),
('Electrodomésticos', 'A006', 'Secadora', 400.00, 7),
('Electrodomésticos', 'A007', 'Licuadora', 60.00, 25),
('Electrodomésticos', 'A008', 'Cafetera', 80.00, 30),
('Electrodomésticos', 'A009', 'Horno', 350.00, 5),
('Electrodomésticos', 'A010', 'Aspiradora', 120.00, 20),
('Hogar', 'H005', 'Espejo', 25.00, 50),
('Hogar', 'H006', 'Sillón', 200.00, 10),
('Hogar', 'H007', 'Mesa de Centro', 150.00, 15),
('Hogar', 'H008', 'Estantería', 100.00, 12),
('Hogar', 'H009', 'Alfombra', 75.00, 30),
('Hogar', 'H010', 'Cojines', 20.00, 40),
('Ropa', 'R005', 'Pantalones', 50.00, 80),
('Ropa', 'R006', 'Camiseta', 20.00, 100),
('Ropa', 'R007', 'Sudadera', 45.00, 70),
('Ropa', 'R008', 'Falda', 35.00, 60),
('Ropa', 'R009', 'Gorra', 15.00, 90),
('Ropa', 'R010', 'Guantes', 10.00, 50),
('Juguetes', 'J005', 'Muñeca', 25.00, 100),
('Juguetes', 'J006', 'Pelota', 10.00, 120),
('Juguetes', 'J007', 'Coche de Juguete', 30.00, 80),
('Juguetes', 'J008', 'Juego de Mesa', 40.00, 50),
('Juguetes', 'J009', 'Peluche', 15.00, 70),
('Juguetes', 'J010', 'Dinosaurio de Juguete', 20.00, 60),
('Deportes', 'D001', 'Bicicleta', 300.00, 10),
('Deportes', 'D002', 'Patines', 80.00, 20),
('Deportes', 'D003', 'Balón de Fútbol', 25.00, 50),
('Deportes', 'D004', 'Raqueta de Tenis', 70.00, 15),
('Deportes', 'D005', 'Guantes de Boxeo', 40.00, 25),
('Deportes', 'D006', 'Pesas', 100.00, 30),
('Libros', 'L001', 'Novela', 20.00, 100),
('Libros', 'L002', 'Biografía', 25.00, 80),
('Libros', 'L003', 'Libro de Texto', 50.00, 60),
('Libros', 'L004', 'Revista', 10.00, 150),
('Libros', 'L005', 'Cómic', 15.00, 90),
('Libros', 'L006', 'Diccionario', 30.00, 40),
('Jardinería', 'J011', 'Maceta', 10.00, 200),
('Jardinería', 'J012', 'Regadera', 15.00, 150),
('Jardinería', 'J013', 'Tijeras de Podar', 20.00, 80),
('Jardinería', 'J014', 'Manguera', 25.00, 100),
('Jardinería', 'J015', 'Abono', 30.00, 70),
('Jardinería', 'J016', 'Guantes de Jardín', 10.00, 120);
