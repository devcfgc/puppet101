class minecraft (
  $url         = 'https://s3.amazonaws.com/Minecraft.Download/versions/1.12.1/minecraft_server.1.12.1.jar',
  $install_dir = '/opt/minecraft'
){
  file {$install_dir:
    ensure => directory,
  }
  file {"${install_dir}/minecraft_server.1.12.2.jar":
    ensure => file,
    source => $url,
    before => Service['minecraft'],
  }
  package {'java':
    ensure => present,
  }
  file {"${install_dir}/eula.txt":
    ensure  => file,
    content => 'eula=true'
  }
  file {'/etc/systemd/system/minecraft.service':
    ensure  => file,
    content => epp('minecraft/minecraft.service.epp', {
      install_dir => $install_dir,
    }),
  }
  service { 'minecraft':
    ensure  => running,
    enable  => true,
    require => [
      Package['java'],
      File["${install_dir}/eula.txt"],
      File['/etc/systemd/system/minecraft.service']
    ],
  }
}
