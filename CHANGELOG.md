# Changelog

## [2.3.0](https://github.com/crowbar/crowbar-client/releases/tag/v2.3.0) - 2015-01-15

* BREAKING
  * Dropped --no-aliases option from node list subcommand (@tboerger)
  * Dropped --no-names option from node list subcommand (@tboerger)
* ENHANCEMENT
  * Added more columns to node list subcommand (@tboerger)
  * Order node list subcommand output alphabetically now (@tboerger)
  * Added subcommand to reset a proposal state through the API (@tboerger)
  * Added subcommand to interact with the backup API (@tboerger)
  * Added subcommand to set the group of a node (@tboerger)

## [2.2.1](https://github.com/crowbar/crowbar-client/releases/tag/v2.2.1) - 2015-12-15

* BUGFIX
  * Fixed attribute naming within network request classes (@tboerger)
  * Always provide a valid output format (@tboerger)
  * Call correct classes for ip deallocation (@tboerger)
* ENHANCEMENT
  * Prevent install with invalid network config (@MaximilianMeister)

## [2.2.0](https://github.com/crowbar/crowbar-client/releases/tag/v2.2.0) - 2015-12-03

* BUGFIX
  * Fixed reading of files for proposal create/edit (@tboerger)
* ENHANCEMENT
  * Added proper error handling to file read on proposal (@tboerger)
  * Added subcommands for installation of admin server (@MaximilianMeister)
  * Added proper error handling for general connection (@tboerger)

## [2.1.0](https://github.com/crowbar/crowbar-client/releases/tag/v2.1.0) - 2015-11-25

* BREAKING
  * Removed the config file flag, just using default paths (@tboerger)
* BUGFIX
  * Fixed heading for node status (@tboerger)
* ENHANCEMENT
  * Added API help subcommand (@tboerger)
  * Added switch to hide ready nodes within status (@tboerger)
  * Added switches to hide names or aliases on node list (@tboerger)
  * Integrated config values from environment (@tboerger)

## [2.0.0](https://github.com/crowbar/crowbar-client/releases/tag/v2.0.0) - 2015-11-12

* BREAKING
  * Renamed bin/crowbar to bin/crowbarctl (@tboerger)
* BUGFIX
  * Fixed format shortcuts to method instead of class options (@tboerger)
* ENHANCEMENT
  * Be sure to set the correct output format (@tboerger)

## [1.0.1](https://github.com/crowbar/crowbar-client/releases/tag/v1.0.1) - 2015-11-11

* BUGFIX
  * Fixed typos for renaming of HostIP (@tboerger)
  * Fixed typos for renaming of VirtualIP (@tboerger)
* ENHANCEMENT
  * Downgraded terminal-table dependency (@tboerger)

## [1.0.0](https://github.com/crowbar/crowbar-client/releases/tag/v1.0.0) - 2015-11-11

* Initial release (@tboerger)
