
#!/bin/pwsh

# Name: find_key_items_in_tmsh_conf.sh
# Author Michael Johnson and John Su 09-02-2025

# References: 
# MS Copilot (GPT 5 model)
# https://blog.iisreset.me/openssl-s_client-but-in-powershell/

# Quick implementation of Powershell script to connect , obtain, and display certificate in use by a server
# Can be used for troubleshooting similar to 'openssl s_client -connect' and 'openssl x509 -text'
# Similar openssh would be 'openssl s_client -connect server.example.com:443 -showcerts  </dev/null 2>/dev/null|openssl x509 -text'

using namespace System.Net.Sockets
using namespace System.Net.Security
using namespace System.Security.Cryptography.X509Certificates

# Prompt for FQDN
$fqdn = Read-Host "Enter the FQDN (e.g., www.example.com)"
$port = 443

$client = [TcpClient]::new()
try {
    # Connect to remote endpoint
    $client.Connect($fqdn, $port)

    # Create SSL stream
    $sslStream = [SslStream]::new($client.GetStream(), $false, { $true })

    # Authenticate as client
    $sslStream.AuthenticateAsClient($fqdn)

    # Get the remote certificate
    $cert = $sslStream.RemoteCertificate
    $x509 = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 $cert

    # Output certificate details
    Write-Host "`n--- Certificate Info ---"
    Write-Host "Subject: $($x509.Subject)"
    Write-Host "Issuer (CA): $($x509.Issuer)"
    Write-Host "Valid From: $($x509.NotBefore)"
    Write-Host "Valid Until: $($x509.NotAfter)"
    Write-Host "Thumbprint: $($x509.Thumbprint)"
    Write-Host "-------------------------`n"

    # Send an HTTP 1.1 request with Host Header and close after
    $sendBuffer = [System.Text.Encoding]::ASCII.GetBytes("GET / HTTP/1.1`r`nHost: $fqdn`r`nConnection: close`r`n`r`n")
    $sslStream.Write($sendBuffer, 0, $sendBuffer.Length)
}
finally {
    # Clean up
    if ($sslStream -is [IDisposable]) {
        $sslStream.Dispose()
    }
    $client.Dispose()
}
