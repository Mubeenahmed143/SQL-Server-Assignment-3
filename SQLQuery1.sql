create database class;
use class;

------------------------------------------------------------TRIGGERS-------------------------------------------------------------------

create table Students
    (
     S_ID int identity,
     S_Name varchar(255),
     S_Batch varchar(255),
     Roll_Number int
    );

INSERT INTO Students (S_Name, S_Batch, Roll_Number)
VALUES
    ('Ali Khan', 'Batch A', 101),
    ('Sara Ahmed', 'Batch B', 102),
    ('Ahmed Hassan', 'Batch C', 103),
    ('Fatima Khan', 'Batch B', 104),
    ('Mohammad Khan', 'Batch A', 105),
    ('Aisha Malik', 'Batch C', 106),
    ('Usman Ali', 'Batch A', 107),
    ('Ayesha Ahmed', 'Batch B', 108),
    ('Bilal Khan', 'Batch A', 109),
    ('Hina Raza', 'Batch C', 110);



	create table Students_Audit 
			(
			S_id int,
			S_name varchar(200),
			S_batch varchar(100),
			Roll_num int,

			Action_Performed NVARCHAR(100),
			Time_Of_Action Datetime
			);
			

			

                    ------------------Insert------------------
			create Trigger Std_Insert
			ON Students
			for insert 
			AS
			   Begin 
			          Declare @Std_ID int
			          Declare @Std_Name varchar(200)
			          Declare @Std_Batch varchar(100)
					  Declare @Std_Roll int
			          Declare @Audit varchar(200)

			          select @Std_ID = S_ID from inserted
			          select @Std_Name = S_Name from inserted
			          select @Std_Batch = S_Batch from inserted
			          select @Std_Roll = Roll_Number from inserted


				      Set @Audit = 'Insert Action'

				      INSERT INTO Students_Audit (S_id, S_name, S_batch, Roll_num, Action_Performed, Time_Of_Action)
                      VALUES (@Std_ID, @Std_Name, @Std_Batch, @Std_Roll, @Audit, GETDATE());


				End

				          ---Check---
				INSERT INTO Students (S_Name, S_Batch, Roll_Number)
                VALUES    ('Hanif Khan', 'Batch D', 111);


                    ------------------Delete------------------
			create Trigger Std_Delete
			ON Students
			for delete 
			AS
			   Begin 
			          Declare @Std_ID int
			          Declare @Std_Name varchar(200)
			          Declare @Std_Batch varchar(100)
					  Declare @Std_Roll int
			          Declare @Audit varchar(200)

			          select @Std_ID = S_ID from deleted
			          select @Std_Name = S_Name from deleted
			          select @Std_Batch = S_Batch from deleted
			          select @Std_Roll = Roll_Number from deleted


				      Set @Audit = 'Delete Action'

				      INSERT INTO Students_Audit (S_id, S_name, S_batch, Roll_num, Action_Performed, Time_Of_Action)
                      VALUES (@Std_ID, @Std_Name, @Std_Batch, @Std_Roll, @Audit, GETDATE());


				End

				---Check---
				Delete from Students where Roll_Number = 111; 

                    ------------------Update------------------
	ALTER TRIGGER Std_Update
ON Students
FOR UPDATE 
AS
BEGIN 
    DECLARE @Std_ID INT
    DECLARE @Audit VARCHAR(200)
    DECLARE @Std_Name VARCHAR(200)
    DECLARE @S_Name VARCHAR(200)
    DECLARE @Std_Batch VARCHAR(100)
    DECLARE @S_Batch VARCHAR(100)
    DECLARE @Std_Roll INT
    DECLARE @S_Roll INT

    SELECT @Std_ID = S_ID FROM inserted
    SET @Audit = 'Update Action'

    SELECT @Std_Name = S_Name FROM inserted
    SELECT @S_Name = S_Name FROM deleted
    SELECT @Std_Batch = S_Batch FROM inserted
    SELECT @S_Batch = S_Batch FROM deleted
    SELECT @Std_Roll = Roll_Number FROM inserted
    SELECT @S_Roll = Roll_Number FROM deleted

    INSERT INTO Students_Audit (S_id, S_name, S_batch, Roll_num, Action_Performed, Time_Of_Action)
    VALUES (
        @Std_ID,
        'Updated ' + @Std_Name + ' Old ' + @S_Name,
        'Updated ' + @Std_Batch + ' Old ' + @S_Batch,
        'Updated ' + CONVERT(VARCHAR(20), @Std_Roll) + ' Old ' + CONVERT(VARCHAR(20), @S_Roll),
        @Audit,
        GETDATE()
    );
END;



				---Check---
				Update Students Set S_Name = 'Muhammad Zaid' where S_ID = 5;


				select * from Students;
	            select * from Students_Audit;










				
create Trigger Std_Update
			ON Students
			for update 
			AS
			   Begin 
			          Declare @Std_ID int
			          Declare @Audit varchar(200)
			          Declare @Std_Name varchar(200)
			          Declare @S_Name varchar(200)
			          Declare @Std_Batch varchar(100)
			          Declare @S_Batch varchar(100)
					  Declare @Std_Roll int
					  Declare @S_Roll int

			          select @Std_ID = S_ID from inserted
				      Set @Audit = 'Update Action'

			          select @Std_Name = S_Name from inserted
					  select @S_Name = S_Name from deleted
			          select @Std_Batch = S_Batch from inserted
					  select @S_Batch = S_Batch from deleted
			          select @Std_Roll = Roll_Number from inserted
					  select @S_Roll = Roll_Number from deleted



				      INSERT INTO Students_Audit (S_id, S_name, S_batch, Roll_num, Action_Performed, Time_Of_Action)
                      VALUES (@Std_ID,'Updated ' + @Std_Name + ' Old ' + @S_Name,'Updated ' + @Std_Batch + ' Old ' + @S_Batch,
					  'Updated ' + @Std_Roll + ' Old ' + @S_Roll, @Audit, GETDATE());


				End--