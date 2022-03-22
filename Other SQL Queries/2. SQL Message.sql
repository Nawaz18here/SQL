Declare @LL int, @UL int Select @LL=1, @UL=25
WHILE (@LL<@UL)
	BEGIN
		PRINT ('Hello !!!!, I like you')
		Set @LL=@LL+1
		IF(@LL=@UL)
		BEGIN
			PRINT ('You have entered ' + 'Hello !!!!, I like you ' + CAST(@LL as varchar)+ ' times, its enough for today,' + 'You can tell later now!!')
		END
END
