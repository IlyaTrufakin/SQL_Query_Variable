


--1. �������� �������������� ����� �� �������� ������ @L
--�����������
DECLARE @StarsCount INT = 10
WHILE (@StarsCount>0)
BEGIN
  PRINT '*'
  SET @StarsCount = @StarsCount - 1
END

--�������������
DECLARE @StarsCountH INT = 10
DECLARE @String nvarchar(max) = ''
WHILE (@StarsCountH>0)
BEGIN
	SET @String = @String + '*'
	SET @StarsCountH = @StarsCountH - 1
END
PRINT @String




--2. ������ ���������, ����� ������ ����� �����, � ����� ����������� "������ �����!" ��� "������ ����!"
DECLARE @CurrentTime TIME = GETDATE()
DECLARE @Message NVARCHAR(max)

IF @CurrentTime >= '04:30:00' AND @CurrentTime < '11:00:00'
	SET @Message = '������ ����!'

ELSE IF @CurrentTime >= '11:00:00' AND @CurrentTime < '17:00:00'
    SET @Message = '������ ����!'

ELSE IF @CurrentTime >= '17:00:00' AND @CurrentTime < '23:00:00'
    SET @Message = '������ �����!'

ELSE
    SET @Message = '������ ����!'

PRINT @Message




--3. ������ ���������� ��������� ������� ������ ������ @N ��������
DECLARE @PasswordLength INT = 10 --  �������� ����� ������
DECLARE @AvailableCharacters NVARCHAR(100) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_+='
DECLARE @Password NVARCHAR(max) = ''

WHILE (@PasswordLength >0)

BEGIN
    DECLARE @RandomIndex INT = ROUND(RAND() * (LEN(@AvailableCharacters) - 1) + 1, 0)
    SET @Password = @Password + SUBSTRING(@AvailableCharacters, @RandomIndex, 1)
    SET @PasswordLength = @PasswordLength - 1
END

PRINT @Password



--4. �������� ���������� ���� ����� �� 0 �� 25
DECLARE @Number INT = 0
DECLARE @Factorial NUMERIC(38, 0) = 1

WHILE (@Number <= 25)
BEGIN
    PRINT '��������� ����� ' + CAST(@Number AS NVARCHAR(10)) + ': ' + CAST(@Factorial AS NVARCHAR(50))
    SET @Number = @Number + 1
    SET @Factorial = @Factorial * @Number
END




--5. �������� ��� ������� ����� �� 3 �� 100000 (� �������� ����.����� �� �������, ������� ����� ������������)
DECLARE @start INT = 3
DECLARE @end INT = 100000
DECLARE @primes TABLE (  Number INT) -- �������� ��������� ������� ��� �������� ���������� � ������� ������

WHILE (@start <= @end)
BEGIN
  DECLARE @isPrime BIT = 1
  DECLARE @divisor INT = 2

   -- ��������, �������� �� ����� �������
  WHILE (@divisor * @divisor <= @start)
  BEGIN
    IF (@start % @divisor = 0)
    BEGIN
      SET @isPrime = 0
      BREAK
    END
    SET @divisor = @divisor + 1
  END
   -- ���� ����� �������, ��������� ��� � �������
  IF (@isPrime = 1) INSERT INTO @primes (Number) VALUES (@start)

  SET @start = @start + 1
END

SELECT Number -- ����� ������� ������� �����
FROM @primes






--6. �������� ������ ���� ���������� ���������� �������
DECLARE @TicketNumber INT = 100000

WHILE (@TicketNumber <= 999999)
BEGIN
    DECLARE @TicketString NVARCHAR(6) = RIGHT('000000' + CAST(@TicketNumber AS NVARCHAR(6)), 6) -- �������������� � ������ 6 �����.

	-- ��������� ����� 3� ����� �����
    DECLARE @SumLeftHalf INT =
        CAST(SUBSTRING(@TicketString, 1, 1) AS INT) +
        CAST(SUBSTRING(@TicketString, 2, 1) AS INT) +
        CAST(SUBSTRING(@TicketString, 3, 1) AS INT)

	-- ��������� ����� 3� ������ �����
    DECLARE @SumRightHalf INT =
        CAST(SUBSTRING(@TicketString, 4, 1) AS INT) +
        CAST(SUBSTRING(@TicketString, 5, 1) AS INT) +
        CAST(SUBSTRING(@TicketString, 6, 1) AS INT)

    IF (@SumLeftHalf = @SumRightHalf) -- ��������� ����
    PRINT @TicketString

    SET @TicketNumber = @TicketNumber + 1

END