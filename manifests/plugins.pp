define ohmyzsh::plugins(
  $plugins = 'git',
  $user = $username
) {
  if $user == 'root' { $home = '/root' } else { $home = "${ohmyzsh::params::home}/${user}" }
  if $user {
    file_line { "${user}-${plugins}-install":
      path    => "${home}/.zshrc",
      line    => "plugins=(${plugins})",
      match   => '^plugins=',
      require => Ohmyzsh::Install[$user]
    }
  }
}
