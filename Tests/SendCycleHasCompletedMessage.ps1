$hostname = 'hapd-esbmsg001.afcorp.afg'
$exchange = 'Afc.Enterprise.Mail.Backend.Errors'
$vhost = '/'
$username = 'Matt'
$password = ConvertTo-SecureString 'pas' -AsPlainText -Force
$messageType = 'Afc.PolicyAdmin.Integration.Cycle.Messages.Events.ICycleHasCompleted, Afc.PolicyAdmin.Integration.Cycle.Messages'
$message = '<ICycleHasCompleted />'

###############################################################################
#
# Modifying anything below this line will void the warranty!
#
###############################################################################

if (Get-Module 'PSRabbitMQ') {
    Remove-Module 'PSRabbitMQ'
}

Import-Module '..\PSRabbitMQ'

$messageId = [System.Guid]::NewGuid().ToString('D')
$headers = @{'NServiceBus.EnclosedMessageTypes' = $messageType}
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password

Send-RabbitMqMessage `
    -ComputerName $hostname `
    -Exchange $exchange `
    -vhost $vhost `
    -Ssl ([Security.Authentication.SslProtocols]::Tls12) `
    -Key ([string]::Empty) `
    -Credential $credential `
    -headers $headers `
    -MessageID $messageId `
    -ContentType 'text/xml' `
    -SerializeAs 'text/xml' `
    -InputObject $message `
    -Persistent

