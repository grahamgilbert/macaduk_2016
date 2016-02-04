# Munki

This module can install and configure Munki. Example usage:

``` puppet
class { 'munki':
    repourl                     => 'http://munki.example.com',
    suppressstopbuttononinstall => true,
    bootstrap                   => true,
    clientidentifier            => 'demo_client',
}
```

## Options

### Munki preferences

These preferences will be set in the ``.mobileconfig``.

For information on what the preferences do, see the [Munki wiki](https://github.com/munki/munki/wiki/Preferences).

| Puppet Option  | Munki Preference | Default |
| ------------- | ------------- | ------------- |
| repourl  | SoftwareRepoURL  | http://munki |
| clientidentifier  | ClientIdentifier  | |
| install_apple_updates | InstallAppleSoftwareUpdates | false |
| suppress_stop | SuppressStopButtonOnInstall | false |
| packageurl | PackageURL | |
| catalogurl | CatalogURL | |
| manifesturl | ManifestURL | |
| additionalhttpheaders | AdditionalHttpHeaders | |

### Other Options

* ``install_tools``: Installs Munki Tools.
* ``bootstrap``: If Munki tools are installed by Puppet, this will touch ``/Users/Shared/.com.googlecode.munki.checkandinstallatstartup`` after. Defaults to ``false``.
* ``install_version``: The version that ``install_tool`` will install. Defaults to ``2.4.0.2561``.

$manage_services = true,
$install_conditions = true,
$min_version = '2.4.0.2561',
$toolsurl = 'https://github.com/munki/munki/releases/download/v2.4.0/munkitools-2.4.0.2561.pkg',
