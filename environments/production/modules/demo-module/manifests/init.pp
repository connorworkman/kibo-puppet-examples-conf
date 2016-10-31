class demo-module {
    notice(hiera('ntp::autoupdate'))
    #switch this if to case statement and continue on with linuxacademy tutorials
    user { 'kibo-dev':
        ensure          => present,
        home            => '/home/kibo-dev',
        gid             => 'dev',
        shell           => '/bin/bash',
        managehome      => true,
    }
    user { 'kibo-admin':
        ensure          => present,
        managehome      => false,
        gid             => 'wheel',
        groups          => ['wheel','dev'],
        shell           => '/bin/bash',
    }
    if $operatingsystem == 'Amazon' {
        notify{"Your OS is ${operatingsystem}.":}
        $source = 'puppet:///modules/demo-module/puppet-demo2.csv'
    } elsif $operatingsystem == 'RedHat' {
        notify{"Your OS is RHEL.":}
        $source = 'puppet:///modules/demo-module/puppet-demo2.csv'
    } else {
        notify{"This operating system is ${operatingsystem}.":}
        notice("Your OS is definitely not Amazon.")
        $source = 'puppet:///modules/demo-module/puppet-demo.csv'
    }
    file { 'puppet-demo.csv':
        ensure          => file,
        path            => '/home/kibo-dev/puppet-demo.csv',
        source          => $source,
    }
    file { 'puppet-demo.txt':
        ensure          => file,
        content         => "This was created by Puppet Master version ${serverversion}.",
        path            => '/home/kibo-dev/puppet-demo.txt',
    }
    file { '/home/kibo-dev/':
        ensure          => directory,
    }
#    ec2_securitygroup { 'createdViaPuppetMaster':
#        ensure          => present,
#        region          => 'us-west-2',
#        description     => 'This sec group was launched from Puppet-AWS module on the puppet master.',
#        ingress         => [{
#            protocol    => 'tcp',
#            port        => 80,
#            cidr        => '0.0.0.0/0',
#        }],
#        tags            => {
#            my_tagname  => 'some_tag_value',
#        },
#    }
}
