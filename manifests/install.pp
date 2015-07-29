# == Class: ohmyzsh::install
#
# This is the ohmyzsh module. It installs oh-my-zsh for a user and changes
# their shell to zsh. It has been tested under Ubuntu.
#
# This module is called ohmyzsh as Puppet does not support hyphens in module
# names.
#
# oh-my-zsh is a community-driven framework for managing your zsh configuration.
#
# === Parameters
#
# None.
#
# === Examples
#
# class { 'ohmyzsh': }
# ohmyzsh::install { 'acme': }
#
# === Authors
#
# Leon Brocard <acme@astray.com>
#
# === Copyright
#
# Copyright 2013 Leon Brocard
#
define ohmyzsh::install() {
  if $username == 'root' { $home = '/root' } else { $home = "${ohmyzsh::params::home}/${username}" }
  exec { "ohmyzsh::git clone ${username}":
    creates => "${home}/.oh-my-zsh",
    command => "/usr/bin/git clone git://github.com/robbyrussell/oh-my-zsh.git ${home}/.oh-my-zsh",
    user    => $username,
    require => [Package['git'], Package['zsh']]
  }

  exec { "ohmyzsh::cp .zshrc ${username}":
    creates => "${home}/.zshrc",
    command => "/bin/cp ${home}/.oh-my-zsh/templates/zshrc.zsh-template ${home}/.zshrc",
    user    => $username,
    require => Exec["ohmyzsh::git clone ${username}"],
  }

  if ! defined(User[$username]) {
    user { "ohmyzsh::user ${username}":
      ensure     => present,
      username       => $username,
      managehome => true,
      shell      => $ohmyzsh::params::zsh,
      require    => Package['zsh'],
    }
  } else {
    User <| title == $username |> {
      shell => $ohmyzsh::params::zsh
    }
  }
}
