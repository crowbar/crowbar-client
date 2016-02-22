# Crowbar: Client

This tool is a complete reimplementation of the old CLI scripts of Crowbar.
It is intended to be installable standalone on any machine with access to
the Crowbar admin network. It is the **recommended command line interface** to manage
Crowbar from remote or locally on the Crowbar server itself.

The [Crowbar Framework](https://github.com/crowbar/crowbar) is currently
maintained by [SUSE](http://www.suse.com/) as an [OpenStack](http://openstack.org)
installation framework but is prepared to be a much broader function tool. It
was originally developed by the [Dell CloudEdge Solutions Team](http://dell.com/openstack).

## Badges

[![Build Status](https://secure.travis-ci.org/crowbar/crowbar-client.svg)](https://travis-ci.org/crowbar/crowbar-client)
[![Code Climate](https://codeclimate.com/github/crowbar/crowbar-client.svg)](https://codeclimate.com/github/crowbar/crowbar-client)
[![Test Coverage](https://codeclimate.com/github/crowbar/crowbar-client/badges/coverage.svg)](https://codeclimate.com/github/crowbar/crowbar-client)
[![Dependency Status](https://gemnasium.com/crowbar/crowbar-client.svg)](https://gemnasium.com/crowbar/crowbar-client)
[![Join the chat at https://gitter.im/crowbar/crowbar](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/crowbar/crowbar)

## Install

To install this simple ruby gem you can check your package manager if it is
available for you, alternatively you can just install the ruby gem if you have a
running ruby stack on your machine with this command:

```
gem install crowbar-client
```

## Configuration

`crowbar-client` can be configured by placing a `.crowbarrc` file in your `$HOME` directory.
For details about the options see the [default configuration file](config/crowbarrc).

## Usage

```
crowbarctl help
```

## Contributing

Fork -> Patch -> Spec -> Push -> Pull Request

## Contact

To get in contact with the developers you have multiple options, all of them
are listed below:

* [Google Mailinglist](https://groups.google.com/forum/#!forum/crowbar)
* [Gitter Chat](https://gitter.im/crowbar/crowbar)
* [Freenode Webchat](http://webchat.freenode.net/?channels=%23crowbar)

## Legals

Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied. See the License for the
specific language governing permissions and limitations under the License.
