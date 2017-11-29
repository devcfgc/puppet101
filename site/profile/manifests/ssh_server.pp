class profile::ssh_server {
  package {'openssh-server':
    ensure => present,
  }
  service { 'sshd':
    ensure => 'running',
    enable => 'true',
  }
  ssh_authorized_key { 'root@master.puppet.vm':
    ensure => present,
    user   => 'root',
    type   => 'ssh-rsa',
    key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCcj4iD4ygl3VTMkEklDmq5dqh0dxCC3fgrPSWkq8StexbCdoot2rXqfq9q3jzkpBgFGyTzLdWsHQbWemBkz8HEnULLnmEgAtWCrUFtpNAIssOILwCKCp7sMLIdKHYOGDv6CCn8hkID2EdLj8wybai1GTTPS2uVlziycu5UCmaug2qdv2IawQsyV38a23oiWKtUKdkfz7MXS0lh51j276l3m8qe+VOnp74r1haP42pr6UIhFp0PEdTNUKDC3sJNgbfSFWQY2//gtWlPNwOc/z4xpcYR2XK8X2DpeqBaDnnvuwJRBP8fj4C56Mo189OwB0YFdS3oORe8rXW198ySQfH5',
  }
}
