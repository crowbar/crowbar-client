# Changelog

## [3.9.1](https://github.com/crowbar/crowbar-client/releases/tag/v3.9.1) - 2020-07-01

* BUGFIX
  * Fix repocheck table output (SOC-10718)
  * Enable restricted commands for Cloud8 (bsc#1117080)

## [3.9.0](https://github.com/crowbar/crowbar-client/releases/tag/v3.9.0) - 2019-04-05

* ENHANCEMENT
  * Add support for the restricted APIs
  * Add --raw to "proposal show" & "proposal edit"
  * Correctly parse error messages that we don't handle natively

## [3.8.0](https://github.com/crowbar/crowbar-client/releases/tag/v3.8.0) - 2019-04-02

* ENHANCEMENT
  * Add 'ses' subcommand to upload SES configuration file to crowbar (@skazi0)

## [3.7.0](https://github.com/crowbar/crowbar-client/releases/tag/v3.7.0) - 2018-12-14

* ENHANCEMENT
  * Better upgrade repocheck output

## [3.6.1](https://github.com/crowbar/crowbar-client/releases/tag/v3.6.1) - 2018-12-07

* BUGFIX
  * Hide the database step when it is not used (bsc#1118004)
* ENHANCEMENT
  * Fix help strings
  * Describe how to upgrade more nodes with one command

## [3.6.0](https://github.com/crowbar/crowbar-client/releases/tag/v3.6.0) - 2018-06-19

* BUGFIX
  * Fix node show help (bsc#1024498)
* ENHANCEMENT
  * Extend the clean restart flags
  * Add an option to identify the version of product being upgraded
  * Added support for postpone/resume upgrade actions

## [3.5.2](https://github.com/crowbar/crowbar-client/releases/tag/v3.5.2) - 2018-01-09

* BUGFIX
  * Display invalid nodes when editing proposal

## [3.5.1](https://github.com/crowbar/crowbar-client/releases/tag/v3.5.1) - 2017-12-05

* BUGFIX
  * Escape reserved characters in credentials
  * Fix for custom user and password for database subcommand
  * Fix IP allocation subcommand (bsc#1069792)

## [3.5.0](https://github.com/crowbar/crowbar-client/releases/tag/v3.5.0) - 2017-10-13

* ENHANCEMENT
  * Add new service command and subcommands

## [3.4.0](https://github.com/crowbar/crowbar-client/releases/tag/v3.4.0) - 2017-10-08

* BUGFIX
  * Fix proposal create from file (bsc#1037374)
  * Fix create proposal from data (bsc#1037374)

* ENHANCEMENT
  * Add filtering of proposal deployment lists

## [3.3.1](https://github.com/crowbar/crowbar-client/releases/tag/v3.3.1) - 2017-04-07

* BUGFIX
  * Fix CROWBAR_VERIFY_SSL environment variable evaluation
  * Fix upgrade hint after admin repochecks step (bsc#1029682)
  * Use same timeout then the crowbar API

## [3.3.0](https://github.com/crowbar/crowbar-client/releases/tag/v3.3.0) - 2017-03-30

* ENHANCEMENT
  * Allow skipping the SSL verification step

## [3.2.2](https://github.com/crowbar/crowbar-client/releases/tag/v3.2.2) - 2017-03-08

* ENHANCEMENT
  * Add support for api/upgrade/mode API
* BUGFIX
  * Send a reset command on node reset (bsc#1025206)
  * Check for file existance before uploading backup (bsc#1025309)
  * Fix backup upload args (bsc#1026111)

## [3.2.1](https://github.com/crowbar/crowbar-client/releases/tag/v3.2.1) - 2017-02-14

* BUGFIX
  * Revert "Fix json encoding for post request" (@rsalevsky)
  * Fix json encoding for proposal edit (@rsalevsky)

## [3.2.0](https://github.com/crowbar/crowbar-client/releases/tag/v3.2.0) - 2017-02-10

* ENHANCEMENT
  * Remove experimental marker from upgrade subcommand (@rsalevsky)
* BUGFIX
  * Fix json encoding for post request (@rhafer)
  * Print nodes status only when nodes attribute is given (@jsuchome)
  * Fix content-type sent from crowbarctl to v2 APIs (@skazi0)

## [3.1.9](https://github.com/crowbar/crowbar-client/releases/tag/v3.1.9) - 2017-02-03

* ENHANCEMENT
  * Enable querying the nodes upgrade status (@MaximilianMeister)
* BUGFIX
  * Don't show just one Error (@MaximilianMeister)

## [3.1.8](https://github.com/crowbar/crowbar-client/releases/tag/v3.1.8) - 2017-02-02

* ENHANCEMENT
  * Inform the user that OpenStack backup is ongoing (@jsuchome)
  * Allow granular node upgrade (@MaximilianMeister)
* BUGFIX
  * Display an error when a false parameter gets passed (@MaximilianMeister)
  * Change next step after 'services' to openstack DB backup (@jsuchome)
  * Correctly format database error (@MaximilianMeister)

## [3.1.7](https://github.com/crowbar/crowbar-client/releases/tag/v3.1.7) - 2017-01-13

* ENHANCEMENT
  * Guide user through the upgrade (@MaximilianMeister)
  * Internal steps of the upgrade were renamed (@MaximilianMeister)

## [3.1.6](https://github.com/crowbar/crowbar-client/releases/tag/v3.1.6) - 2017-01-05

* BUGFIX
  * Catch error 406 when node alias is not unique (bsc#1011581) (@MaximilianMeister)
  * Use cancel not prepare (@MaximilianMeister)
* ENHANCEMENT
  * Adapt http codes for upgrade cancel (@MaximilianMeister)
  * Add SimpleError mixxin (@rsalevsky)
  * Schema migration is included in the crowbar-init step now (@MaximilianMeister)
  * Change endpoint of the openstack backup (@MaximilianMeister)

## [3.1.5](https://github.com/crowbar/crowbar-client/releases/tag/v3.1.5) - 2016-12-06

* BUGFIX
  * Handover timeout to the rest-client (@MaximilianMeister)
* ENHANCEMENT
  * Improve upgrade precheck output (@MaximilianMeister)
  * Improve upgrade error output (@MaximilianMeister)
  * Add subcommand to cancel upgrade (@MaximilianMeister)
  * Drop batch build command (@MaximilianMeister)
  * Mark upgrade subcommand as experimental (@rsalevsky)

## [3.1.4](https://github.com/crowbar/crowbar-client/releases/tag/v3.1.4) - 2016-11-14

* ENHANCEMENT
  * Add database subcommand for fresh cloud installations (@MaximilianMeister)
  * Update database parameter validations (@MaximilianMeister)
  * Adapting request urls to various API changes (@MaximilianMeister)

## [3.1.3](https://github.com/crowbar/crowbar-client/releases/tag/v3.1.3) - 2016-10-18

* BUGFIX
  * Dont try to parse the body when it could be nil (@MaximilianMeister)
* ENHANCEMENT
  * Namespace the database setup in the upgrade case (@MaximilianMeister)
  * Restrict the port validation to a max of 65535 (@MaximilianMeister)
  * Adapt urls after moving the repocheck APIs (@MaximilianMeister)
  * Adapt upgrade nodes command to the API (@MaximilianMeister)

## [3.1.2](https://github.com/crowbar/crowbar-client/releases/tag/v3.1.2) - 2016-09-19

* BUGFIX
  * fix wrong usage of a case statement (@MaximilianMeister)

## [3.1.1](https://github.com/crowbar/crowbar-client/releases/tag/v3.1.1) - 2016-09-16

* BUGFIX
  * Use the new API version by default on SP2 (@rsalevsky)
* ENHANCEMENT
  * Add upgrade database subcommand (@MaximilianMeister)
  * Add upgrade admin server repocheck subcommand (@MaximilianMeister)
  * Drop ha and ceph repocheck in favor of nodes repocheck (@MaximilianMeister)

## [3.1.0](https://github.com/crowbar/crowbar-client/releases/tag/v3.1.0) - 2016-08-23

* BUGFIX
  * Set the default apiversion to 1.0 (@MaximilianMeister)
* ENHANCEMENT
  * Add upgrade subcommand (@MaximilianMeister)

## [3.0.1](https://github.com/crowbar/crowbar-client/releases/tag/v3.0.1) - 2016-08-19

* BUGFIX
  * Fix batch export subcommand (bsc#994125) (@rsalevsky)
* ENHANCEMENT
  * Enable configuring the api version (@MaximilianMeister)

## [3.0.0](https://github.com/crowbar/crowbar-client/releases/tag/v3.0.0) - 2016-08-16

* BREAKING
  * Adapt backups subcommand to the new api 2.0 (@MaximilianMeister)
* BUGFIX
  * Fix repository handling (bsc#993445) (@MaximilianMeister)
* ENHANCEMENT
  * Added lgtm config (@rsalevsky)
  * Clarify command role show (@itxaka)
  * Replace httparty/httmultiparty with rest-client (@MaximilianMeister)

## [2.4.3](https://github.com/crowbar/crowbar-client/releases/tag/v2.4.3) - 2016-07-06

* BUGFIX
  * Raise timeout to 300s to handle long requests (@rsalevsky)
* ENHANCEMENT
  * Added --default option to create a proposal without an editor (@rsalevsky)

## [2.4.2](https://github.com/crowbar/crowbar-client/releases/tag/v2.4.2) - 2015-05-04

* BUGFIX
  * Fixed duplicate option, renamed --anonymous shorthand from -a to -A (@tboerger)
  * Raised timeout default value to prevent timeouts on requests (@MaximilianMeister)
  * Pin development dependency listen to ruby 2.1 compatible version (@tboerger)
* ENHANCEMENT
  * Properly handle 502, 503 and 504 responses (@tboerger)
  * Map -h and --help options properly to help subcommand (@tboerger)
  * Extended the test suite (@MaximilianMeister)
  * Enhanched the inline documentation (@tboerger)
  * Added subcommand to check server sanity (@MaximilianMeister)

## [2.4.1](https://github.com/crowbar/crowbar-client/releases/tag/v2.4.1) - 2015-02-08

* BUGFIX
  * Fixed updated path to installer API (@jdsn)
  * Print correct help output for backup commands (@tboerger)
* ENHANCEMENT
  * Integrated changes for fixed batch API (@tboerger)

## [2.4.0](https://github.com/crowbar/crowbar-client/releases/tag/v2.4.0) - 2015-01-27

* BUGFIX
  * Fixed backup commands by name (@tboerger)
  * Fixed help output for nested commands (@tboerger)
* ENHANCEMENT
  * Added subcommand to trigger a backup restore (@tboerger)
  * Added subcommand for batch build and export (@tboerger)

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
