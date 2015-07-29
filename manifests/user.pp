define ohmyzsh::user(
  $username = undef,
  $theme = undef,
  $plugins = undef,
  $autoupdate = undef
  ) {
  if $username {
    ohmyzsh::install { $username: }
    if $theme {
      ohmyzsh::theme { [$username,]: theme => $theme }
    }
    if $plugins {
      ohmyzsh::plugins { $username: plugins => $plugins }
    }
    if $autoupdate != undef {
      ohmyzsh::autoupdate { $username: autoupdate => $autoupdate }
    }
  }
}
