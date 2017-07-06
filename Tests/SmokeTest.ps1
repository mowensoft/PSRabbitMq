$username = 'guest'
$password = ConvertTo-SecureString 'guest' -AsPlainText -Force
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password
$headers = @{'NServiceBus.EnclosedMessageTypes' = 'Afc.Messages.SomeMessage'}
$messageId = [System.Guid]::NewGuid().ToString('D')
$message = '<MyFirstMessage />'

Send-RabbitMqMessage `
    -ComputerName 'localhost' `
    -Exchange 'Afc.PolicyAdmin.NewBusiness.Host.Errors' `
    -vhost 'PasHost' `
    -Key ([string]::Empty) `
    -Credential $credential `
    -headers $headers `
    -MessageID $messageId `
    -ContentType 'text/xml' `
    -SerializeAs 'text/xml' `
    -InputObject $message `
    -Persistent

