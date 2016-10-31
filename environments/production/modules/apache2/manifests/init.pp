class apache2 {
    package { "httpd": 
        ensure => installed,
    }
}
