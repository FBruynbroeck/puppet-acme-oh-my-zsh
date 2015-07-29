define ohmyzsh::autoupdate(
  $autoupdate = 'true',
  $user = $username
) {
  if $user == 'root' { $home = '/root' } else { $home = "${ohmyzsh::params::home}/${user}" }
  if $autoupdate == 'true' { $disableautoupdate = 'false' } else { $disableautoupdate = 'true' }
  if $user {
    file_line { "${user}-autoupdate":
      path    => "${home}/.zshrc",
      line    => "DISABLE_AUTO_UPDATE=\"${disableautoupdate}\"",
      match   => 'DISABLE_AUTO_UPDATE=',
      require => Ohmyzsh::Install[$user]
    }
  }
}
