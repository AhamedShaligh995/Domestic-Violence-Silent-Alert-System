# Download script for Smart Emergency Alert System dependencies
# Includes full Twilio SDK 9.0.0 and its core dependencies
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$libDir = "c:\Users\Admin\Desktop\aad\lib"
if (!(Test-Path $libDir)) {
    New-Item -ItemType Directory -Force -Path $libDir | Out-Null
}

$urls = @{
    # Original Dependencies
    "mysql-connector-j-8.0.33.jar"      = "https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar"
    "javax.mail-1.6.2.jar"               = "https://repo1.maven.org/maven2/com/sun/mail/javax.mail/1.6.2/javax.mail-1.6.2.jar"
    "activation-1.1.1.jar"               = "https://repo1.maven.org/maven2/javax/activation/activation/1.1.1/activation-1.1.1.jar"
    "jnativehook-2.2.2.jar"              = "https://repo1.maven.org/maven2/com/1stleg/jnativehook/2.2.2/jnativehook-2.2.2.jar"
    
    # Twilio SDK & Core Dependencies
    "twilio-9.0.0.jar"                  = "https://repo1.maven.org/maven2/com/twilio/sdk/twilio/9.0.0/twilio-9.0.0.jar"
    "jackson-core-2.14.0.jar"           = "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.14.0/jackson-core-2.14.0.jar"
    "jackson-annotations-2.14.0.jar"    = "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.14.0/jackson-annotations-2.14.0.jar"
    "jackson-databind-2.14.0.jar"       = "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.14.0/jackson-databind-2.14.0.jar"
    "jackson-datatype-jsr310-2.14.0.jar" = "https://repo1.maven.org/maven2/com/fasterxml/jackson/datatype/jackson-datatype-jsr310/2.14.0/jackson-datatype-jsr310-2.14.0.jar"
    "httpclient-4.5.13.jar"             = "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpclient/4.5.13/httpclient-4.5.13.jar"
    "httpcore-4.4.13.jar"               = "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcore/4.4.13/httpcore-4.4.13.jar"
    "gson-2.8.9.jar"                    = "https://repo1.maven.org/maven2/com/google/code/gson/gson/2.8.9/gson-2.8.9.jar"
    "slf4j-api-1.7.30.jar"              = "https://repo1.maven.org/maven2/org/slf4j/slf4j-api/1.7.30/slf4j-api-1.7.30.jar"
    "commons-codec-1.15.jar"            = "https://repo1.maven.org/maven2/commons-codec/commons-codec/1.15/commons-codec-1.15.jar"
    "commons-logging-1.2.jar"           = "https://repo1.maven.org/maven2/commons-logging/commons-logging/1.2/commons-logging-1.2.jar"
    "joda-time-2.10.13.jar"              = "https://repo1.maven.org/maven2/joda-time/joda-time/2.10.13/joda-time-2.10.13.jar"
    "jaxb-api-2.3.1.jar"                = "https://repo1.maven.org/maven2/javax/xml/bind/jaxb-api/2.3.1/jaxb-api-2.3.1.jar"
}

Write-Host "Updating dependencies in $libDir..."

foreach ($key in $urls.Keys) {
    $filePath = Join-Path $libDir $key
    $url = $urls[$key]
    if (!(Test-Path $filePath)) {
        Write-Host "Downloading $key..."
        Invoke-WebRequest -Uri $url -OutFile $filePath -ErrorAction Stop
        Write-Host "Downloaded $key successfully."
    } else {
        Write-Host "$key already exists."
    }
}

Write-Host "All libraries downloaded successfully."
