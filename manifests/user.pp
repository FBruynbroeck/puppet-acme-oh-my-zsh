define ohmyzsh::user(
  $name = undef,
  $theme = undef,
  $plugins = undef,
  $autoupdate = undef
  ) {
  if $name {
    ohmyzsh::install { $name: }
    if $theme {
      ohmyzsh::theme { [$name,]: theme => $theme }
    }
    if $plugins {
      ohmyzsh::plugins { $name: plugins => $plugins }
    }
    if $autoupdate {
      ohmyzsh::autoupdate { $name: autoupdate => $autoupdate }
    }
  }
}
