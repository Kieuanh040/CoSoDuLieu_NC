--In ra các số nhỏ hơn 100 và lớn hơn 50.
DECLARE @chiso INT
set @chiso = 51
WHILE @chiso<100
BEGIN
    print 'Gia tri ' + cast(@chiso as varchar)
    set @chiso=@chiso+1
END
--In ra các số chẵn từ 1 đến 100.
DECLARE @so1 INT
SET @so1=2
WHILE @so1<=100
BEGIN
    print @so1
    set @so1=@so1+2
END
--In ra các trong khoảng [20, 40] và [50, 60].
DECLARE @so2 INT
SET @so2=20
WHILE @so2<=60
BEGIN
    IF @so2<=40 or @so2>=50
        print @so2
    set @so2=@so2+1
END