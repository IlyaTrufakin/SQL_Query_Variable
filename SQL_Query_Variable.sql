USE [Library]
GO



--показать имена преподавателей и названия книг, которые они взяли в библиотеке:
CREATE VIEW TeacherAndBooks
AS
SELECT Teacher.first_name AS 'Имя учителя', Teacher.last_name AS 'Фамилия учителя', Book.name AS Книга
FROM Teacher
JOIN T_Cards ON Teacher.id = T_Cards.id_teacher
JOIN Book ON Book.id = T_Cards.id_book;

SELECT * FROM TeacherAndBooks;



--показать имена студентов, которые взяли, но не вернули книги
CREATE VIEW StudentsAndBooks
AS
SELECT Student.first_name AS 'Имя студента', Student.last_name AS 'Фамилия студента'
FROM Student
JOIN S_Cards ON Student.id = S_Cards.id_student
WHERE S_Cards.date_in IS NULL;

SELECT * FROM StudentsAndBooks;


--показать имена студентов никогда не бравших книг
CREATE VIEW StudentsWithoutBooks
AS
SELECT Student.first_name AS 'Имя студента', Student.last_name AS 'Фамилия студента'
FROM Student
LEFT JOIN S_Cards ON Student.id = S_Cards.id_student
WHERE S_Cards.id IS NULL;


SELECT * FROM StudentsWithoutBooks;



--показать  имя библиотекаря, который выдал больше всего книг
-- 1й вариант: НЕ используя order by:
CREATE VIEW TopLibrarian
AS
SELECT Librarian.first_name AS 'Имя библиотекаря', Librarian.last_name AS 'Фамилия библиотекаря', books_count AS 'Выдано книг'
FROM (SELECT id_librarian, COUNT(*) AS books_count
		FROM (SELECT id_librarian FROM S_Cards UNION ALL SELECT id_librarian FROM T_Cards) AS all_cards
			  GROUP BY id_librarian
			  HAVING COUNT(*) = (SELECT MAX(books_count) 
					FROM (SELECT COUNT(*) AS books_count
						FROM (SELECT id_librarian FROM S_Cards UNION ALL SELECT id_librarian FROM T_Cards) AS all_cards
						GROUP BY id_librarian) 
			  AS max_counts)
	) AS ctss
JOIN Librarian ON ctss.id_librarian = Librarian.id;


-- 2й вариант: используя order by:
CREATE VIEW TopLibrarian
AS
SELECT TOP 1 Librarian.first_name AS 'Имя библиотекаря', Librarian.last_name AS 'Фамилия библиотекаря', books_count AS 'Выдано книг'
FROM (SELECT id_librarian, COUNT(*) AS books_count
	FROM (SELECT id_librarian FROM S_Cards UNION ALL SELECT id_librarian FROM T_Cards) AS all_cards
	GROUP BY id_librarian
) AS count_all
JOIN Librarian ON count_all.id_librarian = Librarian.id
ORDER BY books_count DESC;

SELECT * FROM TopLibrarian;




--показать  имя библиотекаря, которому вернули больше всего книг
--  используя order by:
CREATE VIEW TopReturningLibrarian
AS
SELECT TOP 1 Librarian.first_name AS 'Имя библиотекаря', Librarian.last_name AS 'Фамилия библиотекаря', COUNT(*) AS returned_books_count
FROM Librarian
JOIN (SELECT id_librarian, date_in FROM S_Cards UNION ALL SELECT id_librarian, date_in FROM T_Cards) AS all_cards 
ON Librarian.id = all_cards.id_librarian
WHERE all_cards.date_in IS NOT NULL
GROUP BY Librarian.first_name, Librarian.last_name
ORDER BY returned_books_count DESC;

SELECT * FROM TopReturningLibrarian;






